# Getting Started with LLM Provider Pulse

## Prerequisites

- Bash 4.0+
- curl
- Python 3.8+
- (Optional) Docker

## Quick Start

```bash
# Clone the repository
git clone https://github.com/markdavis8898/llm-provider-pulse.git
cd llm-provider-pulse

# Run a health check on all providers
make check

# Run detailed latency tests
make latency

# View feedback summary
make feedback
```

## Using Docker

```bash
make docker-build
make docker-run
```

## Adding Your Config

Create a `config.local.json` to add custom provider endpoints:

```json
{
  "providers": [
    {
      "name": "My Provider",
      "endpoint": "https://my-provider.com/v1",
      "type": "OpenAI-compatible"
    }
  ]
}
```
