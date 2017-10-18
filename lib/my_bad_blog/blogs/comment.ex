defmodule MyBadBlog.Blogs.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias MyBadBlog.Blogs.Comment


  schema "comments" do
    field :content, :string
    belongs_to :posts, MyBadBlog.Blogs.Posts

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content, :posts_id])
    |> validate_required([:content, :posts_id])
  end
end
