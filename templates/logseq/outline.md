# Logseq 大纲模板

## 基础格式

```markdown
- 一级主题
  - 二级主题
    - 文献1
    - 文献2
  - 二级主题
    - 文献3
```

## 使用示例

```markdown
- 文献调研：边缘计算与联邦学习
  - 综述类论文
    - Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
      - 摘要：全面综述了联邦学习在边缘计算中的应用
      - 标签：#survey #federated-learning #edge-computing
    - Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE. [Zotero链接](zotero://select/items/DEF456)
      - 摘要：提出了边缘智能的按需深度学习模型
      - 标签：#edge-ai #deep-learning #model-compression

  - 隐私保护技术
    - Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS. [Zotero链接](zotero://select/items/GHI789)
      - 摘要：研究了联邦学习中的差分隐私保护
      - 标签：#privacy #differential-privacy #federated-learning

  - 通信优化
    - Wang et al. (2024). Communication-Efficient Federated Learning. ICML. [Zotero链接](zotero://select/items/JKL012)
      - 摘要：提出了通信高效的联邦学习算法
      - 标签：#communication #optimization #federated-learning
```

## 标签系统

### 标签规范
```markdown
- 文献标题 #tag1 #tag2
  - 笔记内容 #tag3
```

### 标签示例
```markdown
- Federated Learning for Edge Computing #survey #federated-learning #edge-computing
  - 全面综述了联邦学习在边缘计算中的应用 #综述 #边缘计算
  - 主要贡献：识别了通信效率、隐私保护、模型压缩等关键挑战 #贡献 #挑战
```

## 链接格式

### Zotero链接
```markdown
- [文献标题](zotero://select/items/KEY)
```

### 内部链接
```markdown
- [[内部链接]]
```

### 示例
```markdown
- [Federated Learning for Edge Computing](zotero://select/items/ABC123)
  - 相关文献：[[Differential Privacy in Federated Learning]]
```

## 高级格式

### 带元数据的文献条目
```markdown
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
  - 摘要：全面综述了联邦学习在边缘计算中的应用
  - 标签：#survey #federated-learning #edge-computing
  - 作者：Li, Xiaoxiao and others
  - DOI：10.1109/JIOT.2023.1234567
  - 笔注：这篇综述覆盖了2020-2023年的主要工作
```

### 带时间线的文献组织
```markdown
- 文献调研：边缘计算与联邦学习
  - 2024年
    - Wang et al. (2024). Communication-Efficient Federated Learning. ICML. [Zotero链接](zotero://select/items/JKL012)
  - 2023年
    - Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
    - Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS. [Zotero链接](zotero://select/items/GHI789)
  - 2022年
    - Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE. [Zotero链接](zotero://select/items/DEF456)
```

### 带笔记的文献条目
```markdown
- **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
  - 摘要：全面综述了联邦学习在边缘计算中的应用
  - 标签：#survey #federated-learning #edge-computing
  - 笔记：
    - 这篇综述覆盖了2020-2023年的主要工作
    - 识别了通信效率、隐私保护、模型压缩等关键挑战
    - 提出了未来研究方向和建议
  - 标注：
    - 第4页：联邦学习定义（红色高亮）
    - 第8页：通信优化方法（蓝色高亮）
    - 第12页：隐私保护技术（绿色高亮）
```
