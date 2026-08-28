# Copilot Starter

一套从私有 `agent-env` 中提炼出的安全、轻量 GitHub Copilot CLI 基础配置。

它只提供：

- 一份通用的工作与安全说明；
- 三个轻量技能：调试、代码审查和代码简化；
- 最小化的显示设置；
- macOS/Linux 与 Windows 安装脚本。

它**不包含**账号、订阅、API key、会话记录、MCP、代理、SSH、远程算力、
实验环境或任何私有项目配置。

## 前提

你需要：

1. 自己的 GitHub 账号；
2. 有效的 GitHub Copilot 订阅或组织授权；
3. Git；
4. GitHub Copilot CLI。

官方安装方式：

### macOS 或 Linux

```bash
brew install --cask copilot-cli
```

也可以使用 npm（需要 Node.js 22 或更高版本）：

```bash
npm install -g @github/copilot
```

### Windows

```powershell
winget install GitHub.Copilot
```

官方文档：

- [安装 GitHub Copilot CLI](https://docs.github.com/copilot/how-tos/copilot-cli/set-up-copilot-cli/install-copilot-cli)
- [使用 GitHub Copilot CLI](https://docs.github.com/copilot/how-tos/use-copilot-agents/use-copilot-cli)

## 安装 Starter

本仓库是私有仓库。仓库所有者需要先在 GitHub 中邀请你的账号。

### macOS 或 Linux

```bash
git clone https://github.com/shatianming5/copilot-starter.git
cd copilot-starter

./scripts/install.sh --dry-run
./scripts/install.sh
./scripts/verify.sh
```

### Windows PowerShell

需要 PowerShell 6 或更高版本。

```powershell
git clone https://github.com/shatianming5/copilot-starter.git
cd copilot-starter

pwsh -File .\scripts\install.ps1 -DryRun
pwsh -File .\scripts\install.ps1
pwsh -File .\scripts\verify.ps1
```

安装脚本只会操作 Copilot 配置目录：

- 默认：`~/.copilot`
- 如果设置了 `COPILOT_HOME`：使用该目录

已有的同名 instructions 或 skill 会先备份为
`.pre-copilot-starter-<timestamp>`。如果已有 `settings.json`，安装脚本会保留
它，不会覆盖。

## 首次启动

在一个你信任的代码目录中运行：

```bash
copilot
```

首次使用时输入：

```text
/login
```

然后使用你自己的 GitHub 账号完成登录。订阅和 AI Credits 均由该账号承担，
本仓库不提供或共享任何额度。

进入 Copilot 后可以检查：

```text
/instructions
/skills
/usage
```

## 安装内容

| 内容 | 安装位置 | 用途 |
|---|---|---|
| 通用 instructions | `~/.copilot/instructions/starter.instructions.md` | 限制范围、保护现有代码、要求有效验证 |
| `debugging-basics` | `~/.copilot/skills/debugging-basics` | 复现、定位并修复根因 |
| `review-basics` | `~/.copilot/skills/review-basics` | 只报告高置信度问题 |
| `simplify-basics` | `~/.copilot/skills/simplify-basics` | 在保持行为不变的前提下简化代码 |
| 最小设置 | `~/.copilot/settings.json` | 仅在目标文件不存在时安装 |

[`dist/`](dist/) 中还提供三个经过验证的 `.skill` 独立包，方便只分享或安装某一个
skill；完整 Starter 仍建议使用安装脚本。

## 给项目添加说明

把 [`examples/AGENTS.md`](examples/AGENTS.md) 复制到项目根目录，再填写项目命令和
约定：

```bash
cp examples/AGENTS.md /path/to/project/AGENTS.md
```

Copilot 会在该项目中自动读取它。

## 更新

```bash
git pull --ff-only
./scripts/install.sh
./scripts/verify.sh
```

Windows 使用对应的 PowerShell 脚本。

## 安全边界

- 不要把 token、密码或 `.env` 提交到 Git；
- 不要把整个 `~/.copilot` 目录发给别人；
- 只在可信目录中允许 Copilot 访问文件；
- 不要无条件批准 `rm`、`git reset --hard` 等破坏性命令；
- 在修改重要项目之前先提交或备份当前工作。
