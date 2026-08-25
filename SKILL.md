# Zotero Research Skill

---
name: zotero-research-skill
description: |
  Zotero文献管理与科研工作流技能。当用户需要搜索文献、阅读论文、管理文献库、生成文献综述、提取PDF内容、格式化引用时使用此技能。
  即使用户没有明确提到"Zotero"，只要涉及文献检索、论文分析、学术写作、参考文献管理、PDF论文阅读等场景，都应触发此技能。
  支持中文和英文文献，特别适合中文学术环境。
---

## 概述
这是一个 Zotero 文献管理技能，支持全流程科研工作流，包括**自动搜索和导入文献**到 Zotero。

**核心原则：所有写入操作必须通过 Zotero Web API（pyzotero），严禁直接操作 SQLite 数据库。**

## WorkBuddy 环境配置

### Python 路径
```bash
PYTHON="C:/Users/20236/.workbuddy/binaries/python/envs/zotero-mcp/Scripts/python.exe"
```

### Zotero Web API 凭据
```
ZOTERO_API_KEY=PKQu6ADEfPv35LxfQUH8eykw
ZOTERO_LIBRARY_ID=20877475
ZOTERO_USERNAME=Jayvex
```

### 依赖包（已安装在 zotero-mcp venv 中）
- pyzotero（Zotero API 客户端）
- requests（HTTP 请求）
- fastmcp 1.0（MCP 服务器，用于 db_server.py 只读模式）

### Zotero 数据目录
- 数据库：`C:\ZoteroFile\zotero.sqlite`
- 存储：`C:\ZoteroFile\storage\`
- PDF/笔记临时目录：`C:\ZoteroFile\papers\`

### 快速连接测试
```bash
PYTHON="C:/Users/20236/.workbuddy/binaries/python/envs/zotero-mcp/Scripts/python.exe"
$PYTHON -c "
from pyzotero import zotero
zot = zotero.Zotero('20877475', 'user', 'PKQu6ADEfPv35LxfQUH8eykw')
items = zot.items(limit=3)
print(f'✓ 连接成功，文库共 {len(zot.items())} 条')
for i in items[:3]:
    print(f'  - {i[\"data\"][\"title\"][:50]}')
"
```

### 自动导入文献（推荐方式）
```bash
# 使用 auto_import.py 脚本
$PYTHON scripts/auto_import.py -q "IoT embedded" "物联网 嵌入式" --api-key PKQu6ADEfPv35LxfQUH8eykw --library-id 20877475

# 仅搜索不导入
$PYTHON scripts/auto_import.py -q "STM32 RTOS" --no-import

# 导出 RIS 文件
$PYTHON scripts/auto_import.py -q "edge computing" --export-ris -o output.ris
```

### 手动导入文献（pyzotero 直接调用）
```python
from pyzotero import zotero
zot = zotero.Zotero('20877475', 'user', 'PKQu6ADEfPv35LxfQUH8eykw')

# 创建文献条目
item = {
    "itemType": "journalArticle",
    "title": "论文标题",
    "creators": [
        {"creatorType": "author", "firstName": "名", "lastName": "姓"},
    ],
    "publicationTitle": "期刊名",
    "date": "2026",
    "DOI": "10.xxxx/xxxxx",
    "abstractNote": "摘要内容",
    "tags": [{"tag": "标签1"}, {"tag": "标签2"}],
}
result = zot.create_items([item])
key = result['successful']['0']['key']

# 附加 PDF 文件
zot.attachment_simple([r"C:\path\to\paper.pdf"], key)

# 创建笔记
zot.create_items([{
    "itemType": "note",
    "parentItem": key,
    "note": "<h1>笔记标题</h1><p>笔记内容...</p>",
}])
```

## 使用场景
当用户需要：
- 搜索和发现文献（支持多源搜索：Crossref、Semantic Scholar）
- **自动导入文献到Zotero**（通过Web API）
- 阅读和分析论文（包括提取PDF全文）
- 管理和组织文献库
- 生成文献综述
- 导出和格式化引用

## 环境检测

在执行任何操作前，先检测Python环境。Windows系统下`python`命令可能指向Windows Store存根（exit code 49），需要找到正确的Python路径。

**WorkBuddy 环境下直接使用**：
```bash
PYTHON="C:/Users/20236/.workbuddy/binaries/python/envs/zotero-mcp/Scripts/python.exe"
```

## 命令路由

### 文献检索（本地库）
- 基础检索：`pyzotero search -q "关键词" --json`
- 高级检索：`pyzotero search -q "关键词" --tag 标签 --json`
- 全文检索：`pyzotero search -q "关键词" --fulltext --json`
- 按类型检索：`pyzotero search -q "关键词" --itemtype journalArticle --json`
- 按收藏夹检索：`pyzotero search -q "关键词" --collection COLLKEY --json`

### 多源文献搜索（在线）
- Crossref搜索：搜索全球学术文献
- Semantic Scholar搜索：AI驱动的学术搜索，提供引用次数
- 使用自动导入脚本：`python scripts/auto_import.py -q "关键词"`

### 自动导入（Web API）
- 搜索并导入：`python scripts/auto_import.py -q "IoT agriculture" "物联网 农业"`
- 仅搜索不导入：`python scripts/auto_import.py -q "关键词" --no-import`
- 导出RIS文件：`python scripts/auto_import.py -q "关键词" --export-ris -o output.ris`
- 指定API配置：`python scripts/auto_import.py -q "关键词" --api-key KEY --library-id ID`

### 论文阅读
- 获取详情：`pyzotero item KEY`
- 获取多个项目：`pyzotero subset KEY1 KEY2 KEY3`
- 获取子项目：`pyzotero children KEY`
- 获取全文：`pyzotero fulltext KEY`（注意：此命令可能返回空结果，需备选方案）

### 引用管理
- 列出收藏夹：`pyzotero listcollections`
- 列出标签：`pyzotero tags`
- 测试连接：`pyzotero test`

### 文献管理
- 搜索文献：`pyzotero search -q "关键词" --limit 10`
- JSON输出：`pyzotero search -q "关键词" --json`
- 分页查询：`pyzotero search -q "关键词" --limit 10 --offset 20`

## PDF全文提取

`pyzotero fulltext KEY` 可能返回空结果。当遇到此情况时，使用以下备选方案：

### 方案1：通过附件路径直接读取
1. 获取条目的子项目（附件）：`pyzotero children KEY --json`
2. 从返回的JSON中提取PDF文件路径（`enclosure.href` 字段，格式为 `file:///...`）
3. 将 `file:///` 前缀替换为实际路径
4. 使用Python PyPDF2提取文本

### 方案2：Python PyPDF2提取
```python
import PyPDF2
import sys
sys.stdout.reconfigure(encoding='utf-8')  # Windows下必须设置UTF-8编码

pdf_path = r'<PDF文件路径>'
reader = PyPDF2.PdfReader(pdf_path)
print(f'总页数: {len(reader.pages)}')

text = ''
for i, page in enumerate(reader.pages):
    t = page.extract_text()
    if t:
        text += f'\n--- 第{i+1}页 ---\n{t}'
print(text)
```

### 方案3：Read工具直接读取
如果系统安装了pdftoppm等工具，可以直接使用Read工具读取PDF：
```
Read file_path=<PDF路径> pages=1-20
```

### 编码注意事项
- Windows下Python输出中文时可能遇到GBK编码错误
- 必须在脚本开头添加 `sys.stdout.reconfigure(encoding='utf-8')`
- PyPDF2的`extract_text()`对某些PDF可能提取效果不佳，这是正常现象

## 搜索策略优化

当搜索结果较少时（<3条），执行扩展搜索：

### 多维度搜索
1. **中文关键词**：`pyzotero search -q "物联网" --json`
2. **英文关键词**：`pyzotero search -q "IoT" --json`
3. **同义词搜索**：`pyzotero search -q "Internet of Things" --json`
4. **上位概念**：`pyzotero search -q "农业" --json`
5. **组合搜索**：`pyzotero search -q "物联网 农业" --json`

### 搜索结果扩展
如果初始搜索结果不足，尝试：
- 去掉限定词，使用更宽泛的关键词
- 使用英文和中文分别搜索
- 搜索相关领域的上位概念
- 使用 `--limit 50` 增加返回数量

## 工作流

### 自动导入工作流（新增！）
当用户需要搜索并导入文献到Zotero时：

**快速使用**：
```bash
# 搜索并自动导入
python scripts/auto_import.py -q "IoT agriculture" "物联网 农业" "precision agriculture"

# 指定数量
python scripts/auto_import.py -q "smart farming" --limit 20

# 仅搜索，不导入
python scripts/auto_import.py -q "agricultural sensor" --no-import

# 导出为RIS文件（可在Zotero中手动导入）
python scripts/auto_import.py -q "智慧农业" --export-ris -o agriculture.ris
```

**完整流程**：
1. **环境检测**：自动检测Python路径和依赖
2. **多源搜索**：从Crossref和Semantic Scholar搜索文献
3. **智能去重**：基于标题自动去重
4. **结果排序**：按引用次数排序（如有）
5. **自动导入**：通过Web API导入到Zotero
6. **标签管理**：自动添加来源标签（如：`imported:crossref`）

**API配置**：
```bash
# 方式1：环境变量
export ZOTERO_API_KEY="your_api_key"
export ZOTERO_LIBRARY_ID="your_library_id"

# 方式2：命令行参数
python scripts/auto_import.py -q "关键词" --api-key KEY --library-id ID
```

**获取API配置**：
1. 访问 https://www.zotero.org/settings/keys
2. 创建API密钥（选择全部权限）
3. 复制Library ID和API密钥

### 文献调研工作流
当用户需要研究一个新领域或新主题时：
1. 分析查询意图（概念搜索 vs 关键词搜索）
2. 执行多策略搜索（至少3种变体，中英文各尝试）
3. 合并去重结果
4. 按相关性排序
5. 输出Markdown格式

### 论文精读工作流
当用户需要深入阅读一篇论文时：
1. 获取论文元数据（`pyzotero item KEY`）
2. 提取PDF文本（优先`pyzotero fulltext KEY`，失败则用PyPDF2）
3. 读取现有标注
4. 提供分析选项（摘要、关键点、方法总结）
5. 支持交互式标注

### 文献综述生成工作流
当用户需要基于文库中的文献生成文献综述时：
1. **文献检索**：使用多维度搜索找到所有相关文献
2. **内容提取**：对每篇文献提取PDF全文
   - 先尝试 `pyzotero fulltext KEY`
   - 失败则获取附件路径，用PyPDF2提取
3. **内容分析**：阅读提取的文本，识别：
   - 研究背景和动机
   - 关键技术和方法
   - 主要贡献和发现
   - 实验结果和数据
   - 参考文献列表
4. **综述结构设计**：
   - 引言（研究背景）
   - 发展现状
   - 关键技术
   - 应用实践
   - 挑战与展望
   - 结论
5. **综述撰写**：基于分析结果撰写文献综述
6. **引用格式化**：整理参考文献列表

### 论文写作支持工作流
当用户撰写论文需要文献支持时：
1. 根据写作主题检索相关文献
2. 按论文章节组织引用
3. 生成引用列表
4. 提供文献综述框架

### 批量管理工作流
当用户需要大规模文献组织和管理时：
1. 统计文献数量和分布
2. 识别未分类文献
3. 执行批量操作
4. 生成管理报告

## 输出格式

### Markdown格式
```markdown
- **作者(s)** (年份). *标题*. 期刊/会议. [Zotero链接](zotero://select/items/KEY)
  - 摘要：简要摘要内容
  - 标签：#tag1 #tag2 #tag3
  - 笔注：个人笔记或标注摘要
```

### Logseq格式
```markdown
- 一级主题
  - 二级主题
    - 文献1
    - 文献2
```

### 文献综述格式
```markdown
# [主题]：文献综述

## 1. 引言
[研究背景和动机]

## 2. 发展现状
[领域发展概述]

## 3. 关键技术
### 3.1 [技术1]
[技术描述和相关文献]

### 3.2 [技术2]
[技术描述和相关文献]

## 4. 应用实践
[应用案例和效果]

## 5. 挑战与展望
[当前挑战和未来方向]

## 6. 结论
[总结]

## 参考文献
[格式化的引用列表]
```

## 安全策略

### 写操作保护
- **所有写入操作必须通过 Web API**，严禁直接修改 SQLite 数据库
- 删除操作默认使用trash（移动到回收站）而非永久删除
- 删除前必须确认
- 批量操作前显示影响范围
- 超过10个条目的批量操作需要二次确认

### 数据完整性
- Web API 自动处理所有内部关联（key、version、syncState 等）
- 大规模操作前建议备份（`C:\ZoteroFile\zotero.sqlite.bak`）

### 权限控制
- API 密钥不记录在日志中
- SQLite 数据库只读访问（通过 MCP server 的 db_server.py）
- 写操作通过 Web API（安全）

## 错误处理

### Python环境错误
- **exit code 49**：`python`命令指向Windows Store存根，使用完整Python路径
- **找不到Python**：检查 `C:/Users/<用户名>/AppData/Local/Programs/Python/` 目录
- **PyPDF2未安装**：运行 `pip install PyPDF2`

### 编码错误
- **UnicodeEncodeError: 'gbk' codec**：在Python脚本开头添加 `sys.stdout.reconfigure(encoding='utf-8')`
- **UnicodeDecodeError**：确保文件路径使用正确的编码

### 网络错误
- 自动重试（最多3次）
- 重试间隔递增（1s, 2s, 4s）
- 提供离线模式建议

### 数据错误
- 条目不存在时提供相似条目建议
- PDF损坏时尝试多种提取器
- 元数据缺失时尝试自动补全

### 操作错误
- 提供详细错误信息
- 建议可能的解决方案
- 提供帮助文档链接

## 配置要求
- Python 3.8+ 已安装
- pyzotero 已安装（`pip install pyzotero`）
- requests 已安装（`pip install requests`）- 用于在线搜索
- PyPDF2 已安装（`pip install PyPDF2`）- 用于PDF全文提取
- Zotero Desktop 正在运行
- 本地 API 可用（默认端口 23119）
- Web API 密钥（用于自动导入，可选）

## API 配置

### 本地 API（只读，MCP Server 使用）
- 地址：`http://localhost:23119/api/`
- 无需 API 密钥
- 需要 Zotero Desktop 运行
- **限制**：只读，不支持写入操作
- MCP Server 配置在 `~/.workbuddy/mcp.json` 的 `zotero-mcp-server` 条目

### Web API（读写，推荐用于导入）
- 地址：`https://api.zotero.org/`
- **已配置完成**（见上方 WorkBuddy 环境配置）
- **支持**：读取和写入操作

**配置步骤**：
1. 访问 https://www.zotero.org/settings/keys
2. 登录您的Zotero账户
3. 点击 "Create new private key"
4. 为密钥命名（如：auto-import）
5. 选择权限（建议选择全部权限）
6. 点击 "Save Key"
7. 复制生成的 API 密钥和 Library ID

**环境变量配置**：
```bash
# Windows PowerShell
$env:ZOTERO_API_KEY="your_api_key"
$env:ZOTERO_LIBRARY_ID="your_library_id"

# Windows CMD
set ZOTERO_API_KEY=your_api_key
set ZOTERO_LIBRARY_ID=your_library_id

# Linux/Mac
export ZOTERO_API_KEY="your_api_key"
export ZOTERO_LIBRARY_ID="your_library_id"
```

**验证配置**：
```bash
# 测试API连接
python scripts/auto_import.py -q "test" --no-import
```

## 相关文档
- [命令详细参考](reference.md)
- [中文使用说明](docs/使用说明.md)
- [自动导入工作流](workflows/auto-import.md)（新增！）
- [自动导入快速参考](docs/auto-import-quick-reference.md)（新增！）
- [文献调研工作流](workflows/literature-review.md)
- [论文精读工作流](workflows/paper-reading.md)
- [论文写作支持工作流](workflows/writing-support.md)
- [批量管理工作流](workflows/batch-management.md)
- [故障排除指南](docs/troubleshooting.md)
