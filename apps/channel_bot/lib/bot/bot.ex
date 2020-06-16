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
    files = Helpers.get_files_id_and_types(update)
    post = %Post{ title: title, text: text, date: update.date, channel: update.chat.title, files: [] }
    post_files = if length(files) do
      Enum.map(files, fn file -> 
          path = Helpers.download_file(file.file_id)
          file = if !file.type, do: Map.put(file, :type, Helpers.get_file_type_from_ext(path)), else: file
      end)
    else
      []
    end
    Map.put(post, :files, JSON.encode(post_files))
    IO.inspect post
    # Repo.insert!(post)
  end

  def handle_info({:trigger, offset}, state) do
    IO.puts "Checking for updates #{offset}"
    case Nadia.get_updates(offset: offset, allowed_updates: ["update_id", "channel_post"]) do
      {:ok, updates} ->
        Enum.each(updates, fn(update) -> spawn(fn -> handle_update(update) end)  end)
        :erlang.send_after(2000, self(), {:trigger, Helpers.get_next_offset(updates)})
      _ -> :erlang.send_after(2000, self(), {:trigger, -1})
    end
    {:noreply, state}
  end
end
