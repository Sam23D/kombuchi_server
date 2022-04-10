defmodule KombuchiServerWeb.SubscribeLive.Show do
  use KombuchiServerWeb, :live_view

  alias KombuchiServer.Frontend

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:subscribe, Frontend.get_subscribe!(id))}
  end

  defp page_title(:show), do: "Show Subscribe"
  defp page_title(:edit), do: "Edit Subscribe"
end
