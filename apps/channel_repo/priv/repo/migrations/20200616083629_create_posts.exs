defmodule Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :video, :string
      add :photo, :string
      add :text, :text
      add :channel, :string
      add :date, :integer
    end
  end
end
