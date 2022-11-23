local helper = {}

function helper.run(command)
	if helper.log then
		helper.log("Running '"..command.."'")
	end

	local success = os.execute(command)

	if not success then
		error("Command failed: '"..command.."'", 2)
	end
end

return helper
