# Path to the Godot 4 executable. Override with: make test GODOT=/path/to/godot
GODOT ?= godot

setup:
	git submodule update --init

test:
	$(GODOT) --headless -s res://addons/gut/gut_cmdln.gd -- -gdir=res://test -gexit -glog=1

.PHONY: setup test
