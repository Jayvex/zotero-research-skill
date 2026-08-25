# Skill 结构测试

## 测试目的
验证 SKILL.md 文件的结构完整性。

## 测试用例

### 测试 1：SKILL.md 文件存在
**目标**：验证 SKILL.md 文件存在

**步骤**：
1. 检查文件是否存在
2. 验证文件不为空

**预期结果**：
- 文件存在
- 文件大小大于 0

**验证命令**：
```bash
test -f SKILL.md && test -s SKILL.md
```

### 测试 2：SKILL.md 包含必要章节
**目标**：验证 SKILL.md 包含所有必要章节

**步骤**：
1. 检查文件是否包含 "## 概述"
2. 检查文件是否包含 "## 命令路由"
3. 检查文件是否包含 "## 工作流"
4. 检查文件是否包含 "## 输出格式"
5. 检查文件是否包含 "## 安全策略"
6. 检查文件是否包含 "## 错误处理"

**预期结果**：
- 所有章节都存在

**验证命令**：
```bash
grep -q "## 概述" SKILL.md
grep -q "## 命令路由" SKILL.md
grep -q "## 工作流" SKILL.md
grep -q "## 输出格式" SKILL.md
grep -q "## 安全策略" SKILL.md
grep -q "## 错误处理" SKILL.md
```

### 测试 3：SKILL.md 包含命令示例
**目标**：验证 SKILL.md 包含 pyzotero 命令示例

**步骤**：
1. 检查文件是否包含 "pyzotero search"
2. 检查文件是否包含 "pyzotero item"
3. 检查文件是否包含 "pyzotero fulltext"

**预期结果**：
- 所有命令示例都存在

**验证命令**：
```bash
grep -q "pyzotero search" SKILL.md
grep -q "pyzotero item" SKILL.md
grep -q "pyzotero fulltext" SKILL.md
```

## 测试执行

### 手动测试
```bash
cd zotero-research-skill

# 测试 1
test -f SKILL.md && test -s SKILL.md && echo "PASS" || echo "FAIL"

# 测试 2
grep -q "## 概述" SKILL.md && \
grep -q "## 命令路由" SKILL.md && \
grep -q "## 工作流" SKILL.md && \
grep -q "## 输出格式" SKILL.md && \
grep -q "## 安全策略" SKILL.md && \
grep -q "## 错误处理" SKILL.md && \
echo "PASS" || echo "FAIL"

# 测试 3
grep -q "pyzotero search" SKILL.md && \
grep -q "pyzotero item" SKILL.md && \
grep -q "pyzotero fulltext" SKILL.md && \
echo "PASS" || echo "FAIL"
```

### 自动化测试脚本
```bash
#!/bin/bash

# 测试 SKILL.md 结构
test_skill_structure() {
    local skill_file="SKILL.md"
    local passed=0
    local failed=0
    
    # 测试 1：文件存在
    if [ -f "$skill_file" ] && [ -s "$skill_file" ]; then
        echo "PASS: SKILL.md 文件存在"
        passed=$((passed + 1))
    else
        echo "FAIL: SKILL.md 文件不存在或为空"
        failed=$((failed + 1))
    fi
    
    # 测试 2：包含必要章节
    local sections=("## 概述" "## 命令路由" "## 工作流" "## 输出格式" "## 安全策略" "## 错误处理")
    for section in "${sections[@]}"; do
        if grep -q "$section" "$skill_file"; then
            echo "PASS: 包含章节 '$section'"
            passed=$((passed + 1))
        else
            echo "FAIL: 缺少章节 '$section'"
            failed=$((failed + 1))
        fi
    done
    
    # 测试 3：包含命令示例
    local commands=("pyzotero search" "pyzotero item" "pyzotero fulltext")
    for cmd in "${commands[@]}"; do
        if grep -q "$cmd" "$skill_file"; then
            echo "PASS: 包含命令 '$cmd'"
            passed=$((passed + 1))
        else
            echo "FAIL: 缺少命令 '$cmd'"
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
test_skill_structure
```
