.PHONY: help install update clean

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dotfiles
	@bash install.sh

update: ## Update system and tools
	@bash scripts/update_system.sh

clean: ## Clean temporary files
	@bash scripts/docker_cleanup.sh
	@find . -name "*.pyc" -delete
	@find . -name "__pycache__" -type d -exec rm -rf {} + 2>/dev/null || true
