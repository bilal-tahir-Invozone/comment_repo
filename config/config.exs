# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :inpower_comment,
  ecto_repos: [InpowerComment.Repo]

config :grpc, start_server: true

import_config "#{Mix.env()}.exs"

config :ex_aws,
  debug_requests: true,
  access_key_id: "AKIA5PMTBW2NIVSQQKGY",
  secret_access_key: "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",
  s3: [
    scheme: "https://",
    host: "inpower2.s3.amazonaws.com",
    region: "us-east-2"
  ]

config :inpower_s3,
  bucket: "inpower2",
  region: "us-east-2",
  webroot: "inpower_comments"
