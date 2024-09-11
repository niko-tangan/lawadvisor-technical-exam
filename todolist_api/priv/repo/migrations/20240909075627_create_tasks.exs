defmodule TodolistApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
      add :is_completed, :boolean, default: false, null: false
      add :custom_order, :integer
      add :deleted_at, :utc_datetime, null: true

      timestamps(type: :utc_datetime)
    end
  end
end
