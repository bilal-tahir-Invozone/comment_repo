defmodule InpowerComment.Comments do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comment" do
    field :commentid, :integer
    field :comments, :string
    field :isdeletedbyadmin, :boolean, default: false
    field :likecount, :integer
    field :postid, :integer
    field :replyid, :integer
    field :status, :integer
    field :userid, :integer
    field :userlikes, :integer

    timestamps()
  end

  @doc false
  def changeset(comments, attrs) do
    comments
    |> cast(attrs, [:comments, :isdeletedbyadmin, :userid, :replyid, :postid, :status, :likecount, :userlikes, :commentid])
    |> validate_required([:comments, :isdeletedbyadmin, :userid, :replyid, :postid, :status, :likecount, :userlikes, :commentid])
  end
end
