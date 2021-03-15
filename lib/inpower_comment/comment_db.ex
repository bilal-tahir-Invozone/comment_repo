defmodule InpowerComment.Comment do

  import Ecto.Query, warn: false
  alias InpowerComment.Repo
  alias InpowerComment.Replies
  alias InpowerComment.Comments


  def list_comments do
    Repo.all(Comments)
  end

  def get_comments!(postid) do
    query =
      from(c in Comments,
        where: c.postid == ^postid
      )

    {:ok, Repo.all(query)}

  end

  def create_comments(attrs \\ %{}) do
    %Comments{}
    |> Comments.changeset(attrs)
    |> Repo.insert()
  end


  def updating_comments(%Comments{} = comments, attrs) do
    comments
    |> Comments.changeset(attrs)
    |> Repo.update()
  end


  def delete_comments(%Comments{} = comments) do
    Repo.delete(comments)
  end



  def delete_comments_in_repo(commentid) do
    query =
          from(c in Comments,
            where:  c.commentid == ^commentid
            )

    delete_reply_by_commentid_in_repo(commentid)
    Repo.delete_all(query)
  end

  defp delete_reply_by_commentid_in_repo(commentid) do
    query =
            from(c in Replies,
            where:  c.commentid == ^commentid
            )

    Repo.delete_all(query)

  end

  def change_comments(%Comments{} = comments, attrs \\ %{}) do
    Comments.changeset(comments, attrs)
  end
end
