.PHONY: extras check-extras fmt check

# regenerate extras/ from lua/eggfriedrice/colors.lua
extras:
	nvim -l scripts/extras.lua

# fail when the committed extras drift from the palette
check-extras: extras
	git diff --exit-code -- extras/
	test -z "$$(git status --porcelain -- extras/)"

fmt:
	stylua lua/ colors/ scripts/

check:
	stylua --check lua/ colors/ scripts/
