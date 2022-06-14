defmodule KombuchiServerWeb.LiveHelpers do
  import Phoenix.LiveView
  import Phoenix.LiveView.Helpers

  alias Phoenix.LiveView.JS

  @doc """
  Renders a live component inside a modal.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <.modal return_to={Routes.subscribe_index_path(@socket, :index)}>
        <.live_component
          module={KombuchiServerWeb.SubscribeLive.FormComponent}
          id={@subscribe.id || :new}
          title={@page_title}
          action={@live_action}
          return_to={Routes.subscribe_index_path(@socket, :index)}
          subscribe: @subscribe
        />
      </.modal>
  """
  def modal(assigns) do
    assigns = assign_new(assigns, :return_to, fn -> nil end)

    ~H"""
    <div id="modal" class="z-50 w-full fixed flex justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0 sm:block sm:p-0" phx-remove={hide_modal()}>
      <div class="flex justify-center w-full pt-4 px-4 pb-20 text-center sm:block sm:p-0">

        <div class="fixed z-60 inset-0 w-full h-full bg-black bg-opacity-40 transition-opacity" aria-hidden="false"></div>

        <div
          id="modal-content"
          class="relative inline-block align-bottom bg-white rounded-lg text-left overflow-hidden drop-shadow-2xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full"
          phx-click-away={JS.dispatch("click", to: "#close")}
          phx-window-keydown={JS.dispatch("click", to: "#close")}
          phx-key="escape"
        >

          <a id="close" href={@return_to} class="phx-modal-close" hidden phx-click={hide_modal()}>✖</a>
          <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
            <div class="sm:flex sm:items-end">
              <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full bg-red-100 sm:mx-0 sm:h-10 sm:w-10">


              <%= render_slot(@inner_block) %>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}) do
    js
    |> JS.hide(to: "#modal", transition: "fade-out")
    |> JS.hide(to: "#modal-content", transition: "fade-out-scale")
  end
end
