defmodule TodolistApi.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias TodolistApi.Repo

  alias TodolistApi.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  @doc """
  Returns the ordered list of tasks.

  ## Examples

      iex> list_ordered_tasks()
      [%Task{}, ...]

  """
  def list_ordered_tasks do
    Repo.all(from t in Task, order_by: [t.custom_order, t.id])
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id, show_deleted \\ false) do
    task = Repo.get!(Task, id)
    if is_nil(task.deleted_at) || show_deleted do task else nil end
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Task.set_custom_order_if_missing()
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Soft deletes a task.

  ## Examples

      iex> soft_delete_task(task)
      {:ok, %Task{}}

      iex> soft_delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def soft_delete_task(%Task{} = task) do
    update_task(task, %{deleted_at: DateTime.utc_now()})
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  def reorder_task(%Task{} = task, new_custom_order) do
    new_custom_order = String.to_integer(new_custom_order)
    increment = if new_custom_order > task.custom_order do -1 else 1 end
    query = if new_custom_order > task.custom_order do
      from(t in Task, where: t.custom_order > ^task.custom_order and t.custom_order <= ^new_custom_order)
    else
      from(t in Task, where: t.custom_order >= ^new_custom_order and t.custom_order < ^task.custom_order)
    end

    query
    |> update(inc: [custom_order: ^increment], set: [updated_at: ^DateTime.utc_now()])
    |> Repo.update_all([])

    update_task(task, %{custom_order: new_custom_order})
    # task
    # |> Task.changeset(%{custom_order: new_custom_order})
    # |> Repo.update()
  end
end
