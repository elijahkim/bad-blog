defmodule MyBadBlog.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :content, :string, size: 1_000_000
      add :posts_id, references(:posts)

      timestamps()
    end

  end
end
