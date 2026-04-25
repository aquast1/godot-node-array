# Path to the Godot 4 executable. Override with: make test GODOT=/path/to/godot
GODOT ?= godot

setup:
	rm -rf .gut_tmp
	git clone --depth 1 https://github.com/bitwes/Gut.git .gut_tmp
	rm -rf addons/gut
	cp -r .gut_tmp/addons/gut addons/gut
	rm -rf .gut_tmp

test:
	$(GODOT) --headless -s res://addons/gut/gut_cmdln.gd

.PHONY: setup test
