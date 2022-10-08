local helper = {}

function helper.run(command)
	if helper.log then
		helper.log("Running '"..command.."'")
	end

	local success = os.execute(command)

	if not success then
		error("Task failed: '"..command.."'", 2)
	end
end

return helper
