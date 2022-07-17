defmodule KombuchiServerWeb.SellItemLive.Show do
  use KombuchiServerWeb, :live_view

  alias KombuchiServer.Ecommerce

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, user: nil)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sell_item, Ecommerce.get_sell_item!(id))}
  end

  defp page_title(:show), do: "Show Sell item"
  defp page_title(:edit), do: "Edit Sell item"
end
