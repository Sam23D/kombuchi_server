defmodule KombuchiServerWeb.SubscribeLive.FormComponent do
  use KombuchiServerWeb, :live_component

  alias KombuchiServer.Frontend

  @impl true
  def update(%{subscribe: subscribe} = assigns, socket) do
    changeset = Frontend.change_subscribe(subscribe)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"subscribe" => subscribe_params}, socket) do
    changeset =
      socket.assigns.subscribe
      |> Frontend.change_subscribe(subscribe_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"subscribe" => subscribe_params}, socket) do
    save_subscribe(socket, socket.assigns.action, subscribe_params)
  end

  defp save_subscribe(socket, :edit, subscribe_params) do
    case Frontend.update_subscribe(socket.assigns.subscribe, subscribe_params) do
      {:ok, _subscribe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Subscribe updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  @new_subscriber_actions [:new, :index]

  defp save_subscribe(socket, action, subscribe_params) when action in @new_subscriber_actions do
    case Frontend.create_subscribe(subscribe_params) do
      {:ok, _subscribe} ->
        {:noreply,
        # add session for current subscriber
         socket
         |> put_flash(:info, "Subscribe created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
