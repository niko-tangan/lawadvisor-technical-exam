# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TodolistApi.Repo.insert!(%TodolistApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TodolistApi.Tasks

# Read quotes from the JSON file
tasks_path = "priv/repo/tasks.json"
tasks_path
|> File.read!()
|> Jason.decode!()
|> Enum.each(fn attrs ->
	# Construct a quote struct and attempt to insert it
	task = %{description: attrs["description"], custom_order: attrs["custom_order"]}
	case Tasks.create_task(task) do
		{:ok, _task} -> :ok
		{:error, _changeset} -> :duplicate
	end
end)
