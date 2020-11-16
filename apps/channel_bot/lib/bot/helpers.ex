defmodule ChannelBot.Helpers do

  def get_title(update) do
    cond do
      update.caption -> update.caption |> get_first_line# |> make_short_title
      update.text -> update.text |> get_first_line# |> make_short_title
      true -> ""
    end
  end

  def get_text(update) do
    text = cond do
      update.caption -> update.caption
      update.text -> update.text
      true -> ""
    end
    text_parts = String.split(text, "\n")
    count = length(text_parts)
    
    cond do
      count > 1 -> text_parts |> tl |> Enum.join("\n")
      true -> text
    end
  end

  def get_file_ext(path) do
    arr = String.split(path, ".")
    Enum.at(arr, length(arr) - 1)
  end

  def make_short_title(str), do: String.slice(str, 0, 15) <> if String.length(str) > 15, do: "...", else: ""

  def get_first_line(str), do: String.split(str, "\n") |> hd
  
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
    { Path.join(Application.get_env(:channel_bot, :server_url), file_name), file_path }
  end

  def get_file_name(path) do
    arr = String.split(path, "/")
    Enum.at(arr, length(arr) - 1)
  end

  def get_file_type_from_ext(name) do
    ext = get_file_ext(name)

    cond do
      String.match?(ext, ~r/mp4|mov|ogg|mpeg|gif/i) -> :video
      String.match?(ext, ~r/jpe?g|png|svg/i) -> :photo
      true -> ext
    end
  end

  def get_file_id_and_type(update) do
    photos_length = length(update.photo)
    cond do
      photos_length > 0 -> %{type: :photo, file_id: Enum.at(update.photo, photos_length - 1).file_id}
      update.video -> %{type: :video, file_id: update.video.file_id}
      update.document -> %{type: nil, file_id: update.document.file_id}
      true -> nil
    end
  end

  def get_next_offset(updates) do
    update = Enum.at(updates, length(updates) - 1)
    if update, do: update.update_id + 1, else: -1
  end

  def upload_to_s3(path) do
    # Get file extension
    file_name = get_file_name(path)
    file_uuid = UUID.uuid4(:hex) 
    unique_filename = "#{file_uuid}-#{file_name}"
    {:ok, binary} = File.read(path)
    bucket_name = System.get_env("BUCKET_NAME")
    region = System.get_env("AWS_REGION") || "eu-central-1"

    {:ok, body} = 
      ExAws.S3.put_object(bucket_name, unique_filename, binary)          
      |> ExAws.request(region: region)
    
    remove_file(path)
    # return the image url and add to the params to be stored
    "https://#{bucket_name}.s3.amazonaws.com/#{bucket_name}/#{unique_filename}"
  end

  def remove_file(path) do
    File.rm_rf(path)
  end
end
