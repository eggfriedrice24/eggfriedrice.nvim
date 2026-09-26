.PHONY: extras preview check-extras check-preview fmt check

# regenerate extras/ from lua/eggfriedrice/colors.lua
extras:
	nvim -l scripts/extras.lua

# regenerate assets/preview.svg from lua/eggfriedrice/colors.lua
preview:
	nvim -l scripts/preview.lua

# fail when the committed extras or preview drift from the palette
check-extras: extras check-preview
	git diff --exit-code -- extras/
	test -z "$$(git status --porcelain -- extras/)"

check-preview: preview
	git diff --exit-code -- assets/
	test -z "$$(git status --porcelain -- assets/)"

fmt:
	stylua lua/ colors/ scripts/

check:
	stylua --check lua/ colors/ scripts/
