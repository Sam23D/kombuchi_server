defmodule KombuchiServer.Frontend do
  @moduledoc """
  The Frontend context.
  """

  import Ecto.Query, warn: false
  alias KombuchiServer.Repo

  alias KombuchiServer.Frontend.Subscribe

  @doc """
  Returns the list of subscribers.

  ## Examples

      iex> list_subscribers()
      [%Subscribe{}, ...]

  """
  def list_subscribers do
    Repo.all(Subscribe)
  end

  @doc """
  Gets a single subscribe.

  Raises `Ecto.NoResultsError` if the Subscribe does not exist.

  ## Examples

      iex> get_subscribe!(123)
      %Subscribe{}

      iex> get_subscribe!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subscribe!(id), do: Repo.get!(Subscribe, id)

  @doc """
  Creates a subscribe.

  ## Examples

      iex> create_subscribe(%{field: value})
      {:ok, %Subscribe{}}

      iex> create_subscribe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subscribe(attrs \\ %{}) do
    %Subscribe{}
    |> Subscribe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subscribe.

  ## Examples

      iex> update_subscribe(subscribe, %{field: new_value})
      {:ok, %Subscribe{}}

      iex> update_subscribe(subscribe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subscribe(%Subscribe{} = subscribe, attrs) do
    subscribe
    |> Subscribe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subscribe.

  ## Examples

      iex> delete_subscribe(subscribe)
      {:ok, %Subscribe{}}

      iex> delete_subscribe(subscribe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subscribe(%Subscribe{} = subscribe) do
    Repo.delete(subscribe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subscribe changes.

  ## Examples

      iex> change_subscribe(subscribe)
      %Ecto.Changeset{data: %Subscribe{}}

  """
  def change_subscribe(subscribe, attrs \\ %{})

  def change_subscribe(nil, attrs) do
    Subscribe.changeset(%Subscribe{}, attrs)
  end
  def change_subscribe(%Subscribe{} = subscribe, attrs) do
    Subscribe.changeset(subscribe, attrs)
  end
end
