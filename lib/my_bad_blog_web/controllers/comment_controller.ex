defmodule MyBadBlogWeb.CommentController do
  use MyBadBlogWeb, :controller
  alias MyBadBlog.Blogs.Comment
  alias MyBadBlog.Blogs

  def new(conn, %{"post_id" => id}) do
    changeset = Comment.changeset(%Comment{}, %{posts_id: id})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"comment" => comment_params}) do
    case Blogs.create_comment(comment_params) do
      {:ok, blog} ->
        conn
        |> redirect(to: "/")
      {:error, changeset} ->
        IO.inspect changeset
        conn
        |> redirect(to: "/")
    end
  end
end
