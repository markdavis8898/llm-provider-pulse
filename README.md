<p align="center">
  <img src="https://img.shields.io/badge/LLM%20Provider%20Pulse-v0.1.0-00E5FF?style=for-the-badge" alt="Version" />
  <img src="https://img.shields.io/github/stars/markdavis8898/llm-provider-pulse?style=for-the-badge" alt="Stars" />
  <img src="https://img.shields.io/badge/license-MIT-blue?style=for-the-badge" alt="License" />
  <img src="https://img.shields.io/badge/coverage-41%20providers-brightgreen?style=for-the-badge" alt="Coverage" />
</p>

<h1 align="center">🔍 LLM Provider Pulse</h1>
<p align="center"><b>AI 供应商服务健康检测工具集</b><br>
Monitor latency, availability, and status of 40+ LLM providers in real time.</p>

<p align="center">
  <a href="#中文">中文</a> · <a href="#english">English</a> ·
  <a href="docs/provider-list.md">Provider List</a> ·
  <a href="docs/getting-started.md">Getting Started</a> ·
  <a href="docs/faq.md">FAQ</a>
</p>

---

<a name="中文"></a>

## 📋 概览

LLM Provider Pulse 是一款轻量级开源工具，用于**监测主流 AI 供应商 API 服务的可用性和响应性能**。

**它能做什么？**

- 🔄 支持 **41 家** AI 供应商的连通性检测
- ⏱ 测量各供应商 API 的响应延迟
- 📊 生成结构化的健康检测报告
- 🐳 支持 Docker 部署
- 🔔 支持 GitHub Actions 定时巡检

**为什么需要它？**

AI 开发者每天面对大量供应商选择——Groq 快还是 DeepSeek 快？OpenRouter 现在稳不稳？Zhipu 的 API 挂了没？让 Pulse 替你盯着。

---

## 🚀 快速开始

```bash
# 克隆
git clone https://github.com/markdavis8898/llm-provider-pulse.git
cd llm-provider-pulse

# 一键运行健康检测
make check

# 测试延迟
make latency

# 查看用户反馈
make feedback
```

### 使用 Docker

```bash
make docker-build
make docker-run
```

---

## 📁 项目结构

```
llm-provider-pulse/
├── scripts/
│   ├── health-check.sh    ← 健康检测主脚本
│   ├── latency-test.sh    ← 延迟测试脚本
│   ├── feedback.py        ← 反馈收集工具
│   └── providers.json     ← 41 家供应商配置
├── providers/             ← 每家供应商独立配置 (41 个)
│   ├── groq.json
│   ├── deepseek.json
│   ├── ...
│   └── INDEX.json
├── docs/                  ← 文档
├── tests/                 ← 测试
├── data/results/          ← 检测报告
├── Dockerfile & docker-compose.yml
└── Makefile
```

---

## 🔌 支持的供应商（共 45 家）

> 以下为当前支持的 AI 供应商完整列表。部分链接包含推广/邀请信息，使用它们支持本项目持续维护，对您无额外费用。

### API 供应商（36 家）

| # | 供应商 | 类型 | 代表模型 | 起步价 | 直达 |
|---|--------|------|----------|--------|------|
| 1 | **Groq** | OpenAI 兼容 | Llama 3, Mixtral | 免费额度 | [注册](https://console.groq.com/) |
| 2 | **DeepSeek** | OpenAI 兼容 | DeepSeek-V4, Coder | 按量计费 | [注册](https://platform.deepseek.com/) |
| 3 | **OpenRouter** | OpenAI 兼容 | 多供应商聚合 | 按量计费 | [注册](https://openrouter.ai/signup?ref=markdavis8898) |
| 4 | **Cerebras** | OpenAI 兼容 | Llama 3, Llama 3.1 | 免费额度 | [注册](https://cloud.cerebras.ai/) |
| 5 | **SambaNova** | OpenAI 兼容 | Llama 3, Llama 405B | 免费额度 | [注册](https://cloud.sambanova.ai/) |
| 6 | **Gemini API** | OpenAI 兼容 | Gemini 2.5 Pro/Flash | 免费额度 | [注册](https://ai.google.dev/) |
| 7 | **Mistral** | OpenAI 兼容 | Mistral Large, Codestral | 按量计费 | [注册](https://console.mistral.ai/) |
| 8 | **xAI** | OpenAI 兼容 | Grok-3, Grok-3 Mini | 按量计费 | [注册](https://x.ai/) |
| 9 | **SiliconFlow** | OpenAI 兼容 | DeepSeek, Qwen, GLM | 按量计费 | [注册](https://cloud.siliconflow.cn/i/bXPxKFXw) |
| 10 | **Zhipu / GLM** | OpenAI 兼容 | GLM-5.1, GLM-4.7 | 订阅制 | [注册](https://www.bigmodel.cn/invite?icode=hb%2F%2BSlVm613Mh%2F%2BTNTL%2FGgZ3c5owLmCCcMQXWcJRS8E%3D) |
| 11 | **Together AI** | OpenAI 兼容 | Llama 3, Mixtral | 按量计费 | [注册](https://together.ai/) |
| 12 | **DashScope** | OpenAI 兼容 | Qwen3, Qwen3-Coder | 按量计费 | [注册](https://www.aliyun.com/minisite/goods?userCode=va4ma6uz) |
| 13 | **NVIDIA NIM** | OpenAI 兼容 | Llama 3, Nemotron | 免费额度 | [注册](https://build.nvidia.com/) |
| 14 | **GitHub Models** | OpenAI 兼容 | GPT-4o, DeepSeek, Llama | 免费 | [注册](https://github.com/marketplace/models) |
| 15 | **Fireworks** | OpenAI 兼容 | Llama 3, Mixtral | 按量计费 | [注册](https://fireworks.ai/) |
| 16 | **Volcengine** | OpenAI 兼容 | Doubao-Seed-2.0, DeepSeek-V4, GLM-5.1 | ¥38/月起 | [注册](https://volcengine.com/L/jAaD686YDKQ/) |
| 17 | **Qianfan** | OpenAI 兼容 | ERNIE, GLM, DeepSeek | 订阅制 | [注册](https://cloud.baidu.com/campaign/ambassador-product/index.html?ambassadorId=749713c338ae438aa02056936e97047d) |
| 18 | **iFlytek / 讯飞** | OpenAI 兼容 | Spark X2, Spark Pro | ¥19/月起 | [注册](https://maas.xfyun.cn/packageSubscription?inviteCode=MAAS-7F97CC35) |
| 19 | **Lanyun / 蓝耘** | OpenAI 兼容 | GLM-5.1, DeepSeek, MiniMax | ¥49/月起 | [注册](https://console.lanyun.net/#/register?promoterCode=b804918124) |
| 20 | **Compshare / 优云** | OpenAI 兼容 | DeepSeek-V4, GLM-5.1, Qwen3 | ¥49/月起 | [注册](https://passport.compshare.cn/register?referral_code=2MnXIUvuGePCjs9ERvQzxy) |
| 21 | **JDCloud / 京东云** | OpenAI 兼容 | DeepSeek-V4, GLM-5, Qwen3-Coder | ¥40/月起 | [注册](https://3.cn/2-P6IXBQ) |
| 22 | **Qiniu** | OpenAI 兼容 | 多模型 | 按量计费 | [注册](https://s.qiniu.com/neyU3i) |
| 23 | **Moonshot** | OpenAI 兼容 | Kimi-K2, Kimi-K2.5 | 订阅制 | [注册](https://kimi.com/code/zh) |
| 24 | **Baichuan** | OpenAI 兼容 | Baichuan 4 | 按量计费 | [注册](https://www.baichuan-ai.com/) |
| 25 | **Stepfun** | OpenAI 兼容 | Step-2, Step-1 | 按量计费 | [注册](https://platform.stepfun.com/) |
| 26 | **MiniMax** | OpenAI 兼容 | MiniMax-M2.7, M2.5 | 订阅制 | [注册](https://platform.minimaxi.com/subscribe/token-plan?code=1vsjCEkBf1&source=img) |
| 27 | **Hunyuan** | OpenAI 兼容 | Hunyuan Turbo/Pro | 按量计费 | [注册](https://curl.qcloud.com/YyIieB2d) |
| 28 | **Cloudflare AI** | OpenAI 兼容 | Workers AI, Llama | 免费额度 | [注册](https://cloudflare.com/) |
| 29 | **HuggingFace** | Inference API | 100k+ 模型 | 免费额度 | [注册](https://huggingface.co/) |
| 30 | **LongCat** | OpenAI 兼容 | 多供应商聚合 | 按量计费 | [注册](https://longcat.ai/) |
| 31 | **Vercel AI Gateway** | OpenAI 兼容 | 多供应商聚合 | 免费额度 | [注册](https://vercel.com/docs/ai) |
| 32 | **Anthropic API** | Anthropic 原生 | Claude 4 Sonnet/Haiku | 按量计费 | [注册](https://anthropic.com/) |
| 33 | **Pollinations** | OpenAI 兼容 | 多模型 | 免费 | [注册](https://pollinations.ai/) |
| 34 | **BlazeAPI** | OpenAI 兼容 | 多模型 | 按量计费 | [注册](https://blazeapi.ai/) |
| 35 | **LLM7** | OpenAI 兼容 | 多模型 | 按量计费 | [注册](https://llm7.com/) |
| 36 | **BazaarLink** | OpenAI 兼容 | 多模型 | 按量计费 | [注册](https://bazaarlink.com/) |

### 本地/CLI 供应商（9 家）

| # | 供应商 | 类型 | 说明 | 了解详情 |
|---|--------|------|------|---------|
| 1 | **Claude Desktop** | 桌面应用 | Claude Pro/Max 订阅 | [了解](https://claude.ai/) |
| 2 | **Claude Code** | CLI 工具 | Claude 账号配额 | [了解](https://claude.ai/) |
| 3 | **Kiro** | 桌面应用 | Kiro 账号配额 | [了解](https://kiro.ai/) |
| 4 | **Windsurf** | IDE | Codeium IDE 额度 | [了解](https://codeium.com/windsurf) |
| 5 | **OpenCode** | CLI 工具 | 内置路由 | [了解](https://opencode.ai/) |
| 6 | **VS Code Copilot** | IDE 扩展 | Copilot 账号额度 | [了解](https://github.com/features/copilot) |
| 7 | **OpenAI Codex** | CLI 工具 | Codex 订阅 | [了解](https://codex.openai.com/) |
| 8 | **Gemini CLI** | CLI 工具 | Gemini CLI OAuth | [了解](https://cloud.google.com/ai/gemini) |
| 9 | **Ollama** | 本地运行 | 完全免费 | [了解](https://ollama.com/) |

---

## 📝 反馈与贡献

遇到供应商挂了？发现新的供应商？欢迎：

- 提交 [Issue](https://github.com/markdavis8898/llm-provider-pulse/issues) 报告问题
- 提交 [PR](https://github.com/markdavis8898/llm-provider-pulse/pulls) 添加新供应商
- 运行 `python3 scripts/feedback.py submit <供应商> <评分>` 提交使用体验

---

## 📄 License

MIT © 2026 markdavis8898

---

<a name="english"></a>

## English

LLM Provider Pulse is an open-source toolkit for monitoring the health and latency of 40+ LLM providers. It runs simple curl-based checks against provider endpoints to track availability and response times.

**Quick start:**

```bash
git clone https://github.com/markdavis8898/llm-provider-pulse.git
cd llm-provider-pulse
make check
```

See full provider list → [docs/provider-list.md](docs/provider-list.md)
