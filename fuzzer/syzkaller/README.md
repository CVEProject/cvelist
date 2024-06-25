This directory has an OSV-generation prototype for syzkaller bugs.

Once the bug lands on OSV, and there are no updates for some time (backports, regressions), a CVE would follow.

The workflow is as follows:
  1. db_to_list.sh: just executes db_to_list.sql over mirror.sl3
  2. db_to_list.sql: obtains all syzkaller reports and their corresponding commits and cves
  3. list_to_unique.py: uses the list of syzkaller reports and commits and deduplicates them by fix, cve and syzkaller report
  4. unique_to_delta.py: gets the unique crashes and obtains all metadata needed for the advisory
  5. delta_to_processed.py: merges the advisories and obtains the new ones
  6. processed_to_osv.py: formats the processed advisories into osv format

Could be improved by:
  - the advisory summary/title could include more information (eg, from the syzkaller reproducer we can guess attack vector, privileges required)
  - llm summarization could be a lot faster if done in batch, instead of serially
  - summarization could be done at the last stage, only on new ones
  - individual steps could be just functions to improve readability
