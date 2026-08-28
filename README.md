# Copilot Starter

一个面向初学者的 GitHub Copilot CLI 中文入门包。

如果你想在终端里使用 AI 帮你读代码、改代码、排查报错，但又不想一开始安装
一大堆复杂插件，这个仓库可以帮你快速搭好一套安全、轻量的基础环境。

> **不用在电脑本地运行大模型，也不需要独立显卡。**
> Copilot 的模型和算力在云端，轻薄本也可以使用。你只需要自己的 GitHub
> 账号和有效的 Copilot 订阅或组织授权；订阅与 AI Credits 由你自己的账号承担。

## 这个 Starter 带来了什么？

| 内容 | 作用 |
|---|---|
| 基础工作说明 | 让 Copilot 先理解问题、控制修改范围并保护现有代码 |
| `debugging-basics` | 帮助复现问题、定位原因并修复根因 |
| `review-basics` | 审查代码时只报告有实际影响的高置信度问题 |
| `simplify-basics` | 在不改变功能的前提下简化和整理代码 |
| 安全安装脚本 | 自动安装基础配置，并备份已有的同名文件 |
| `AGENTS.md` 模板 | 方便为自己的项目补充命令、约定和安全边界 |

这不是模型安装包，也不会提供或共享任何 Copilot 账号、订阅额度或密钥。

## Copilot CLI 和 WorkBuddy 有什么区别？

如果你还听说过腾讯 **WorkBuddy**，它和 GitHub Copilot CLI 是两个独立产品：

| | GitHub Copilot CLI | Tencent WorkBuddy |
|---|---|---|
| 使用界面 | 终端 | 桌面应用和网页版 |
| 更适合 | 阅读代码、修改仓库、调试和开发工作流 | 文档、表格、研究、办公自动化和多步骤任务 |
| 账号与计费 | GitHub 账号、Copilot 订阅及 AI Credits | WorkBuddy 账号及独立 Credits |
| 本仓库支持 | 可以直接安装 | 不能直接安装，只能参考其中的工作流内容 |

WorkBuddy 也支持 Skills 和 MCP，但官方公开的自定义 Skill 结构以
`skill.yml` 为主，并没有说明可以直接导入本仓库的 `SKILL.md`、`.skill`、
`AGENTS.md` 或 `~/.copilot` 配置。

如果主要需求是编程和操作代码仓库，建议先使用本 Starter；如果还希望让 AI
处理文档、数据、演示文稿或其他桌面任务，可以另外安装 WorkBuddy。两个产品可以
同时使用，但账号、配置和费用互相独立。

详细说明和官方入口见
[`docs/workbuddy.md`](docs/workbuddy.md)。

## 三步开始使用

### 第一步：安装 GitHub Copilot CLI

#### macOS 或 Linux

使用 Homebrew：

```bash
brew install --cask copilot-cli
```

或者使用 npm（需要 Node.js 22 或更高版本）：

```bash
npm install -g @github/copilot
```

#### Windows

需要 PowerShell 6 或更高版本：

```powershell
winget install GitHub.Copilot
```

更多安装方式可以查看
[GitHub 官方安装文档](https://docs.github.com/copilot/how-tos/copilot-cli/set-up-copilot-cli/install-copilot-cli)。

### 第二步：下载并安装 Starter

#### macOS 或 Linux

```bash
git clone https://github.com/shatianming5/copilot-starter.git
cd copilot-starter

# 先预览将要安装的文件，不会修改电脑
./scripts/install.sh --dry-run

# 确认无误后安装
./scripts/install.sh

# 检查安装结果
./scripts/verify.sh
```

#### Windows PowerShell

```powershell
git clone https://github.com/shatianming5/copilot-starter.git
cd copilot-starter

# 先预览将要安装的文件
pwsh -File .\scripts\install.ps1 -DryRun

# 确认无误后安装
pwsh -File .\scripts\install.ps1

# 检查安装结果
pwsh -File .\scripts\verify.ps1
```

### 第三步：启动并登录

进入一个你信任的代码目录，然后运行：

```bash
copilot
```

首次使用时，在 Copilot 中输入：

```text
/login
```

按照提示登录你自己的 GitHub 账号即可。

登录后可以输入：

```text
/instructions
/skills
/usage
```

分别查看已加载的说明、skills 和当前使用量。

## 可以从这些问题开始

```text
先阅读这个项目，告诉我它是做什么的，不要修改文件。
```

```text
帮我定位这个报错的根因，修复后运行最相关的测试。
```

```text
检查当前 Git diff，只报告会影响正确性的真实问题。
```

```text
在功能完全不变的前提下，简化这段代码。
```

如果只是想先讨论方案，可以明确告诉它：

```text
先给我方案和取舍，不要修改任何文件。
```

## 安装脚本会修改什么？

安装内容默认放在 `~/.copilot`。如果设置了 `COPILOT_HOME`，则使用你指定的
目录。

| 内容 | 安装位置 |
|---|---|
| 基础 instructions | `~/.copilot/instructions/starter.instructions.md` |
| 调试 skill | `~/.copilot/skills/debugging-basics` |
| 审查 skill | `~/.copilot/skills/review-basics` |
| 简化 skill | `~/.copilot/skills/simplify-basics` |
| 最小设置 | `~/.copilot/settings.json` |

为了保护你原来的环境：

- 安装前可以使用 `--dry-run` 预览；
- 已有的同名 instructions 或 skill 会先备份；
- 如果已经存在 `settings.json`，脚本会保留它，不会覆盖；
- 脚本不会修改 shell、SSH、代理、Git 配置或其他开发工具。

[`dist/`](dist/) 目录还提供三个独立的 `.skill` 文件。如果只想使用其中一个
skill，可以单独下载对应文件；完整入门环境仍建议使用安装脚本。

## 给自己的项目增加规则

仓库提供了一个简单的 [`examples/AGENTS.md`](examples/AGENTS.md) 模板。

把它复制到项目根目录：

```bash
cp examples/AGENTS.md /path/to/project/AGENTS.md
```

然后填写项目的安装、测试、构建命令和代码约定。Copilot 在该项目中工作时会自动
读取这些说明。

## 更新 Starter

```bash
cd copilot-starter
git pull --ff-only
./scripts/install.sh
./scripts/verify.sh
```

Windows 用户运行对应的 PowerShell 脚本。

## 使用时请注意

- 只允许 Copilot 操作你信任的文件夹；
- 不要提交 token、密码、私钥或 `.env`；
- 不要把整个 `~/.copilot` 文件夹发送给别人；
- 仔细确认删除文件、覆盖配置和破坏性 Git 命令；
- 修改重要项目之前，先提交或备份现有工作；
- 遇到不确定的操作，可以拒绝授权并让 Copilot 换一种方式。

这个 Starter 来自个人 `agent-env` 中最通用的部分，但已经移除了账号信息、
远程机器、MCP、代理、实验环境、模型锁定和私人工作流，可以作为一个更安全的
入门起点。
