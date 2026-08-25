# 文献列表模板

## 基础格式

```markdown
# 文献调研：[主题]

**调研时间**：[日期]
**文献数量**：[数量]

## 按主题分类

### 1. [主题1]
- **作者** (年份). *标题*. 期刊/会议. [Zotero链接](zotero://select/items/KEY)
  - 摘要：[摘要内容]
  - 标签：#tag1 #tag2 #tag3

### 2. [主题2]
- **作者** (年份). *标题*. 期刊/会议. [Zotero链接](zotero://select/items/KEY)
  - 摘要：[摘要内容]
  - 标签：#tag1 #tag2 #tag3

## 按时间排序

### [年份1]
- **作者** (年份). *标题*. 期刊/会议. [Zotero链接](zotero://select/items/KEY)

### [年份2]
- **作者** (年份). *标题*. 期刊/会议. [Zotero链接](zotero://select/items/KEY)

## 统计信息
- 总文献数：[数量]
- 主要期刊/会议：[列表]
- 高引用文献：[列表]
```

## 使用示例

```markdown
# 文献调研：边缘计算与联邦学习

**调研时间**：2026-06-09
**文献数量**：8篇

## 按主题分类

### 1. 综述类论文
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
  - 摘要：全面综述了联邦学习在边缘计算中的应用
  - 标签：#survey #federated-learning #edge-computing

### 2. 隐私保护技术
- **Chen et al.** (2023). *Differential Privacy in Federated Learning*. NeurIPS. [Zotero链接](zotero://select/items/DEF456)
  - 摘要：研究了联邦学习中的差分隐私保护
  - 标签：#privacy #differential-privacy #federated-learning

## 按时间排序

### 2024年
- **Wang et al.** (2024). *Communication-Efficient Federated Learning*. ICML. [Zotero链接](zotero://select/items/GHI789)
  - 摘要：提出了通信高效的联邦学习算法
  - 标签：#communication #optimization #federated-learning

### 2023年
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
- **Chen et al.** (2023). *Differential Privacy in Federated Learning*. NeurIPS. [Zotero链接](zotero://select/items/DEF456)

## 统计信息
- 总文献数：8
- 主要期刊/会议：IEEE IoT Journal, NeurIPS, ICML
- 高引用文献：Li et al. (2023)
```

## 特殊元素处理

### 中英文混合
```markdown
- **Wang et al.** (2024). *Communication-Efficient Federated Learning*. ICML. [Zotero链接](zotero://select/items/KEY)
  - 摘要：本文提出了通信高效的联邦学习算法（本文为中文摘要）
  - 标签：#communication #federated-learning
```

### 多作者处理
```markdown
- **Li, Zhang, Wang et al.** (2023). *标题*. 期刊.
  # 超过3位作者时使用"et al."
```

### 图表引用
```markdown
## 图表

### 图1：系统架构图
![系统架构图](./figures/architecture.png)
- 来源：Li et al. (2023), Figure 3
- 说明：展示了联邦学习在边缘计算中的系统架构

### 表1：性能对比
| 方法 | 准确率 | 通信开销 |
|------|--------|----------|
| FedAvg | 85.2% | 高 |
| Ours | 87.3% | 低 |
- 来源：Wang et al. (2024), Table 2
```
