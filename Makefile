.SILENT:
SHELL := /bin/bash

set_up_dev: install_dev set_up_pre_commit

install_dev:
	echo ""
	echo "🐍・Installing python dev dependencies"
	echo ""
	gum spin --spinner monkey --title "Installing..." -- pip3 install -r requirements-dev.txt
	echo "Done 🪇"
	echo ""

set_up_pre_commit: check_venv_exists_exit_if_not install_precommit_and_set_up_git_hooks pre_commit

install_precommit_and_set_up_git_hooks:
	echo ""
	echo "🚓・Setting up pre-commit"
	echo ""
	gum spin --spinner monkey --title "Setting up..." -- pre-commit install --hook-type commit-msg
	echo "Done 🪇"
	echo ""

pre_commit:
	echo ""
	echo "🚓・Running pre-commit in all files"
	echo ""
	pre-commit run --all-files
	echo ""
	echo "Done 🪇"
	echo ""

check_venv_exists_exit_if_not:
	echo ""
	echo "🐍・Checking if venv is activated"
	echo ""
	if [ -z $$VIRTUAL_ENV ]; then \
		echo "Not activated ❌"; \
		echo ""; \
		echo "Please activate it with: source venv/bin/activate"; \
		echo ""; \
		exit 1; \
	else \
		echo "Python virtual environment is active 🐍"; \
	fi
	echo ""
