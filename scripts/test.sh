#!/bin/bash

# Zotero Research Skill 测试脚本
# 用法: ./scripts/test.sh

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 打印带颜色的消息
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_test() {
    echo -e "${GREEN}[TEST]${NC} $1"
}

print_pass() {
    echo -e "${GREEN}[PASS]${NC} $1"
}

print_fail() {
    echo -e "${RED}[FAIL]${NC} $1"
}

# 测试计数器
TESTS_TOTAL=0
TESTS_PASSED=0
TESTS_FAILED=0

# 运行测试
run_test() {
    local test_name="$1"
    local test_command="$2"

    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    print_test "$test_name"

    if eval "$test_command" &> /dev/null; then
        print_pass "$test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        print_fail "$test_name"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# 测试 pyzotero 是否安装
test_pyzotero_installed() {
    command -v pyzotero &> /dev/null
}

# 测试 Zotero 连接
test_zotero_connection() {
    curl -s "http://localhost:23119/api/users/0/items?limit=1" > /dev/null 2>&1
}

# 测试 pyzotero 连接
test_pyzotero_connection() {
    pyzotero test > /dev/null 2>&1
}

# 测试文件是否存在
test_file_exists() {
    local file="$1"
    [ -f "$file" ]
}

# 测试目录是否存在
test_directory_exists() {
    local dir="$1"
    [ -d "$dir" ]
}

# 测试项目文件
test_project_files() {
    print_info "测试项目文件..."

    # 获取项目根目录
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

    # 测试核心文件
    run_test "SKILL.md 存在" "test_file_exists '$PROJECT_DIR/SKILL.md'"
    run_test "reference.md 存在" "test_file_exists '$PROJECT_DIR/reference.md'"
    run_test "README.md 存在" "test_file_exists '$PROJECT_DIR/README.md'"
    run_test "LICENSE 存在" "test_file_exists '$PROJECT_DIR/LICENSE'"
    run_test "CHANGELOG.md 存在" "test_file_exists '$PROJECT_DIR/CHANGELOG.md'"

    # 测试工作流文件
    run_test "workflows/ 目录存在" "test_directory_exists '$PROJECT_DIR/workflows'"
    run_test "workflows/literature-review.md 存在" "test_file_exists '$PROJECT_DIR/workflows/literature-review.md'"
    run_test "workflows/paper-reading.md 存在" "test_file_exists '$PROJECT_DIR/workflows/paper-reading.md'"
    run_test "workflows/writing-support.md 存在" "test_file_exists '$PROJECT_DIR/workflows/writing-support.md'"
    run_test "workflows/batch-management.md 存在" "test_file_exists '$PROJECT_DIR/workflows/batch-management.md'"

    # 测试模板文件
    run_test "templates/ 目录存在" "test_directory_exists '$PROJECT_DIR/templates'"
    run_test "templates/markdown/ 目录存在" "test_directory_exists '$PROJECT_DIR/templates/markdown'"
    run_test "templates/logseq/ 目录存在" "test_directory_exists '$PROJECT_DIR/templates/logseq'"
    run_test "templates/markdown/literature-list.md 存在" "test_file_exists '$PROJECT_DIR/templates/markdown/literature-list.md'"
    run_test "templates/markdown/paper-note.md 存在" "test_file_exists '$PROJECT_DIR/templates/markdown/paper-note.md'"
    run_test "templates/markdown/reference-list.md 存在" "test_file_exists '$PROJECT_DIR/templates/markdown/reference-list.md'"
    run_test "templates/logseq/outline.md 存在" "test_file_exists '$PROJECT_DIR/templates/logseq/outline.md'"
    run_test "templates/logseq/bibliography.md 存在" "test_file_exists '$PROJECT_DIR/templates/logseq/bibliography.md'"

    # 测试示例文件
    run_test "examples/ 目录存在" "test_directory_exists '$PROJECT_DIR/examples'"
    run_test "examples/find-output.md 存在" "test_file_exists '$PROJECT_DIR/examples/find-output.md'"
    run_test "examples/show-output.md 存在" "test_file_exists '$PROJECT_DIR/examples/show-output.md'"
    run_test "examples/export-output.md 存在" "test_file_exists '$PROJECT_DIR/examples/export-output.md'"
    run_test "examples/workflow-output.md 存在" "test_file_exists '$PROJECT_DIR/examples/workflow-output.md'"

    # 测试脚本文件
    run_test "scripts/ 目录存在" "test_directory_exists '$PROJECT_DIR/scripts'"
    run_test "scripts/install.sh 存在" "test_file_exists '$PROJECT_DIR/scripts/install.sh'"
    run_test "scripts/test.sh 存在" "test_file_exists '$PROJECT_DIR/scripts/test.sh'"
    run_test "scripts/update.sh 存在" "test_file_exists '$PROJECT_DIR/scripts/update.sh'"

    # 测试文档文件
    run_test "docs/ 目录存在" "test_directory_exists '$PROJECT_DIR/docs'"
    run_test "docs/getting-started.md 存在" "test_file_exists '$PROJECT_DIR/docs/getting-started.md'"
    run_test "docs/configuration.md 存在" "test_file_exists '$PROJECT_DIR/docs/configuration.md'"
    run_test "docs/troubleshooting.md 存在" "test_file_exists '$PROJECT_DIR/docs/troubleshooting.md'"
    run_test "docs/api-reference.md 存在" "test_file_exists '$PROJECT_DIR/docs/api-reference.md'"
    run_test "docs/使用说明.md 存在" "test_file_exists '$PROJECT_DIR/docs/使用说明.md'"
}

# 测试 pyzotero
test_pyzotero() {
    print_info "测试 pyzotero..."

    run_test "pyzotero 已安装" "test_pyzotero_installed"

    if test_pyzotero_installed; then
        run_test "Zotero API 连接" "test_zotero_connection"
        run_test "pyzotero 连接" "test_pyzotero_connection"
    else
        print_warn "跳过 pyzotero 连接测试（未安装）"
    fi
}

# 显示测试结果
show_test_results() {
    echo ""
    echo "========================================"
    echo "  测试结果"
    echo "========================================"
    echo ""
    echo "总测试数：$TESTS_TOTAL"
    echo "通过：$TESTS_PASSED"
    echo "失败：$TESTS_FAILED"
    echo ""

    if [ $TESTS_FAILED -eq 0 ]; then
        print_info "所有测试通过！"
        return 0
    else
        print_error "有 $TESTS_FAILED 个测试失败"
        return 1
    fi
}

# 主函数
main() {
    echo "========================================"
    echo "  Zotero Research Skill 测试程序"
    echo "========================================"
    echo ""

    test_project_files
    test_pyzotero
    show_test_results
}

# 运行主函数
main
