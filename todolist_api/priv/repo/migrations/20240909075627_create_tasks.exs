defmodule TodolistApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
      add :is_completed, :boolean, default: false, null: false
      add :deleted_at, :naive_datetime, null: true
      add :custom_order, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
