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
    # If there are files download the files
    post = if file do
      {url, file_path} = Helpers.download_file(file.file_id)
      file = if !file.type, do: Map.put(file, :type, Helpers.get_file_type_from_ext(url)), else: file
      # After the files is downloaded check if there's 
      # AWS bucket configs upload file to bucket and remove from disk
      url = if System.get_env("AWS_SECRET_ACCESS_KEY") do
          Helpers.upload_to_s3(file_path)
        else url
      end

      Map.put(post, file.type, url)
    else post
    end

    IO.inspect post
    Repo.insert!(post)
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
