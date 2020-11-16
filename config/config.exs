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
       token: System.get_env("BOT_TOKEN")

config :channel_bot,
       asset_path: "priv/assets",
       server_url: System.get_env("SERVER_URL") || "http://localhost:4000/assets"

config :channel_blog, Blog.Endpoint,
       http: [port: System.get_env("PORT") || 4000]

config :channel_repo, Repo,
       database: System.get_env("DATABASE") || "telegram-channel-blog",
       hostname: System.get_env("DB_HOSTNAME") || "localhost",
       port: System.get_env("DB_PORT") || 5432,
       username: System.get_env("DB_USERNAME") || "postgres",
       password: System.get_env("DB_PASSWORD")

config :ex_aws,
        access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
        secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
        region: System.get_env("AWS_REGION"),
        s3: [ 
            scheme: "https://", 
            host: ~s(#{System.get_env("BUCKET_NAME")}.s3.#{System.get_env("AWS_REGION")}.amazonaws.com), 
            region: System.get_env("AWS_REGION"),
        ]