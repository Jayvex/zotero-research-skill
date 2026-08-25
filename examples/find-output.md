# 检索输出示例

## 基础检索示例

### 命令
```bash
pyzotero search -q "machine learning" --limit 10 --json
```

### 输出
```json
[
  {
    "key": "ABC123",
    "version": 1,
    "library": {
      "type": "user",
      "id": 0,
      "name": "我的文库"
    },
    "data": {
      "key": "ABC123",
      "itemType": "journalArticle",
      "title": "Federated Learning for Edge Computing: A Survey",
      "creators": [
        {"creatorType": "author", "firstName": "Xiaoxiao", "lastName": "Li"},
        {"creatorType": "author", "firstName": "Wei", "lastName": "Wang"}
      ],
      "date": "2023",
      "abstractNote": "This paper provides a comprehensive survey...",
      "tags": [{"tag": "survey"}, {"tag": "federated-learning"}],
      "DOI": "10.1109/JIOT.2023.1234567"
    }
  }
]
```

### Markdown格式化输出
```markdown
# 检索结果：machine learning

**检索时间**：2026-06-09
**结果数量**：10篇

## 结果列表

### 1. Federated Learning for Edge Computing: A Survey
- **作者**：Li, Xiaoxiao, Wang, Wei
- **年份**：2023
- **期刊**：IEEE Internet of Things Journal
- **摘要**：This paper provides a comprehensive survey...
- **标签**：#survey #federated-learning
- **DOI**：10.1109/JIOT.2023.1234567
- **Key**：ABC123
```

## 高级检索示例

### 命令
```bash
pyzotero search -q "IoT" --tag "survey" --limit 10 --json
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
      "date": "2023",
      "tags": [{"tag": "survey"}, {"tag": "federated-learning"}]
    }
  }
]
```

## 全文检索示例

### 命令
```bash
pyzotero search -q "transformer attention" --fulltext --limit 10 --json
```

### 输出
```json
[
  {
    "key": "GHI789",
    "data": {
      "key": "GHI789",
      "itemType": "conferencePaper",
      "title": "Attention Is All You Need",
      "creators": [
        {"creatorType": "author", "firstName": "Ashish", "lastName": "Vaswani"}
      ],
      "date": "2017",
      "tags": [{"tag": "attention"}, {"tag": "transformer"}]
    }
  }
]
```

## 空结果示例

### 命令
```bash
pyzotero search -q "nonexistent topic" --json
```

### 输出
```json
[]
```

### Markdown格式化输出
```markdown
# 检索结果：nonexistent topic

**检索时间**：2026-06-09
**结果数量**：0篇

## 未找到相关文献

未找到与"nonexistent topic"相关的文献。

### 建议
1. 检查关键词拼写
2. 尝试使用同义词
3. 使用更广泛的关键词
4. 尝试全文搜索（`--fulltext`）
```
