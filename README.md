# LawAdvisor Technical Exam
Technical Exam for LawAdvisor by Anton Nikolai Regis Tangan

# September 9, Monday
Hi, I'm treating this initial README as somewhat of a dev log just to explain my thought processes and as a better way to personally track my day-to-day progress. I'll probably move this somewhere else when the API is done so that there's an actual, proper README here.

I'll also be using this as a chance to start learning Elixir and Phoenix, since if I get the job with LawAdvisor I'd need to learn them anyway.

## TODO

So to make a checklist for what needs to be done it's just a todo list API (endpoints should return JSON)

### Main Endpoints
- [ ] /tasks (get all)
- [ ] /tasks/{id} (get one)
- [ ] /tasks/{id} (patch)
- [ ] /tasks/{id} (delete) (maybe add soft deleting? as a treat?)

### Other Tasks
- [ ] Add reordering (maybe add a custom_id or custom_order field to the ToDoListItem?)

- [ ] Should be able to handle 1M tasks in under 5 seconds

### Bonus Tasks
- [ ] Add unit tests?
- [ ] Make a frontend? (just so i have an excuse to try out the liveview and tailwind integration)


## Notes

### Task/TodoListItem (maybe task is the better name)
- id
- description
- status (completed/not completed)
- deleted_on (if soft deleting is implemented)
- created_on
- modified_on
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
