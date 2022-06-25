defmodule KombuchiServerWeb.SellerLive.FormComponent do
  use KombuchiServerWeb, :live_component

  alias KombuchiServer.Frontend

  @impl true
  def update(%{seller: seller} = assigns, socket) do
    changeset = Frontend.change_seller(seller)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"seller" => seller_params}, socket) do
    changeset =
      socket.assigns.seller
      |> Frontend.change_seller(seller_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"seller" => seller_params}, socket) do
    save_seller(socket, socket.assigns.action, seller_params)
  end

  defp save_seller(socket, :edit, seller_params) do
    case Frontend.update_seller(socket.assigns.seller, seller_params) do
      {:ok, _seller} ->
        {:noreply,
         socket
         |> put_flash(:info, "Seller updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_seller(socket, :new, seller_params) do
    case Frontend.create_seller(seller_params) do
      {:ok, _seller} ->
        {:noreply,
         socket
         |> put_flash(:info, "Seller created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
