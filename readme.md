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

## Initialisation & Cleanup

The `spooder` executable will look for the `SPOODER_INIT` and `SPOODER_CLEANUP`
variables and run their contents as shell scripts before and after running.

These variables can be used, for example, to compile task files written in
moonscript and delete the resulting Lua files afterwards, or to clear the sudo
password cache with `sudo -K` to make sure tasks never run as root without first
asking for a password.

Note that clearing the sudo cache should be thought of as a last line of
defense; it won't make it "safe" to run untrusted code.
