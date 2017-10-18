defmodule MyBadBlogWeb.PostController do
  use MyBadBlogWeb, :controller

  def show(conn, %{"id" => id}) do
    post = MyBadBlog.Blogs.get_posts!(id)
    render(conn, "show.html", post: post)
  end
end
