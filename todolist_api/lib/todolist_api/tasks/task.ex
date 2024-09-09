defmodule TodolistApi.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :deleted_on, :naive_datetime
    field :custom_order, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:description, :is_completed, :deleted_on, :custom_order])
    |> validate_required([:description, :is_completed, :deleted_on, :custom_order])
  end
end
