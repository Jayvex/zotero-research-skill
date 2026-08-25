# 命令参考测试

## 测试目的
验证 reference.md 文件的完整性和准确性。

## 测试用例

### 测试 1：reference.md 文件存在
**目标**：验证 reference.md 文件存在

**步骤**：
1. 检查文件是否存在
2. 验证文件不为空

**预期结果**：
- 文件存在
- 文件大小大于 0

**验证命令**：
```bash
test -f reference.md && test -s reference.md
```

### 测试 2：reference.md 包含所有命令
**目标**：验证 reference.md 包含所有必要的 pyzotero 命令

**步骤**：
1. 检查文件是否包含 "pyzotero search"
2. 检查文件是否包含 "pyzotero item"
3. 检查文件是否包含 "pyzotero children"
4. 检查文件是否包含 "pyzotero fulltext"
5. 检查文件是否包含 "pyzotero listcollections"
6. 检查文件是否包含 "pyzotero tags"
7. 检查文件是否包含 "pyzotero test"
8. 检查文件是否包含 "pyzotero citations"
9. 检查文件是否包含 "pyzotero references"
10. 检查文件是否包含 "pyzotero related"
11. 检查文件是否包含 "pyzotero s2search"

**预期结果**：
- 所有命令都存在

**验证命令**：
```bash
grep -q "pyzotero search" reference.md
grep -q "pyzotero item" reference.md
grep -q "pyzotero children" reference.md
grep -q "pyzotero fulltext" reference.md
grep -q "pyzotero listcollections" reference.md
grep -q "pyzotero tags" reference.md
grep -q "pyzotero test" reference.md
grep -q "pyzotero citations" reference.md
grep -q "pyzotero references" reference.md
grep -q "pyzotero related" reference.md
grep -q "pyzotero s2search" reference.md
```

### 测试 3：reference.md 包含命令参数
**目标**：验证 reference.md 包含命令参数说明

**步骤**：
1. 检查 "pyzotero search" 是否包含参数说明
2. 检查 "pyzotero item" 是否包含参数说明
3. 检查 "pyzotero fulltext" 是否包含参数说明

**预期结果**：
- 所有命令都有参数说明

**验证命令**：
```bash
grep -A 10 "pyzotero search" reference.md | grep -q "参数"
grep -A 10 "pyzotero item" reference.md | grep -q "参数"
grep -A 10 "pyzotero fulltext" reference.md | grep -q "参数"
```

### 测试 4：reference.md 包含命令示例
**目标**：验证 reference.md 包含命令示例

**步骤**：
1. 检查 "pyzotero search" 是否包含示例
2. 检查 "pyzotero item" 是否包含示例
3. 检查 "pyzotero citations" 是否包含示例

**预期结果**：
- 所有命令都有示例

**验证命令**：
```bash
grep -A 20 "pyzotero search" reference.md | grep -q "示例"
grep -A 20 "pyzotero item" reference.md | grep -q "示例"
grep -A 20 "pyzotero citations" reference.md | grep -q "示例"
```

### 测试 5：reference.md 不包含旧的 zot 命令
**目标**：验证 reference.md 中没有遗留的 `zot` 命令引用

**步骤**：
1. 检查文件不包含 "### zot find"
2. 检查文件不包含 "### zot show"
3. 检查文件不包含 "### zot export"

**预期结果**：
- 没有旧的 zot 命令引用

**验证命令**：
```bash
! grep -q "### zot find" reference.md
! grep -q "### zot show" reference.md
! grep -q "### zot export" reference.md
```

## 测试执行

### 手动测试
```bash
cd zotero-research-skill

# 测试 1
test -f reference.md && test -s reference.md && echo "PASS" || echo "FAIL"

# 测试 2
grep -q "pyzotero search" reference.md && \
grep -q "pyzotero item" reference.md && \
grep -q "pyzotero children" reference.md && \
grep -q "pyzotero fulltext" reference.md && \
grep -q "pyzotero listcollections" reference.md && \
grep -q "pyzotero tags" reference.md && \
grep -q "pyzotero test" reference.md && \
grep -q "pyzotero citations" reference.md && \
grep -q "pyzotero references" reference.md && \
grep -q "pyzotero related" reference.md && \
grep -q "pyzotero s2search" reference.md && \
echo "PASS" || echo "FAIL"

# 测试 3
grep -A 10 "pyzotero search" reference.md | grep -q "参数" && \
grep -A 10 "pyzotero item" reference.md | grep -q "参数" && \
grep -A 10 "pyzotero fulltext" reference.md | grep -q "参数" && \
echo "PASS" || echo "FAIL"

# 测试 4
grep -A 20 "pyzotero search" reference.md | grep -q "示例" && \
grep -A 20 "pyzotero item" reference.md | grep -q "示例" && \
grep -A 20 "pyzotero citations" reference.md | grep -q "示例" && \
echo "PASS" || echo "FAIL"

# 测试 5
! grep -q "### zot find" reference.md && \
! grep -q "### zot show" reference.md && \
! grep -q "### zot export" reference.md && \
echo "PASS" || echo "FAIL"
```

### 自动化测试脚本
```bash
#!/bin/bash

# 测试 reference.md 完整性
test_reference() {
    local ref_file="reference.md"
    local passed=0
    local failed=0

    # 测试 1：文件存在
    if [ -f "$ref_file" ] && [ -s "$ref_file" ]; then
        echo "PASS: reference.md 文件存在"
        passed=$((passed + 1))
    else
        echo "FAIL: reference.md 文件不存在或为空"
        failed=$((failed + 1))
    fi

    # 测试 2：包含所有 pyzotero 命令
    local commands=("pyzotero search" "pyzotero item" "pyzotero children" "pyzotero fulltext" "pyzotero listcollections" "pyzotero tags" "pyzotero test" "pyzotero citations" "pyzotero references" "pyzotero related" "pyzotero s2search")
    for cmd in "${commands[@]}"; do
        if grep -q "$cmd" "$ref_file"; then
            echo "PASS: 包含命令 '$cmd'"
            passed=$((passed + 1))
        else
            echo "FAIL: 缺少命令 '$cmd'"
            failed=$((failed + 1))
        fi
    done

    # 测试 3：包含命令参数
    local cmd_names=("pyzotero search" "pyzotero item" "pyzotero fulltext")
    for cmd in "${cmd_names[@]}"; do
        if grep -A 10 "$cmd" "$ref_file" | grep -q "参数"; then
            echo "PASS: 命令 '$cmd' 包含参数说明"
            passed=$((passed + 1))
        else
            echo "FAIL: 命令 '$cmd' 缺少参数说明"
            failed=$((failed + 1))
        fi
    done

    # 测试 4：包含命令示例
    for cmd in "${cmd_names[@]}"; do
        if grep -A 20 "$cmd" "$ref_file" | grep -q "示例"; then
            echo "PASS: 命令 '$cmd' 包含示例"
            passed=$((passed + 1))
        else
            echo "FAIL: 命令 '$cmd' 缺少示例"
            failed=$((failed + 1))
        fi
    done

    # 测试 5：不包含旧的 zot 命令
    local old_commands=("### zot find" "### zot show" "### zot export")
    for cmd in "${old_commands[@]}"; do
        if ! grep -q "$cmd" "$ref_file"; then
            echo "PASS: 不包含旧命令 '$cmd'"
            passed=$((passed + 1))
        else
            echo "FAIL: 包含旧命令 '$cmd'"
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
test_reference
```
