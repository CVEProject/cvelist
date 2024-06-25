#!/usr/bin/python3

import json
import sys

def main(argv):
    unique_bugs = {}

    if len(argv) < 1:
        raise Exception("No input file")

    with open(argv[0]) as list_file:
        while True:
            line = list_file.readline()
            if not line:
                break
            item = json.loads(line)
            ids = item['syzkaller'] + item['fixed_by'] + item['cve']
            canonical = None
            for id in ids:
                if id in unique_bugs:
                    canonical = unique_bugs[id]
                    for key in canonical.keys():
                        canonical[key] = list(set(canonical[key] + item[key]))

            if canonical is None:
                canonical = item

            for id in ids:
                if id in unique_bugs:
                    for key in canonical.keys():
                        canonical[key] = list(set(canonical[key] + unique_bugs[id][key]))
            
            ids = canonical['syzkaller'] + canonical['fixed_by'] + canonical['cve']
            for id in ids:
                unique_bugs[id] = canonical
        
        for id in unique_bugs.keys():
            unique_bugs[id] = json.dumps(unique_bugs[id])
        
        print(json.dumps([json.loads(item) for item in list(set(unique_bugs.values()))]))

if __name__ == "__main__":
   main(sys.argv[1:])