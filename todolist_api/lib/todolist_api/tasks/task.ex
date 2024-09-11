defmodule TodolistApi.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "tasks" do
    field :description, :string
    field :is_completed, :boolean, default: false
    field :deleted_at, :naive_datetime
    field :custom_order, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  defp set_custom_order_if_missing(%Ecto.Changeset{data: %TodolistApi.Tasks.Task{custom_order: nil}} = changeset) do
    query = from t in TodolistApi.Tasks.Task, select: t.id, order_by: [{:desc, :inserted_at}], limit: 1
    most_recent_id = TodolistApi.Repo.one(query) + 1

    changeset
    |> put_change(:custom_order, most_recent_id)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:description, :is_completed, :deleted_at, :custom_order])
    |> set_custom_order_if_missing()
    |> validate_required([:description, :is_completed])
  end
end
