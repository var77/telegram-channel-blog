defmodule Blog.PageController do
  use Phoenix.Controller, namespace: Blog
  import Plug.Conn
  import Blog.Router.Helpers

  def index(conn, _opts) do
    send_file conn, 200, "priv/client/dist/index.html"
  end
end