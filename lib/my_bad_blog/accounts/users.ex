defmodule MyBadBlog.Accounts.Users do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyBadBlog.Accounts.Users


  schema "users" do
    field :password, :string
    field :username, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(%Users{} = users, attrs) do
    users
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
  end

  def login_changeset(user, attrs) do
    user
    |> cast(attrs, [:token])
  end
end
