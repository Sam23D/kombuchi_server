defmodule KombuchiServerWeb.SubscribeLive.Front do
  use KombuchiServerWeb, :live_view

  alias KombuchiServer.Frontend
  alias KombuchiServer.Frontend.Subscribe

  @impl true
  def mount(_params, _session, socket) do
    new_subscriber =  %Subscribe{}
    {:ok, assign(socket, subscribe: new_subscriber )}
  end

  @impl true
  def handle_params(params, _url, socket) do
    # get user from session and assign to socket
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :user_register, _params) do

    socket
    |> assign(:page_title, "Ingreta tu info y subscribete")
    |> assign(:subscribe, nil)
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Registratae a nuestras ofertas y noticias")
    |> assign(:subscribe, nil)
  end



end
