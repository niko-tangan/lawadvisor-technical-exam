# LawAdvisor Technical Exam
Technical Exam for LawAdvisor by Anton Nikolai Regis Tangan

#### Table of Contents  
[Summary](#summary)  
[Starting the Server](#starting-the-server)  
[Important Routes](#important-routes)  
[Checklist](#checklist)  
[Issues Encountered](#issues-encountered)  
[Future Improvements](#future-improvements)
[Notes on the Reorder Endpoint](#notes-on-the-reorder-endpoint)  
[Additional Notes](#additional-notes)


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

## Issues Encountered

## Future Improvements

## Notes on the Reorder Endpoint

## Additional Notes
Additional notes on the development of this API can be found [here](todolist_api/priv/static/personal_notes.md).
They mostly consist of stream of consciousness notes taken by the applicant to help organize their thoughts while working on this project.