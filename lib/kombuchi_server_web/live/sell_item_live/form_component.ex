defmodule KombuchiServerWeb.SellItemLive.FormComponent do
  use KombuchiServerWeb, :live_component

  alias KombuchiServer.Ecommerce

  @impl true
  def update(%{sell_item: sell_item} = assigns, socket) do
    changeset = Ecommerce.change_sell_item(sell_item)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"sell_item" => sell_item_params}, socket) do
    changeset =
      socket.assigns.sell_item
      |> Ecommerce.change_sell_item(sell_item_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"sell_item" => sell_item_params}, socket) do
    save_sell_item(socket, socket.assigns.action, sell_item_params)
  end

  defp save_sell_item(socket, :edit, sell_item_params) do
    case Ecommerce.update_sell_item(socket.assigns.sell_item, sell_item_params) do
      {:ok, _sell_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sell item updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_sell_item(socket, :new, sell_item_params) do
    case Ecommerce.create_sell_item(sell_item_params) do
      {:ok, _sell_item} ->
        {:noreply,
         socket
         |> put_flash(:info, "Sell item created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
