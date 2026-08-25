# 在 Claude Code 中使用 Zotero Research Skill

## 📋 目录

- [概述](#概述)
- [安装方法](#安装方法)
- [使用方法](#使用方法)
- [可用命令](#可用命令)
- [工作流使用](#工作流使用)
- [示例对话](#示例对话)
- [常见问题](#常见问题)

## 概述

Zotero Research Skill 是一个为 Claude Code 设计的技能，可以让 Claude 直接与你的 Zotero 文献库交互。通过这个技能，你可以：

- 🔍 搜索文献库中的论文
- 📄 获取论文详情和元数据
- 📚 管理收藏夹和标签
- 📊 分析引用关系
- 📝 生成文献综述和引用列表

## 安装方法

### 方法 1：全局安装（推荐）

将 skill 安装到 Claude Code 的全局技能目录：

```bash
# 1. 克隆项目
git clone https://github.com/yourusername/zotero-research-skill.git
cd zotero-research-skill

# 2. 复制到 Claude Code 技能目录
# Windows
cp -r . "C:\Users\%USERNAME%\.claude\skills\zotero-research"

# macOS/Linux
cp -r . ~/.claude/skills/zotero-research
```

### 方法 2：项目级安装

将 skill 安装到特定项目的技能目录：

```bash
# 1. 克隆项目
git clone https://github.com/yourusername/zotero-research-skill.git
cd zotero-research-skill

# 2. 复制到项目技能目录
mkdir -p .claude/skills
cp -r . .claude/skills/zotero-research
```

### 方法 3：符号链接（开发模式）

```bash
# 1. 克隆项目
git clone https://github.com/yourusername/zotero-research-skill.git
cd zotero-research-skill

# 2. 创建符号链接
# Windows (需要管理员权限)
mklink /D "C:\Users\%USERNAME%\.claude\skills\zotero-research" "C:\path\to\zotero-research-skill"

# macOS/Linux
ln -s /path/to/zotero-research-skill ~/.claude/skills/zotero-research
```

### 验证安装

安装完成后，重启 Claude Code，然后输入：

```
/skills
```

你应该能看到 `zotero-research` 在技能列表中。

## 使用方法

### 前置条件

1. **Zotero Desktop 正在运行**
   - 确保 Zotero Desktop 已启动
   - 本地 API 默认端口 23119 可用

2. **pyzotero 已安装**
   ```bash
   pip install pyzotero
   ```

3. **测试连接**
   ```bash
   pyzotero test
   ```

### 基本使用

在 Claude Code 中，你可以直接用自然语言与 Zotero 交互：

#### 搜索文献

```
用户：帮我搜索关于"machine learning"的文献
Claude：我来帮你搜索文献库...
[执行 pyzotero search -q "machine learning" --limit 10]
```

#### 获取论文详情

```
用户：帮我查看这篇论文的详情 [提供 KEY]
Claude：我来获取这篇论文的详情...
[执行 pyzotero item KEY]
```

#### 列出收藏夹

```
用户：帮我查看我的收藏夹
Claude：我来列出你的收藏夹...
[执行 pyzotero listcollections]
```

## 可用命令

### 搜索命令

```
# 基础搜索
pyzotero search -q "关键词"

# 限制返回数量
pyzotero search -q "关键词" --limit 10

# JSON 格式输出
pyzotero search -q "关键词" --json

# 全文搜索（包括 PDF 内容）
pyzotero search -q "关键词" --fulltext

# 按项目类型过滤
pyzotero search -q "关键词" --itemtype journalArticle

# 按标签过滤
pyzotero search -q "关键词" --tag "标签"

# 按收藏夹过滤
pyzotero search -q "关键词" --collection COLLKEY
```

### 项目命令

```
# 获取单个项目详情
pyzotero item KEY

# 获取多个项目
pyzotero subset KEY1 KEY2 KEY3

# 获取子项目（附件、笔记）
pyzotero children KEY

# 获取全文内容
pyzotero fulltext KEY
```

### 管理命令

```
# 列出所有收藏夹
pyzotero listcollections

# 列出所有标签
pyzotero tags

# 测试连接
pyzotero test
```

### 引用分析命令

> 注意：以下命令需要论文的 **DOI**，不支持 Zotero KEY。且不支持 `--json` 参数。

```
# 查找引用给定论文的论文（需要 DOI）
pyzotero citations --doi "10.xxxx/yyyy"

# 查找给定论文引用的参考文献（需要 DOI）
pyzotero references --doi "10.xxxx/yyyy"

# 查找相关文献（需要 DOI）
pyzotero related --doi "10.xxxx/yyyy"

# 在 Semantic Scholar 上搜索
pyzotero s2search -q "关键词"
```

## 工作流使用

### 文献调研工作流

当你说"帮我调研某个主题"时，Claude 会：

1. **分析主题**：提取关键词和同义词
2. **多策略搜索**：执行多次不同角度的搜索
3. **合并结果**：去重并按相关性排序
4. **输出报告**：生成 Markdown 格式的文献列表

**示例对话**：
```
用户：帮我调研"边缘计算与联邦学习"的最新进展

Claude：我来帮你调研这个主题。

首先，让我搜索相关文献：

[执行搜索命令]
- pyzotero search -q "边缘计算 联邦学习" --limit 10
- pyzotero search -q "edge computing federated learning" --limit 10
- pyzotero search -q "federated learning" --fulltext --limit 10

找到以下文献：

## 文献调研：边缘计算与联邦学习

### 1. 综述类论文
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal.
  - Key: ABC123
  - 标签：#survey #federated-learning #edge-computing

### 2. 隐私保护技术
- **Chen et al.** (2023). *Differential Privacy in Federated Learning*. NeurIPS.
  - Key: DEF456
  - 标签：#privacy #differential-privacy #federated-learning

需要我帮你创建收藏夹或添加标签吗？
```

### 论文精读工作流

当你说"精读这篇论文"时，Claude 会：

1. **获取元数据**：论文标题、作者、摘要等
2. **提取内容**：PDF 全文、标注、笔记
3. **分析引用**：查找引用和参考文献
4. **生成笔记**：结构化的论文笔记

**示例对话**：
```
用户：精读这篇论文 [提供 KEY 或标题]

Claude：我来帮你精读这篇论文。

[获取论文详情]
pyzotero item ABC123

[获取子项目]
pyzotero children ABC123

[分析引用（需要 DOI）]
pyzotero citations --doi "10.1109/JIOT.2023.1234567"
pyzotero references --doi "10.1109/JIOT.2023.1234567"

## 论文笔记：Federated Learning for Edge Computing: A Survey

### 基本信息
- **作者**：Li, Xiaoxiao and others
- **年份**：2023
- **期刊**：IEEE Internet of Things Journal
- **Key**：ABC123

### 核心内容
[论文摘要和关键点]

### 引用分析
[引用该论文的文献列表]
[该论文引用的参考文献列表]
[相关文献列表]
```

### 论文写作支持工作流

当你说"帮我整理引用"时，Claude 会：

1. **搜索相关文献**：根据写作主题
2. **分类整理**：按主题或时间分类
3. **生成引用**：BibTeX、APA、IEEE 等格式
4. **输出列表**：结构化的参考文献列表

**示例对话**：
```
用户：帮我整理"联邦学习隐私保护"的引用，准备写 Related Work

Claude：我来帮你整理引用。

[搜索相关文献]
pyzotero search -q "federated learning privacy" --limit 20
pyzotero search -q "differential privacy federated learning" --limit 10

## 参考文献列表：联邦学习隐私保护

### 正文中引用
[1] Li et al. (2023). Federated Learning for Edge Computing. IEEE IoT Journal.
[2] Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.

### BibTeX 格式
```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao and others},
  journal={IEEE Internet of Things Journal},
  year={2023}
}
```

需要我帮你生成其他格式的引用吗？
```

### 批量管理工作流

当你说"帮我整理文献库"时，Claude 会：

1. **分析现状**：统计文献数量和分布
2. **识别问题**：未分类文献、重复文献等
3. **提供建议**：标签体系、收藏夹结构
4. **执行操作**：批量添加标签、移动收藏夹

**示例对话**：
```
用户：帮我整理文献库，添加统一的标签体系

Claude：我来帮你整理文献库。

[分析现状]
pyzotero listcollections
pyzotero tags
pyzotero search -q "" --limit 100

## 文献库分析报告

### 当前状态
- 总文献数：150
- 收藏夹：5 个
- 标签：20 个

### 建议的标签体系
1. 按主题分类
   - #federated-learning
   - #edge-computing
   - #privacy
   - #communication

2. 按类型分类
   - #survey
   - #methodology
   - #application

需要我帮你批量添加这些标签吗？
```

## 示例对话

### 示例 1：快速搜索

```
用户：搜索关于"transformer"的论文

Claude：我来搜索关于 transformer 的论文。

[执行搜索]
pyzotero search -q "transformer" --limit 10

找到 10 篇相关论文：

1. [journalArticle] Attention Is All You Need
   Authors: Vaswani, Ashish et al.
   Date: 2017
   Key: ABC123

2. [journalArticle] BERT: Pre-training of Deep Bidirectional Transformers
   Authors: Devlin, Jacob et al.
   Date: 2019
   Key: DEF456

需要我获取某篇论文的详细信息吗？
```

### 示例 2：获取论文详情

```
用户：帮我查看 ABC123 这篇论文

Claude：我来获取这篇论文的详情。

[执行命令]
pyzotero item ABC123

## 论文详情

**标题**：Attention Is All You Need
**作者**：Vaswani, Ashish et al.
**年份**：2017
**会议**：NeurIPS
**Key**：ABC123

这篇论文提出了 Transformer 架构，是深度学习领域的重要突破。

需要我分析这篇论文的引用关系吗？
```

### 示例 3：查看收藏夹

```
用户：帮我看看我有哪些收藏夹

Claude：我来列出你的收藏夹。

[执行命令]
pyzotero listcollections

## 你的收藏夹

- **联邦学习** (Key: COLL123)
  - 包含 25 篇文献
- **边缘计算** (Key: COLL456)
  - 包含 15 篇文献
- **隐私保护** (Key: COLL789)
  - 包含 10 篇文献

需要我帮你查看某个收藏夹中的文献吗？
```

## 常见问题

### Q: 为什么 Claude 无法连接到 Zotero？

**A**: 可能原因：
1. Zotero Desktop 未运行 → 启动 Zotero Desktop
2. pyzotero 未安装 → 运行 `pip install pyzotero`
3. 端口被占用 → 检查端口 23119

### Q: 如何让 Claude 使用中文回复？

**A**: 在对话开始时说：
```
请用中文回复我
```

### Q: 如何让 Claude 生成特定格式的引用？

**A**: 明确指定格式：
```
帮我生成这篇论文的 BibTeX 格式引用
帮我生成这篇论文的 APA 格式引用
帮我生成这篇论文的 IEEE 格式引用
```

### Q: 如何让 Claude 搜索特定类型的文献？

**A**: 指定项目类型：
```
帮我搜索关于"machine learning"的期刊文章
帮我搜索关于"deep learning"的会议论文
```

### Q: 如何让 Claude 使用全文搜索？

**A**: 指定全文搜索：
```
帮我全文搜索"methodology"
搜索 PDF 中包含"attention mechanism"的论文
```

### Q: 如何让 Claude 分析引用关系？

**A**: 指定分析类型：
```
帮我分析这篇论文的引用关系
帮我查找引用这篇论文的其他论文
帮我查找这篇论文引用的参考文献
帮我查找与这篇论文相关的其他论文
```

### Q: 如何让 Claude 批量操作？

**A**: 明确指定操作：
```
帮我获取这 5 篇论文的详情 [提供 KEY 列表]
帮我查看这 3 个收藏夹中的文献
```

## 高级技巧

### 1. 组合命令

```
用户：帮我搜索"federated learning"，然后获取前 3 篇论文的详情

Claude：我来执行组合操作。

[搜索]
pyzotero search -q "federated learning" --limit 3

[获取详情]
pyzotero item KEY1
pyzotero item KEY2
pyzotero item KEY3
```

### 2. 条件过滤

```
用户：帮我搜索 2023 年以后关于"edge computing"的期刊文章

Claude：我来搜索符合条件的文献。

[搜索]
pyzotero search -q "edge computing" --itemtype journalArticle --limit 20

然后手动过滤 2023 年以后的文献。
```

### 3. 分页查询

```
用户：帮我查看文献库中的第 11-20 篇文献

Claude：我来分页查询。

[分页查询]
pyzotero search -q "" --limit 10 --offset 10
```

### 4. JSON 格式输出

```
用户：帮我搜索"deep learning"，并以 JSON 格式输出

Claude：我来搜索并以 JSON 格式输出。

[JSON 输出]
pyzotero search -q "deep learning" --json
```

## 📚 相关资源

- **pyzotero 文档**：https://pyzotero.readthedocs.io/
- **Zotero API 文档**：https://www.zotero.org/support/dev/web_api/v3/start
- **Semantic Scholar API**：https://api.semanticscholar.org/
- **Claude Code 文档**：https://docs.claude.com/claude-code

---

**🎉 享受使用 Zotero Research Skill！**
