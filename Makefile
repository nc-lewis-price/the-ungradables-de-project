PROJECT_NAME = the-ungradeables-de-project
PYTHON_INTERPRETER = python3
PIP:=pip3

## Create python interpreter environment.
create-environment:
	@echo ">>> About to create environment: $(PROJECT_NAME)..."
	@echo ">>> check python3 version"
	( \
		$(PYTHON_INTERPRETER) --version; \
	)
	@echo ">>> Setting up VirtualEnv."
	( \
	    $(PYTHON_INTERPRETER) -m venv venv; \
	)

## Build the environment requirements
requirements: create-environment
	source venv/bin/activate && $(PIP) install -r ./requirements.txt