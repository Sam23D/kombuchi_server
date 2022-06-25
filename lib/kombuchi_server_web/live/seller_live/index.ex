defmodule KombuchiServerWeb.SellerLive.Index do
  use KombuchiServerWeb, :live_view

  alias KombuchiServer.Frontend
  alias KombuchiServer.Frontend.Seller

  @impl true

  # TODO add plug to inject :current_user

  def mount(_params, _session, socket) do
    {:ok, assign(socket, sellers: list_sellers(), user: nil)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Seller")
    |> assign(:seller, Frontend.get_seller!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Seller")
    |> assign(:seller, %Seller{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Sellers")
    |> assign(:seller, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    seller = Frontend.get_seller!(id)
    {:ok, _} = Frontend.delete_seller(seller)

    {:noreply, assign(socket, :sellers, list_sellers())}
  end

  defp list_sellers do
    Frontend.list_sellers()
  end
end
