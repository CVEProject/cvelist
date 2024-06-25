import sys
import json

def get_reference_type(url):
    if "git.kernel.org" in url:
        return "FIX"
    if "syzkaller.appspot.com" in url:
        return "REPORT"
    if "groups.google.com" in url:
        return "DISCUSSION"
    return "WEB"

def main(argv):
  output = []
  with open(argv[0]) as processed_file:
      processed_bugs = json.load(processed_file)
      for bug in processed_bugs:
          if len(bug['osvs']) == 1:
              osv_num = bug['osvs'][0]
              osv_record = {
                "id": osv_num,
                "summary": bug["summary"],
                "details": bug["description"],
                "references": [
                    {
                        "type": get_reference_type(reference),
                        "url": reference
                    } for reference in bug["references"]
                ],
                "affected": [{
                    "package": {
                        "name": "Kernel",
                        "ecosystem": "Linux"
                    },
                    "ranges": [{
                        "type": "GIT",
                        "repo": "https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/",
                        "events": [
                            {"introduced": version} for version in bug["versions"]["affected"]
                        ] + [
                            {"limit": version} for version in bug["versions"]["fixed"]
                        ]
                    }]
                }]
              }
              output.append(osv_record)
  print(json.dumps(output))


if __name__ == "__main__":
    main(sys.argv[1:])