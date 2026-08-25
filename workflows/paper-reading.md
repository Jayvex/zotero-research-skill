# 论文精读工作流

## 使用场景
当用户需要深入阅读和分析一篇论文时使用此工作流。

## 工作流程

### 步骤1：论文获取
**目标**：通过关键词或DOI找到论文，获取元数据和PDF附件

**操作**：
1. **通过关键词查找**
   ```bash
   pyzotero search -q "论文标题" --json
   ```

2. **通过DOI查找**
   ```bash
   pyzotero search -q "10.1109/TII.2023.1234567" --json
   ```

3. **获取论文详情**
   ```bash
   pyzotero item KEY --json
   ```

### 步骤2：内容提取
**目标**：提取PDF全文、读取现有标注、提取图表

**操作**：
1. **获取附件信息**
   ```bash
   pyzotero children KEY --json
   ```

2. **提取PDF全文**
   ```bash
   pyzotero fulltext ATT_KEY
   ```
   > 注意：`ATT_KEY` 是通过 `pyzotero children` 获取的 PDF 附件 Key（非论文 Key）。

3. **图表提取**
   > pyzotero 不支持直接提取图表。需在 Zotero Desktop 中手动导出，或通过 Zotero Desktop 的 PDF 阅读器查看。

### 步骤3：深度分析
**目标**：生成结构化摘要，提取关键信息

**分析维度**：
1. **研究问题**
   - 论文要解决什么问题？
   - 为什么这个问题重要？

2. **方法论**
   - 作者提出了什么方法？
   - 方法的创新点是什么？

3. **主要贡献**
   - 论文的主要贡献是什么？
   - 与现有工作相比有什么优势？

4. **实验结果**
   - 实验设置了哪些场景？
   - 结果如何验证方法的有效性？

5. **局限性与未来工作**
   - 论文有什么局限性？
   - 作者提出了哪些未来研究方向？

### 步骤4：标注管理
**目标**：添加高亮标注、笔记和评论

**操作**：
1. **添加高亮标注**
   > pyzotero 不支持添加标注。请在 Zotero Desktop 的 PDF 阅读器中手动添加标注。

2. **添加带评论的标注**
   > 同上，请在 Zotero Desktop 中操作。

3. **按主题分类标注**
   - 方法论标注（红色）
   - 实验结果标注（绿色）
   - 创新点标注（蓝色）
   - 局限性标注（黄色）

### 步骤5：知识整理
**目标**：生成论文笔记，提取关键引用，关联相关论文

**操作**：
1. **生成论文笔记**
   > pyzotero 不支持创建笔记。可将笔记内容输出为 Markdown 文件，或在 Zotero Desktop 中手动创建笔记。

2. **提取关键引用**
   - 从参考文献中识别重要引用
   - 搜索这些引用是否在库中

3. **关联相关论文**
   - 添加相关标签
   - 创建相关论文收藏夹

## 输出格式

### 论文笔记格式
```markdown
# 论文笔记：[标题]

## 基本信息
- **作者**：[作者列表]
- **年份**：[年份]
- **期刊/会议**：[期刊名]
- **DOI**：[DOI]
- **Zotero链接**：[链接]

## 核心内容

### 研究问题
[研究问题描述]

### 方法论
[方法描述]

### 主要贡献
1. [贡献1]
2. [贡献2]
3. [贡献3]

### 实验结果
[实验结果摘要]

## 个人笔记

### 关键发现
[个人笔记]

### 标注汇总
- 第X页：[标注内容]
- 第Y页：[标注内容]

### 相关文献
- [相关文献1]
- [相关文献2]

## 引用格式

### BibTeX
```bibtex
[ BibTeX代码 ]
```

### APA格式
[ APA格式引用 ]
```

## 示例交互

**用户请求**：
```
精读这篇论文 [提供关键词或DOI]
```

**Skill响应**：
1. 检索并定位论文
2. 提取PDF全文和标注
3. 生成结构化摘要
4. 提供标注建议
5. 输出完整的论文笔记

## 输出示例

```markdown
# 论文笔记：Federated Learning for Edge Computing: A Survey

## 基本信息
- **作者**：Li, Xiaoxiao and others
- **年份**：2023
- **期刊/会议**：IEEE Internet of Things Journal
- **DOI**：10.1109/JIOT.2023.1234567
- **Zotero链接**：[Zotero链接](zotero://select/items/ABC123)

## 核心内容

### 研究问题
联邦学习在边缘计算环境中的应用面临哪些挑战？如何解决这些问题？

### 方法论
本文通过系统性文献综述，分析了联邦学习在边缘计算中的应用现状，识别了关键挑战，并提出了未来研究方向。

### 主要贡献
1. 全面综述了联邦学习在边缘计算中的应用
2. 识别了通信效率、隐私保护、模型压缩等关键挑战
3. 提出了未来研究方向和建议

### 实验结果
本文为综述类论文，通过文献分析得出结论。

## 个人笔记

### 关键发现
- 联邦学习在边缘计算中具有巨大潜力
- 通信效率是主要瓶颈之一
- 隐私保护需要更多关注

### 标注汇总
- 第4页：联邦学习定义（红色高亮）
- 第8页：通信优化方法（蓝色高亮）
- 第12页：隐私保护技术（绿色高亮）

### 相关文献
- [1] Chen et al. (2023). Differential Privacy in Federated Learning
- [2] Wang et al. (2024). Communication-Efficient Federated Learning

## 引用格式

### BibTeX
```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao and others},
  journal={IEEE Internet of Things Journal},
  year={2023}
}
```

### APA格式
Li, X., et al. (2023). Federated Learning for Edge Computing: A Survey. IEEE Internet of Things Journal.
```

## 相关命令参考
- [pyzotero search](../reference.md#pyzotero-search)
- [pyzotero item](../reference.md#pyzotero-item)
- [pyzotero children](../reference.md#pyzotero-children)
- [pyzotero fulltext](../reference.md#pyzotero-fulltext)
- [pyzotero citations](../reference.md#pyzotero-citations)
- [pyzotero references](../reference.md#pyzotero-references)
- [pyzotero related](../reference.md#pyzotero-related)
