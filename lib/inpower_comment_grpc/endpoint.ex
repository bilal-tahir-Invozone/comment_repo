defmodule InpowerCommentGrpc.Endpoint do
  use GRPC.Endpoint

  intercept(GRPC.Logger.Server)
  run(InpowerCommentGrpc.Service.Server)
end
