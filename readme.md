# Spooder

A cute little task runner for Lua

## How it works

See the `tasks.lua` file in this repository for a basic example.

TODO: Write an actual explanation of what `tasks` files have to look like

## SPOODER\_INIT

The `spooder` executable will look for this environment variable and, if found,
run it as a shell command.

It is recommended to set this to run `sudo -K` to reset the sudo credentials.
This way, potential `sudo` commands inside spooder tasks won't run without
asking for a password first.
