import json
import sys
import uuid

def main(argv):
    with open(argv[0]) as base_file, open(argv[1]) as delta_file:
        base = json.load(base_file)
        delta = json.load(delta_file)
        all_bugs = {}
        for bug in base + delta:
            is_dupe = False
            has_osv = len(bug['osvs']) > 0
            for id in bug['unique_ids']:
                if id in all_bugs:
                    if has_osv and len(all_bugs[id]['osvs']) > 0:
                        print("two OSVs share reference %s (%s and %s)" % (id, bug['osvs'], all_bugs[id]['osvs']), file=sys.stderr)
                    is_dupe = True

            if not is_dupe or has_osv:
                for id in bug['unique_ids']:
                    if id not in all_bugs:
                        all_bugs[id] = bug
                    else:
                        dupe_bug = all_bugs[id]
                        for id in dupe_bug['unique_ids']:
                            all_bugs[id] = bug
                            bug['unique_ids'] = list(
                                set(bug['unique_ids'] + dupe_bug['unique_ids']))
                            bug['unique_ids'].sort()

        unique_bugs = list(set([json.dumps(bug) for bug in all_bugs.values()]))
        unique_bugs.sort(reverse=True)

        osv_eligible_bugs = []
        for bug_serialized in unique_bugs:
            bug = json.loads(bug_serialized)
            if not len(bug['osvs']):
                bug['osvs'].append(str(uuid.uuid4()))
            osv_eligible_bugs.append(bug)

        print(json.dumps(osv_eligible_bugs))


if __name__ == "__main__":
    main(sys.argv[1:])