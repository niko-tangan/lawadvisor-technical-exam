defmodule TodolistApi.TasksTest do
  use TodolistApi.DataCase

  alias TodolistApi.Tasks

  describe "tasks" do
    alias TodolistApi.Tasks.Task

    import TodolistApi.TasksFixtures

    @invalid_attrs %{description: nil, is_completed: nil, deleted_at: nil, custom_order: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Tasks.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Tasks.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{description: "some description", is_completed: true, deleted_at: ~N[2024-09-08 07:56:00], custom_order: 42}

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.description == "some description"
      assert task.is_completed == true
      assert task.deleted_at == ~N[2024-09-08 07:56:00]
      assert task.custom_order == 42
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{description: "some updated description", is_completed: false, deleted_at: ~N[2024-09-09 07:56:00], custom_order: 43}

      assert {:ok, %Task{} = task} = Tasks.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.is_completed == false
      assert task.deleted_at == ~N[2024-09-09 07:56:00]
      assert task.custom_order == 43
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end
end
