# API 参考文档

## 概述

本文档提供 Zotero Research Skill 的详细 API 参考。所有命令基于 `pyzotero` 命令行工具。

> 详细的命令参数和示例请参考 [命令详细参考](../reference.md)。

## 检索命令

### pyzotero search

**用途**：搜索文献库

**语法**：
```bash
pyzotero search [OPTIONS]
```

**参数**：
- `-q, --query TEXT`：搜索查询字符串（必需）
- `--fulltext`：全文搜索（包括 PDF 内容）
- `--itemtype TEXT`：按项目类型过滤
- `--collection TEXT`：按收藏夹过滤
- `--tag TEXT`：按标签过滤（可多次指定，AND 搜索）
- `--limit INTEGER`：限制返回数量（默认：1000000）
- `--offset INTEGER`：跳过结果数量（用于分页）
- `--json`：JSON 格式输出

**示例**：
```bash
# 基础检索
pyzotero search -q "machine learning" --json

# 按标签过滤
pyzotero search -q "IoT" --tag "survey" --json

# 全文搜索
pyzotero search -q "transformer attention" --fulltext --json

# 按项目类型过滤
pyzotero search -q "climate change" --itemtype journalArticle --json

# 分页查询
pyzotero search -q "edge computing" --limit 10 --offset 20 --json
```

## 项目命令

### pyzotero item

**用途**：获取单个项目详情

**语法**：
```bash
pyzotero item [OPTIONS] KEY
```

**参数**：
- `KEY`：项目唯一标识（必需）
- `--json`：JSON 格式输出

**示例**：
```bash
pyzotero item ABC123 --json
```

### pyzotero subset

**用途**：批量获取多个项目

**语法**：
```bash
pyzotero subset [OPTIONS] KEYS...
```

**参数**：
- `KEYS`：项目 ID 列表（必需，最多 50 个）
- `--json`：JSON 格式输出

**示例**：
```bash
pyzotero subset ABC123 DEF456 GHI789 --json
```

### pyzotero children

**用途**：获取子项目（附件、笔记）

**语法**：
```bash
pyzotero children [OPTIONS] KEY
```

**参数**：
- `KEY`：父项目 ID（必需）
- `--json`：JSON 格式输出

**示例**：
```bash
pyzotero children ABC123 --json
```

### pyzotero fulltext

**用途**：获取全文内容

**语法**：
```bash
pyzotero fulltext KEY
```

**参数**：
- `KEY`：附件 ID（必需，注意是附件 KEY 而非论文 KEY）

**示例**：
```bash
# 先获取附件 KEY
pyzotero children ABC123 --json

# 再获取全文（使用附件 KEY）
pyzotero fulltext ATT456
```

## 引用分析命令

> 注意：以下命令通过 Semantic Scholar API 查询，需要论文的 **DOI**，不支持 Zotero KEY。且不支持 `--json` 参数。

### pyzotero citations

**用途**：查找引用给定论文的论文（使用 Semantic Scholar）

**语法**：
```bash
pyzotero citations --doi "DOI" [OPTIONS]
```

**参数**：
- `--doi TEXT`：论文的 DOI（必需）
- `--limit INTEGER`：限制返回数量（默认：100，最大：1000）
- `--min-citations INTEGER`：最小引用数过滤（默认：0）

**示例**：
```bash
pyzotero citations --doi "10.1109/JIOT.2023.1234567"
pyzotero citations --doi "10.1109/JIOT.2023.1234567" --limit 50
```

### pyzotero references

**用途**：查找给定论文引用的参考文献（使用 Semantic Scholar）

**语法**：
```bash
pyzotero references --doi "DOI" [OPTIONS]
```

**参数**：
- `--doi TEXT`：论文的 DOI（必需）
- `--limit INTEGER`：限制返回数量（默认：100，最大：1000）
- `--min-citations INTEGER`：最小引用数过滤（默认：0）

**示例**：
```bash
pyzotero references --doi "10.1109/JIOT.2023.1234567"
pyzotero references --doi "10.1109/JIOT.2023.1234567" --limit 50
```

### pyzotero related

**用途**：查找相关文献（使用 Semantic Scholar，基于 SPECTER2 嵌入）

**语法**：
```bash
pyzotero related --doi "DOI" [OPTIONS]
```

**参数**：
- `--doi TEXT`：论文的 DOI（必需）
- `--limit INTEGER`：限制返回数量（默认：20，最大：500）
- `--min-citations INTEGER`：最小引用数过滤（默认：0）

**示例**：
```bash
pyzotero related --doi "10.1109/JIOT.2023.1234567"
pyzotero related --doi "10.1109/JIOT.2023.1234567" --limit 30
```

### pyzotero s2search

**用途**：在 Semantic Scholar 上搜索论文

**语法**：
```bash
pyzotero s2search -q "QUERY" [OPTIONS]
```

**参数**：
- `-q, --query TEXT`：搜索查询字符串（必需）
- `--limit INTEGER`：限制返回数量（默认：20，最大：100）
- `--year TEXT`：年份过滤（如 '2020'、'2018-2022'）
- `--open-access`：仅返回开放获取论文
- `--sort [citations|year]`：按引用数或年份排序
- `--min-citations INTEGER`：最小引用数过滤

**示例**：
```bash
pyzotero s2search -q "machine learning"
pyzotero s2search -q "climate change" --year 2020-2024 --limit 50
pyzotero s2search -q "deep learning" --sort citations --min-citations 100
```

## 管理命令

### pyzotero listcollections

**用途**：列出所有收藏夹

**语法**：
```bash
pyzotero listcollections [OPTIONS]
```

**参数**：
- `--limit INTEGER`：限制返回数量（默认：全部）

**示例**：
```bash
pyzotero listcollections
pyzotero listcollections --limit 10
```

### pyzotero tags

**用途**：列出所有标签

**语法**：
```bash
pyzotero tags [OPTIONS]
```

**参数**：
- `--json`：JSON 格式输出

**示例**：
```bash
pyzotero tags --json
```

## 其他命令

### pyzotero test

**用途**：测试连接

**示例**：
```bash
pyzotero test
```

### pyzotero itemtypes

**用途**：列出所有有效的项目类型

**示例**：
```bash
pyzotero itemtypes
```

### pyzotero doiindex

**用途**：输出完整的 DOI 到 Key 的映射

**示例**：
```bash
pyzotero doiindex --json
```

### pyzotero alldoi

**用途**：查找本地库中的所有 DOI

**示例**：
```bash
pyzotero alldoi --json
```

## 暂不支持的功能

以下功能在 pyzotero 中暂不支持，需在 Zotero Desktop 中手动操作：

| 功能 | 说明 |
|------|------|
| 创建收藏夹 | 需在 Zotero Desktop 中操作 |
| 批量添加标签 | 需在 Zotero Desktop 中操作 |
| 批量移动条目 | 需在 Zotero Desktop 中操作 |
| 添加标注 | 需在 Zotero Desktop PDF 阅读器中操作 |
| 提取图表 | 需在 Zotero Desktop 中手动导出 |
| BibTeX 导出 | 可通过 `pyzotero item --json` 获取元数据后由 AI 转换 |
| 创建笔记 | 需在 Zotero Desktop 中操作 |

## 错误处理

### 常见错误

**错误：Connection refused**
- 原因：Zotero Desktop 未运行
- 解决：启动 Zotero Desktop

**错误：No results found**
- 原因：搜索词不准确或文库为空
- 解决：尝试更广泛的搜索词或添加文献

**错误：Invalid key**
- 原因：项目 ID 不存在
- 解决：检查项目 ID 是否正确

### 调试技巧

```bash
# 测试连接
pyzotero test

# 查看详细输出
pyzotero search -q "test" --json

# 检查 API 状态
curl -s "http://localhost:23119/api/users/0/items?limit=1"

# 查看帮助
pyzotero --help
pyzotero search --help
```

## 参考资源

- **pyzotero 文档**：https://pyzotero.readthedocs.io/
- **Zotero API 文档**：https://www.zotero.org/support/dev/web_api/v3/start
- **Semantic Scholar API**：https://api.semanticscholar.org/
- **命令详细参考**：[../reference.md](../reference.md)
