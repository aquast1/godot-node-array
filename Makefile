# Path to the Godot 4 executable. Override with: make test GODOT=/path/to/godot
GODOT ?= godot

setup:
	git clone --depth 1 https://github.com/bitwes/Gut.git .gut_tmp
	cp -r .gut_tmp/addons/gut addons/gut
	rm -rf .gut_tmp

test:
	$(GODOT) --headless -s res://addons/gut/gut_cmdln.gd

.PHONY: setup test
