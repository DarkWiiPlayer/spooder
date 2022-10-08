local spooder = require 'spooder'

spooder.task "install" {
	description = "Installs the rock";
	depends = {"test"};
	function(helper)
		helper.run("luarocks make")
	end;
}

spooder.task "test" {
	description = "runs tests and stuff";
	function(helper)
		helper.run("luacheck .")
--		helper.run("busted")
	end
}
