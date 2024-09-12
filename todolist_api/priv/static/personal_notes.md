# LawAdvisor Technical Exam
Technical Exam for LawAdvisor by Anton Nikolai Regis Tangan

## September 9, Monday
Hi, I'm treating this initial README as somewhat of a dev log just to explain my thought processes and as a better way to personally track my day-to-day progress. I'll probably move this somewhere else once the API is done so that there's an actual, proper README with instructions here.

I'll be using Elixir and Phoenix to make this, since if I get the job with LawAdvisor I'd need to learn them anyway.
I'll also using sqlite as the database.

## September 10-11, Tuesday-Wednesday

Didn't have as much time to work on this so I'm combining Tuesday and Wednesday into one entry.
I experimented with the generator and stuff. It's nice to have the API scaffolded for me.
Mainly got stuck on two things.

1. 2 auto generated tests would fail.
2. The reordering endpoint

For the tests, I was just running `mix test` but it would error for some reason.
By reading the Phoenix docs I found that the FallbackController was missing a function.
So I had to make like a generic one that had a Changeset as the argument? I still don't fully understand it, I'm just happy it worked.

The other thing I got stuck on was the reordering endpoint. I knew what it was supposed to do, I just got stuck on figuring out how to implement it. To use the reordering endpoint, you just need to specify the ID to reorder, and to what `custom_order` you want it to be in. Then based on if the new order is less than or greater than the old one, it'll set the value, then get a range of affected elements and either increment or decrement their values.

What stumped me was figuring out how to use Ecto, specifically using the update_all method. It's a little embarassing to admit but I got stuck for the longest time because in my where clause I used an atom to specify the `custom_order` column instead of just referring to it as `t.custom_order` (`t` because my from was `t in Task`).

But now at least the reordering is done. Which means all of the required endpoints are done. All that's left to do is maybe add the reordering stuff to the test cases and fix this readme so that it actually just tells you how it works.

I should probably also try to add an OpenAPI spec just so it'll be easier to test this out. But I also wanna try actually rendering a frontend for this since Phoenix has Tailwind as a dependency by default which is really cool. And I'm kinda curious about how LiveView works from reading about it. But I'll focus on the important stuff first like documenting how to use this API and making the readme nice and whatever.

## September 12, Thursday

Ok don't really have time to make a frontend right now but I can always do that next time if I wanna keep learning phoenix/elixir.
I was considering eventually changing the db to postgres but it might take a while for it to setup given it keeps erroring on the laptop I'm using right now.
Because ever since getting the technical requirements for the exam I've had no internet at home.
I've had to be away from my usual setup and borrow a laptop from a friend. On a side note I found out my net died at home because squirrels chewed through the line.

Other than that though I was able to complete the API and added a Swagger UI so it would be easier to use and test the API.
I just got a little stuck earlier today while cleaning up and testing my code though, but it should be okay now.
Just need to finish the readme and move this dev log type thing somewhere else.

## Notes

### Task/TodoListItem (maybe task is the better name)
- id (auto increment)
- description (string, default "")
- is_completed (bool, default False)
- deleted_at (if soft deleting is implemented)
- inserted_on
- updated_on
- custom_order (default to id)

### How custom order could work
- specify new position
- set task to new position
- if new_pos > old_pos: (old_pos, new_pos] - 1
- if new_pos < old_pos: [new_pos, old_pos) + 1

#### example (so it's easier to visualize):
id:     0 1 2 3 4
custom: 1 2 3 4 5

move position 3 to position 5:
set id  2 to pos 5
(3,5] = 4,5 - 1
0 1 3 4 2
1 2 3 4 5

move position 4 to position 1
set id 4 to pos 1
[1, 4) = 1,2,3 + 1
4 0 1 3 2
1 2 3 4 5

## Commands Cheatsheet (can refer to mix.exs to read more commands or add your own)?
mix local.hex - install hex (dependency manager)
mix archive.install hex phx_new - phoenix project generator
mix phx.new todolist-api - new phoenix project
mix phx.gen.context Tasks Task tasks description:string is_completed:boolean deleted_at:naive_datetime custom_order:integer - generate context
mix phx.gen.html Tasks Task tasks description:string is_completed:boolean deleted_at:naive_datetime custom_order:integer --no-context --no-schema  - generate crud
mix phx.gen.json Tasks Task tasks description:string is_completed:boolean deleted_at:naive_datetime custom_order:integer --no-context --no-schema  --web api - generate json api
mix ecto.migrate - migrates db
mix hex.docs offline elixir - downloads docs for offline viewing
