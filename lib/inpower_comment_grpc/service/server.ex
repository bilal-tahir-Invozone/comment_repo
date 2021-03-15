defmodule InpowerCommentGrpc.Service.Server do
  use GRPC.Server, service: Commentapi.CommentService.Service

  alias Commentapi.{
    CreateCommentRequest,
    CreateCommentResponse,

    GetCommentRequest,
    GetCommentResponse,

    DeleteCommentRequest,
    DeleteCommentResponse,

    UpdateCommentRequest,
    UpdateCommentResponse,

    CreateReplyRequest,
    CreateReplyResponse,

    GetReplyRequest,
    GetReplyResponse,

    DeleteReplyRequest,
    DeleteReplyResponse,

    UpdateReplyRequest,
    UpdateReplyResponse

  }

  alias InpowerComment.HandleDb

  require Logger

  ####################### Comments #####################################################3

  def get_comment(%GetCommentRequest{postid: postid}, _stream) do
    with {:ok, getting_comment} <- InpowerComment.HandleDb.get_comment_by_id(postid) do
      comment =
      getting_comment
      |> Enum.map(fn(x) -> Map.from_struct(x) end)

      GetCommentResponse.new(comments: comment) |> IO.inspect

    else
      _error ->
        Logger.info("Did not find arguments #{postid}")
        GetCommentResponse.new()
    end
  end

  def create_comment(%CreateCommentRequest{comment: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, likecount: likecount, userlikes: userlikes, commentid: commentid}, _stream) do
    with {:ok, creating_comment} <- InpowerComment.HandleDb.create_comments_in_Table(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do
      CreateCommentResponse.new(creating_comment: creating_comment)
    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        CreateCommentResponse.new()
    end
  end

  def update_comment(%UpdateCommentRequest{comment: comment, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, likecount: likecount, userlikes: userlikes, commentid: commentid}, _stream) do
    with {:ok, updating_comment} <- InpowerComment.HandleDb.update_comments_in_table(comment, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do
      UpdateCommentResponse.new(updating_comment: updating_comment)
    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        UpdateCommentResponse.new()
    end
  end

  def delete_comment(%DeleteCommentRequest{commentid: commentid}, _stream) do
    with {1, deleting_comment} <- InpowerComment.HandleDb.delete_comment_by_id(commentid) do
      case deleting_comment do
        nil ->
          DeleteCommentResponse.new(status: true)
        _ ->
          DeleteCommentResponse.new(status: false)
      end

    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        DeleteCommentResponse.new()
    end
  end

  ################################# Replies ###########################################

  def get_reply(%GetReplyRequest{commentid: commentid}, _stream) do
    with {:ok, getting_reply} <- InpowerComment.HandleDb.get_replies_by_id(commentid) do

      replies =
      getting_reply
      |> Enum.map(fn(x) -> Map.from_struct(x) end)

      GetReplyResponse.new(replies: replies) |> IO.inspect
    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        GetReplyResponse.new()
    end
  end

  def create_reply(%CreateReplyRequest{reply: reply, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, likecount: likecount, userlikes: userlikes, commentid: commentid}, _stream) do
    with {:ok, creating_reply} <- InpowerComment.HandleDb.create_replies_in_Table(isdeletedbyadmin, userid,  reply, replyid, postid, status, userlikes, likecount, commentid) do
      CreateReplyResponse.new(creating_reply: creating_reply)
    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        CreateReplyResponse.new()
    end
  end

  def update_reply(%UpdateReplyRequest{reply: reply, isdeletedbyadmin: isdeletedbyadmin, userid: userid, replyid: replyid, postid: postid, status: status, likecount: likecount, userlikes: userlikes, commentid: commentid}, _stream) do
    with {:ok, updating_reply} <- InpowerComment.HandleDb.update_reply_in_table(reply, isdeletedbyadmin, userid,  replyid, postid, status, userlikes, likecount, commentid) do
      UpdateReplyResponse.new(updating_reply: updating_reply)
    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        UpdateReplyResponse.new()
    end
  end

  def delete_reply(%DeleteReplyRequest{replyid: replyid}, _stream) do
    with {1, deleting_reply} <- InpowerComment.HandleDb.delete_reply_by_id(replyid) do
      case deleting_reply do
      nil ->
        DeleteReplyResponse.new(status: true)
      _ ->
        DeleteReplyResponse.new(status: false)
      end
    else
      _error ->
        Logger.info("Did not find arguments #{replyid}")
        DeleteReplyResponse.new()
    end
  end
end
