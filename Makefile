.DEFAULT_GOAL:=help
# ----------------------------------------------------------------------------------------------------------------------
COMMAND ?= /bin/sh
# Don't change
SRC_DIR := .
# ----------------------------------------------------------------------------------------------------------------------
.PHONY: help
help:  ## 💬 Help message
	@echo "This is help message. Feel free to extend."
# ----------------------------------------------------------------------------------------------------------------------
.PHONY: venv
venv: $(SRC_DIR)/venv/touchfile
$(SRC_DIR)/venv/touchfile: $(SRC_DIR)/pyproject.toml
	python3 -m venv $(SRC_DIR)/venv
	. $(SRC_DIR)/venv/bin/activate; \
	pip install wheel; \
	pip install .; \
	pip install '.[tests]'; \
	touch $(SRC_DIR)/venv/touchfile
# ----------------------------------------------------------------------------------------------------------------------
.PHONY: clean
clean:  ## 🧹 Clean up project
	rm -rf $(SRC_DIR)/.coverage
	rm -rf $(SRC_DIR)/*.egg-info
	rm -rf $(SRC_DIR)/.pytest_cache
	rm -rf $(SRC_DIR)/build
	rm -rf $(SRC_DIR)/venv
# ----------------------------------------------------------------------------------------------------------------------
.PHONY: test
test: venv  ## 🎯 Unit tests for App
	. $(SRC_DIR)/venv/bin/activate \
	&& pytest -vv -r sfx --cov=helper --cov=app --cov-report=html --cov-report=term --cov-report=xml:coverage.xml
# ----------------------------------------------------------------------------------------------------------------------