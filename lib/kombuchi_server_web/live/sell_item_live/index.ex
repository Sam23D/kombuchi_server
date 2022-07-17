defmodule KombuchiServerWeb.SellItemLive.Index do
  use KombuchiServerWeb, :live_view

  alias KombuchiServer.Ecommerce
  alias KombuchiServer.Ecommerce.SellItem

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, sell_items: list_sell_items(), user: nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sell item")
    |> assign(:sell_item, Ecommerce.get_sell_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sell item")
    |> assign(:sell_item, %SellItem{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sell items")
    |> assign(:sell_item, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sell_item = Ecommerce.get_sell_item!(id)
    {:ok, _} = Ecommerce.delete_sell_item(sell_item)

    {:noreply, assign(socket, :sell_items, list_sell_items())}
  end

  defp list_sell_items do
    Ecommerce.list_sell_items()
  end
end
