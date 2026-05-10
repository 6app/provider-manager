# provider-manager

`provider-manager` 是一个零依赖的 Codex CLI 接入点管理工具，命令名为 `cx`。它可以交互式管理多个 OpenAI-compatible provider，快速切换 Codex 使用的 `base_url` / `OPENAI_API_KEY`，并单独切换模型。

## 功能

- 交互式 TUI，上下键选择，回车确认。
- 顶层菜单：
  1. 切换提供商
  2. 管理提供商
  3. 切换模型
- Provider 管理：添加、编辑、删除、刷新 `/models`、选择模型、测试连通性。
- `base_url` 自动补齐 `/v1`：
  - 输入 `https://api.example.com` 会保存/写入为 `https://api.example.com/v1`
  - 输入已带 `/v1` 的地址不会重复追加
- 自动调用 `GET /v1/models` 获取模型列表。
- 可手动输入 custom 模型名。
- 默认代理：`http://192.168.3.54:7893`
- `--no-proxy` 可禁用代理。

## 重要行为

### 切换提供商

切换 provider 时严格只修改两处：

1. `~/.codex/auth.json` 中的 `OPENAI_API_KEY` 值
2. `~/.codex/config.toml` 当前 `[model_providers.*]` section 中已有的 `base_url` 值

不会修改：

- `model`
- `model_provider`
- `wire_api`
- 其它 TOML/JSON 字段
- 不新增或删除 Codex provider section
- 不改写 `~/.codex/providers.json`

### 切换模型

切换模型只修改 `~/.codex/config.toml` 顶层：

```toml
model = "your-model"
```

不会修改 provider、key、base_url 或其它字段。

## 安装

```bash
./install.sh
```

安装脚本会把当前项目中的 `cx` 链接到：

```text
~/.local/bin/cx
```

请确保 `~/.local/bin` 在 `PATH` 中。

也可以不安装，直接运行：

```bash
./cx
```

## 使用

打开交互界面：

```bash
cx
```

列出保存的 provider：

```bash
cx --list
```

切换到第 1 个 provider：

```bash
cx --provider 1
```

切换到第 1 个 provider 后直接启动 Codex，默认使用代理：

```bash
cx --start-codex --provider 1
```

不使用代理启动 Codex：

```bash
cx --start-codex --provider 1 --no-proxy
```

透传参数给原始 `codex`：

```bash
cx --start-codex --provider 1 -- --help
```

## 数据文件

Provider 列表保存在：

```text
~/.codex/providers.json
```

Codex 自身配置文件：

```text
~/.codex/config.toml
~/.codex/auth.json
```

## 依赖

- Python 3.10+
- Codex CLI（仅在 `--start-codex` 时需要）

不需要额外 Python 包。

## 安全提示

`~/.codex/providers.json` 会保存 API key，请不要把该文件提交到仓库或分享给他人。
