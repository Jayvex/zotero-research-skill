# Zotero Research Skill

> **Zotero 文献管理与科研工作流技能** — 让 AI 编程助手（Claude Code / WorkBuddy）直接与 Zotero 文献库交互。
>
> **Zotero Literature Management & Research Workflow Skill** — Enables AI coding assistants to interact directly with your Zotero library.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Python 3.8+](https://img.shields.io/badge/Python-3.8+-blue.svg)](https://www.python.org/)

---

## 功能特性 / Features

| 功能 / Feature | 说明 / Description |
|----------------|-------------------|
| 🔍 多源文献搜索 / Multi-source Search | 支持 Crossref、Semantic Scholar，中英文关键词 / Supports Crossref, Semantic Scholar with Chinese & English keywords |
| 📥 自动导入文献 / Auto Import | 通过 Zotero Web API 创建条目、上传 PDF、生成笔记 / Create items, upload PDFs, generate notes via Web API |
| 📖 论文精读 / Paper Reading | 获取元数据、提取 PDF 全文、分析引用关系 / Fetch metadata, extract PDF text, analyze citations |
| 📝 文献综述生成 / Literature Review | 基于指定文献自动生成结构化综述 / Auto-generate structured reviews from selected papers |
| 🔗 引用分析 / Citation Analysis | 查找引用、参考文献、相关文献（Semantic Scholar）/ Find citations, references, related papers |
| 📚 批量管理 / Batch Management | 收藏夹、标签、分页查询 / Collections, tags, pagination queries |

---

## 快速开始 / Quick Start

### 前置要求 / Prerequisites

| 依赖 / Dependency | 版本 / Version | 说明 / Description |
|-------------------|----------------|-------------------|
| Python | 3.8+ | 推荐 3.13+ / Recommended 3.13+ |
| Zotero Desktop | 7.0+ | 需要运行以使用本地 API / Must be running for local API |
| pyzotero | 最新 / Latest | `pip install pyzotero` |
| requests | 最新 / Latest | `pip install requests` |

### 安装 / Installation

```bash
# 克隆仓库 / Clone repository
git clone https://github.com/Jayvex/zotero-research-skill.git
cd zotero-research-skill

# 安装依赖 / Install dependencies
pip install pyzotero requests

# 中国用户可使用镜像 / Chinese users can use mirror
pip install pyzotero requests -i https://mirrors.aliyun.com/pypi/simple/
```

### 配置 Zotero Web API / Configure Zotero Web API

Web API 支持读写操作，是导入文献的唯一可靠方式。
Web API supports read/write operations and is the only reliable way to import literature.

1. 访问 / Visit https://www.zotero.org/settings/keys
2. 创建新密钥（勾选全部权限）/ Create new key (select all permissions)
3. 记录 Library ID 和 API Key / Record Library ID and API Key

```bash
# Linux/Mac
export ZOTERO_API_KEY="your_api_key"
export ZOTERO_LIBRARY_ID="your_library_id"

# Windows PowerShell
$env:ZOTERO_API_KEY="your_api_key"
$env:ZOTERO_LIBRARY_ID="your_library_id"

# Windows CMD
set ZOTERO_API_KEY=your_api_key
set ZOTERO_LIBRARY_ID=your_library_id
```

### 验证连接 / Verify Connection

```bash
# 测试 Web API / Test Web API
python -c "
from pyzotero import zotero
zot = zotero.Zotero('YOUR_ID', 'user', 'YOUR_KEY')
print(f'✓ 连接成功，文库共 {len(zot.items())} 条 / Connected, {len(zot.items())} items in library')
"

# 测试本地 API（需要 Zotero Desktop 运行）/ Test local API (requires Zotero Desktop)
pyzotero test
```

---

## 使用方法 / Usage

### 文献搜索与导入 / Search & Import

```bash
# 搜索并自动导入（Web API）/ Search and auto-import (Web API)
python scripts/auto_import.py -q "IoT agriculture" "物联网 农业"

# 仅搜索，不导入 / Search only, no import
python scripts/auto_import.py -q "STM32 RTOS" --no-import

# 导出 RIS 文件 / Export RIS file
python scripts/auto_import.py -q "edge computing" --export-ris -o output.ris

# 指定 API 配置 / Specify API config
python scripts/auto_import.py -q "smart farming" --api-key KEY --library-id ID
```

### 本地库检索 / Local Library Search

```bash
# 基础搜索 / Basic search
pyzotero search -q "machine learning" --json

# 全文搜索（包括 PDF 内容）/ Full-text search (including PDF content)
pyzotero search -q "methodology" --fulltext

# 按类型过滤 / Filter by type
pyzotero search -q "climate change" --itemtype journalArticle

# 按标签过滤 / Filter by tags
pyzotero search -q "topic" --tag "climate" --tag "adaptation"
```

### 论文阅读 / Paper Reading

```bash
pyzotero item KEY              # 获取详情 / Get details
pyzotero children KEY          # 获取附件/笔记 / Get attachments/notes
pyzotero fulltext KEY          # 获取全文 / Get full text
pyzotero subset KEY1 KEY2 KEY3 # 批量获取 / Batch fetch
```

### 引用分析 / Citation Analysis

```bash
pyzotero citations KEY     # 谁引用了这篇 / Who cited this
pyzotero references KEY    # 这篇引用了谁 / What this cited
pyzotero related KEY       # 相关文献 / Related papers
pyzotero s2search "query"  # Semantic Scholar 搜索 / Semantic Scholar search
```

### Python API 调用 / Python API Usage

```python
from pyzotero import zotero

zot = zotero.Zotero('YOUR_ID', 'user', 'YOUR_KEY')

# 创建文献 / Create item
item = {
    "itemType": "journalArticle",
    "title": "论文标题 / Paper Title",
    "creators": [{"creatorType": "author", "firstName": "First", "lastName": "Last"}],
    "publicationTitle": "期刊名 / Journal",
    "date": "2026",
    "DOI": "10.xxxx/xxxxx",
    "tags": [{"tag": "标签1"}],
}
result = zot.create_items([item])
key = result['successful']['0']['key']

# 附加 PDF / Attach PDF
zot.attachment_simple(["/path/to/paper.pdf"], key)

# 创建笔记 / Create note
zot.create_items([{
    "itemType": "note",
    "parentItem": key,
    "note": "<h1>笔记 / Notes</h1><p>内容... / Content...</p>",
}])
```

---

## 工作流 / Workflows

### 文献调研 / Literature Survey

```
用户 / User: 帮我调研"边缘计算与联邦学习"的最新进展
             Help me survey the latest advances in "edge computing and federated learning"

→ 多策略搜索（中英文）→ 合并去重 → 按引用排序 → 生成报告
→ Multi-strategy search (CN/EN) → Merge & deduplicate → Sort by citations → Generate report
```

### 论文精读 / Paper Deep Reading

```
用户 / User: 精读这篇论文 [提供 KEY]
             Deep read this paper [provide KEY]

→ 获取元数据 → 提取 PDF 全文 → 分析引用 → 生成笔记
→ Fetch metadata → Extract PDF text → Analyze citations → Generate notes
```

### 文献综述 / Literature Review

```
用户 / User: 根据这些文献生成综述：KEY1, KEY2, KEY3
             Generate a review from these papers: KEY1, KEY2, KEY3

→ 获取内容 → 识别主题 → 结构化写作 → 输出综述 + BibTeX
→ Fetch content → Identify themes → Structured writing → Output review + BibTeX
```

### 自动导入 / Auto Import

```
用户 / User: 帮我搜索并导入关于"IoT 嵌入式"的最新文献
             Search and import latest papers about "IoT embedded"

→ Crossref + Semantic Scholar 搜索 → 去重 → Web API 导入 → 附加 PDF
→ Crossref + Semantic Scholar search → Deduplicate → Web API import → Attach PDF
```

---

## 项目结构 / Project Structure

```
zotero-research-skill/
├── SKILL.md                          # 主入口（AI 助手读取）/ Main entry (AI assistant reads)
├── README.md                         # 本文件 / This file
├── reference.md                      # 命令详细参考 / Command reference
├── CHANGELOG.md                      # 更新日志 / Changelog
├── LICENSE                           # MIT 许可证 / MIT License
├── scripts/
│   ├── auto_import.py                # 搜索 + 自动导入脚本 / Search + auto-import script
│   ├── generate_review.py            # 文献综述生成脚本 / Literature review generator
│   ├── install.sh                    # 安装脚本 / Installation script
│   └── test.sh                       # 测试脚本 / Test script
├── templates/
│   └── markdown/
│       ├── paper-note.md             # 论文笔记模板（英文）/ Paper note template (EN)
│       ├── paper-note-zh.md          # 论文笔记模板（中文）/ Paper note template (ZH)
│       ├── literature-review.md      # 文献综述模板（英文）/ Literature review template (EN)
│       ├── literature-review-zh.md   # 文献综述模板（中文）/ Literature review template (ZH)
│       └── reference-list.md         # 引用列表模板 / Reference list template
├── workflows/
│   ├── literature-review.md          # 文献调研工作流 / Literature survey workflow
│   ├── paper-reading.md              # 论文精读工作流 / Paper reading workflow
│   ├── writing-support.md            # 论文写作支持 / Writing support
│   └── batch-management.md           # 批量管理 / Batch management
├── examples/                         # 输出示例 / Output examples
├── tests/                            # 测试文件 / Test files
└── docs/                             # 文档 / Documentation
```

---

## 集成到 AI 助手 / Integrate with AI Assistants

### WorkBuddy

```bash
# 复制到 WorkBuddy 技能目录 / Copy to WorkBuddy skills directory
cp -r . ~/.workbuddy/skills/zotero-research-skill
```

### Claude Code

```bash
# 复制到 Claude Code 技能目录 / Copy to Claude Code skills directory
cp -r . ~/.claude/skills/zotero-research-skill
```

安装后重启 AI 助手，即可用自然语言操作 Zotero：
After installation, restart your AI assistant and use natural language to operate Zotero:

```
帮我搜索关于"STM32 FreeRTOS"的文献
Search for papers about "STM32 FreeRTOS"

帮我精读这篇论文 [提供 DOI 或标题]
Deep read this paper [provide DOI or title]

帮我生成这些文献的综述
Generate a literature review from these papers
```

---

## 安全策略 / Security Policy

- **所有写入操作必须通过 Web API**，严禁直接修改 SQLite 数据库
  **All write operations must go through Web API** — direct SQLite modification is prohibited
- 删除操作使用 trash 而非永久删除
  Deletion uses trash (not permanent delete)
- API 密钥不记录在日志中
  API keys are not logged
- 大规模操作前建议备份数据库
  Backup database before large-scale operations

---

## 常见问题 / FAQ

**Q: 连接失败？/ Connection failed?**
A: 确认 Zotero Desktop 正在运行（本地 API），或检查 API Key 是否正确（Web API）。
   Ensure Zotero Desktop is running (local API), or check your API Key (Web API).

**Q: 搜索结果为空？/ Empty search results?**
A: 尝试更宽泛的关键词，或使用中英文分别搜索。
   Try broader keywords, or search in Chinese and English separately.

**Q: PDF 全文提取失败？/ PDF extraction failed?**
A: `pyzotero fulltext` 可能返回空，改用 PyPDF2 直接读取附件文件。
   `pyzotero fulltext` may return empty; use PyPDF2 to read attachment files directly.

**Q: 如何搜索所有文献？/ How to search all papers?**
A: `pyzotero search -q "" --limit 1000`

---

## 致谢 / Acknowledgements

- [pyzotero](https://github.com/urschrei/pyzotero) — Zotero Python 库 / Zotero Python library
- [Zotero](https://www.zotero.org/) — 文献管理软件 / Reference management software
- [Semantic Scholar](https://api.semanticscholar.org/) — 学术搜索引擎 / Academic search engine
- [Crossref](https://api.crossref.org/) — 学术元数据 / Scholarly metadata

---

## 许可证 / License

MIT License — 详见 / See [LICENSE](LICENSE)
