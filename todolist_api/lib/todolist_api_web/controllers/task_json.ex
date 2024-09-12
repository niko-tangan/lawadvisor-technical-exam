defmodule TodolistApiWeb.TaskJSON do
  alias TodolistApi.Tasks.Task

  @doc """
  Renders a list of tasks.
  """
  def index(%{tasks: tasks}) do
    %{data: for(task <- tasks, do: data(task))}
  end

  @doc """
  Renders a single task.
  """
  def show(%{task: task}) do
    if not(is_nil(task)) do
      %{data: data(task)}
    else
      %{error: "Task does not exist"}
    end
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      description: task.description,
      is_completed: task.is_completed,
      custom_order: task.custom_order,
      inserted_at: task.inserted_at,
      updated_at: task.updated_at,
      deleted_at: task.deleted_at,
    }
  end
end
