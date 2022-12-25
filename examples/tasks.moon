-- Example taskfile written in Yuescript
-- https://yuescript.org

import task from require 'spooder'

with task
	.install
		description: "Installs the rock"
		depends: "test"
		* "luarocks make"

	.test
		description: "Runs Tests"
		* 'rm luacov.stats.out'
		* 'luacheck .'
		* 'busted --coverage --lpath "?.lua;?/init.lua"'
		* 'luacov -r html spooder.lua'

	.documentation
		description: "Builds and pushes the documentation"
		depends: "test"
		* [[
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
