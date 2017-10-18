defmodule MyBadBlog.Blogs.Posts do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyBadBlog.Blogs.Posts


  schema "posts" do
    field :content, :string
    field :title, :string
    has_many :comments, MyBadBlog.Blogs.Comment

    timestamps()
  end

  @doc false
  def changeset(%Posts{} = posts, attrs) do
    posts
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
