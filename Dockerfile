FROM python:3.11-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY scripts/ ./scripts/
COPY providers/ ./providers/
COPY data/ ./data/

RUN chmod +x scripts/health-check.sh scripts/latency-test.sh

ENTRYPOINT ["bash", "scripts/health-check.sh"]
