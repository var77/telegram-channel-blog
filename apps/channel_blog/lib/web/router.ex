defmodule Blog.Router do
  use Phoenix.Router
  import Plug.Conn
  import Phoenix.Controller

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/blog", Blog do
    pipe_through :api
    get "/health", BlogController, :health
    get "/posts", BlogController, :all
    get "/post/:id", BlogController, :one

  end

  get "/", Blog.PageController, :index
  get "/*path", Blog.BlogController, :not_found

end