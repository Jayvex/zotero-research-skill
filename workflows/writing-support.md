# 论文写作支持工作流

## 使用场景
当用户撰写论文需要文献支持时使用此工作流。

## 工作流程

### 步骤1：引用收集
**目标**：根据写作主题检索相关文献，按论文章节组织引用

**操作**：
1. **根据主题检索文献**
   ```bash
   pyzotero search -q "联邦学习 隐私保护" --json
   ```

2. **按章节组织引用**
   - Introduction：背景和动机
   - Related Work：相关工作
   - Methodology：方法论
   - Experiments：实验
   - Conclusion：结论

3. **获取文献详情用于生成引用**
   ```bash
   pyzotero subset KEY1 KEY2 KEY3 --json
   ```
   > 注意：pyzotero 不直接支持 BibTeX 导出。可获取 JSON 元数据后，由 AI 转换为 BibTeX 格式。

### 步骤2：引用格式化
**目标**：选择引用格式，生成文中引用和参考文献列表

**操作**：
1. **选择引用格式**
   - APA格式
   - IEEE格式
   - ACM格式
   - Chicago格式

2. **生成文中引用**
   ```markdown
   [1] Li et al. (2023) 提出了...
   根据文献[2]，...
   ```

3. **生成参考文献列表**
   ```markdown
   ## References
   [1] Li, X., et al. (2023). Federated Learning for Edge Computing. IEEE IoT Journal.
   [2] Chen, Y., et al. (2023). Differential Privacy in Federated Learning. NeurIPS.
   ```

### 步骤3：文献综述支持
**目标**：按主题分类文献，生成文献综述框架

**操作**：
1. **按主题分类文献**
   - 隐私保护技术
   - 通信优化方法
   - 模型压缩技术
   - 应用场景

2. **生成文献综述框架**
   ```markdown
   ## Related Work

   ### 隐私保护技术
   [文献列表]

   ### 通信优化方法
   [文献列表]

   ### 模型压缩技术
   [文献列表]
   ```

3. **提供文献对比分析**
   - 方法对比
   - 性能对比
   - 优缺点分析

### 步骤4：图表引用
**目标**：提取论文图表，生成图表引用

**操作**：
1. **获取论文附件信息**
   ```bash
   pyzotero children KEY --json
   ```
   > 注意：pyzotero 不支持直接提取图表。可通过 `pyzotero children` 获取附件列表，在 Zotero Desktop 中手动导出图表。

2. **生成图表引用**
   ```markdown
   ![系统架构图](./figures/architecture.png)
   - 来源：Li et al. (2023), Figure 3
   - 说明：展示了联邦学习在边缘计算中的系统架构
   ```

3. **提供图表说明**
   - 图表来源
   - 图表内容说明
   - 在论文中的引用位置

### 步骤5：输出格式化
**目标**：生成最终的引用列表和文献综述

**输出格式**：
```markdown
# 参考文献列表

## 正文中引用
[1] Li et al. (2023). Federated Learning for Edge Computing. IEEE IoT Journal.
[2] Zhang et al. (2022). Edge Intelligence. Proceedings of the IEEE.
[3] Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.

## 按主题分类

### 联邦学习
- Li et al. (2023). Federated Learning for Edge Computing. IEEE IoT Journal.
- Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.

### 边缘计算
- Zhang et al. (2022). Edge Intelligence. Proceedings of the IEEE.
- Wang et al. (2024). Communication-Efficient Federated Learning. ICML.

## BibTeX格式
```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao and others},
  journal={IEEE Internet of Things Journal},
  year={2023}
}

@inproceedings{chen2023differential,
  title={Differential Privacy in Federated Learning},
  author={Chen, Yu and others},
  booktitle={NeurIPS},
  year={2023}
}
```
```

## 示例交互

**用户请求**：
```
帮我整理"联邦学习隐私保护"的引用，准备写Related Work章节
```

**Skill响应**：
1. 检索相关文献
2. 按隐私保护技术分类
3. 生成IEEE格式引用
4. 输出参考文献列表
5. 提供文献综述框架

## 输出示例

```markdown
# 参考文献列表：联邦学习隐私保护

## 正文中引用
[1] Li et al. (2023). Federated Learning for Edge Computing. IEEE IoT Journal.
[2] Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.
[3] Wang et al. (2024). Communication-Efficient Federated Learning. ICML.

## 按主题分类

### 差分隐私
- Chen et al. (2023). Differential Privacy in Federated Learning. NeurIPS.
- [相关文献]

### 安全聚合
- [相关文献]

### 同态加密
- [相关文献]

## BibTeX格式
```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao and others},
  journal={IEEE Internet of Things Journal},
  year={2023}
}

@inproceedings{chen2023differential,
  title={Differential Privacy in Federated Learning},
  author={Chen, Yu and others},
  booktitle={NeurIPS},
  year={2023}
}
```

## 文献综述框架

```markdown
## Related Work

### 差分隐私
Chen et al. [2] 提出了联邦学习中的差分隐私保护方法...

### 安全聚合
[相关文献描述]

### 同态加密
[相关文献描述]
```

## 相关命令参考
- [pyzotero search](../reference.md#pyzotero-search)
- [pyzotero subset](../reference.md#pyzotero-subset)
- [pyzotero children](../reference.md#pyzotero-children)
