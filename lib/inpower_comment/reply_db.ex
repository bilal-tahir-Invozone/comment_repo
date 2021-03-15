defmodule InpowerComment.Reply do

  import Ecto.Query, warn: false
  alias InpowerComment.Repo

  alias InpowerComment.Replies


  def list_Replies do
    Repo.all(Replies)
  end

  def get_reply!(commentid) do
    query = from(c in Replies,
            where:  c.commentid == ^commentid)

    {:ok, Repo.all(query)}
  end

  def create_Replies(attrs \\ %{}) do
    %Replies{}
    |> Replies.changeset(attrs)
    |> Repo.insert()
  end


  def updating_Replies(%Replies{} = replies, attrs) do
    replies
    |> Replies.changeset(attrs)
    |> Repo.update()
  end


  def delete_Replies(%Replies{} = replies) do
    Repo.delete(replies)
  end



  def delete_replyid_in_repo(replyid) do
    query = from c in Replies,
            where:  c.replyid == ^replyid

    Repo.delete_all(query)

  end



  def change_Replies(%Replies{} = replies, attrs \\ %{}) do
    Replies.changeset(replies, attrs)
  end
end
