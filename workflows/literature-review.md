# 文献调研工作流

## 使用场景
当用户需要研究一个新领域或新主题时使用此工作流。

## 工作流程

### 步骤1：主题分析
**目标**：理解用户的研究需求，提取关键概念

**操作**：
1. 分析用户输入的研究主题
2. 提取核心关键词
3. 识别同义词和相关概念
4. 确定搜索策略

**示例**：
```
用户输入：边缘计算与联邦学习
分析结果：
- 核心关键词：边缘计算、联邦学习
- 同义词：Edge Computing、Federated Learning、边缘智能
- 相关概念：分布式学习、隐私保护、模型压缩
```

### 步骤2：多策略检索
**目标**：从多个角度搜索相关文献

**策略**：
1. **语义搜索**：概念相似性
   ```bash
   pyzotero search -q "边缘计算 联邦学习" --json
   ```

2. **关键词搜索**：精确匹配
   ```bash
   pyzotero search -q "edge computing" --json
   pyzotero search -q "federated learning" --json
   ```

3. **标签搜索**：利用现有标签体系
   ```bash
   pyzotero search -q "" --tag "edge-computing" --json
   pyzotero search -q "" --tag "federated-learning" --json
   ```

4. **全文搜索**：PDF内容检索
   ```bash
   pyzotero search -q "边缘计算" --fulltext --json
   ```

5. **组合搜索**：多条件组合
   ```bash
   pyzotero search -q "edge computing" --tag "survey" --json
   ```

### 步骤3：结果筛选
**目标**：从搜索结果中筛选最相关的文献

**筛选标准**：
1. **按时间排序**：最新优先
   ```bash
   pyzotero search -q "federated learning" --limit 50 --json
   ```
   > 注意：pyzotero 不直接支持 `--date-after` 参数，需手动过滤 JSON 结果中的日期字段。

2. **按引用量排序**：高引用优先（需要额外数据）

3. **按相关性排序**：基于关键词匹配度

4. **按文献类型筛选**：综述、会议论文、期刊文章

### 步骤4：文献组织
**目标**：将筛选后的文献组织成结构化集合

**操作**：
1. **查看现有收藏夹**
   ```bash
   pyzotero listcollections
   ```
   > 注意：pyzotero 不支持创建收藏夹，需在 Zotero Desktop 中手动创建。

2. **查看现有标签**
   ```bash
   pyzotero tags --json
   ```
   > 注意：pyzotero 不支持批量添加标签，需在 Zotero Desktop 中手动操作。

3. **生成文献综述框架**
   - 按主题分类
   - 按时间线组织
   - 按方法论分组

### 步骤5：输出格式化
**目标**：生成结构化的文献调研报告

**输出格式**：
```markdown
# 文献调研：边缘计算与联邦学习

**调研时间**：2026-06-09
**文献数量**：15篇

## 按主题分类

### 1. 综述类论文
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
  - 摘要：全面综述了联邦学习在边缘计算中的应用...
  - 标签：#survey #federated-learning #edge-computing

### 2. 隐私保护技术
- **Chen et al.** (2023). *Differential Privacy in Federated Learning*. NeurIPS. [Zotero链接](zotero://select/items/DEF456)
  - 摘要：研究了联邦学习中的差分隐私保护...
  - 标签：#privacy #differential-privacy #federated-learning

## 按时间排序

### 2024年
- [文献列表]

### 2023年
- [文献列表]

## 统计信息
- 总文献数：15
- 主要期刊/会议：IEEE IoT Journal, NeurIPS, ICML
- 高引用文献：[列表]
```

## 示例交互

**用户请求**：
```
帮我调研"边缘计算与联邦学习"的最新进展
```

**Skill响应**：
1. 执行多策略搜索（5-8次不同角度的搜索）
2. 合并去重结果
3. 按主题分类整理
4. 输出Markdown格式的文献列表
5. 建议创建收藏夹和标签

## 输出示例

```markdown
# 文献调研：边缘计算与联邦学习

**调研时间**：2026-06-09
**文献数量**：8篇

## 1. 综述类论文
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
  - 摘要：全面综述了联邦学习在边缘计算中的应用
  - 标签：#survey #federated-learning #edge-computing

## 2. 隐私保护技术
- **Chen et al.** (2023). *Differential Privacy in Federated Learning*. NeurIPS. [Zotero链接](zotero://select/items/DEF456)
  - 摘要：研究了联邦学习中的差分隐私保护
  - 标签：#privacy #differential-privacy #federated-learning

## 3. 通信优化
- **Wang et al.** (2024). *Communication-Efficient Federated Learning*. ICML. [Zotero链接](zotero://select/items/GHI789)
  - 摘要：提出了通信高效的联邦学习算法
  - 标签：#communication #optimization #federated-learning
```

## 相关命令参考
- [pyzotero search](../reference.md#pyzotero-search)
- [pyzotero listcollections](../reference.md#pyzotero-listcollections)
- [pyzotero tags](../reference.md#pyzotero-tags)
