PROJECT_NAME = the-ungradeables-de-project
PYTHON_INTERPRETER = python3
PIP:=pip3
# If this isn't set the shell will default to `sh`
SHELL=/bin/bash
# The shell function allows us to use command substitution
PYTHONPATH=$(shell pwd)

# ~~~~~ Create python interpreter environment ~~~~~
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

# ~~~~~ Install requirements ~~~~~
requirements: create-environment
	source venv/bin/activate && $(PIP) install -r ./requirements.txt


# ~~~~~ Install code quality tools ~~~~~
install-dev-tools:
	source venv/bin/activate && $(PIP) install bandit safety flake8 coverage

# ~~~~~ Run unit tests ~~~~~
unit-test:
	source venv/bin/activate && PYTHONPATH=$(PYTHONPATH) pytest -vvv

# ~~~~~ Run code quality checks ~~~~~
security-checks:
	source venv/bin/activate && safety check -r ./requirements.txt
	source venv/bin/activate && bandit -lll */*.py *c/*.py

check-pep8-compliance:
	source venv/bin/activate && flake8 src test

check-test-coverage:
	source venv/bin/activate && PYTHONPATH=$(PYTHONPATH) coverage run -m pytest && coverage report

# Run unit tests, security checks and code compliance checks
run-checks: unit-test security-checks check-pep8-compliance check-test-coverage

