# How to contribute

## Notes

1.  Only members of the CVE Automation Working Group should create
pull requests or open issues in this repository currently.  Going
forward, we hope to allow progressively wider participation; eg, from
CNAs generally and then security researchers and other cybersecurity
community members.  Until then, others who wish to contribute should
use the [CVE Request web form](https://cveform.mitre.org). 

2.  Only submit information that is intended to become public
immediately.  There is **no support** for embargoed submissions!!

3.  Understand that this is only a pilot - it could be changed
significantly or even halted. 

4.  Submissions should be made subject to the [CVE Submissions
License Terms of Use](https://cve.mitre.org/about/termsofuse.html). 

5.  It is **strongly recommended** that submissions use [signed
commits](https://help.github.com/articles/signing-commits-with-gpg/).



## Sending Data about CVE Entries to MITRE

0.  If you haven't done so already, fork the _cvelist_ repository. 

1.  Ensure your fork is up to date. 

2.  Create a new branch.  We recommend grouping related updates into a
single submission and using a separate branch for each submission. 
For example, one CNA may choose to have a single submission for each
monthly patch bundle, while another may opt for a daily submission. 

3.  Make changes to one or more files.  **NB:** limit your changes to
only those portions of the JSON that need to be updated rather than
naively overwriting the entire file. 

4.  Create a pull request to merge the changes in your new branch into
the cvelist master.

After a pull request has been submitted, the CVE Team will review the
submission and work with you to resolve issues.  Then the CVE Team
will merge the updated files into the "master" branch and use the
supplied information to update the associated entries in the CVE List
itself. 


## Contact

Direct questions, comments, or concerns about use of this repo to the CVE
Team using the [CVE Request web form](https://cveform.mitre.org). 

