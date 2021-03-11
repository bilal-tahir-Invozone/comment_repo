defmodule InpowerCommentGrpc.Service.Server do
  use GRPC.Server, service: Commentapi.Comment.Service

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
      IO.puts "here is comments"
      # IO.inspect getting_comment
      IO.inspect GetCommentResponse.new(comments: getting_comment)
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
    with {:ok, deleting_comment} <- InpowerComment.HandleDb.delete_comment_by_id(commentid) do
      DeleteCommentResponse.new(deleting_comment: deleting_comment)
    else
      _error ->
        Logger.info("Did not find arguments #{commentid}")
        DeleteCommentResponse.new()
    end
  end

  ################################# Replies ###########################################

  def get_reply(%tGetReplyReques{postid: postid}, _stream) do
    with {:ok, getting_reply} <- InpowerComment.HandleDb.get_replies_by_id(postid) do
      GetReplyResponse.new(getting_reply: getting_reply)
    else
      _error ->
        Logger.info("Did not find arguments #{postid}")
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
    with {:ok, deleting_reply} <- InpowerComment.HandleDb.delete_reply_by_id(replyid) do
      DeleteReplyResponse.new(deleting_reply: deleting_reply)
    else
      _error ->
        Logger.info("Did not find arguments #{replyid}")
        DeleteReplyResponse.new()
    end
  end
end
