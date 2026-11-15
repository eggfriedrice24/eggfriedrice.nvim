.PHONY: extras preview check-extras check-preview fmt check

# regenerate extras/ from lua/eggfriedrice/colors.lua
extras:
	nvim -l scripts/extras.lua

# regenerate assets/preview.svg from lua/eggfriedrice/colors.lua
preview:
	nvim -l scripts/preview.lua

# fail when the committed extras or preview drift from the palette, or
# when a tracked file under extras/ is one no generator writes any more
check-extras: check-preview
	@written="$$(nvim -l scripts/extras.lua)" || exit 1; \
	stray="$$(git ls-files -- extras/ | grep -vxF -e "$$written")"; \
	if [ -n "$$stray" ]; then \
		printf 'tracked under extras/ but written by no generator:\n%s\n' "$$stray" >&2; \
		exit 1; \
	fi
	git diff --exit-code -- extras/
	test -z "$$(git status --porcelain -- extras/)"

check-preview: preview
	git diff --exit-code -- assets/
	test -z "$$(git status --porcelain -- assets/)"

fmt:
	stylua lua/ colors/ scripts/

check:
	stylua --check lua/ colors/ scripts/
