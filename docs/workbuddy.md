# WorkBuddy 简介

## WorkBuddy 是什么？

[Tencent WorkBuddy](https://www.workbuddy.ai/) 是腾讯推出的桌面 AI 工作台。
它可以根据自然语言要求拆解并执行多步骤任务，处理经过授权的本地文件，并生成
文档、表格、演示文稿、数据分析和研究结果。

它和 GitHub Copilot CLI 是两个独立产品：

- **GitHub Copilot CLI** 更靠近终端、代码仓库和软件开发流程；
- **WorkBuddy** 更靠近桌面办公、知识工作和跨应用任务。

两者可以同时安装，但需要分别登录和使用各自的订阅或 Credits。

## 支持的平台

WorkBuddy 官方安装文档目前列出：

- Windows 10 1809 或更高版本、Windows 11；
- macOS 12 Monterey 或更高版本；
- Apple Silicon 和 Intel Mac。

目前没有在官方公开文档中确认 Linux 客户端，因此不要假设 Linux 可以直接安装。

官方下载和说明：

- [WorkBuddy 官网及下载入口](https://www.workbuddy.ai/)
- [WorkBuddy 产品概览](https://www.workbuddy.ai/docs/workbuddy/Overview)
- [Windows 安装指南](https://www.workbuddy.ai/docs/workbuddy/From-Beginner-to-Expert-Guide/Installation-Win-Guide)
- [macOS 安装指南](https://www.workbuddy.ai/docs/workbuddy/From-Beginner-to-Expert-Guide/Installation-Mac-Guide)
- [套餐与 Credits](https://www.workbuddy.ai/docs/workbuddy/pricing)

## 能否直接使用这个 Starter？

不能直接安装。

本仓库使用的是 GitHub Copilot CLI 的目录和文件格式：

```text
~/.copilot/
├── instructions/
├── skills/
└── settings.json
```

WorkBuddy 官方公开文档中的自定义 Skill 通常包含：

```text
skill.yml
implementation files
README
```

目前没有官方证据表明 WorkBuddy 会自动读取 Copilot 的：

- `SKILL.md` 或 `.skill` 文件；
- `AGENTS.md`；
- `starter.instructions.md`；
- `~/.copilot` 配置目录。

因此不要把本仓库宣传成“WorkBuddy 安装包”或“WorkBuddy 原生兼容配置”。

## 哪些内容可以迁移？

虽然安装格式不同，但这些自然语言工作方法可以复用：

- 调试时先复现问题，再追踪根因；
- 代码审查只报告会造成真实影响的问题；
- 简化代码时保持外部行为不变；
- 修改前理解目标、保护已有改动并运行最相关的验证；
- 不把 token、密码、私钥或 `.env` 内容交给 AI。

可以在 WorkBuddy 中提出类似要求：

```text
请根据以下要求创建一个 Tencent WorkBuddy skill：
先复现问题并定位根因，只做与当前问题直接相关的修改；
不要添加没有真实触发条件的兜底逻辑；
完成后运行最相关的验证，并简洁报告原因、修改和结果。
```

然后按照 WorkBuddy 的界面提示检查生成内容，再决定是否安装。

官方说明：

- [WorkBuddy Skill Marketplace](https://www.workbuddy.ai/docs/workbuddy/From-Beginner-to-Expert-Guide/Function-Description/Skills-Market)
- [创建自定义 Skill](https://www.workbuddy.ai/docs/workbuddy/From-Beginner-to-Expert-Guide/Practice-Cases/Create-Skills)
- [MCP Integration](https://www.workbuddy.ai/docs/workbuddy/From-Beginner-to-Expert-Guide/Function-Description/MCP-Guide)

## 应该选哪个？

| 你的主要需求 | 建议 |
|---|---|
| 在终端里修改和理解代码仓库 | GitHub Copilot CLI |
| 调试、代码审查、运行测试和 Git 工作流 | GitHub Copilot CLI |
| 整理文档、表格、PPT 或批量桌面任务 | WorkBuddy |
| 连接办公服务并执行跨应用任务 | WorkBuddy |
| 两类任务都有 | 两者同时使用，但分别管理账号与配置 |
