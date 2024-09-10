defmodule TodolistApiWeb.TasksJSON do
	alias TodolistApi.Tasks.Task

	def index(%{tasks: tasks}) do
		%{data: for(task <- tasks, do: data(task))}
	end

	defp data(%Task{} = datum) do
		%{
			id: datum.id,
			description: datum.description,
			custom_order: datum.custom_order,
			inserted_at: datum.inserted_at,
			updated_at: datum.updated_at,
			deleted_at: datum.deleted_at
		}
	end
end
