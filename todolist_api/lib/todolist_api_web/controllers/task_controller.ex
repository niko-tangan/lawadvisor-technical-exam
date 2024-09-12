defmodule TodolistApiWeb.TaskController do
  use TodolistApiWeb, :controller
  use PhoenixSwagger

  alias TodolistApi.Tasks
  alias TodolistApi.Tasks.Task

  action_fallback TodolistApiWeb.FallbackController

  swagger_path :index do
    get "/api/tasks"
    summary "List all Tasks"
    description "List all Tasks"
    response 200, "Ok", Schema.ref(:Tasks)
  end
  def index(conn, _params) do
    tasks = Tasks.list_tasks()
    render(conn, :index, tasks: tasks)
  end

  swagger_path :ordered_tasks do
    get "/api/ordered_tasks"
    summary "List all Tasks ordered by custom_order"
    description "List all Tasks ordered by custom_order"
    response 200, "Ok", Schema.ref(:Tasks)
  end
  def ordered_tasks(conn, _params) do
    tasks = Tasks.list_ordered_tasks()
    render(conn, :index, tasks: tasks)
  end

  swagger_path :show do
    get "/api/tasks/{id}"
    summary "Lists a Task with a given ID"
    description "Lists a Task with a given ID"
    response 200, "Ok", Schema.ref(:Task)
    parameters do
      id(:path, :integer, "Task ID", required: true, example: 3)
    end
  end
  def show(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)
    conn = case task do
      nil -> conn |> put_status(404)
      _ -> conn
    end
    render(conn, :show, task: task)
  end

  swagger_path :create do
    post "/api/tasks/"
    summary "Creates a new Task"
    description "Creates a new Task"
    response 200, "Ok", Schema.ref(:Task)
    consumes "application/json"
    produces "application/json"
    parameters do
      task(:body, Schema.ref(:UpdateTask), "The task details")
    end
  end
  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tasks/#{task}")
      |> render(:show, task: task)
    end
  end

  swagger_path :update do
    patch "/api/tasks/{id}"
    summary "Updates a Task with a given ID"
    description "Updates a Task with a given ID"
    response 200, "Ok", Schema.ref(:Task)
    consumes "application/json"
    produces "application/json"
    parameters do
      id(:path, :integer, "Task ID", required: true, example: 3)
      task(:body, Schema.ref(:UpdateTask), "The task details",
        example: %{
          task: %{
            description: "Sample Updated Description", is_completed: true
          }
        }
      )
    end
  end
  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.update_task(task, task_params) do
      render(conn, :show, task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{}} <- Tasks.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end

  def reorder(conn, %{"id" => id, "new_custom_order" => new_custom_order}) do
    task = Tasks.get_task!(id)

    with {:ok, %Task{} = task} <- Tasks.reorder_task(task, new_custom_order) do
      render(conn, :show, task: task)
    end
  end

  def swagger_definitions do
    %{
      Task: swagger_schema do
        title "Task"
        description "A Task on the ToDo List"
        properties do
          id :integer, "The ID of the Task"
          description :string, "The description of the Task", required: true
          is_completed :boolean, "Whether the Task is completed or not", required: true
          custom_order :integer, "The custom order of the Task"
          inserted_at :string, "When the Task was initially inserted", format: "ISO-8601"
          updated_at :string, "When the Task was last updated", format: "ISO-8601"
          deleted_at :string, "When the Task was completed", format: "ISO-8601"
        end
        example %{
          data: %{
            id: 3,
            description: "Task 3",
            is_completed: false,
            custom_order: 2,
            inserted_at: "2024-09-11T18:31:13Z",
            updated_at: "2024-09-11T18:32:10Z",
            deleted_at: nil
          }
        }
      end,
      TaskItem: swagger_schema do
        title "Task"
        description "A Task as rendered in a list"
        properties do
          id :integer, "The ID of the Task"
          description :string, "The description of the Task", required: true
          is_completed :boolean, "Whether the Task is completed or not", required: true
          custom_order :integer, "The custom order of the Task"
          inserted_at :string, "When the Task was initially inserted", format: "ISO-8601"
          updated_at :string, "When the Task was last updated", format: "ISO-8601"
          deleted_at :string, "When the Task was completed", format: "ISO-8601"
        end
        example %{
            id: 3,
            description: "Task 3",
            is_completed: false,
            custom_order: 2,
            inserted_at: "2024-09-11T18:31:13Z",
            updated_at: "2024-09-11T18:32:10Z",
            deleted_at: nil
        }
      end,
      UpdateTask: swagger_schema do
        title "Update Task"
        description "An object with data to update on a Task"
        properties do
          description :string, "The description of the Task", required: true
          is_completed :boolean, "Whether the Task is completed or not", required: true
          custom_order :integer, "The custom order of the Task"
          deleted_at :string, "When the Task was completed", format: "ISO-8601"
        end
        example %{
          task: %{
            description: "Task 3",
            is_completed: false,
            custom_order: 2,
          }
      }
      end,
      Tasks: swagger_schema do
        title "Tasks"
        description "All tasks"
        type :array
        items Schema.ref(:TaskItem)
      end,
      Error: swagger_schema do
        title "Errors"
        description "Error responses from the ToDo List API"
        properties do
          error :string, "The message of the error raised", required: true
        end
      end
    }
  end
end
