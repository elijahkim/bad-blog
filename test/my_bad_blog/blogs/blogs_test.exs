defmodule MyBadBlog.BlogsTest do
  use MyBadBlog.DataCase

  alias MyBadBlog.Blogs

  describe "posts" do
    alias MyBadBlog.Blogs.Posts

    @valid_attrs %{content: "some content", title: "some title"}
    @update_attrs %{content: "some updated content", title: "some updated title"}
    @invalid_attrs %{content: nil, title: nil}

    def posts_fixture(attrs \\ %{}) do
      {:ok, posts} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_posts()

      posts
    end

    test "list_posts/0 returns all posts" do
      posts = posts_fixture()
      assert Blogs.list_posts() == [posts]
    end

    test "get_posts!/1 returns the posts with given id" do
      posts = posts_fixture()
      assert Blogs.get_posts!(posts.id) == posts
    end

    test "create_posts/1 with valid data creates a posts" do
      assert {:ok, %Posts{} = posts} = Blogs.create_posts(@valid_attrs)
      assert posts.content == "some content"
      assert posts.title == "some title"
    end

    test "create_posts/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_posts(@invalid_attrs)
    end

    test "update_posts/2 with valid data updates the posts" do
      posts = posts_fixture()
      assert {:ok, posts} = Blogs.update_posts(posts, @update_attrs)
      assert %Posts{} = posts
      assert posts.content == "some updated content"
      assert posts.title == "some updated title"
    end

    test "update_posts/2 with invalid data returns error changeset" do
      posts = posts_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_posts(posts, @invalid_attrs)
      assert posts == Blogs.get_posts!(posts.id)
    end

    test "delete_posts/1 deletes the posts" do
      posts = posts_fixture()
      assert {:ok, %Posts{}} = Blogs.delete_posts(posts)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_posts!(posts.id) end
    end

    test "change_posts/1 returns a posts changeset" do
      posts = posts_fixture()
      assert %Ecto.Changeset{} = Blogs.change_posts(posts)
    end
  end

  describe "comments" do
    alias MyBadBlog.Blogs.Comment

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Blogs.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Blogs.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Blogs.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Blogs.create_comment(@valid_attrs)
      assert comment.content == "some content"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blogs.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, comment} = Blogs.update_comment(comment, @update_attrs)
      assert %Comment{} = comment
      assert comment.content == "some updated content"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Blogs.update_comment(comment, @invalid_attrs)
      assert comment == Blogs.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Blogs.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Blogs.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Blogs.change_comment(comment)
    end
  end
end
