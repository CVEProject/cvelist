# Warning: This repository will be no longer updated with new CVE information after 5/30/2025.  Please refer to the official CVE List that resides [here](https://github.com/CVEProject/cvelistV5) for up to date CVE Information.

In March/2023 the CVE Program adopted a new official CVE Record Format (CVE Record Version 5.x which is defined [here](https://github.com/CVEProject/cve-schema) ) to advance automation and vulnerability information enrichment for the global vulnerability management ecosystem.  In June/2023, [the AWG Git Submission Pilot (hosted in this repository) was deprecated](https://github.com/CVEProject/cvelist/discussions/8938).  Although the CVE Record Git Submission capability was deprecated, this repository was maintained with updated CVE Information drawn from the official CVE List (and presented in CVE Record Version 4 format).  After 5/30/2025, this list will no longer be maintained.  The [official CVE List](https://github.com/CVEProject/cvelistV5) will be the only location that will be maintained by the CVE Program.

### ---- Everything below the line is considered legacy information and no longer operational ---
 ----------------------------------------------------------------------------------------------

# CVE Automation Working Group Git Pilot

The [CVE Automation Working
Group](https://github.com/CVEProject/automation-working-group) is
piloting use of git to share information about public vulnerabilities. 
The goal is to learn not only what features are necessary to support
the "plumbing" of sending and receiving the data, but also which
attributes and metadata are needed in the CVE format to support
automation. 

See [How to Contribute](https://github.com/CVEProject/cvelist/blob/master/CONTRIBUTING.md)
for details on participating in this pilot.

This repository holds information included in the [CVE
List](https://cve.mitre.org/cve/) formatted using the [CVE JSON
format](https://github.com/CVEProject/automation-working-group/tree/master/cve_json_schema). 

Use of the CVE information in this repository is subject to the [CVE
Terms of Use](https://cve.mitre.org/about/termsofuse.html). 


## Overview of the Repository

Information about each CVE id is stored as a unique file in the repo
in a subdirectory based on the year as well as the numeric portion of
the id, truncated by 1,000.  Thus, [2017/3xxx](2017/3xxx) is for
CVE-2017-3000 - CVE-2017-3999, and [2017/1002xxx](2017/1002xxx) is for
CVE-2017-1002000 - CVE-2017-1002999. 

The CVE Team updates these files automatically every hour using
information from the CVE List, provided there have been changes.  The
synchronization job kicks off at the top of the hour and should
complete within 5 minutes. 

For ids that have been populated, the files contain the description
and references that appear in the [CVE
List](https://cve.mitre.org/cve/).  They may also contain
information about the affected product(s) and problem type(s), which
CNAs have been supplying when making assignments during the past year
but which is not included in the CVE List.  And going forward, it is
hoped that they will contain a richer collection of information about
the vulnerability, as supported by the full CVE JSON schema. 


## Contact

Direct questions, comments, or concerns about use of this repo to the CVE
Team using the [CVE Request web form](https://cveform.mitre.org). 
