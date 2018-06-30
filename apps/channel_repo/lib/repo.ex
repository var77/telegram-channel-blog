defmodule Repo do
  use Ecto.Repo, otp_app: :channel_repo, adapter: Mongo.Ecto


end