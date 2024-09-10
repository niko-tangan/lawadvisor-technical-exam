defmodule TodolistApiWeb.TasksController do
	use Phoenix.Controller, formats: [:json]
	alias TodolistApi.Tasks

	def index(conn, _params) do
		tasks = %{tasks: Tasks.list_tasks()}
		render(conn, :index, tasks)
	end
end