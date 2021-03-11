defmodule InpowerComment.Replies do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reply" do
    field :commentid, :integer
    field :isdeletedbyadmin, :boolean, default: false
    field :likecount, :integer
    field :postid, :integer
    field :reply, :string
    field :replyid, :integer
    field :status, :integer
    field :userid, :integer
    field :userlikes, :integer

    timestamps()
  end

  @doc false
  def changeset(replies, attrs) do
    replies
    |> cast(attrs, [:reply, :isdeletedbyadmin, :userid, :replyid, :postid, :status, :likecount, :userlikes, :commentid])
    |> validate_required([:reply, :isdeletedbyadmin, :userid, :replyid, :postid, :status, :likecount, :userlikes, :commentid])
  end
end
