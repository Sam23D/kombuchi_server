defmodule KombuchiServer.Frontend do
  @moduledoc """
  The Frontend context.
  """

  import Ecto.Query, warn: false
  alias KombuchiServer.Repo
  alias KombuchiServer.Frontend.Subscribe
  alias KombuchiServer.Frontend.Seller

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
  Tries to fetch a suubscribe that matches both name and email
  """
  def maybe_subscribe_by_name_and_email(name, email)do
    qry = from subscriber in Subscribe,
      where: subscriber.name == ^name and subscriber.email == ^email

    Repo.one(qry)
  end

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


  @doc """
  Returns the list of sellers.

  ## Examples

      iex> list_sellers()
      [%Seller{}, ...]

  """
  def list_sellers do
    Repo.all(Seller)
  end

  @doc """
  Gets a single seller.

  Raises `Ecto.NoResultsError` if the Seller does not exist.

  ## Examples

      iex> get_seller!(123)
      %Seller{}

      iex> get_seller!(456)
      ** (Ecto.NoResultsError)

  """
  def get_seller!(id), do: Repo.get!(Seller, id)

  @doc """
  Creates a seller.

  ## Examples

      iex> create_seller(%{field: value})
      {:ok, %Seller{}}

      iex> create_seller(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_seller(attrs \\ %{}) do
    %Seller{}
    |> Seller.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a seller.

  ## Examples

      iex> update_seller(seller, %{field: new_value})
      {:ok, %Seller{}}

      iex> update_seller(seller, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_seller(%Seller{} = seller, attrs) do
    seller
    |> Seller.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a seller.

  ## Examples

      iex> delete_seller(seller)
      {:ok, %Seller{}}

      iex> delete_seller(seller)
      {:error, %Ecto.Changeset{}}

  """
  def delete_seller(%Seller{} = seller) do
    Repo.delete(seller)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking seller changes.

  ## Examples

      iex> change_seller(seller)
      %Ecto.Changeset{data: %Seller{}}

  """
  def change_seller(%Seller{} = seller, attrs \\ %{}) do
    Seller.changeset(seller, attrs)
  end
end
