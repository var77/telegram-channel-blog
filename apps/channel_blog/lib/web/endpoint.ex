defmodule Blog.Endpoint do
  use Phoenix.Endpoint, otp_app: :channel_blog
  plug Plug.Logger
  plug CORSPlug
  plug Plug.Parsers,
       parsers: [:urlencoded, :multipart, :json],
       pass: ["*/*"],
       json_decoder: Poison

  plug Plug.Static,
       at: "/assets", from: "priv/assets"

#  plug Plug.Static,
#       at: "/", from: "priv/"

  plug Blog.Router
end