defmodule KombuchiServerWeb.SubscribeLive.Index do
  use KombuchiServerWeb, :live_view

  alias KombuchiServer.Frontend
  alias KombuchiServer.Frontend.Subscribe

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :subscribers, list_subscribers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Subscribe")
    |> assign(:subscribe, Frontend.get_subscribe!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Subscribe")
    |> assign(:subscribe, %Subscribe{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Subscribers")
    |> assign(:subscribe, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    subscribe = Frontend.get_subscribe!(id)
    {:ok, _} = Frontend.delete_subscribe(subscribe)

    {:noreply, assign(socket, :subscribers, list_subscribers())}
  end

  defp list_subscribers do
    Frontend.list_subscribers()
  end
end
