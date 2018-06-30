defmodule Blog.BlogController do
  use Phoenix.Controller, namespace: Blog
  import Plug.Conn
  import Blog.Router.Helpers


  def all(conn, params) do
    limit = if params["limit"], do: params["limit"] |> String.to_integer, else: 0
    skip = if params["skip"], do: params["skip"] |> String.to_integer, else: 0
    json conn, Repo.all(Post, limit: limit, skip: skip)
  end

  def one(conn, params) do
    case Repo.get(Post, params["id"]) do
      nil -> send_resp conn, 404, "Not found"
      post -> json conn, post
    end
  end

  def not_found(conn, _opts) do
    send_resp conn, 404, "Not found"
  end
end