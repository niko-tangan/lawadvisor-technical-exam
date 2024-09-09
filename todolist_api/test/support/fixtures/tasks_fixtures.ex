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
        created_on: ~N[2024-09-08 07:22:00],
        custom_order: 42,
        deleted_on: ~N[2024-09-08 07:22:00],
        description: "some description",
        id: 42,
        is_completed: true,
        modified_on: ~N[2024-09-08 07:22:00]
      })
      |> TodolistApi.Tasks.create_task()

    task
  end
end
