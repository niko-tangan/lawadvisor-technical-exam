defmodule TodolistApiWeb.TasksJSON do
	alias TodolistApi.Tasks.Task

	def index(%{tasks: tasks}) do
		%{data: for(task <- tasks, do: data(task))}
	end

	defp data(%Task{} = datum) do
		%{
			description: datum.description,
			custom_id: datum.custom_id,
		}
	end
end