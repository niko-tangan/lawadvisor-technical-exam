defmodule TodolistApi.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TodolistApi.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        custom_order: 42,
        deleted_on: ~N[2024-09-08 07:56:00],
        description: "some description",
        is_completed: true
      })
      |> TodolistApi.Tasks.create_task()

    task
  end
end
