defmodule InpowerComment.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [

      InpowerComment.Repo,
      {GRPC.Server.Supervisor, {InpowerCommentGrpc.Endpoint, 8080}},

    ]

    opts = [strategy: :one_for_one, name: InpowerComment.Supervisor]
    Supervisor.start_link(children, opts)
  end


end
