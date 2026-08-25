# 文献综述生成工作流

## 使用场景

当用户需要根据指定的文献生成结构化文献综述时使用此工作流。

**典型场景**：
- 已选定若干篇核心文献，需要生成综述框架
- 需要分析多篇文献之间的引用关系
- 需要批量获取文献元数据并生成 BibTeX 引用
- 撰写论文 Related Work 章节时需要文献综述支持

## 工作流程

### 步骤 1：获取文献元数据

**目标**：根据用户提供的文献 KEY，获取每篇文献的详细元数据

**操作**：
```bash
# 获取单篇文献详情
pyzotero item KEY --json

# 批量获取多篇文献
pyzotero subset KEY1 KEY2 KEY3 --json
```

**提取信息**：
- 标题、作者、年份、期刊/会议
- 摘要、DOI、标签
- 文献类型（期刊论文、会议论文、综述等）

### 步骤 2：获取引用关系

**目标**：分析文献之间的引用网络

**操作**：
> 注意：以下命令需要论文的 **DOI**，不支持 Zotero KEY。

```bash
# 查找引用该论文的论文
pyzotero citations --doi "10.xxxx/yyyy"

# 查找该论文引用的参考文献
pyzotero references --doi "10.xxxx/yyyy"

# 查找相关文献
pyzotero related --doi "10.xxxx/yyyy"
```

**分析维度**：
- 被引用情况：哪些论文引用了这篇文献
- 参考文献：这篇文献引用了哪些论文
- 相关文献：Semantic Scholar 推荐的相关论文
- 交叉引用：输入文献之间的相互引用关系

### 步骤 3：获取全文（可选）

**目标**：尝试获取 PDF 全文用于内容分析

**操作**：
```bash
# 获取附件信息
pyzotero children KEY --json

# 获取全文内容（使用附件 KEY，非论文 KEY）
pyzotero fulltext ATT_KEY
```

> 注意：全文获取取决于是否有 PDF 附件以及是否已被索引。

### 步骤 4：生成文献综述

**目标**：将收集到的信息组织成结构化文献综述

**输出内容**：
1. **文献列表**：每篇文献的元数据摘要
2. **引用关系分析**：文献之间的引用网络
3. **BibTeX 引用**：可直接使用的 BibTeX 格式
4. **综述框架**：按年份、主题分类的综述大纲
5. **全文摘要**（如有全文）

## 使用方式

### 方式 1：使用脚本（推荐）

```bash
# 基本用法
python scripts/generate_review.py KEY1 KEY2 KEY3

# 指定输出文件
python scripts/generate_review.py KEY1 KEY2 KEY3 -o review.md

# 跳过引用关系查询（加快速度）
python scripts/generate_review.py KEY1 KEY2 --no-citations

# 跳过全文获取
python scripts/generate_review.py KEY1 KEY2 --no-fulltext

# 从标准输入读取 KEY
echo "KEY1 KEY2 KEY3" | python scripts/generate_review.py --stdin
```

### 方式 2：在 Claude Code 中使用

```
帮我根据这些文献生成文献综述：ABC123, DEF456, GHI789
```

Claude 会：
1. 依次执行 `pyzotero item KEY --json` 获取元数据
2. 通过论文 DOI 执行 `pyzotero citations/references/related --doi "DOI"` 获取引用关系
3. 尝试执行 `pyzotero fulltext ATT_KEY` 获取全文（需要先获取附件 KEY）
4. 生成结构化文献综述

### 方式 3：分步操作

```
帮我获取 ABC123、DEF456、GHI789 这三篇论文的详情和引用关系
```

然后：
```
根据刚才获取的信息，生成文献综述
```

## 输出格式

### 文献综述结构

```markdown
# 文献综述

**生成时间**：2026-06-09
**文献数量**：3 篇

## 一、文献列表

### 1. [论文标题]
- 作者：...
- 年份：...
- 类型：...
- DOI：...
- 标签：...
- 摘要：...
- Zotero链接：...

## 二、引用关系分析

### 1. [论文标题]
**被引用**（X 篇）：
- ...

**参考文献**（X 篇）：
- ...

**相关文献**（X 篇）：
- ...

## 三、BibTeX 引用

```bibtex
@article{...}
```

## 四、文献综述框架

### 引言
（请根据文献主题撰写引言）

### 相关工作
#### 2024 年
- Author et al. [Title]

#### 2023 年
- Author et al. [Title]

### 方法对比
（请根据各论文的方法论进行对比分析）

### 总结与展望
（请根据文献分析结果撰写总结）
```

## 示例交互

### 示例 1：生成文献综述

**用户请求**：
```
帮我根据这些文献生成文献综述：ABC123, DEF456, GHI789
```

**Skill 响应**：
1. 获取 3 篇文献的元数据
2. 获取引用关系
3. 生成结构化文献综述
4. 输出 BibTeX 引用
5. 提供综述框架建议

### 示例 2：快速获取 BibTeX

**用户请求**：
```
帮我获取 ABC123 和 DEF456 的 BibTeX 引用
```

**Skill 响应**：
1. 获取元数据
2. 生成 BibTeX 格式
3. 输出可复制的 BibTeX 代码

### 示例 3：分析引用关系

**用户请求**：
```
帮我分析 ABC123 这篇论文的引用关系
```

**Skill 响应**：
1. 获取论文详情
2. 查找引用该论文的论文
3. 查找该论文引用的参考文献
4. 查找相关文献
5. 输出引用关系分析报告

## 相关命令参考

- [pyzotero item](../reference.md#pyzotero-item)
- [pyzotero subset](../reference.md#pyzotero-subset)
- [pyzotero children](../reference.md#pyzotero-children)
- [pyzotero fulltext](../reference.md#pyzotero-fulltext)
- [pyzotero citations](../reference.md#pyzotero-citations)
- [pyzotero references](../reference.md#pyzotero-references)
- [pyzotero related](../reference.md#pyzotero-related)
