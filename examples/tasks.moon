-- Example taskfile written in Yuescript
-- https://yuescript.org

import task from require 'spooder'

task "install"
	description: "Installs the rock"
	depends:
		* "test"
	* (helper) -> with helper
		.run "luarocks make"

task "test"
	description: "Runs Tests"
	* (helper) -> with helper
		.run 'rm luacov.stats.out'
		.run 'luacheck .'
		.run 'busted --coverage --lpath "?.lua;?/init.lua"'
		.run 'luacov -r html spooder.lua'

task "documentation"
	description: "Builds and pushes the documentation"
	depends:
		* "test"
	* (helper) -> with helper
		.run [[
			hash=$(git log -1 --format=%h)
			mkdir -p doc/coverage
			cp -r luacov-html/* doc/coverage
			ldoc .
			cd doc
				find . | treh -c
				git add --all
				if git log -1 --format=%s | grep "$hash$"
				then git commit --amend --no-edit
				else git commit -m "Update documentation to $hash"
				fi
				git push --force origin doc
			cd ../
			git stash pop || true
		]]
