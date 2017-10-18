# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MyBadBlog.Repo.insert!(%MyBadBlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

for n <- (1..15) do
  MyBadBlog.Accounts.create_users(
    %{username: Faker.Internet.user_name,
      password: Faker.String.base64}
  )
end

for n <- (1..15) do
  MyBadBlog.Blogs.create_posts(
    %{title: Faker.Lorem.words(%Range{first: 1, last: 8}) |> Enum.join(" "),
      content: Faker.Lorem.paragraph(3)}
  )
end
