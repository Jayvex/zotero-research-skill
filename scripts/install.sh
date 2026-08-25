#!/bin/bash

# Zotero Research Skill 安装脚本
# 用法: ./scripts/install.sh

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

# 检查依赖
check_dependencies() {
    print_info "检查依赖..."

    # 检查 git
    if ! command -v git &> /dev/null; then
        print_error "git 未安装，请先安装 git"
        exit 1
    fi

    # 检查 Python
    if ! command -v python &> /dev/null && ! command -v python3 &> /dev/null; then
        print_error "Python 未安装，请先安装 Python 3.8+"
        print_info "下载地址：https://www.python.org/downloads/"
        exit 1
    fi

    # 检查 pip
    if ! command -v pip &> /dev/null && ! command -v pip3 &> /dev/null; then
        print_error "pip 未安装，请先安装 pip"
        exit 1
    fi

    # 检查 pyzotero
    if ! command -v pyzotero &> /dev/null; then
        print_warn "pyzotero 未安装"
        print_info "正在安装 pyzotero..."

        # 安装 pyzotero
        if command -v pip3 &> /dev/null; then
            pip3 install pyzotero -i https://pypi.tuna.tsinghua.edu.cn/simple
        else
            pip install pyzotero -i https://pypi.tuna.tsinghua.edu.cn/simple
        fi

        # 验证安装
        if ! command -v pyzotero &> /dev/null; then
            print_error "pyzotero 安装失败"
            print_info "请手动安装：pip install pyzotero"
            exit 1
        fi
    fi

    print_info "依赖检查完成"
}

# 创建目录结构
create_directories() {
    print_info "创建目录结构..."

    # 获取脚本所在目录的父目录（项目根目录）
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

    # 创建必要的目录
    mkdir -p "$PROJECT_DIR/workflows"
    mkdir -p "$PROJECT_DIR/templates/markdown"
    mkdir -p "$PROJECT_DIR/templates/logseq"
    mkdir -p "$PROJECT_DIR/examples"
    mkdir -p "$PROJECT_DIR/docs"

    print_info "目录结构创建完成"
}

# 验证安装
validate_installation() {
    print_info "验证安装..."

    # 检查必要文件是否存在
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

    if [ ! -f "$PROJECT_DIR/SKILL.md" ]; then
        print_error "SKILL.md 文件不存在"
        exit 1
    fi

    if [ ! -f "$PROJECT_DIR/reference.md" ]; then
        print_error "reference.md 文件不存在"
        exit 1
    fi

    print_info "安装验证完成"
}

# 测试 Zotero 连接
test_zotero_connection() {
    print_info "测试 Zotero 连接..."

    # 测试本地 API
    if curl -s "http://localhost:23119/api/users/0/items?limit=1" > /dev/null 2>&1; then
        print_info "✅ 本地 Zotero API 连接成功"
    else
        print_warn "⚠️ 本地 Zotero API 连接失败"
        print_info "请确保 Zotero Desktop 正在运行"
        print_info "或者使用 Web API（需要配置 API 密钥）"
    fi

    # 测试 pyzotero 连接
    if pyzotero test > /dev/null 2>&1; then
        print_info "✅ pyzotero 连接成功"
    else
        print_warn "⚠️ pyzotero 连接失败"
        print_info "请检查 Zotero Desktop 是否运行"
    fi
}

# 显示安装信息
show_installation_info() {
    echo ""
    echo "========================================"
    echo "  Zotero Research Skill 安装完成！"
    echo "========================================"
    echo ""
    echo "项目位置：$(pwd)"
    echo ""
    echo "下一步："
    echo "1. 确保 Zotero Desktop 正在运行"
    echo "2. 测试连接：pyzotero test"
    echo "3. 搜索文献：pyzotero search -q \"machine learning\""
    echo ""
    echo "常用命令："
    echo "  - pyzotero search -q \"关键词\"  # 搜索文献"
    echo "  - pyzotero item KEY            # 获取项目详情"
    echo "  - pyzotero listcollections     # 列出收藏夹"
    echo "  - pyzotero tags                # 列出标签"
    echo "  - pyzotero test                # 测试连接"
    echo ""
    echo "文档："
    echo "  - README.md：项目说明"
    echo "  - SKILL.md：Claude Code 技能文件"
    echo "  - reference.md：命令参考"
    echo "  - docs/使用说明.md：中文使用说明"
    echo ""
    echo "工作流："
    echo "  - workflows/literature-review.md：文献调研"
    echo "  - workflows/paper-reading.md：论文精读"
    echo "  - workflows/writing-support.md：论文写作"
    echo "  - workflows/batch-management.md：批量管理"
    echo ""
}

# 主函数
main() {
    echo "========================================"
    echo "  Zotero Research Skill 安装程序"
    echo "========================================"
    echo ""

    check_dependencies
    create_directories
    validate_installation
    test_zotero_connection
    show_installation_info
}

# 运行主函数
main
