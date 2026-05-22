.PHONY: help check latency feedback test clean docker-build docker-run

help:
	@echo "LLM Provider Pulse — Available Commands"
	@echo "  make check        Run health check on all providers"
	@echo "  make latency      Run detailed latency test"
	@echo "  make feedback     Show feedback summary"
	@echo "  make test         Run unit tests"
	@echo "  make clean        Clean results directory"
	@echo "  make docker-build Build Docker image"
	@echo "  make docker-run   Run health check in Docker"

check:
	bash scripts/health-check.sh

latency:
	bash scripts/latency-test.sh

feedback:
	python3 scripts/feedback.py summary

test:
	bash tests/test_config.sh

clean:
	rm -f data/results/*.json
	@echo "Cleaned results."

docker-build:
	docker compose build

docker-run:
	docker compose run --rm provider-pulse
