defmodule InpowerComment.Repo.Migrations.CreateMedias do
  use Ecto.Migration

  def change do
    create table(:medias) do
      add :commentid, :integer
      add :status, :string
      add :media_url, :string
      add :replyid, :integer

      timestamps()
    end

  end
end
