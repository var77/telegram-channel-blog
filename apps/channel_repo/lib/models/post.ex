defmodule Post do
  use Ecto.Schema
  @primary_key {:id, :id, autogenerate: true}

  schema "posts" do
    field :title, :string
    field :video, :string
    field :photo, :string
    field :text, :string
    field :channel, :string
    field :date, :integer
  end
end