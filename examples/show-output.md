# 论文详情示例

## 基础详情示例

### 命令
```bash
pyzotero item ABC123 --json
```

### 输出
```json
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
      {"creatorType": "author", "firstName": "Wei", "lastName": "Wang"},
      {"creatorType": "author", "firstName": "Jie", "lastName": "Zhang"}
    ],
    "date": "2023",
    "DOI": "10.1109/JIOT.2023.1234567",
    "abstractNote": "This paper provides a comprehensive survey of federated learning in edge computing. We review the state-of-the-art techniques and identify key challenges...",
    "tags": [{"tag": "survey"}, {"tag": "federated-learning"}, {"tag": "edge-computing"}],
    "volume": "10",
    "issue": "12",
    "pages": "12345-12367"
  }
}
```

### Markdown格式化输出
```markdown
# 论文详情：Federated Learning for Edge Computing: A Survey

## 基本信息
- **作者**：Li, Xiaoxiao, Wang, Wei, Zhang, Jie
- **年份**：2023
- **期刊**：IEEE Internet of Things Journal
- **卷**：10
- **期**：12
- **页码**：12345-12367
- **DOI**：10.1109/JIOT.2023.1234567
- **Key**：ABC123
- **Zotero链接**：[Zotero链接](zotero://select/items/ABC123)

## 摘要
This paper provides a comprehensive survey of federated learning in edge computing. We review the state-of-the-art techniques and identify key challenges...

## 标签
#survey #federated-learning #edge-computing
```

## 获取子项目（附件、笔记）

### 命令
```bash
pyzotero children ABC123 --json
```

### 输出
```json
[
  {
    "key": "ATT456",
    "data": {
      "key": "ATT456",
      "itemType": "attachment",
      "title": "Li2023_Federated_Learning_Edge_Computing.pdf",
      "contentType": "application/pdf",
      "filename": "Li2023_Federated_Learning_Edge_Computing.pdf"
    }
  }
]
```

## 获取全文内容

### 命令
```bash
pyzotero fulltext ATT456
```

### 输出
```json
{
  "key": "ATT456",
  "content": "Federated learning enables multiple devices to collaboratively train a model while keeping their data local..."
}
```

## 批量获取详情

### 命令
```bash
pyzotero subset ABC123 DEF456 --json
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
      "title": "Edge Intelligence: On-Demand Deep Learning Model",
      "creators": [
        {"creatorType": "author", "firstName": "Jie", "lastName": "Zhang"}
      ],
      "date": "2022"
    }
  }
]
```
