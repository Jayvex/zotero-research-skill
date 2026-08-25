#!/bin/bash

# Zotero Research Skill 更新脚本
# 用法: ./scripts/update.sh

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

# 获取项目根目录
get_project_dir() {
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    echo "$(dirname "$SCRIPT_DIR")"
}

# 检查是否为 Git 仓库
check_git_repo() {
    local project_dir="$1"

    if [ ! -d "$project_dir/.git" ]; then
        print_error "项目目录不是 Git 仓库"
        print_info "请先初始化 Git 仓库：git init"
        exit 1
    fi
}

# 备份当前版本
backup_current_version() {
    local project_dir="$1"
    local backup_dir="$project_dir/backups"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local backup_file="$backup_dir/backup_$timestamp.tar.gz"

    print_info "备份当前版本..."

    # 创建备份目录
    mkdir -p "$backup_dir"

    # 创建备份
    tar -czf "$backup_file" \
        -C "$project_dir" \
        --exclude='.git' \
        --exclude='backups' \
        .

    print_info "备份完成：$backup_file"
}

# 拉取最新更新
pull_latest_updates() {
    local project_dir="$1"

    print_info "拉取最新更新..."

    cd "$project_dir"

    # 检查是否有远程仓库
    if git remote -v | grep -q 'origin'; then
        git fetch origin
        git pull origin main
        print_info "更新完成"
    else
        print_warn "未配置远程仓库，跳过拉取更新"
        print_info "请配置远程仓库：git remote add origin <URL>"
    fi
}

# 更新 pyzotero
update_pyzotero() {
    print_info "检查 pyzotero 更新..."

    if ! command -v pyzotero &> /dev/null; then
        print_warn "pyzotero 未安装，跳过更新"
        return
    fi

    # 检查是否为最新版本
    print_info "当前 pyzotero 版本：$(pyzotero --version 2>/dev/null || echo '未知')"
    print_info "尝试更新 pyzotero..."

    if command -v pip3 &> /dev/null; then
        pip3 install --upgrade pyzotero -i https://pypi.tuna.tsinghua.edu.cn/simple || print_warn "更新失败，请手动更新：pip install --upgrade pyzotero"
    elif command -v pip &> /dev/null; then
        pip install --upgrade pyzotero -i https://pypi.tuna.tsinghua.edu.cn/simple || print_warn "更新失败，请手动更新：pip install --upgrade pyzotero"
    else
        print_warn "pip 未找到，请手动更新 pyzotero"
    fi
}

# 验证更新
validate_update() {
    local project_dir="$1"

    print_info "验证更新..."

    # 检查核心文件是否存在
    if [ ! -f "$project_dir/SKILL.md" ]; then
        print_error "SKILL.md 文件不存在，更新可能失败"
        exit 1
    fi

    if [ ! -f "$project_dir/reference.md" ]; then
        print_error "reference.md 文件不存在，更新可能失败"
        exit 1
    fi

    # 运行测试
    if [ -f "$project_dir/scripts/test.sh" ]; then
        print_info "运行测试..."
        bash "$project_dir/scripts/test.sh"
    fi

    print_info "更新验证完成"
}

# 显示更新信息
show_update_info() {
    echo ""
    echo "========================================"
    echo "  Zotero Research Skill 更新完成！"
    echo "========================================"
    echo ""
    echo "更新内容："
    echo "  - 项目文件已更新"
    echo "  - pyzotero 已检查更新"
    echo "  - 更新已验证"
    echo ""
    echo "下一步："
    echo "1. 检查更新日志：git log --oneline -10"
    echo "2. 运行测试：./scripts/test.sh"
    echo "3. 测试功能：pyzotero test"
    echo ""
    echo "如有问题："
    echo "  - 查看文档：README.md"
    echo "  - 检查故障排除：docs/troubleshooting.md"
    echo "  - 提交 Issue：GitHub Issues"
    echo ""
}

# 主函数
main() {
    echo "========================================"
    echo "  Zotero Research Skill 更新程序"
    echo "========================================"
    echo ""

    # 获取项目目录
    PROJECT_DIR=$(get_project_dir)

    # 检查 Git 仓库
    check_git_repo "$PROJECT_DIR"

    # 备份当前版本
    backup_current_version "$PROJECT_DIR"

    # 拉取最新更新
    pull_latest_updates "$PROJECT_DIR"

    # 更新 pyzotero
    update_pyzotero

    # 验证更新
    validate_update "$PROJECT_DIR"

    # 显示更新信息
    show_update_info
}

# 运行主函数
main
