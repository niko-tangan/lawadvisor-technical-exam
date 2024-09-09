defmodule TodolistApi.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :id, :integer
      add :description, :string
      add :is_completed, :boolean, default: false, null: false
      add :created_on, :naive_datetime
      add :modified_on, :naive_datetime
      add :deleted_on, :naive_datetime
      add :custom_order, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
