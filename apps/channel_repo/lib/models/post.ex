defmodule Post do
  use Ecto.Schema
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id # For associations

  schema "post" do
    field :title, :string
    field :video, :string
    field :photo, :string
    field :text, :string
    field :channel, :string
    field :date, :integer
  end
end