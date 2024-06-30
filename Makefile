.PHONY: all
all: test lint integration-test

.PHONY: test
test:
	@docker compose --file ./tests/docker-compose.yml run --rm test

.PHONY: integration-test
integration-test:
	@docker compose --file ./tests/docker-compose.yml run --rm integration-test

.PHONY: plugin-lint
plugin-lint:
	@docker compose --file ./tests/docker-compose.yml run plugin-lint
