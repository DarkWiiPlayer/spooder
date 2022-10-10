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
		function(helper)
			helper.run("mkdir directory")
		end;
	}

## SPOODER\_INIT

The `spooder` executable will look for this environment variable and, if found,
run it as a shell command.

It is recommended to set this to run `sudo -K` to reset the sudo credentials.
This way, potential `sudo` commands inside spooder tasks won't run without
asking for a password first.
