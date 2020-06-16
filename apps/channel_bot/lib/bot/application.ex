defmodule ChannelBot.Application do
  use Supervisor

  def start(_type, _opts) do
    children = [
      ChannelBot.Bot
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: TelegramChannelBlog)
  end

  def init(_opts), do: nil

end