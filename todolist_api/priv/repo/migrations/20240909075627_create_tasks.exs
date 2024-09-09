defmodule TodolistApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
      add :is_completed, :boolean, default: false, null: false
      add :deleted_on, :naive_datetime
      add :custom_order, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
