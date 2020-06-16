# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# By default, the umbrella project as well as each child
# application will require this configuration file, ensuring
# they all use the same configuration. While one could
# configure all applications here, we prefer to delegate
# back to each application for organization purposes.
import_config "../apps/*/config/config.exs"

# Sample configuration (overrides the imported configuration above):
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]

config :nadia,
       token: "1099439215:AAGtpUnr1wwiZuParBM0QYYO4QSIDpUwnWg"

config :channel_bot,
       asset_path: "priv/assets",
       server_url: "http://localhost:4000/assets"

config :channel_repo, Repo,
       database: "channel_blog",
       hostname: "localhost",
       username: "postgres"