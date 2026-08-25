# 配置指南

## 概述

本指南介绍如何配置 Zotero Research Skill。本项目使用 `pyzotero` 命令行工具，通过 Zotero 本地 API（默认端口 23119）与 Zotero Desktop 交互。

## pyzotero 配置

### 本地 API（推荐）

- **地址**：`http://localhost:23119/api/`
- **优点**：无需 API 密钥、速度快
- **要求**：Zotero Desktop 正在运行

pyzotero 默认使用本地 API，无需额外配置。只需确保 Zotero Desktop 正在运行即可。

### Web API

如果需要使用 Web API，需配置环境变量：

```bash
# 设置 API 类型
export ZOTERO_API_TYPE=user

# 设置 Library ID
export ZOTERO_LIBRARY_ID=12345

# 设置 API 密钥
export ZOTERO_API_KEY=your_api_key_here
```

### 获取 API 密钥（Web API）

1. 访问 https://www.zotero.org/settings/keys
2. 登录您的 Zotero 账户
3. 点击 "Create new private key"
4. 为密钥命名（如：zotero-research-skill）
5. 选择权限（建议选择全部权限）
6. 点击 "Save Key"
7. 复制生成的 API 密钥

### 获取 Library ID（Web API）

1. 访问 https://www.zotero.org/settings/keys
2. 您的 Library ID 在页面顶部显示

## 环境变量配置

pyzotero 使用环境变量进行配置：

```bash
# 设置 Library ID（Web API）
export ZOTERO_LIBRARY_ID=12345

# 设置 API 密钥（Web API）
export ZOTERO_API_KEY=your_api_key_here

# 设置 Library 类型（user 或 group）
export ZOTERO_LIBRARY_TYPE=user
```

您也可以将这些环境变量添加到 `~/.bashrc` 或 `~/.zshrc` 中永久生效：

```bash
echo 'export ZOTERO_LIBRARY_ID=12345' >> ~/.bashrc
echo 'export ZOTERO_API_KEY=your_api_key_here' >> ~/.bashrc
source ~/.bashrc
```

## 验证配置

### 测试连接

```bash
pyzotero test
```

如果配置正确，将显示连接成功信息：
```
✓ Connected to Zotero
  Library: 我的文库
  Type: user
  ID: 0
```

### 测试检索

```bash
pyzotero search -q "test" --limit 5 --json
```

如果返回结果，说明配置正确。

### 检查 API 状态

```bash
curl -s "http://localhost:23119/api/users/0/items?limit=1"
```

## 配置故障排除

### 问题：连接失败

**可能原因**：
1. Zotero Desktop 未运行
2. 端口 23119 被占用
3. 防火墙阻止

**解决方案**：
1. 启动 Zotero Desktop
2. 检查端口：`netstat -an | grep 23119`
3. 检查防火墙设置

### 问题：Web API 认证失败

**可能原因**：
1. API 密钥无效
2. Library ID 错误

**解决方案**：
1. 检查 API 密钥是否正确
2. 检查 Library ID 是否正确
3. 重新生成 API 密钥

### 问题：搜索无结果

**可能原因**：
1. 文献库为空
2. 搜索词不准确

**解决方案**：
1. 检查文献库是否有内容：`pyzotero search -q "" --limit 10`
2. 尝试更广泛的搜索词
3. 使用全文搜索：`pyzotero search -q "keyword" --fulltext`

## 重新配置

如果需要重新配置：

```bash
# 清除环境变量
unset ZOTERO_LIBRARY_ID
unset ZOTERO_API_KEY
unset ZOTERO_LIBRARY_TYPE

# 重新设置
export ZOTERO_LIBRARY_ID=your_new_id
export ZOTERO_API_KEY=your_new_key
```

## 配置备份

建议定期备份 Zotero 数据：

1. 在 Zotero Desktop 中：编辑 → 首选项 → 高级 → 文件和文件夹
2. 备份 Zotero 数据目录
3. 定期同步 Zotero 账户

## 相关资源

- **pyzotero 文档**：https://pyzotero.readthedocs.io/
- **Zotero API 文档**：https://www.zotero.org/support/dev/web_api/v3/start
- **命令参考**：[../reference.md](../reference.md)
