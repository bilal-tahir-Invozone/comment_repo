defmodule InpowerComment.Media do
  use Ecto.Schema
  import Ecto.Changeset

  schema "medias" do
    field :commentid, :integer
    field :media_url, :string
    field :replyid, :integer
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(media, attrs) do
    media
    |> cast(attrs, [:commentid, :status, :media_url, :replyid])
    |> validate_required([:commentid, :status, :media_url, :replyid])
  end
end
