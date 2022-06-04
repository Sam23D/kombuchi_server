defmodule KombuchiServerWeb.SubscribeLive.Front do
  use KombuchiServerWeb, :live_view

  require Logger

  alias KombuchiServer.Frontend
  alias KombuchiServer.Frontend.Subscribe
  alias  KombuchiServer.Accounts
  @moduledoc """
  This liveview will work as main entry for registration and client aquisition

  It contains:
  - Subscription, user confirmation form
  - FAQ displayed

  Should check if there is an existign session

  if session
  - check for verified account?
  - show current status of subscription

  unless session
  - show subscribe form
  - show send verification email button

  TODO mmust change to be teh source of truth for form_component follow this link
  https://hexdocs.pm/phoenix_live_view/Phoenix.LiveComponent.html#module-livecomponent-as-the-source-of-truth

  """

  @impl true
  def mount(_params, session, socket) do
    new_socket = socket
    |> PhoenixLiveSession.maybe_subscribe(session)
    |> assign_new(:user, fn -> nil end)
    |> _maybe_assign_user_from_session(session)
    |> assign(subscribe: nil, registration_step: :unsubscribed)

    {:ok, new_socket}
  end

  """
  Will attach the user from a "user_token" or a "user_id" found in the session struct
  """
  def _maybe_assign_user_from_session(socket, %{"user_token" => user_token}=session) do
    IO.inspect("Getting user from user_token")
    user = Accounts.get_user_by_session_token(session["user_token"])
    assign(socket, user: user)
  end
  def _maybe_assign_user_from_session(socket, %{"user_id" => user_id}=session) do
    user = Accounts.get_user!(user_id)
    assign(socket, user: user)
  end
  def _maybe_assign_user_from_session(socket, _), do: socket

  def handle_info(params={:user_updated, %{registration_step: :unconfirmed_subscription}}, socket)do

    {:noreply, assign(socket, form_title: "Te enviamos un correo", registration_step: :unconfirmed_subscription)}
  end

  def handle_info(params={:session_user_updated, user}, socket)do
    PhoenixLiveSession.put_session(socket, "user_id", user.id)
    {:noreply, assign(socket, user: user)}
  end

  def handle_info({:live_session_updated, session}, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_params(params, url, socket) do
    # get user from session and assign to socket
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :user_register, _params) do

    socket
    |> assign(:page_title, "Ingreta tu info y subscribete")
    |> assign(:subscribe, nil)
  end

  defp apply_action(socket, :index, params) do
    case params do


      params -> IO.inspect(params, label: "Unhandled socket :index action" )
    end

    socket
    |> assign(:page_title, "Registratae a nuestras ofertas y noticias")
    |> assign_new(:form_title, fn  -> "Subscribete a nuestras promociones y correos" end)
    |> assign(:subscribe, nil)
  end


end
