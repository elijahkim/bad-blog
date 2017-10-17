defmodule MyBadBlogWeb.PageController do
  use MyBadBlogWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
