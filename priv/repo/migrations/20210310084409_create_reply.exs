defmodule InpowerComment.Repo.Migrations.CreateReply do
  use Ecto.Migration

  def change do
    create table(:reply) do
      add :reply, :string
      add :isdeletedbyadmin, :boolean, default: false, null: false
      add :userid, :integer
      add :replyid, :integer
      add :postid, :integer
      add :status, :integer
      add :likecount, :integer
      add :userlikes, :integer
      add :commentid, :integer

      timestamps()
    end

  end
end
