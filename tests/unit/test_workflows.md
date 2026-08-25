# 工作流测试

## 测试目的
验证工作流模板的完整性和正确性。

## 测试用例

### 测试 1：工作流目录存在
**目标**：验证 workflows 目录存在

**步骤**：
1. 检查目录是否存在

**预期结果**：
- 目录存在

**验证命令**：
```bash
test -d workflows
```

### 测试 2：所有工作流文件存在
**目标**：验证所有工作流文件存在

**步骤**：
1. 检查 workflows/literature-review.md 是否存在
2. 检查 workflows/paper-reading.md 是否存在
3. 检查 workflows/writing-support.md 是否存在
4. 检查 workflows/batch-management.md 是否存在

**预期结果**：
- 所有文件都存在

**验证命令**：
```bash
test -f workflows/literature-review.md
test -f workflows/paper-reading.md
test -f workflows/writing-support.md
test -f workflows/batch-management.md
```

### 测试 3：工作流文件不为空
**目标**：验证所有工作流文件不为空

**步骤**：
1. 检查每个文件是否大于 0 字节

**预期结果**：
- 所有文件都不为空

**验证命令**：
```bash
test -s workflows/literature-review.md
test -s workflows/paper-reading.md
test -s workflows/writing-support.md
test -s workflows/batch-management.md
```

### 测试 4：工作流包含必要章节
**目标**：验证每个工作流包含必要章节

**步骤**：
1. 检查是否包含 "## 使用场景"
2. 检查是否包含 "## 工作流程"
3. 检查是否包含 "## 输出格式"
4. 检查是否包含 "## 示例交互"

**预期结果**：
- 所有工作流都包含这些章节

**验证命令**：
```bash
# literature-review.md
grep -q "## 使用场景" workflows/literature-review.md
grep -q "## 工作流程" workflows/literature-review.md
grep -q "## 输出格式" workflows/literature-review.md
grep -q "## 示例交互" workflows/literature-review.md

# paper-reading.md
grep -q "## 使用场景" workflows/paper-reading.md
grep -q "## 工作流程" workflows/paper-reading.md
grep -q "## 输出格式" workflows/paper-reading.md
grep -q "## 示例交互" workflows/paper-reading.md

# writing-support.md
grep -q "## 使用场景" workflows/writing-support.md
grep -q "## 工作流程" workflows/writing-support.md
grep -q "## 输出格式" workflows/writing-support.md
grep -q "## 示例交互" workflows/writing-support.md

# batch-management.md
grep -q "## 使用场景" workflows/batch-management.md
grep -q "## 工作流程" workflows/batch-management.md
grep -q "## 输出格式" workflows/batch-management.md
grep -q "## 示例交互" workflows/batch-management.md
```

### 测试 5：工作流包含 pyzotero 命令示例
**目标**：验证工作流包含 pyzotero 命令示例

**步骤**：
1. 检查是否包含 "pyzotero search"
2. 检查是否包含 "pyzotero item"
3. 检查是否包含 "pyzotero subset"

**预期结果**：
- 工作流包含相关 pyzotero 命令示例

**验证命令**：
```bash
# literature-review.md
grep -q "pyzotero search" workflows/literature-review.md

# paper-reading.md
grep -q "pyzotero item" workflows/paper-reading.md
grep -q "pyzotero fulltext" workflows/paper-reading.md

# writing-support.md
grep -q "pyzotero subset" workflows/writing-support.md

# batch-management.md
grep -q "pyzotero tags" workflows/batch-management.md
```

## 测试执行

### 手动测试
```bash
cd zotero-research-skill

# 测试 1
test -d workflows && echo "PASS" || echo "FAIL"

# 测试 2
test -f workflows/literature-review.md && \
test -f workflows/paper-reading.md && \
test -f workflows/writing-support.md && \
test -f workflows/batch-management.md && \
echo "PASS" || echo "FAIL"

# 测试 3
test -s workflows/literature-review.md && \
test -s workflows/paper-reading.md && \
test -s workflows/writing-support.md && \
test -s workflows/batch-management.md && \
echo "PASS" || echo "FAIL"

# 测试 4
grep -q "## 使用场景" workflows/literature-review.md && \
grep -q "## 工作流程" workflows/literature-review.md && \
grep -q "## 输出格式" workflows/literature-review.md && \
grep -q "## 示例交互" workflows/literature-review.md && \
echo "PASS" || echo "FAIL"

# 测试 5
grep -q "pyzotero search" workflows/literature-review.md && \
grep -q "pyzotero item" workflows/paper-reading.md && \
grep -q "pyzotero subset" workflows/writing-support.md && \
grep -q "pyzotero tags" workflows/batch-management.md && \
echo "PASS" || echo "FAIL"
```

### 自动化测试脚本
```bash
#!/bin/bash

# 测试工作流完整性
test_workflows() {
    local workflows_dir="workflows"
    local passed=0
    local failed=0
    
    # 测试 1：目录存在
    if [ -d "$workflows_dir" ]; then
        echo "PASS: workflows 目录存在"
        passed=$((passed + 1))
    else
        echo "FAIL: workflows 目录不存在"
        failed=$((failed + 1))
    fi
    
    # 测试 2：所有文件存在
    local files=("literature-review.md" "paper-reading.md" "writing-support.md" "batch-management.md")
    for file in "${files[@]}"; do
        if [ -f "$workflows_dir/$file" ]; then
            echo "PASS: $file 存在"
            passed=$((passed + 1))
        else
            echo "FAIL: $file 不存在"
            failed=$((failed + 1))
        fi
    done
    
    # 测试 3：文件不为空
    for file in "${files[@]}"; do
        if [ -s "$workflows_dir/$file" ]; then
            echo "PASS: $file 不为空"
            passed=$((passed + 1))
        else
            echo "FAIL: $file 为空"
            failed=$((failed + 1))
        fi
    done
    
    # 测试 4：包含必要章节
    local sections=("## 使用场景" "## 工作流程" "## 输出格式" "## 示例交互")
    for file in "${files[@]}"; do
        for section in "${sections[@]}"; do
            if grep -q "$section" "$workflows_dir/$file"; then
                echo "PASS: $file 包含章节 '$section'"
                passed=$((passed + 1))
            else
                echo "FAIL: $file 缺少章节 '$section'"
                failed=$((failed + 1))
            fi
        done
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
test_workflows
```
