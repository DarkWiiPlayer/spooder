local spooder = {}

spooder.helper = require 'spooder.helper'

local tasks = {}

function spooder.tasks()
	return pairs(tasks)
end

function spooder.task(name, task)
	if not task then
		return function(task) -- luacheck: ignore
			return spooder.task(name, task)
		end
	end

	if spooder.helper.log then
		spooder.helper.log:debug("Adding task: ", name)
	end

	if tasks[name] then
		if spooder.helper.log then
			spooder.helper.log:warn("Task ", name, " already exists")
		end
	end
	tasks[name] = task
end

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
			for _, dependency in ipairs(task.depends) do
				run(stack, dependency)
			end
		end
		for _, runner in ipairs(task) do
			runner(spooder.helper, ...)
		end
		stack[name] = true
		return true
	else
		error("No task "..name)
	end
end

function spooder.run(name, ...)
	return run({}, name, ...)
end

return spooder
