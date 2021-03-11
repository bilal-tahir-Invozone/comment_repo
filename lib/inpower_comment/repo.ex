defmodule InpowerComment.Repo do
  use Ecto.Repo,
    otp_app: :inpower_comment,
    adapter: Ecto.Adapters.Postgres
end
