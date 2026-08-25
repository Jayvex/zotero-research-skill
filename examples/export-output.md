# 导出示例

> 注意：pyzotero 不直接支持 BibTeX/RIS/CSL-JSON 导出。以下示例展示如何通过 `pyzotero item --json` 获取元数据，然后由 AI 转换为各种引用格式。

## 获取元数据

### 命令
```bash
pyzotero item ABC123 --json
```

### 输出
```json
{
  "key": "ABC123",
  "version": 1,
  "data": {
    "key": "ABC123",
    "itemType": "journalArticle",
    "title": "Federated Learning for Edge Computing: A Survey",
    "creators": [
      {"creatorType": "author", "firstName": "Xiaoxiao", "lastName": "Li"},
      {"creatorType": "author", "firstName": "Wei", "lastName": "Wang"},
      {"creatorType": "author", "firstName": "Jie", "lastName": "Zhang"}
    ],
    "date": "2023",
    "DOI": "10.1109/JIOT.2023.1234567",
    "abstractNote": "This paper provides a comprehensive survey...",
    "tags": [{"tag": "survey"}, {"tag": "federated-learning"}]
  }
}
```

## 转换为 BibTeX 格式

基于上述元数据，AI 可生成 BibTeX：

```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao and Wang, Wei and Zhang, Jie},
  journal={IEEE Internet of Things Journal},
  year={2023},
  doi={10.1109/JIOT.2023.1234567}
}
```

## 转换为 APA 格式

```
Li, X., Wang, W., & Zhang, J. (2023). Federated Learning for Edge Computing: A Survey. IEEE Internet of Things Journal.
```

## 转换为 IEEE 格式

```
[1] X. Li, W. Wang, and J. Zhang, "Federated Learning for Edge Computing: A Survey," IEEE Internet of Things Journal, 2023.
```

## 批量获取元数据

### 命令
```bash
pyzotero subset ABC123 DEF456 GHI789 --json
```

### 输出
```json
[
  {
    "key": "ABC123",
    "data": {
      "key": "ABC123",
      "itemType": "journalArticle",
      "title": "Federated Learning for Edge Computing: A Survey",
      "creators": [
        {"creatorType": "author", "firstName": "Xiaoxiao", "lastName": "Li"}
      ],
      "date": "2023"
    }
  },
  {
    "key": "DEF456",
    "data": {
      "key": "DEF456",
      "itemType": "journalArticle",
      "title": "Differential Privacy in Federated Learning",
      "creators": [
        {"creatorType": "author", "firstName": "Yu", "lastName": "Chen"}
      ],
      "date": "2023"
    }
  }
]
```

### 批量 BibTeX 输出

```bibtex
@article{li2023federated,
  title={Federated Learning for Edge Computing: A Survey},
  author={Li, Xiaoxiao},
  journal={IEEE Internet of Things Journal},
  year={2023}
}

@article{chen2023differential,
  title={Differential Privacy in Federated Learning},
  author={Chen, Yu},
  journal={NeurIPS},
  year={2023}
}
```

## 在 Claude Code 中使用

在 Claude Code 中，你可以直接请求引用格式转换：

```
帮我获取 ABC123 这篇论文的 BibTeX 格式引用
```

Claude 会：
1. 执行 `pyzotero item ABC123 --json`
2. 解析 JSON 元数据
3. 生成 BibTeX 格式输出
