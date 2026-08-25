# 命令详细参考

## 概述

本文档提供 pyzotero 命令行工具的详细参考。pyzotero 是 Zotero 文献管理软件的命令行接口，支持本地 API 和 Web API。

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
- `--itemtype TEXT`：按项目类型过滤（可多次指定，OR 搜索）
- `--collection TEXT`：按收藏夹过滤
- `--tag TEXT`：按标签过滤（可多次指定，AND 搜索）
- `--limit INTEGER`：限制返回数量（默认：1000000）
- `--offset INTEGER`：跳过结果数量（用于分页，默认：0）
- `--json`：JSON 格式输出

**示例**：
```bash
# 基础检索
pyzotero search -q "machine learning"

# 限制返回数量
pyzotero search -q "machine learning" --limit 10

# JSON 格式输出
pyzotero search -q "machine learning" --json

# 全文搜索（包括 PDF 内容）
pyzotero search -q "methodology" --fulltext

# 按项目类型过滤
pyzotero search -q "climate change" --itemtype journalArticle

# 按收藏夹过滤
pyzotero search -q "test" --collection ABC123

# 按标签过滤
pyzotero search -q "topic" --tag "climate" --tag "adaptation"

# 分页查询
pyzotero search -q "topic" --limit 20 --offset 20 --json
```

**输出格式**：
```
Found 5 items:

1. [journalArticle] Machine Learning for Beginners
   Authors: John Doe, Jane Smith
   Date: 2023
   Publication: Journal of AI
   Volume: 10
   Issue: 2
   DOI: 10.1234/example
   URL: https://example.com
   Key: ABC123
```

**JSON 输出格式**：
```json
[
  {
    "key": "ABC123",
    "version": 1,
    "library": {
      "type": "user",
      "id": 0,
      "name": "我的文库"
    },
    "data": {
      "key": "ABC123",
      "itemType": "journalArticle",
      "title": "Machine Learning for Beginners",
      "creators": [
        {
          "creatorType": "author",
          "firstName": "John",
          "lastName": "Doe"
        }
      ],
      "date": "2023",
      "DOI": "10.1234/example"
    }
  }
]
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
# 获取项目详情
pyzotero item ABC123

# JSON 格式输出
pyzotero item ABC123 --json
```

**输出格式**：
```
[journalArticle] Machine Learning for Beginners
Authors: John Doe, Jane Smith
Date: 2023
Publication: Journal of AI
Volume: 10
Issue: 2
DOI: 10.1234/example
URL: https://example.com
Key: ABC123
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
# 获取多个项目
pyzotero subset ABC123 DEF456 GHI789

# JSON 格式输出
pyzotero subset ABC123 DEF456 --json
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
# 获取子项目
pyzotero children ABC123

# JSON 格式输出
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

## 收藏夹命令

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
# 列出所有收藏夹
pyzotero listcollections

# 限制返回数量
pyzotero listcollections --limit 10
```

**输出格式**：
```
Collections:
- My Papers (Key: COLL123)
- Research (Key: COLL456)
  - Sub Collection (Key: COLL789)
```

## 标签命令

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
# 列出标签
pyzotero tags

# JSON 格式输出
pyzotero tags --json
```

**输出格式**：
```
Tags:
- machine-learning
- deep-learning
- survey
```

## 其他命令

### pyzotero test

**用途**：测试连接

**语法**：
```bash
pyzotero test
```

**示例**：
```bash
# 测试连接
pyzotero test
```

**输出格式**：
```
✓ Connected to Zotero
  Library: 我的文库
  Type: user
  ID: 0
```

### pyzotero itemtypes

**用途**：列出所有有效的项目类型

**语法**：
```bash
pyzotero itemtypes
```

**示例**：
```bash
# 列出项目类型
pyzotero itemtypes
```

**输出格式**：
```
Item Types:
- artwork
- attachment
- audioRecording
- bill
- blogPost
- book
- bookSection
- case
- conferencePaper
- dictionaryEntry
- document
- email
- encyclopediaEntry
- film
- forumPost
- hearing
- instantMessage
- interview
- journalArticle
- letter
- magazineArticle
- manuscript
- map
- newspaperArticle
- note
- patent
- podcast
- presentation
- radioBroadcast
- report
- statute
- thesis
- tvBroadcast
- videoRecording
- webpage
```

### pyzotero doiindex

**用途**：输出完整的 DOI 到 Key 的映射

**语法**：
```bash
pyzotero doiindex [OPTIONS]
```

**参数**：
- `--json`：JSON 格式输出

**示例**：
```bash
# 输出 DOI 索引
pyzotero doiindex

# JSON 格式输出
pyzotero doiindex --json
```

### pyzotero alldoi

**用途**：查找本地库中的所有 DOI

**语法**：
```bash
pyzotero alldoi [OPTIONS]
```

**参数**：
- `--json`：JSON 格式输出

**示例**：
```bash
# 查找所有 DOI
pyzotero alldoi

# JSON 格式输出
pyzotero alldoi --json
```

## 引用分析命令

### pyzotero citations

**用途**：查找引用给定论文的论文（使用 Semantic Scholar）

> 注意：此命令需要论文的 **DOI**，不支持 Zotero KEY。不支持 `--json` 参数。

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
# 查找引用
pyzotero citations --doi "10.1109/JIOT.2023.1234567"

# 限制返回数量
pyzotero citations --doi "10.1109/JIOT.2023.1234567" --limit 50
```

### pyzotero references

**用途**：查找给定论文引用的参考文献（使用 Semantic Scholar）

> 注意：此命令需要论文的 **DOI**，不支持 Zotero KEY。不支持 `--json` 参数。

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
# 查找参考文献
pyzotero references --doi "10.1109/JIOT.2023.1234567"

# 限制返回数量
pyzotero references --doi "10.1109/JIOT.2023.1234567" --limit 50
```

### pyzotero related

**用途**：查找相关文献（使用 Semantic Scholar，基于 SPECTER2 嵌入）

> 注意：此命令需要论文的 **DOI**，不支持 Zotero KEY。不支持 `--json` 参数。

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
# 查找相关文献
pyzotero related --doi "10.1109/JIOT.2023.1234567"

# 限制返回数量
pyzotero related --doi "10.1109/JIOT.2023.1234567" --limit 30
```

### pyzotero s2search

**用途**：在 Semantic Scholar 上搜索论文

> 注意：此命令不支持 `--json` 参数。

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
# 在 Semantic Scholar 上搜索
pyzotero s2search -q "machine learning"

# 按年份过滤
pyzotero s2search -q "climate change" --year 2020-2024

# 按引用数排序
pyzotero s2search -q "deep learning" --sort citations --min-citations 100
```

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

**错误：Permission denied**
- 原因：API 权限不足
- 解决：检查 Zotero API 配置

### 调试技巧

1. **测试连接**：
   ```bash
   pyzotero test
   ```

2. **查看详细输出**：
   ```bash
   pyzotero search -q "test" --json
   ```

3. **检查 API 状态**：
   ```bash
   curl -s "http://localhost:23119/api/users/0/items?limit=1"
   ```

4. **查看帮助**：
   ```bash
   pyzotero --help
   pyzotero search --help
   ```
