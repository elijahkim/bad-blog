defmodule MyBadBlog.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias MyBadBlog.Repo

  alias MyBadBlog.Accounts.Users

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%Users{}, ...]

  """
  def list_users do
    Repo.all(Users)
  end

  def sign_in_user(creds) do
    try do
      get_user_from_auth(creds)
      |> log_in
      |> IO.inspect
    rescue
      _ -> {:error, "User not found"}
    end
  end

  def get_user_by(:token, token) do
    Repo.get_by!(Users, token: token)
  end

  defp log_in(user) do
    token = :crypto.strong_rand_bytes(24) |> Base.url_encode64 |> binary_part(0, 24)

    user
    |> Users.login_changeset(%{token: token})
    |> Repo.update
  end

  defp get_user_from_auth(%{"username" => username, "password" => password}) do
    Repo.get_by!(Users, username: username, password: password)
  end

  @doc """
  Gets a single users.

  Raises `Ecto.NoResultsError` if the Users does not exist.

  ## Examples

      iex> get_users!(123)
      %Users{}

      iex> get_users!(456)
      ** (Ecto.NoResultsError)

  """
  def get_users!(id), do: Repo.get!(Users, id)

  @doc """
  Creates a users.

  ## Examples

      iex> create_users(%{field: value})
      {:ok, %Users{}}

      iex> create_users(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_users(attrs \\ %{}) do
    %Users{}
    |> Users.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a users.

  ## Examples

      iex> update_users(users, %{field: new_value})
      {:ok, %Users{}}

      iex> update_users(users, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_users(%Users{} = users, attrs) do
    users
    |> Users.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Users.

  ## Examples

      iex> delete_users(users)
      {:ok, %Users{}}

      iex> delete_users(users)
      {:error, %Ecto.Changeset{}}

  """
  def delete_users(%Users{} = users) do
    Repo.delete(users)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking users changes.

  ## Examples

      iex> change_users(users)
      %Ecto.Changeset{source: %Users{}}

  """
  def change_users(%Users{} = users) do
    Users.changeset(users, %{})
  end
end
