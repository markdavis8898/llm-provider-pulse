# FAQ

## What is LLM Provider Pulse?

A lightweight, open-source tool that monitors the health and latency of 40+ LLM providers. It helps developers understand which providers are responsive and performant at any given time.

## How does it work?

It runs simple curl-based health checks against each provider's API endpoint, records latency and status, and generates a report.

## Do I need API keys?

No — the health check only tests if endpoints are reachable and responsive, not whether queries can execute. Authentication-required providers will return 401/403 (which confirms the endpoint is alive).

## How is this different from other monitoring tools?

- Lightweight — shell scripts, no heavy dependencies
- Transparent — all code is open source
- Comprehensive — 40+ providers covered

## How can I add a new provider?

Open an issue using the provider request template, or submit a pull request with a new config file.

## Why do some links have referral codes?

To help sustain the project. Using affiliate/referral links when signing up for providers supports ongoing development at no additional cost to you.
