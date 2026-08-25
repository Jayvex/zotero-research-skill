#!/usr/bin/env python3
"""
文献综述生成脚本

根据用户指定的 Zotero 文献 KEY，自动获取元数据、引用关系，
并生成结构化的文献综述 Markdown 文件。

用法：
    python scripts/generate_review.py KEY1 KEY2 KEY3
    python scripts/generate_review.py KEY1 KEY2 -o review.md
    echo "KEY1 KEY2" | python scripts/generate_review.py --stdin
"""

import argparse
import json
import subprocess
import sys
from datetime import datetime


def run_pyzotero(command, positional_arg=None, extra_args=None, use_json=True):
    """执行 pyzotero 命令并返回结果

    Args:
        command: pyzotero 子命令名
        positional_arg: 位置参数（如 KEY）
        extra_args: 额外的命名参数列表，如 ["--doi", "10.xxx/yyy"]
        use_json: 是否添加 --json 参数（部分命令不支持）
    """
    cmd = ["pyzotero", command]
    if positional_arg:
        cmd.append(positional_arg)
    if extra_args:
        cmd.extend(extra_args)
    if use_json:
        cmd.append("--json")

    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            encoding="utf-8",
            timeout=30
        )
        if result.returncode == 0 and result.stdout.strip():
            return json.loads(result.stdout)
        return None
    except (subprocess.TimeoutExpired, json.JSONDecodeError, FileNotFoundError) as e:
        print(f"警告：执行命令失败 {' '.join(cmd)}: {e}", file=sys.stderr)
        return None


def fetch_paper_metadata(key):
    """获取单篇论文的元数据"""
    data = run_pyzotero("item", positional_arg=key)
    if not data:
        return None

    # pyzotero item 返回单个对象
    if isinstance(data, list):
        data = data[0] if data else None

    if not data:
        return None

    item_data = data.get("data", data)

    # 提取作者列表
    creators = item_data.get("creators", [])
    authors = []
    for c in creators:
        if c.get("creatorType") == "author":
            first = c.get("firstName", "")
            last = c.get("lastName", "")
            name = f"{last}, {first}" if first else last
            authors.append(name)

    # 提取标签
    tags = [t.get("tag", "") for t in item_data.get("tags", [])]

    return {
        "key": item_data.get("key", key),
        "title": item_data.get("title", "未知标题"),
        "authors": authors,
        "date": item_data.get("date", "未知年份"),
        "itemType": item_data.get("itemType", "未知类型"),
        "abstract": item_data.get("abstractNote", ""),
        "doi": item_data.get("DOI", ""),
        "url": item_data.get("url", ""),
        "tags": tags,
        "creators_raw": creators,
    }


def fetch_children(key):
    """获取论文的子项目（附件、笔记）"""
    return run_pyzotero("children", positional_arg=key)


def fetch_citations(doi):
    """获取引用该论文的论文列表（通过 DOI 查询 Semantic Scholar）

    Args:
        doi: 论文的 DOI
    """
    if not doi:
        return []
    data = run_pyzotero("citations", extra_args=["--doi", doi], use_json=False)
    if not data:
        return []
    if isinstance(data, list):
        return data
    return []


def fetch_references(doi):
    """获取该论文引用的参考文献列表（通过 DOI 查询 Semantic Scholar）

    Args:
        doi: 论文的 DOI
    """
    if not doi:
        return []
    data = run_pyzotero("references", extra_args=["--doi", doi], use_json=False)
    if not data:
        return []
    if isinstance(data, list):
        return data
    return []


def fetch_related(doi):
    """获取相关文献列表（通过 DOI 查询 Semantic Scholar）

    Args:
        doi: 论文的 DOI
    """
    if not doi:
        return []
    data = run_pyzotero("related", extra_args=["--doi", doi], use_json=False)
    if not data:
        return []
    if isinstance(data, list):
        return data
    return []


def fetch_fulltext_for_paper(key):
    """尝试获取论文的全文内容

    先获取子项目（附件），再尝试获取 PDF 附件的全文。
    """
    children = fetch_children(key)
    if not children:
        return None

    # 查找 PDF 附件
    for child in children:
        child_data = child.get("data", child)
        if child_data.get("contentType") == "application/pdf":
            att_key = child_data.get("key")
            if att_key:
                data = run_pyzotero("fulltext", positional_arg=att_key, use_json=False)
                if data and isinstance(data, dict):
                    return data.get("content", data.get("text", ""))
                if data:
                    return str(data)

    return None


def format_authors_short(authors):
    """格式化作者列表为简短形式"""
    if not authors:
        return "未知作者"
    if len(authors) == 1:
        return authors[0].split(",")[0].strip()
    if len(authors) == 2:
        return f"{authors[0].split(',')[0].strip()} & {authors[1].split(',')[0].strip()}"
    return f"{authors[0].split(',')[0].strip()} et al."


# itemType 到 BibTeX 类型的映射
BIBTEX_TYPE_MAP = {
    "journalArticle": "article",
    "conferencePaper": "inproceedings",
    "book": "book",
    "bookSection": "incollection",
    "thesis": "phdthesis",
    "report": "techreport",
    "webpage": "misc",
    "patent": "misc",
    "preprint": "misc",
}


def generate_bibtex(paper):
    """生成 BibTeX 格式引用"""
    # 使用姓氏（lastName）生成 BibTeX key
    first_author_last = paper["authors"][0].split(",")[0].strip().lower() if paper["authors"] else "unknown"
    year = paper["date"][:4] if paper["date"] and paper["date"] != "未知年份" else "nd"
    key_bibtex = f"{first_author_last}{year}{paper['key'][:6].lower()}"

    authors_str = " and ".join(paper["authors"]) if paper["authors"] else "Unknown"

    # 根据 itemType 选择 BibTeX 类型
    item_type = paper.get("itemType", "")
    bibtex_type = BIBTEX_TYPE_MAP.get(item_type, "article")

    lines = [f"@{bibtex_type}{{{key_bibtex},"]
    lines.append(f"  title={{{paper['title']}}},")
    lines.append(f"  author={{{authors_str}}},")
    lines.append(f"  year={{{year}}},")
    if paper.get("doi"):
        lines.append(f"  doi={{{paper['doi']}}},")
    lines.append("}")

    return "\n".join(lines)


def generate_review(papers_data, output_file=None):
    """生成文献综述 Markdown"""
    now = datetime.now().strftime("%Y-%m-%d %H:%M")
    total = len(papers_data)

    lines = []
    lines.append("# 文献综述")
    lines.append("")
    lines.append(f"**生成时间**：{now}")
    lines.append(f"**文献数量**：{total} 篇")
    lines.append("")

    # ========== 第一部分：文献列表 ==========
    lines.append("---")
    lines.append("")
    lines.append("## 一、文献列表")
    lines.append("")

    for i, paper in enumerate(papers_data, 1):
        meta = paper["metadata"]
        lines.append(f"### {i}. {meta['title']}")
        lines.append(f"- **作者**：{', '.join(meta['authors']) if meta['authors'] else '未知'}")
        lines.append(f"- **年份**：{meta['date']}")
        lines.append(f"- **类型**：{meta['itemType']}")
        if meta.get("doi"):
            lines.append(f"- **DOI**：{meta['doi']}")
        lines.append(f"- **Key**：{meta['key']}")
        if meta["tags"]:
            tags_str = " ".join(f"#{t}" for t in meta["tags"])
            lines.append(f"- **标签**：{tags_str}")
        if meta["abstract"]:
            abstract = meta["abstract"][:300] + "..." if len(meta["abstract"]) > 300 else meta["abstract"]
            lines.append(f"- **摘要**：{abstract}")
        lines.append(f"- **Zotero链接**：[打开](zotero://select/items/{meta['key']})")
        lines.append("")

    # ========== 第二部分：引用关系分析 ==========
    lines.append("---")
    lines.append("")
    lines.append("## 二、引用关系分析")
    lines.append("")

    for i, paper in enumerate(papers_data, 1):
        meta = paper["metadata"]
        citations = paper.get("citations", [])
        references = paper.get("references", [])
        related = paper.get("related", [])

        lines.append(f"### {i}. {meta['title']}")
        lines.append("")

        # 被引用情况
        if citations:
            lines.append(f"**被引用**（{len(citations)} 篇）：")
            for c in citations[:5]:
                c_title = c.get("title", "未知标题") if isinstance(c, dict) else str(c)
                lines.append(f"- {c_title}")
            if len(citations) > 5:
                lines.append(f"- ... 共 {len(citations)} 篇")
            lines.append("")

        # 参考文献
        if references:
            lines.append(f"**参考文献**（{len(references)} 篇）：")
            for r in references[:5]:
                r_title = r.get("title", "未知标题") if isinstance(r, dict) else str(r)
                lines.append(f"- {r_title}")
            if len(references) > 5:
                lines.append(f"- ... 共 {len(references)} 篇")
            lines.append("")

        # 相关文献
        if related:
            lines.append(f"**相关文献**（{len(related)} 篇）：")
            for r in related[:5]:
                r_title = r.get("title", "未知标题") if isinstance(r, dict) else str(r)
                lines.append(f"- {r_title}")
            if len(related) > 5:
                lines.append(f"- ... 共 {len(related)} 篇")
            lines.append("")

        if not citations and not references and not related:
            lines.append("> 暂无引用关系数据（需要论文 DOI 才能查询 Semantic Scholar）")
            lines.append("")

    # ========== 第三部分：BibTeX 引用 ==========
    lines.append("---")
    lines.append("")
    lines.append("## 三、BibTeX 引用")
    lines.append("")
    lines.append("```bibtex")
    for paper in papers_data:
        lines.append(generate_bibtex(paper["metadata"]))
        lines.append("")
    lines.append("```")
    lines.append("")

    # ========== 第四部分：综述框架 ==========
    lines.append("---")
    lines.append("")
    lines.append("## 四、文献综述框架")
    lines.append("")
    lines.append("以下是基于文献元数据生成的综述框架建议，请根据实际阅读内容进行补充：")
    lines.append("")
    lines.append("### 引言")
    lines.append("")
    lines.append("（请根据文献主题撰写引言，说明研究背景和动机）")
    lines.append("")

    lines.append("### 相关工作")
    lines.append("")

    # 按年份分组
    year_groups = {}
    for paper in papers_data:
        year = paper["metadata"]["date"][:4] if paper["metadata"]["date"] else "未知"
        if year not in year_groups:
            year_groups[year] = []
        year_groups[year].append(paper["metadata"])

    for year in sorted(year_groups.keys(), reverse=True):
        lines.append(f"#### {year} 年")
        for meta in year_groups[year]:
            authors_str = format_authors_short(meta["authors"])
            lines.append(f"- {authors_str} 等人 [{meta['title']}](zotero://select/items/{meta['key']})")
        lines.append("")

    lines.append("### 方法对比")
    lines.append("")
    lines.append("（请根据各论文的方法论进行对比分析）")
    lines.append("")

    lines.append("### 总结与展望")
    lines.append("")
    lines.append("（请根据文献分析结果撰写总结和未来研究方向）")
    lines.append("")

    # ========== 第五部分：全文摘要 ==========
    has_fulltext = any(p.get("fulltext") for p in papers_data)
    if has_fulltext:
        lines.append("---")
        lines.append("")
        lines.append("## 五、全文内容摘要")
        lines.append("")
        for i, paper in enumerate(papers_data, 1):
            if paper.get("fulltext"):
                meta = paper["metadata"]
                lines.append(f"### {i}. {meta['title']}")
                lines.append("")
                # 截取前 500 字符
                text = paper["fulltext"][:500] + "..." if len(paper["fulltext"]) > 500 else paper["fulltext"]
                lines.append(text)
                lines.append("")

    content = "\n".join(lines)

    # 输出
    if output_file:
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(content)
        print(f"文献综述已保存到：{output_file}")
    else:
        print(content)

    return content


def main():
    parser = argparse.ArgumentParser(
        description="根据 Zotero 文献 KEY 生成文献综述",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
示例：
  python scripts/generate_review.py ABC123 DEF456 GHI789
  python scripts/generate_review.py ABC123 DEF456 -o review.md
  echo "ABC123 DEF456" | python scripts/generate_review.py --stdin
        """
    )
    parser.add_argument("keys", nargs="*", help="文献 KEY 列表")
    parser.add_argument("--stdin", action="store_true", help="从标准输入读取 KEY")
    parser.add_argument("-o", "--output", help="输出文件路径（默认输出到标准输出）")
    parser.add_argument("--no-citations", action="store_true", help="跳过引用关系查询（加快速度）")
    parser.add_argument("--no-fulltext", action="store_true", help="跳过全文获取（加快速度）")

    args = parser.parse_args()

    # 获取 KEY 列表
    keys = args.keys
    if args.stdin:
        stdin_input = sys.stdin.read().strip()
        keys.extend(stdin_input.split())

    if not keys:
        parser.print_help()
        print("\n错误：请提供至少一个文献 KEY", file=sys.stderr)
        sys.exit(1)

    # 去重
    keys = list(dict.fromkeys(keys))

    print(f"正在处理 {len(keys)} 篇文献...", file=sys.stderr)

    papers_data = []
    for i, key in enumerate(keys, 1):
        print(f"  [{i}/{len(keys)}] 获取文献 {key} 的元数据...", file=sys.stderr)

        metadata = fetch_paper_metadata(key)
        if not metadata:
            print(f"  警告：无法获取文献 {key} 的元数据，跳过", file=sys.stderr)
            continue

        paper = {"metadata": metadata}

        # 获取引用关系（需要 DOI）
        if not args.no_citations:
            doi = metadata.get("doi", "")
            if doi:
                print(f"  [{i}/{len(keys)}] 通过 DOI {doi} 获取引用关系...", file=sys.stderr)
                paper["citations"] = fetch_citations(doi)
                paper["references"] = fetch_references(doi)
                paper["related"] = fetch_related(doi)
            else:
                print(f"  [{i}/{len(keys)}] 无 DOI，跳过引用关系查询", file=sys.stderr)
                paper["citations"] = []
                paper["references"] = []
                paper["related"] = []
        else:
            paper["citations"] = []
            paper["references"] = []
            paper["related"] = []

        # 获取全文（需要先获取附件 KEY）
        if not args.no_fulltext:
            print(f"  [{i}/{len(keys)}] 尝试获取全文...", file=sys.stderr)
            paper["fulltext"] = fetch_fulltext_for_paper(key)
        else:
            paper["fulltext"] = None

        papers_data.append(paper)

    if not papers_data:
        print("错误：没有成功获取任何文献数据", file=sys.stderr)
        sys.exit(1)

    print(f"\n成功获取 {len(papers_data)} 篇文献数据，正在生成综述...", file=sys.stderr)

    generate_review(papers_data, args.output)


if __name__ == "__main__":
    main()
