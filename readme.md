# Spooder 88w88

A very basic task runner written in Lua

## Features

- Modular
- Runs tasks
- Understands dependencies
- Simple

## Goals:

Spooder aims to be:

- Usable
- Hackable
- Free of clutter

## Taskfiles

Taskfiles are simple Lua modules that define tasks using the `spooder.task`
function.

	local spooder = require 'spooder'

	spooder.task 'make_dir' {
		description = "Creates a new directory";
		"mkdir directory"
	}

	spooder.task 'complex_stuff' {
		description = "Does some advanced stuff";
		if os.getenv("THE_STARS_ALIGn") == "yes" then
			spooder.helper.run("echo yes.")
		end
	}

## Initialisation & Cleanup

The `spooder` executable will look for the `SPOODER_INIT` and `SPOODER_CLEANUP`
variables and run their contents as shell scripts before and after running.

These variables can be used, for example, to compile task files written in
moonscript and delete the resulting Lua files afterwards.

For example, you can export the following environment variables

	export SPOODER_INIT="yue tasks"
	export SPOODER_CLEANUP="rm tasks.lua"

and write your tasks in Yuescript instead of plain Lua.
