defmodule TodolistApi.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :id, :integer
    field :description, :string
    field :is_completed, :boolean, default: false
    field :created_on, :naive_datetime
    field :modified_on, :naive_datetime
    field :deleted_on, :naive_datetime
    field :custom_order, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:id, :description, :is_completed, :created_on, :modified_on, :deleted_on, :custom_order])
    |> validate_required([:id, :description, :is_completed, :created_on, :modified_on, :deleted_on, :custom_order])
  end
end
