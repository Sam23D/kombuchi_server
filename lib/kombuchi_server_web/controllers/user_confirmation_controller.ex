defmodule KombuchiServerWeb.UserConfirmationController do
  use KombuchiServerWeb, :controller

  alias KombuchiServer.Accounts
  alias KombuchiServer.Accounts.{User, UserToken}
  alias KombuchiServer.Repo

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"email" => email}}) do
    if user = Accounts.get_user_by_email(email) do
      Accounts.deliver_user_confirmation_instructions(
        user,
        &Routes.user_confirmation_url(conn, :edit, &1)
      )
    end

    conn
    |> put_flash(
      :info,
      "If your email is in our system and it has not been confirmed yet, " <>
        "you will receive an email with instructions shortly."
    )
    |> redirect(to: "/")
  end

  @spec edit(Plug.Conn.t(), map) :: Plug.Conn.t()
  def edit(conn, %{"token" => token}=params) do
    # check if token is valid if not redirect to "/"
    IO.inspect(params,label: "params for user edit and confirmation")
    with {:ok, query} <- UserToken.verify_email_token_query(token, "confirm"),
         %User{} = user <- Repo.one(query)
    do
      # if valid token then render edit.html with name and email prefiled
      changeset = user
      |> User.user_confirmation_changeset(%{})
      changeset.data
      |> IO.inspect(label: "User changeset")
    # TODO create a prefilled changeset for user and render values in confirmation form
    # create changeset to confirm user

    render(conn, "edit.html", token: token, changeset: changeset)
    else
      other ->
        # if not valid then redirect to "/"
        IO.inspect(other)
        conn
        |> put_flash(:error, "Invalid token url.")
        |> redirect(to: "/")
    end

  end

  # Do not log in the user after confirmation to avoid a
  # leaked token giving the user access to the account.
  def update(conn, %{"token" => token, "user" => user}=params) do
    # TODO also take name & password for the user
    # TODO verify password and passwrod veryfy match
    IO.inspect(user,label: "params for user update and confirmation")
    case Accounts.confirm_user(token) do
      {:ok, _} ->
        conn
        |> put_flash(:info, "User confirmed successfully.")
        |> redirect(to: "/")

      # TODO match for {:error, changeset} ->
        # render same page with token and changeset

      :error ->
        # If there is a current user and the account was already confirmed,
        # then odds are that the confirmation link was already visited, either
        # by some automation or by the user themselves, so we redirect without
        # a warning message.
        case conn.assigns do
          %{current_user: %{confirmed_at: confirmed_at}} when not is_nil(confirmed_at) ->
            redirect(conn, to: "/")
          %{} ->
            conn
            |> put_flash(:error, "User confirmation link is invalid or it has expired.")
            |> redirect(to: "/")
        end
    end

  end
end
