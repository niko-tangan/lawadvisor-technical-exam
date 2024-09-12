# LawAdvisor Technical Exam
Technical Exam for LawAdvisor by Anton Nikolai Regis Tangan

#### Table of Contents  
- [Summary](#summary)  
- [Starting the Server](#starting-the-server)  
- [Important Routes](#important-routes)  
- [Checklist](#checklist)  
- [Notes on the Reorder Endpoint](#notes-on-the-reorder-endpoint)
- [Issues Encountered](#issues-encountered)  
- [Future Improvements](#future-improvements)
- [Additional Notes](#additional-notes)
- [Final Thoughts](#final-thoughts)


## Summary
This is an API for a ToDo List meant to serve as an engineering test for LawAdvisor.
No specific programming language was specified, so the stack chosen was Elxir, specifically, the Phoenix Framework, and sqlite for the database. 

Phoenix was chosen as it is already being used by LawAdvisor, and the applicant believed that this engineering test could serve as an opportunity to learn Elixir and Phoenix.

Initially Postgres was considered because it's the default of Phoenix but due to a lack of time and other factors, sqlite was used to simplify things. Traces of attempting to use Postgres though can be seen in the [dev.exs](todolist_api/config/dev.exs) file, wherein it switches the adapter to postgres when not in a development or testing environment.

## Starting the Server
These instructions assume Elixir is already installed, if not it can be installed [here](https://elixir-lang.org/install.html)


> [!NOTE]
> A Docker container w.as considered at first but due to a lack of time was not tested. The dockerfile and docker-compose.yml files are still in this repo, however.

### Steps (assuming you are in the root directory)
1. Go to the app directory: `cd todolist_api`
2. Run `mix setup` to setup the database, run the seeder, and build the assets
3. Start the server with `mix phx.server`
4. The API can now be accessed on `localhost:4000/api`
5. To confrim the database was seeded, the `localhost:4000/api/tasks` lists all the tasks in the database

## Important Routes

### API (`localhost:4000/api`)
All the API routes are scoped under the `/api` prefix

### API Docs (`localhost:4000/api/swagger`)
A Swagger UI exists in this project to make it easier to test the different endpoints.

## Requirements Checklist
### Main Endpoints
- [x] Get All
- [x] Get
- [x] Create
- [x] Update
- [x] Delete
- [x] Reorder

### Other Tasks
- [ ] Should be able to handle 1M tasks in under 5 seconds

### Bonus Tasks
- [x] Unit Tests
- [x] Soft Deleting
- [x] OpenAPI Spec
- [ ] Make a Frontend

## Notes on the Reorder Endpoint
How the reordering functionality was envisioned was that Tasks would have a `custom_order` field, which would allow them to be sorted by that field (which is why the `/ordered_tasks` endpoint exists).

To reorder then, the only data needed would be the ID of the Task to update, and the new `custom_order` field it would receive. The Task would then "move" to that custom order, and all affected rows would either increment or decrement by 1 depending on if the new `custom_order` is greater than or lower than the previous one.

More details and examples of the reordering can be found in the examples section towards the end of the document [here](todolist_api/priv/static/personal_notes.md)

## Issues Encountered
A lot of the issues encountered came about from being new to using both Phoenix and Elixir. Most of the development time was spent on learning how to do certain things in Elixir.

One of the main issues was from the FallbackController. It did not have a generic test with a Changeset argument, which made some tests fail when running `mix test`.
This issue was fixed after seeing how the FallbackController was implemented in the Phoenix documentation.

Another issue came from figuring out the `/reorder` endpoint. The algorithm was already designed when receiving these requirements, but learning how exactly to implement them and learning how to use Ecto took up a substantial amount of time.

The other requirement of *"Should be able to handle 1M tasks in under 5 seconds"* was also not properly tested.

## Future Improvements
An improvment that could be made to this API would be to add proper authentication. Like requiring a Bearer token when consuming the endpoints.

Another database like Postgres could have also been used instead of sqlite. It's already the default database used by Phoenix, and it would help if the project were to increase in size and scope. Though for now sqlite should be fine as this is a small project.

A function for bulk adjusting all the `custom_order` field could also have been implemented. This would be useful in cases where custom_order fields were manually set, or where a lot of tasks have been deleted. What this means is that it would render the tasks in order of `custom_order`, then reassign them a new `custom_order` based on their order of appearance. This would make it so that the range of `custom_order` fields would be a nice, even range that increments by 1 without skipping any numbers. 

On another note, maybe a different library for generating the Swagger UI could have been tested and used. Because currently, the PhoenixSwagger library is using OpenAPI version 2, but the latest version is 3.

## Additional Notes
Additional notes on the development of this API can be found [here](todolist_api/priv/static/personal_notes.md).
They mostly consist of stream of consciousness notes taken by the applicant to help organize their thoughts while working on this project.

## Final Thoughts
I enjoyed working on this engineering exam a lot. It gave me a chance to learn about Elxir and Phoenix. I appreciate that Phoenix has Tailwind as a dependency by default given that I'm a huge fan of Tailwind, and love working with it. It was nice to try something new; it was a lot of fun. So thanks a lot for the exam and for reading this!

***Niko Tangan***