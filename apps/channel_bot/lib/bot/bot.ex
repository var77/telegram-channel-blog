defmodule ChannelBot.Bot do
  use GenServer
  alias ChannelBot.Helpers

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [name: :channel_bot_handler])
  end

  def init(_opts) do
    :erlang.send_after(2000, self(), {:trigger, -1})
    {:ok, {}}
  end

  def handle_update(update) do
    update = update.channel_post

    title = Helpers.get_title(update)
    text = Helpers.get_text(update)
    file = Helpers.get_file_id_and_type(update)
    post = %Post{ title: title, text: text, date: update.date, channel: update.chat.title }

    post = if file do
      path = Helpers.download_file(file.file_id)
      Map.put(post, file.type, path)
    else post
    end

    IO.inspect post
    Repo.insert!(post)
  end

  def handle_info({:trigger, offset}, state) do
#    IO.puts :"Checking for updates #{offset}"
    case Nadia.get_updates(offset: offset, allowed_updates: ["update_id", "channel_post", "edited_channel_post"]) do
      {:ok, updates} ->
        Enum.each(updates, fn(update) -> spawn(fn -> handle_update(update) end)  end)
        :erlang.send_after(2000, self(), {:trigger, Helpers.get_next_offset(updates)})
      _ -> nil
    end
    {:noreply, state}
  end
end
