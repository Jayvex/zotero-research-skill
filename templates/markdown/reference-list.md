# 引用列表模板

## 基础格式

```markdown
# 参考文献列表

## 正文中引用
[1] 作者 (年份). 标题. 期刊/会议.
[2] 作者 (年份). 标题. 期刊/会议.

## 按主题分类

### [主题1]
- 作者 (年份). 标题. 期刊/会议.
- 作者 (年份). 标题. 期刊/会议.

### [主题2]
- 作者 (年份). 标题. 期刊/会议.
- 作者 (年份). 标题. 期刊/会议.

## BibTeX格式
```bibtex
@article{key1,
  title={标题},
  author={作者},
  journal={期刊},
  year={年份}
}
```

## APA格式
作者 (年份). 标题. 期刊.
```

## 使用示例

```markdown
# 参考文献列表

## 正文中引用
[1] Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal.
[2] Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE.
[3] Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.

## 按主题分类

### 联邦学习
- Li et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE IoT Journal.
- Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.

### 边缘计算
- Zhang et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE.
- Wang et al. (2024). Communication-Efficient Federated Learning. ICML.

## BibTeX格式
```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao and others},
  journal={IEEE Internet of Things Journal},
  year={2023}
}

@article{zhang2022edge,
  title={Edge Intelligence: On-Demand Deep Learning Model},
  author={Zhang, Jie and others},
  journal={Proceedings of the IEEE},
  year={2022}
}

@inproceedings{chen2023differential,
  title={Differential Privacy in Federated Learning},
  author={Chen, Yu and others},
  booktitle={NeurIPS},
  year={2023}
}

@inproceedings{wang2024communication,
  title={Communication-Efficient Federated Learning},
  author={Wang, Wei and others},
  booktitle={ICML},
  year={2024}
}
```

## APA格式
Li, X., et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE Internet of Things Journal.

Zhang, J., et al. (2022). Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE.

Chen, Y., et al. (2023). Differential Privacy in Federated Learning. NeurIPS.

Wang, W., et al. (2024). Communication-Efficient Federated Learning. ICML.
```

## IEEE格式

```markdown
## IEEE格式

[1] X. Li et al., "Federated Learning for Edge Computing: A Survey," IEEE Internet of Things Journal, 2023.

[2] J. Zhang et al., "Edge Intelligence: On-Demand Deep Learning Model," Proceedings of the IEEE, 2022.

[3] Y. Chen et al., "Differential Privacy in Federated Learning," in Proc. NeurIPS, 2023.

[4] W. Wang et al., "Communication-Efficient Federated Learning," in Proc. ICML, 2024.
```

## ACM格式

```markdown
## ACM格式

[1] Xiaoxiao Li et al. 2023. Federated Learning for Edge Computing: A Survey. IEEE Internet of Things Journal.

[2] Jie Zhang et al. 2022. Edge Intelligence: On-Demand Deep Learning Model. Proceedings of the IEEE.

[3] Yu Chen et al. 2023. Differential Privacy in Federated Learning. In Proc. NeurIPS.

[4] Wei Wang et al. 2024. Communication-Efficient Federated Learning. In Proc. ICML.
```

## Chicago格式

```markdown
## Chicago格式

Li, Xiaoxiao, et al. "Federated Learning for Edge Computing: A Survey." IEEE Internet of Things Journal (2023).

Zhang, Jie, et al. "Edge Intelligence: On-Demand Deep Learning Model." Proceedings of the IEEE (2022).

Chen, Yu, et al. "Differential Privacy in Federated Learning." In Proc. NeurIPS, 2023.

Wang, Wei, et al. "Communication-Efficient Federated Learning." In Proc. ICML, 2024.
```
