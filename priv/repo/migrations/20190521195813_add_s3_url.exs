defmodule Soda.Repo.Migrations.AddS3Url do
  use Ecto.Migration

  def change do
    alter table(:photos) do
      add :url, :string
    end

  end
end
