# 故障排除指南

## 概述

本指南帮助您解决使用 Zotero Research Skill 时可能遇到的常见问题。

## 安装问题

### 问题：pyzotero 未找到

**症状**：
```bash
$ pyzotero --version
bash: pyzotero: command not found
```

**可能原因**：
1. pyzotero 未安装
2. Python Scripts 目录不在 PATH 中

**解决方案**：
1. 安装 pyzotero：
   ```bash
   pip install pyzotero
   # 或使用国内镜像
   pip install pyzotero -i https://pypi.tuna.tsinghua.edu.cn/simple
   ```

2. 如果已安装但不在 PATH 中：
   ```bash
   # 查找安装位置
   pip show pyzotero

   # 添加到 PATH（Linux/macOS）
   export PATH=$PATH:~/.local/bin

   # 或使用 python -m 方式运行
   python -m pyzotero.tools
   ```

### 问题：安装脚本执行失败

**症状**：
```bash
$ ./scripts/install.sh
Permission denied
```

**解决方案**：
```bash
# 添加执行权限
chmod +x scripts/install.sh

# 重新运行
./scripts/install.sh
```

## 连接问题

### 问题：无法连接到 Zotero

**症状**：
```bash
$ pyzotero test
Error: Connection refused
```

**可能原因**：
1. Zotero Desktop 未运行
2. 端口 23119 被占用
3. 防火墙阻止

**解决方案**：
1. 启动 Zotero Desktop

2. 检查端口是否开放：
   ```bash
   # Windows
   netstat -an | findstr 23119

   # Linux/macOS
   netstat -an | grep 23119
   ```

3. 测试 API 连接：
   ```bash
   curl -s "http://localhost:23119/api/users/0/items?limit=1"
   ```

4. 检查防火墙设置

### 问题：Web API 连接失败

**症状**：
```bash
$ pyzotero test
Error: Invalid API key
```

**可能原因**：
1. API 密钥无效
2. Library ID 错误
3. 网络连接问题

**解决方案**：
1. 检查环境变量：
   ```bash
   echo $ZOTERO_API_KEY
   echo $ZOTERO_LIBRARY_ID
   ```

2. 重新生成 API 密钥：
   - 访问 https://www.zotero.org/settings/keys
   - 删除旧密钥
   - 创建新密钥

3. 检查网络连接：
   ```bash
   ping api.zotero.org
   ```

## 检索问题

### 问题：检索无结果

**症状**：
```bash
$ pyzotero search -q "test" --json
[]
```

**可能原因**：
1. 搜索词不准确
2. 文献库为空
3. 标签过滤过于严格

**解决方案**：
1. 尝试更广泛的搜索词
2. 检查文献库是否有内容：
   ```bash
   pyzotero search -q "" --limit 10
   ```

3. 减少过滤条件
4. 使用全文搜索：
   ```bash
   pyzotero search -q "keyword" --fulltext
   ```

### 问题：检索结果不准确

**症状**：检索结果与预期不符

**解决方案**：
1. 使用更具体的搜索词
2. 使用标签过滤：
   ```bash
   pyzotero search -q "keyword" --tag "specific-tag" --json
   ```

3. 使用项目类型过滤：
   ```bash
   pyzotero search -q "keyword" --itemtype journalArticle --json
   ```

4. 使用全文搜索：
   ```bash
   pyzotero search -q "keyword" --fulltext --json
   ```

## 项目详情问题

### 问题：获取详情失败

**症状**：
```bash
$ pyzotero item KEY
Error: Item not found
```

**可能原因**：
1. Key 不存在
2. Key 格式错误

**解决方案**：
1. 检查 Key 是否正确
2. 先搜索确认 Key 存在：
   ```bash
   pyzotero search -q "论文标题" --json
   ```

### 问题：全文获取失败

**症状**：
```bash
$ pyzotero fulltext KEY
Error: No fulltext available
```

**可能原因**：
1. 没有 PDF 附件
2. PDF 尚未被索引

**解决方案**：
1. 先获取子项目确认有 PDF 附件：
   ```bash
   pyzotero children KEY --json
   ```

2. 在 Zotero Desktop 中手动索引 PDF

## 编码问题

### 问题：中文显示乱码

**症状**：搜索中文关键词时结果异常

**解决方案**：
1. 设置环境变量：
   ```bash
   export PYTHONIOENCODING=utf-8
   ```

2. 使用 JSON 格式输出：
   ```bash
   pyzotero search -q "中文关键词" --json
   ```

## 性能问题

### 问题：检索速度慢

**症状**：检索操作耗时过长

**可能原因**：
1. 文献库过大
2. 使用了全文搜索

**解决方案**：
1. 使用限制参数减少结果：
   ```bash
   pyzotero search -q "keyword" --limit 10 --json
   ```

2. 使用标签过滤：
   ```bash
   pyzotero search -q "keyword" --tag "tag" --json
   ```

3. 避免使用全文搜索（除非必要）

## 获取更多帮助

### 查看帮助

```bash
# 查看 pyzotero 帮助
pyzotero --help

# 查看子命令帮助
pyzotero search --help
pyzotero item --help
```

### 测试连接

```bash
pyzotero test
```

### 检查 API 状态

```bash
curl -s "http://localhost:23119/api/users/0/items?limit=1"
```

### 提交问题

如果以上方法都无法解决问题：

1. 收集错误信息
2. 记录重现步骤
3. 提交 GitHub Issues：
   - 项目地址
   - 错误信息
   - 重现步骤
   - 环境信息（操作系统、Python 版本、pyzotero 版本）

### 社区支持

- GitHub Issues：提交问题
- GitHub Discussions：社区讨论
- 文档：查看详细文档

## 相关资源

- **pyzotero 文档**：https://pyzotero.readthedocs.io/
- **Zotero API 文档**：https://www.zotero.org/support/dev/web_api/v3/start
- **命令参考**：[../reference.md](../reference.md)
