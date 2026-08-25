# 模板测试

## 测试目的
验证输出模板的完整性和正确性。

## 测试用例

### 测试 1：模板目录存在
**目标**：验证 templates 目录存在

**步骤**：
1. 检查目录是否存在

**预期结果**：
- 目录存在

**验证命令**：
```bash
test -d templates
```

### 测试 2：Markdown 模板目录存在
**目标**：验证 templates/markdown 目录存在

**步骤**：
1. 检查目录是否存在

**预期结果**：
- 目录存在

**验证命令**：
```bash
test -d templates/markdown
```

### 测试 3：Logseq 模板目录存在
**目标**：验证 templates/logseq 目录存在

**步骤**：
1. 检查目录是否存在

**预期结果**：
- 目录存在

**验证命令**：
```bash
test -d templates/logseq
```

### 测试 4：Markdown 模板文件存在
**目标**：验证所有 Markdown 模板文件存在

**步骤**：
1. 检查 templates/markdown/literature-list.md 是否存在
2. 检查 templates/markdown/paper-note.md 是否存在
3. 检查 templates/markdown/reference-list.md 是否存在

**预期结果**：
- 所有文件都存在

**验证命令**：
```bash
test -f templates/markdown/literature-list.md
test -f templates/markdown/paper-note.md
test -f templates/markdown/reference-list.md
```

### 测试 5：Logseq 模板文件存在
**目标**：验证所有 Logseq 模板文件存在

**步骤**：
1. 检查 templates/logseq/outline.md 是否存在
2. 检查 templates/logseq/bibliography.md 是否存在

**预期结果**：
- 所有文件都存在

**验证命令**：
```bash
test -f templates/logseq/outline.md
test -f templates/logseq/bibliography.md
```

### 测试 6：模板文件不为空
**目标**：验证所有模板文件不为空

**步骤**：
1. 检查每个文件是否大于 0 字节

**预期结果**：
- 所有文件都不为空

**验证命令**：
```bash
test -s templates/markdown/literature-list.md
test -s templates/markdown/paper-note.md
test -s templates/markdown/reference-list.md
test -s templates/logseq/outline.md
test -s templates/logseq/bibliography.md
```

### 测试 7：Markdown 模板包含必要元素
**目标**：验证 Markdown 模板包含必要元素

**步骤**：
1. 检查 literature-list.md 是否包含 "作者" 和 "年份"
2. 检查 paper-note.md 是否包含 "基本信息" 和 "核心内容"
3. 检查 reference-list.md 是否包含 "BibTeX" 和 "APA"

**预期结果**：
- 所有模板都包含相关元素

**验证命令**：
```bash
# literature-list.md
grep -q "作者" templates/markdown/literature-list.md
grep -q "年份" templates/markdown/literature-list.md

# paper-note.md
grep -q "基本信息" templates/markdown/paper-note.md
grep -q "核心内容" templates/markdown/paper-note.md

# reference-list.md
grep -q "BibTeX" templates/markdown/reference-list.md
grep -q "APA" templates/markdown/reference-list.md
```

### 测试 8：Logseq 模板包含必要元素
**目标**：验证 Logseq 模板包含必要元素

**步骤**：
1. 检查 outline.md 是否包含 "一级主题" 和 "二级主题"
2. 检查 bibliography.md 是否包含 "参考文献" 和 "BibTeX"

**预期结果**：
- 所有模板都包含相关元素

**验证命令**：
```bash
# outline.md
grep -q "一级主题" templates/logseq/outline.md
grep -q "二级主题" templates/logseq/outline.md

# bibliography.md
grep -q "参考文献" templates/logseq/bibliography.md
grep -q "BibTeX" templates/logseq/bibliography.md
```

## 测试执行

### 手动测试
```bash
cd zotero-research-skill

# 测试 1
test -d templates && echo "PASS" || echo "FAIL"

# 测试 2
test -d templates/markdown && echo "PASS" || echo "FAIL"

# 测试 3
test -d templates/logseq && echo "PASS" || echo "FAIL"

# 测试 4
test -f templates/markdown/literature-list.md && \
test -f templates/markdown/paper-note.md && \
test -f templates/markdown/reference-list.md && \
echo "PASS" || echo "FAIL"

# 测试 5
test -f templates/logseq/outline.md && \
test -f templates/logseq/bibliography.md && \
echo "PASS" || echo "FAIL"

# 测试 6
test -s templates/markdown/literature-list.md && \
test -s templates/markdown/paper-note.md && \
test -s templates/markdown/reference-list.md && \
test -s templates/logseq/outline.md && \
test -s templates/logseq/bibliography.md && \
echo "PASS" || echo "FAIL"

# 测试 7
grep -q "作者" templates/markdown/literature-list.md && \
grep -q "年份" templates/markdown/literature-list.md && \
grep -q "基本信息" templates/markdown/paper-note.md && \
grep -q "核心内容" templates/markdown/paper-note.md && \
grep -q "BibTeX" templates/markdown/reference-list.md && \
grep -q "APA" templates/markdown/reference-list.md && \
echo "PASS" || echo "FAIL"

# 测试 8
grep -q "一级主题" templates/logseq/outline.md && \
grep -q "二级主题" templates/logseq/outline.md && \
grep -q "参考文献" templates/logseq/bibliography.md && \
grep -q "BibTeX" templates/logseq/bibliography.md && \
echo "PASS" || echo "FAIL"
```

### 自动化测试脚本
```bash
#!/bin/bash

# 测试模板完整性
test_templates() {
    local templates_dir="templates"
    local passed=0
    local failed=0
    
    # 测试 1：目录存在
    if [ -d "$templates_dir" ]; then
        echo "PASS: templates 目录存在"
        passed=$((passed + 1))
    else
        echo "FAIL: templates 目录不存在"
        failed=$((failed + 1))
    fi
    
    # 测试 2：Markdown 目录存在
    if [ -d "$templates_dir/markdown" ]; then
        echo "PASS: templates/markdown 目录存在"
        passed=$((passed + 1))
    else
        echo "FAIL: templates/markdown 目录不存在"
        failed=$((failed + 1))
    fi
    
    # 测试 3：Logseq 目录存在
    if [ -d "$templates_dir/logseq" ]; then
        echo "PASS: templates/logseq 目录存在"
        passed=$((passed + 1))
    else
        echo "FAIL: templates/logseq 目录不存在"
        failed=$((failed + 1))
    fi
    
    # 测试 4：Markdown 模板文件存在
    local md_files=("literature-list.md" "paper-note.md" "reference-list.md")
    for file in "${md_files[@]}"; do
        if [ -f "$templates_dir/markdown/$file" ]; then
            echo "PASS: $file 存在"
            passed=$((passed + 1))
        else
            echo "FAIL: $file 不存在"
            failed=$((failed + 1))
        fi
    done
    
    # 测试 5：Logseq 模板文件存在
    local logseq_files=("outline.md" "bibliography.md")
    for file in "${logseq_files[@]}"; do
        if [ -f "$templates_dir/logseq/$file" ]; then
            echo "PASS: $file 存在"
            passed=$((passed + 1))
        else
            echo "FAIL: $file 不存在"
            failed=$((failed + 1))
        fi
    done
    
    # 测试 6：文件不为空
    local all_files=("${md_files[@]}" "${logseq_files[@]}")
    for file in "${all_files[@]}"; do
        if [ -s "$templates_dir/$file" ]; then
            echo "PASS: $file 不为空"
            passed=$((passed + 1))
        else
            echo "FAIL: $file 为空"
            failed=$((failed + 1))
        fi
    done
    
    # 输出结果
    echo ""
    echo "测试结果："
    echo "  通过：$passed"
    echo "  失败：$failed"
    echo "  总计：$((passed + failed))"
    
    if [ $failed -eq 0 ]; then
        echo "所有测试通过！"
        return 0
    else
        echo "有测试失败！"
        return 1
    fi
}

# 运行测试
test_templates
```
