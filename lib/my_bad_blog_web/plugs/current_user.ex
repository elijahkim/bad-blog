defmodule MyBadBlogWeb.Plugs.CurrentUser do
  import Plug.Conn

  def init(args) do
    args
  end

  def call(conn, _) do
    conn
    |> assign(:current_user, get_current_user(conn))
  end

  defp get_current_user(conn) do
    token = conn.cookies["my_token"]

    try do
      MyBadBlog.Accounts.get_user_by(:token, token)
    rescue
      _ -> %MyBadBlog.Accounts.Users{username: "Guest"}
    end
  end
end

