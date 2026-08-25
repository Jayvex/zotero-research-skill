# 快速开始指南

## 概述

本指南将帮助您快速开始使用 Zotero Research Skill。

## 前置要求

在开始之前，请确保您已安装以下软件：

1. **Python 3.8+**
   ```bash
   python --version
   ```

2. **pyzotero** - Zotero Python 命令行工具
   ```bash
   pip install pyzotero
   # 或使用国内镜像
   pip install pyzotero -i https://pypi.tuna.tsinghua.edu.cn/simple
   ```

3. **Zotero Desktop** - 文献管理软件
   - 下载：https://www.zotero.org/download/
   - 安装并运行

4. **Claude Code** - AI 编程助手（可选）
   - 文档：https://docs.claude.com/claude-code

## 安装步骤

### 步骤 1：克隆仓库

```bash
git clone https://github.com/yourusername/zotero-research-skill.git
cd zotero-research-skill
```

### 步骤 2：运行安装脚本

```bash
./scripts/install.sh
```

安装脚本将：
- 检查依赖是否安装
- 安装 pyzotero（如果未安装）
- 创建必要的目录结构
- 验证安装
- 测试 Zotero 连接

### 步骤 3：验证安装

```bash
# 测试 pyzotero 连接
pyzotero test
```

如果看到连接成功信息，说明安装成功。

## 基本使用

### 文献检索

```bash
# 搜索文献
pyzotero search -q "machine learning" --json

# 按标签过滤
pyzotero search -q "IoT" --tag "survey" --json

# 全文检索
pyzotero search -q "transformer attention" --fulltext --json

# 限制返回数量
pyzotero search -q "deep learning" --limit 10 --json
```

### 论文阅读

```bash
# 获取论文详情
pyzotero item KEY --json

# 获取子项目（附件、笔记）
pyzotero children KEY --json

# 获取全文内容（需要附件 KEY，非论文 KEY）
pyzotero fulltext ATT_KEY
```

### 引用管理

```bash
# 列出收藏夹
pyzotero listcollections

# 列出标签
pyzotero tags --json
```

### 引用分析

> 注意：以下命令需要论文的 DOI，不支持 Zotero KEY。

```bash
# 查找引用（需要 DOI）
pyzotero citations --doi "10.1109/JIOT.2023.1234567"

# 查找参考文献（需要 DOI）
pyzotero references --doi "10.1109/JIOT.2023.1234567"

# 查找相关文献（需要 DOI）
pyzotero related --doi "10.1109/JIOT.2023.1234567"

# Semantic Scholar 搜索
pyzotero s2search -q "machine learning"
```

## 工作流使用

### 文献调研工作流

当您需要研究一个新领域或新主题时：

1. 告诉 Claude Code 您的研究主题
2. Claude Code 将执行多策略检索
3. 结果将按主题分类整理
4. 输出 Markdown 格式的文献列表

**示例**：
```
帮我调研"边缘计算与联邦学习"的最新进展
```

### 论文精读工作流

当您需要深入阅读一篇论文时：

1. 提供论文关键词或 DOI
2. Claude Code 将提取论文详情
3. 生成结构化论文笔记
4. 提供引用分析

**示例**：
```
精读这篇论文：Federated Learning for Edge Computing
```

### 文献综述生成工作流

当您需要根据指定文献生成文献综述时：

1. 提供文献 KEY 列表
2. Claude Code 将获取元数据和引用关系
3. 生成结构化文献综述

**示例**：
```
帮我根据这些文献生成文献综述：ABC123, DEF456, GHI789
```

或使用脚本：
```bash
python scripts/generate_review.py ABC123 DEF456 GHI789 -o review.md
```

### 论文写作支持工作流

当您撰写论文需要文献支持时：

1. 告诉 Claude Code 您的写作主题
2. Claude Code 将检索相关文献
3. 生成引用列表
4. 提供文献综述框架

**示例**：
```
帮我整理"联邦学习隐私保护"的引用，准备写 Related Work 章节
```

### 批量管理工作流

当您需要大规模文献组织和管理时：

1. 告诉 Claude Code 您的管理需求
2. Claude Code 将分析文献库
3. 提供管理建议
4. 生成管理报告

**示例**：
```
帮我整理文献库，添加统一的标签体系
```

## 输出格式

### Markdown 格式

```markdown
- **作者** (年份). *标题*. 期刊/会议. [Zotero链接](zotero://select/items/KEY)
  - 摘要：摘要内容
  - 标签：#tag1 #tag2
```

### Logseq 格式

```markdown
- 一级主题
  - 二级主题
    - 文献1
    - 文献2
```

## 常见问题

### Q: 如何安装 pyzotero？

A: 使用 pip 安装：
```bash
pip install pyzotero
```

### Q: 为什么连接失败？

A: 可能原因：
1. Zotero Desktop 未运行 → 启动 Zotero Desktop
2. 端口被占用 → 检查端口 23119
3. 防火墙阻止 → 检查防火墙设置

### Q: 支持哪些导出格式？

A: pyzotero 不直接支持导出，但可以通过 `pyzotero item --json` 获取元数据后，由 AI 转换为 BibTeX、APA、IEEE 等格式。

## 获取帮助

- **文档**：查看 `docs/` 目录下的文档
- **示例**：查看 `examples/` 目录下的示例
- **命令参考**：查看 [reference.md](../reference.md)
- **问题反馈**：提交 GitHub Issues

## 下一步

- 阅读 [配置指南](configuration.md) 了解更多配置选项
- 阅读 [故障排除](troubleshooting.md) 解决常见问题
- 阅读 [命令参考](../reference.md) 了解详细命令
