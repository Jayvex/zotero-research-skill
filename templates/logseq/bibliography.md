# Logseq 参考文献模板

## 基础格式

```markdown
- 参考文献
  - 正文中引用
    - [1] 作者 (年份). 标题. 期刊/会议.
    - [2] 作者 (年份). 标题. 期刊/会议.
  - 按主题分类
    - 主题1
      - 文献1
      - 文献2
    - 主题2
      - 文献3
```

## 使用示例

```markdown
- 参考文献
  - 正文中引用
    - [1] Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
    - [2] Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE. [Zotero链接](zotero://select/items/DEF456)
    - [3] Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS. [Zotero链接](zotero://select/items/GHI789)

  - 按主题分类
    - 联邦学习
      - Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
      - Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS. [Zotero链接](zotero://select/items/GHI789)

    - 边缘计算
      - Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE. [Zotero链接](zotero://select/items/DEF456)
      - Wang et al. (2024). Communication-Efficient Federated Learning. ICML. [Zotero链接](zotero://select/items/JKL012)
```

## BibTeX格式

```markdown
- BibTeX引用
  - ```bibtex
    @article{li2023federated,
      title={Federated Learning for Edge Computing: A Survey},
      author={Li, Xiaoxiao and others},
      journal={IEEE Internet of Things Journal},
      year={2023}
    }
    ```

  - ```bibtex
    @article{zhang2022edge,
      title={Edge Intelligence: On-Demand Deep Learning Model},
      author={Zhang, Jie and others},
      journal={Proceedings of the IEEE},
      year={2022}
    }
    ```

  - ```bibtex
    @inproceedings{chen2023differential,
      title={Differential Privacy in Federated Learning},
      author={Chen, Yu and others},
      booktitle={NeurIPS},
      year={2023}
    }
    ```
```

## APA格式

```markdown
- APA格式引用
  - Li, X., et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE Internet of Things Journal.
  - Zhang, J., et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE.
  - Chen, Y., et al. (2023). Differential Privacy in Federated Learning. NeurIPS.
```

## IEEE格式

```markdown
- IEEE格式引用
  - [1] X. Li et al., "Federated Learning for Edge Computing: A Survey," IEEE Internet of Things Journal, 2023.
  - [2] J. Zhang et al., "Edge Intelligence: On-Demand Deep Learning Model," Proceedings of the IEEE, 2022.
  - [3] Y. Chen et al., "Differential Privacy in Federated Learning," in Proc. NeurIPS, 2023.
```

## 带注释的参考文献

```markdown
- 参考文献（带注释）
  - 核心文献
    - **Li et al.** (2023). *Federated Learning for Edge Computing: A Survey*. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
      - 重要性：★★★★★
      - 注释：本领域最全面的综述，必读
      - 引用位置：第1章、第2章、第3章

    - **Chen et al.** (2023). *Differential Privacy in Federated Learning*. NeurIPS. [Zotero链接](zotero://select/items/GHI789)
      - 重要性：★★★★☆
      - 注释：隐私保护的重要工作，方法创新
      - 引用位置：第2章

  - 相关文献
    - **Zhang et al.** (2022). *Edge Intelligence: On-Demand Deep Learning Model*. Proceedings of the IEEE. [Zotero链接](zotero://select/items/DEF456)
      - 重要性：★★★☆☆
      - 注释：边缘计算的相关工作
      - 引用位置：第2章
```

## 按时间线组织

```markdown
- 参考文献（按时间线）
  - 2024年
    - Wang et al. (2024). Communication-Efficient Federated Learning. ICML. [Zotero链接](zotero://select/items/JKL012)
      - 最新进展，通信优化

  - 2023年
    - Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal. [Zotero链接](zotero://select/items/ABC123)
      - 综述，全面覆盖
    - Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS. [Zotero链接](zotero://select/items/GHI789)
      - 隐私保护

  - 2022年
    - Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE. [Zotero链接](zotero://select/items/DEF456)
      - 边缘计算
```
