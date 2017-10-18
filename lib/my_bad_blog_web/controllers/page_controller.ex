defmodule MyBadBlogWeb.PageController do
  use MyBadBlogWeb, :controller

  def index(conn, %{"search" => %{"term" => term}}) do
    posts = MyBadBlog.Blogs.search_posts(term)

    render conn, "index.html", posts: posts
  end

  def index(conn, _params) do
    posts = MyBadBlog.Blogs.list_posts

    render conn, "index.html", posts: posts
  end
end
