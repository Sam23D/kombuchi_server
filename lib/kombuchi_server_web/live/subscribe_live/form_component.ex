defmodule KombuchiServerWeb.SubscribeLive.FormComponent do
  use KombuchiServerWeb, :live_component

  require Logger
  alias __MODULE__
  alias KombuchiServer.Frontend
  alias KombuchiServer.Frontend.Subscribe
  alias KombuchiServer.Accounts
  alias KombuchiServerWeb.Router.Helpers
  @moduledoc """
  This form will manage the Subscrube life cycle, from subscribing to validating (creating a user)

  Posible states of the Form
  - :unsubscribed
  - :unverified (user & subscriber created but not verified)
  - :registered

  When the :unsubscribed, we should ask for the users :name, and :email, with that we send a thx for subscribing and we send an extra email with the verification code and change the user status to :unregistered
  When :unregistered we ask for the verification code and mark the :email as verified, and change the user to :registered
  When the user is registered we render the intended content for each page, in this case form for :kombucha_dotation
  """

  @impl true
  def mount(socket)do
    {:ok, socket}
  end

  @impl true
  @doc """
  Will handle the case when we have a session with a subscriber and maybe not a user
  """
  def update(assigns, socket) do
    changeset = Frontend.change_subscribe(%Subscribe{})

    {:ok,
     socket
     |> assign_new(:subscribe, fn -> %Subscribe{} end)
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  # TODO change this validate to be more generic instead to specific to subscribe
  def handle_event("validate", %{"subscribe" => subscribe_params}, socket) do
    IO.inspect(socket)
    IO.inspect(subscribe_params)
    changeset =
      socket.assigns.subscribe
      |> Frontend.change_subscribe(subscribe_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("send-verification-email", %{}, socket)do
    # TODO add send email verification for current user or sub
    case socket do
      %{ assigns: %{ user: user} } ->
        user
        |> KombuchiServer.Accounts.deliver_user_confirmation_instructions(&Helpers.user_confirmation_url(socket, :edit, &1))
        |> IO.inspect(label: "deliver response")
        # maybe change socket for a ui notification
      {:noreply, socket}
        _ -> {:noreply, socket}
    end
  end

  def handle_event("save", %{"subscribe" => subscribe_params}, socket) do
    case subscribe_params do
      %{"email" => email, "name" => name} ->
        if Frontend.maybe_subscribe_by_name_and_email(name, email) do
          IO.inspect("Subscriber already exists")
        end
        # TODO check if subscriber with the given email exists
        # do it with Accounts.get_or_create_user_by_subscriber
        # if not then create a new subscriber with save_subscribe
        # if a subscriber exists then assigs session with user to the socket

        new_socket = socket
        |> assign(registration_step: :unconfirmed_subscription)
        |> save_subscribe(socket.assigns.action, subscribe_params)

        {:noreply, socket}

      _ ->
        {:noreply, socket}

    end
  end

  defp save_subscribe(socket, :edit, subscribe_params) do
    case Frontend.update_subscribe(socket.assigns.subscribe, subscribe_params) do
      {:ok, _subscribe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Subscribe updated successfully")
         |> assign(registration_step: :unconfirmed_subscription)
         |> assign(form_title: "Tira oari ")
        }

        # TODO add patching liveaction to :unconfirmed

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  # liveview actions taht will trigger a new subscriber creation
  @new_subscriber_actions [:new, :index]
  @doc """
  Creates a subsccription for an existing user with the same email, if no user with the same email exist, one will be created with the
  subscription info and used to create a new session in the liveview
  """
  defp save_subscribe(socket, action, subscribe_params) when action in @new_subscriber_actions do
    case Frontend.create_subscribe(subscribe_params) do
      {:ok, subscriber} ->
        # TODO get or create user
        user = Accounts.get_or_create_user_by_subscriber(subscriber)
        # |> IO.inspect(label: "get or created user")

        {:noreply,
        # TODO add session for current subscribe / user

         socket
         |> assign( :registration_step, :unconfirmed_subscription)
         |> put_flash(:info, "Subscribe created successfully")
         |> assign(form_title: "Tira oari ")}

      # this will happen when a subscriber tries to subscribe with the same email again
      # TODO make it safer tying to fetch with same matching email and name
      {:error, %Ecto.Changeset{ errors: errors, changes: changes } = changeset} ->
        user = if errors[:unique_email] do
          case Accounts.get_or_create_user_by_subscriber(%Subscribe{email: changes.email, name: changes.name }) do
            {:ok, user} ->
              Logger.info("New user created for subscriber #{changes.email}")
              user
            user ->
              Logger.info("User fetched for subscriber #{changes.email}")
              user
          end
        end

        user
        |> KombuchiServer.Accounts.deliver_user_confirmation_instructions(&Helpers.user_confirmation_url(socket, :edit, &1))
        |> case do
          # we can execute specific login in the middle in each case
          {:ok, email} ->
            IO.inspect(email,label: "We sent you this")
            send(self(), {:session_user_updated, user})
          {:error, :already_subscribed} ->
            send(self(), {:session_user_updated, user})
          {:error, :already_confirmed} ->
              send(self(), {:session_user_updated, user})
        end

        #  create new session for user and add it to the socket
        # send mesg to self to update :registration_step?
        send(self(),  {:user_updated, %{registration_step: :unconfirmed_subscription}})

        new_socket = socket
        |> assign( current_user: user, registration_step: :unconfirmed_user)
        # |> IO.inspect(label: "Patched socket")

        {:noreply, new_socket}

    end
  end

end
