# Good ideas at https://tech.davis-hansson.com/p/make/
SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX = >
.SILENT:
APP_NAME := $(shell basename $(PWD))

help: ## Describe useful make targets
> @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "%-30s %s\n", $$1, $$2}'
.PHONY: help

set_up_dev: install_dev set_up_pre_commit_hooks ## Set up dev environment

install_dev: check_venv ## Install python dev dependencies
> echo -e "\n$${PYTHON_EMOJI}・Installing python dev dependencies\n"
> gum spin --spinner monkey --title "Installing..." -- pip3 install -r requirements-dev.txt
> echo -e "\nDone $${CELEBRATION_EMOJI}\n"
.PHONY: install_dev

set_up_pre_commit_hooks: check_venv install_precommit pre_commit ## Set up pre-commit

install_precommit: ## Install pre-commit and set up git hooks
> echo -e "\n$${PRE_COMMIT_EMOJI}・Setting up pre-commit\n"
> gum spin --spinner monkey --title "Setting up..." -- pre-commit install --hook-type commit-msg
> echo -e "Done $${CELEBRATION_EMOJI}\n"
.PHONY: install_precommit

pre_commit: ## Run pre-commit hooks
> echo -e "\n$${PRE_COMMIT_EMOJI}・Running pre-commit hooks\n"
> pre-commit run --all-files
> echo -e "\nDone $${CELEBRATION_EMOJI}\n"
.PHONY: pre_commit

check_venv: ## Check if venv is activated, exit if not
> echo -e "\n$${PYTHON_EMOJI}・Checking if venv is activated\n"
> if [ -z $$VIRTUAL_ENV ]; then \
>   echo -e "Not activated $${ERROR_EMOJI}\n"; \
>   echo -e "\nPlease activate it with: source venv/bin/activate\n"; \
>   exit 1; \
> else \
>   echo -e "Python virtual environment is active 🐍\n"; \
> fi
.PHONY: check_venv
