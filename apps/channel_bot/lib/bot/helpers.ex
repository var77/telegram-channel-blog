defmodule ChannelBot.Helpers do

  def get_title(update) do
    cond do
      update.caption -> update.caption |> get_first_line |> make_short_title
      update.text -> update.text |> get_first_line |> make_short_title
      true -> ""
    end
  end

  def get_text(update) do
    cond do
      update.caption -> update.caption
      update.text -> update.text
      true -> ""
    end
  end

  def make_short_title(str), do: String.slice(str, 0, 15) <> if String.length(str) > 15, do: "...", else: ""

  def get_first_line(str), do: String.split(str, "\n") |> hd

  def download_file(file_id) do
    {:ok, file} = Nadia.get_file(file_id)
    token = Application.get_env(:nadia, :token)
    asset_path = Application.get_env(:channel_bot, :asset_path)
    %HTTPoison.Response{body: body} = HTTPoison.get!("https://api.telegram.org/file/bot#{token}/#{file.file_path}")
    file_name = get_file_name(file.file_path)
    File.mkdir(asset_path)
    file_path = Path.join([File.cwd!, asset_path, file_name])
    File.write!(file_path, body)
    Path.join(Application.get_env(:channel_bot, :server_url), file_name)
  end

  def get_file_name(path) do
    arr = String.split(path, "/")
    Enum.at(arr, length(arr) - 1)
  end

  def get_file_id_and_type(update) do
    photos_length = length(update.photo)
    cond do
      photos_length > 0 -> %{type: :photo, file_id: Enum.at(update.photo, photos_length - 1).file_id}
      update.video -> %{type: :video, file_id: update.video.file_id}
      true -> nil
    end
  end

  def get_next_offset(updates) do
    update = Enum.at(updates, length(updates) - 1)
    if update, do: update.update_id + 1, else: -1
  end
end
