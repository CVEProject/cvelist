#!/usr/bin/python3

import google.auth

import json
import sys

def main(argv):
    bugs = []
    if len(argv) < 1:
        raise Exception("No input file")

    with open(argv[0]) as unique_file:
        unique_bugs = json.load(unique_file)
        for bug in unique_bugs:
            crashes = set()
            commits = set()
            repros = set()
            discussions = set()
            syzkaller_links = set()
            is_kasan = False
            for syzkaller in bug['syzkaller']:
                try:
                    with open("syzkaller/bug_%s.json"%syzkaller) as syzkaller_bug_file:
                        try:
                            syzkaller_bug = json.load(syzkaller_bug_file)
                            syzkaller_links.add("https://syzkaller.appspot.com/bug?%s" % syzkaller)
                            crashes.add(syzkaller_bug['title'])
                            if 'discussions' in syzkaller_bug:
                                for discussion in syzkaller_bug['discussions']:
                                    discussions.add(discussion)
                                    syzkaller_links.add(discussion)
                            if 'crashes' in syzkaller_bug:
                                for crash in syzkaller_bug['crashes']:
                                    if 'title' in crash:
                                        crashes.add(crash['title'])
                                    if 'syz-reproducer' in crash:
                                        repros.add(crash['syz-reproducer'])
                            if 'fix-commits' in syzkaller_bug:
                                for commit in syzkaller_bug['fix-commits']:
                                    if 'title' in commit and commit['title']:
                                        commits.add(commit['title'])
                                    if 'link' in commit and commit['link']:
                                        syzkaller_links.add(commit['link'])
                        except json.decoder.JSONDecodeError:
                            pass
                except FileNotFoundError:
                    pass
            if len(repros) > 0:
                for crash in crashes:
                    if 'KASAN' in crash and 'null-ptr-deref' not in crash:
                        is_kasan = True
                if not is_kasan:
                    continue
                bugs.append({
                    "cves": bug["cve"],
                    "osvs": [],
                    "unique_ids": bug['cve'] + bug['fixed_by'] + bug ['syzkaller'],
                    "summary_inputs": {
                        "commits": list(commits),
                        "crashes": list(crashes),
                        "fixed_by_upstream": list(bug['fixed_by_upstream']),
                        "fixed_by_tag": list(bug['fixed_by_tag']),
                        "introduced_by_tag": list(bug['introduced_by_tag'])
                    },
                    "references": list(syzkaller_links),
                    "versions": {
                        "fixed": bug["fixed_by_upstream"] + bug["fixed_by_downstream"],
                        "affected": bug["introduced_by"] or ["0"]
                    }
                })
    print(json.dumps(bugs))

if __name__ == "__main__":
   main(sys.argv[1:])