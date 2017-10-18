defmodule MyBadBlogWeb.SessionController do
  use MyBadBlogWeb, :controller
  alias MyBadBlog.Accounts.Users
  alias MyBadBlog.Accounts

  def new(conn, _params) do
    changeset = Users.changeset(%Users{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"users" => user}) do
    case Accounts.sign_in_user(user) do
      {:ok, user} ->
        conn
        |> put_resp_cookie("my_token", user.token, http_only: false)
        |> put_flash(:info, "Signed in")
        |> redirect(to: "/")
      {:error, reason} ->
        changeset = Users.changeset(%Users{}, %{})

        conn
        |> put_flash(:error, "Failed to sign in")
        |> render("new.html", changeset: changeset)
    end
  end
end
