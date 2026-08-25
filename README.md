# Zotero Research Skill

> Zotero 文献管理与科研工作流技能 — 支持 AI 编程助手（Claude Code / WorkBuddy）直接与 Zotero 文献库交互。

## 功能特性

- **多源文献搜索**：Crossref、Semantic Scholar，支持中英文关键词
- **自动导入文献**：通过 Zotero Web API 创建条目、上传 PDF、生成笔记
- **论文精读**：获取元数据、提取 PDF 全文、分析引用关系
- **文献综述生成**：基于指定文献自动生成结构化综述
- **引用分析**：查找引用、参考文献、相关文献（Semantic Scholar）
- **批量管理**：收藏夹、标签、分页查询

## 快速开始

### 前置要求

| 依赖 | 版本 | 说明 |
|------|------|------|
| Python | 3.8+ | 推荐 3.13+ |
| Zotero Desktop | 7.0+ | 需要运行以使用本地 API |
| pyzotero | 最新 | `pip install pyzotero` |
| requests | 最新 | `pip install requests` |

### 安装

```bash
# 克隆仓库
git clone https://github.com/Jayvex/zotero-research-skill.git
cd zotero-research-skill

# 安装依赖
pip install pyzotero requests

# 或使用国内镜像（推荐中国用户）
pip install pyzotero requests -i https://mirrors.aliyun.com/pypi/simple/
```

### 配置 Zotero Web API（推荐）

Web API 支持读写操作，是导入文献的唯一可靠方式。

1. 访问 https://www.zotero.org/settings/keys
2. 创建新密钥（勾选全部权限）
3. 记录 Library ID（页面上方的数字）和 API Key

```bash
# 设置环境变量
export ZOTERO_API_KEY="your_api_key"
export ZOTERO_LIBRARY_ID="your_library_id"

# Windows PowerShell
$env:ZOTERO_API_KEY="your_api_key"
$env:ZOTERO_LIBRARY_ID="your_library_id"
```

### 验证连接

```bash
# 测试 Web API
python -c "
from pyzotero import zotero
zot = zotero.Zotero('YOUR_ID', 'user', 'YOUR_KEY')
print(f'✓ 连接成功，文库共 {len(zot.items())} 条')
"

# 测试本地 API（需要 Zotero Desktop 运行）
pyzotero test
```

## 使用方法

### 文献搜索与导入

```bash
# 搜索并自动导入（Web API）
python scripts/auto_import.py -q "IoT agriculture" "物联网 农业"

# 仅搜索，不导入
python scripts/auto_import.py -q "STM32 RTOS" --no-import

# 导出 RIS 文件（可手动导入 Zotero）
python scripts/auto_import.py -q "edge computing" --export-ris -o output.ris

# 指定 API 配置
python scripts/auto_import.py -q "smart farming" --api-key KEY --library-id ID
```

### 本地库检索

```bash
# 基础搜索
pyzotero search -q "machine learning" --json

# 全文搜索（包括 PDF 内容）
pyzotero search -q "methodology" --fulltext

# 按类型过滤
pyzotero search -q "climate change" --itemtype journalArticle

# 按标签过滤
pyzotero search -q "topic" --tag "climate" --tag "adaptation"
```

### 论文阅读

```bash
pyzotero item KEY              # 获取详情
pyzotero children KEY          # 获取附件/笔记
pyzotero fulltext KEY          # 获取全文
pyzotero subset KEY1 KEY2 KEY3 # 批量获取
```

### 引用分析

```bash
pyzotero citations KEY     # 谁引用了这篇
pyzotero references KEY    # 这篇引用了谁
pyzotero related KEY       # 相关文献
pyzotero s2search "query"  # Semantic Scholar 搜索
```

### Python API 直接调用

```python
from pyzotero import zotero

zot = zotero.Zotero('YOUR_ID', 'user', 'YOUR_KEY')

# 创建文献
item = {
    "itemType": "journalArticle",
    "title": "论文标题",
    "creators": [{"creatorType": "author", "firstName": "名", "lastName": "姓"}],
    "publicationTitle": "期刊名",
    "date": "2026",
    "DOI": "10.xxxx/xxxxx",
    "tags": [{"tag": "标签1"}],
}
result = zot.create_items([item])
key = result['successful']['0']['key']

# 附加 PDF
zot.attachment_simple(["/path/to/paper.pdf"], key)

# 创建笔记
zot.create_items([{
    "itemType": "note",
    "parentItem": key,
    "note": "<h1>笔记</h1><p>内容...</p>",
}])
```

## 工作流

### 文献调研

```
用户：帮我调研"边缘计算与联邦学习"的最新进展
→ 多策略搜索（中英文）→ 合并去重 → 按引用排序 → 生成报告
```

### 论文精读

```
用户：精读这篇论文 [提供 KEY]
→ 获取元数据 → 提取 PDF 全文 → 分析引用 → 生成笔记
```

### 文献综述

```
用户：根据这些文献生成综述：KEY1, KEY2, KEY3
→ 获取内容 → 识别主题 → 结构化写作 → 输出综述 + BibTeX
```

### 自动导入

```
用户：帮我搜索并导入关于"IoT 嵌入式"的最新文献
→ Crossref + Semantic Scholar 搜索 → 去重 → Web API 导入 → 附加 PDF
```

## 项目结构

```
zotero-research-skill/
├── SKILL.md                          # 主入口（AI 助手读取）
├── README.md                         # 本文件
├── reference.md                      # 命令详细参考
├── CHANGELOG.md                      # 更新日志
├── LICENSE                           # MIT 许可证
├── scripts/
│   ├── auto_import.py                # 搜索 + 自动导入脚本
│   ├── install.sh                    # 安装脚本
│   └── test.sh                       # 测试脚本
├── templates/
│   └── markdown/
│       ├── paper-note.md             # 论文笔记模板（英文）
│       ├── paper-note-zh.md          # 论文笔记模板（中文）
│       ├── literature-review.md      # 文献综述模板（英文）
│       ├── literature-review-zh.md   # 文献综述模板（中文）
│       └── reference-list.md         # 引用列表模板
├── workflows/
│   ├── literature-review.md          # 文献调研工作流
│   ├── paper-reading.md              # 论文精读工作流
│   ├── writing-support.md            # 论文写作支持
│   └── batch-management.md           # 批量管理
├── examples/                         # 输出示例
├── tests/                            # 测试文件
└── docs/                             # 文档
```

## 集成到 AI 助手

### WorkBuddy

```bash
# 复制到 WorkBuddy 技能目录
cp -r . ~/.workbuddy/skills/zotero-research-skill
```

### Claude Code

```bash
# 复制到 Claude Code 技能目录
cp -r . ~/.claude/skills/zotero-research-skill
```

安装后重启 AI 助手，即可用自然语言操作 Zotero：

```
帮我搜索关于"STM32 FreeRTOS"的文献
帮我精读这篇论文 [提供 DOI 或标题]
帮我生成这些文献的综述
```

## 安全策略

- **所有写入操作必须通过 Web API**，严禁直接修改 SQLite 数据库
- 删除操作使用 trash 而非永久删除
- API 密钥不记录在日志中
- 大规模操作前建议备份数据库

## 常见问题

**Q: 连接失败？**
A: 确认 Zotero Desktop 正在运行（本地 API），或检查 API Key 是否正确（Web API）。

**Q: 搜索结果为空？**
A: 尝试更宽泛的关键词，或使用中英文分别搜索。

**Q: PDF 全文提取失败？**
A: `pyzotero fulltext` 可能返回空，改用 PyPDF2 直接读取附件文件。

**Q: 如何搜索所有文献？**
A: `pyzotero search -q "" --limit 1000`

## 致谢

- [pyzotero](https://github.com/urschrei/pyzotero) — Zotero Python 库
- [Zotero](https://www.zotero.org/) — 文献管理软件
- [Semantic Scholar](https://api.semanticscholar.org/) — 学术搜索引擎
- [Crossref](https://api.crossref.org/) — 学术元数据

## 许可证

MIT License — 详见 [LICENSE](LICENSE)
