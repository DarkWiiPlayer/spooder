--- A simple task runner for Lua
-- @module spooder

local spooder = {}

local tasks = {}

local log = require 'lumber.global'

--- Returns an iterator over all tasks
function spooder.tasks()
	return pairs(tasks)
end

--- Describes a task.
-- Steps to be performed should be stored as functions at sequential numeric indices.
-- @table task
-- @tfield string description A short description of what the task does.
-- @tfield table depends The names of other tasks to complete first.
-- For single dependencies this can be a string.

--- Registers a new task
-- @tparam string name The name of the new task
-- @tparam task task A new task to insert with the given name
function spooder.newtask(name, task)
	log:debug("Adding task: ", name)

	if tasks[name] then
		log:warn("Task ", name, " already exists, overwriting")
	end
	task.name = name
	tasks[name] = task
end

spooder.task = setmetatable({}, {
	__index = function(_, index)
		return function(...)
			return spooder.newtask(index, ...)
		end
	end;
	__call = function(_, name, ...)
		return spooder.newtask(name, ...)
	end;
})

--- Runs a given task with provided arguments.
local function run(stack, name, ...)
	if stack[name] == true then
		return false
	elseif stack[name] == false then
		error("Task Recursion") -- TODO: better error message or something
	end
	stack[name] = false
	local task = tasks[name]
	if task then
		if task.depends then
			if type(task.depends) == "string" then
				run(stack, task.depends)
			else
				for _, dependency in ipairs(task.depends) do
					run(stack, dependency)
				end
			end
		end
		for _, runner in ipairs(task) do
			if type(runner) == "string" then
				local success = os.execute(runner)
				if not success then
					error("Command failed: '"..runner.."'", 2)
				end
			else
				runner(task, ...)
			end
		end
		stack[name] = true
		return true
	else
		error("No task "..name)
	end
end

--- Runs a given task with provided arguments.
-- @tparam string name The task's name
-- @param ... Arguments to pass to the task's step functions
function spooder.run(name, ...)
	return run({}, name, ...)
end

return spooder
