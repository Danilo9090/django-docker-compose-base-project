
clean: clean-build clean-pyc clean-test

clean-build:
	@rm -fr build/
	@rm -fr dist/
	@rm -fr .eggs/
	@find . -name '*.egg-info' -exec rm -fr {} +
	@find . -name '*.egg' -exec rm -f {} +

clean-pyc:
	@find . -name '*.pyc' -exec rm -f {} +
	@find . -name '*.pyo' -exec rm -f {} +
	@find . -name '*~' -exec rm -f {} +
	@find . -name '__pycache__' -exec rm -fr {} +

clean-test:
	@rm -fr .tox/
	@rm -fr .pytest_cache/
	@rm -f .coverage
	@rm -fr htmlcov/

deps:
	@pip install -qr requirements.txt

test: deps clean
	@pytest

build_image:
	@docker-compose build

bash:
	@docker-compose run web

help:
	@grep '^[^#[:space:]].*:' Makefile | sort | awk -F ":" '{print $$1}'
