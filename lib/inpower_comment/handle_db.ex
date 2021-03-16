defmodule InpowerComment.HandleDb do
  import Ecto.Query, warn: false
  alias InpowerComment.Repo
  alias InpowerComment.Comment
  alias InpowerComment.Comments
  alias InpowerComment.Replies
  alias InpowerComment.Reply
  alias InpowerComment.Media_db


  def create_comments_in_Table(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid, media_url) do


    case InpowerS3.base64_to_upload(media_url, "comments/replies") do
      {:ok, media_url} ->
        InpowerComment.Media_db.create_media( %{
          commentid: commentid,
          replyid: replyid,
          status: "True",
          media_url: media_url
       })
      {:error, _} ->
        {:error, "Failed to upload Media file"}
      end

    InpowerComment.Comment.create_comments( %{
      comments: comment,
      isdeletedbyadmin: isdeletedbyadmin,
      userid: userid,
      replyid: replyid,
      postid: postid,
      status: status,
      likecount: likecount,
      userlikes: userlikes,
      commentid: commentid
     })

  end

  def get_posts_comment() do
    InpowerComment.Comment.list_comments()
  end

  def get_comment_by_id(postid) do
    InpowerComment.Comment.get_comments!(postid)
  end

  def update_comments_in_table(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do

    query = from c in Comments,
            where:  c.commentid == ^commentid


    change_data = Repo.all(query) |> Enum.at(0)
    InpowerComment.Comment.updating_comments(change_data,
      %{
        comments: comment,
        isdeletedbyadmin: isdeletedbyadmin,
        userid: userid,
        replyid: replyid,
        postid: postid,
        status: status,
        likecount: likecount,
        userlikes: userlikes,

      })
  end


  def delete_comment_by_id(commentid) do
    InpowerComment.Comment.delete_comments_in_repo(commentid)
  end

  def delete_reply_by_id(replyid) do
    InpowerComment.Reply.delete_replyid_in_repo(replyid)

  end

  def get_replies_by_id(commentid) do
    InpowerComment.Reply.get_reply!(commentid)
  end

  def create_replies_in_Table(isdeletedbyadmin, userid,  reply, replyid, postid, status, userlikes, likecount, commentid, media_url) do


    query = from c in Comments,
            where:  c.commentid == ^commentid
    get_comment_for_reply = Repo.all(query) |> Enum.at(0)


    case get_comment_for_reply do
      nil ->
        {:error, "false"}
      _ ->


        case InpowerS3.base64_to_upload(media_url, "comments/replies") do
          {:ok, _} ->
            InpowerComment.Media_db.create_media( %{
              commentid: commentid,
              replyid: replyid,
              status: "True",
              media_url: media_url
           })
          {:error, _} ->
            {:error, "Failed to upload Media file"}
          end



        InpowerComment.Reply.create_Replies( %{
          isdeletedbyadmin: isdeletedbyadmin,
          userid: userid,
          reply: reply,
          replyid: replyid,
          postid: postid,
          status: status,
          likecount: likecount,
          userlikes: userlikes,
          commentid: commentid
         })


    end
  end

  def update_reply_in_table(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do

    query = from c in Replies,
            where:  c.replyid == ^replyid

    change_data = Repo.all(query) |> Enum.at(0)
    InpowerComment.Reply.updating_Replies(change_data,
      %{
        reply: reply,
        isdeletedbyadmin: isdeletedbyadmin,
        userid: userid,
        replyid: replyid,
        postid: postid,
        status: status,
        likecount: likecount,
        userlikes: userlikes,
      })

  end
end
