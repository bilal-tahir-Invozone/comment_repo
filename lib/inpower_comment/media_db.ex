defmodule InpowerComment.Media_db do

  import Ecto.Query, warn: false
  alias InpowerComment.Repo
  alias InpowerComment.Media
  alias InpowerComment.Replies
  alias InpowerComment.Comments


  def list_media do
    Repo.all(Media)
  end

  def get_media!(commentid) do
    query =
      from(c in Media,
        where: c.commentid == ^commentid
      )

    {:ok, Repo.all(query)}

  end

  def create_media(attrs \\ %{}) do
    %Media{}
    |> Media.changeset(attrs)
    |> Repo.insert()
  end


  def updating_media(%Media{} = medias, attrs) do
    medias
    |> Media.changeset(attrs)
    |> Repo.update()
  end


  def delete_media(%Media{} = medias) do
    Repo.delete(medias)
  end



  def delete_media_in_repo(commentid) do
    query =
          from(c in Media,
            where:  c.commentid == ^commentid
            )


    Repo.delete_all(query)
  end


  def change_media(%Media{} = medias, attrs \\ %{}) do
    Media.changeset(medias, attrs)
  end
end
