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

0. If you haven't done so already, create an account on Github.com
and fork the _cvelist_ repository.  For example, if your account name
is `$YOU`, this will result in a new repo named $YOU/cvelist. 
[**NB**: `$YOU` is used throughout the rest of this file; substitute
your own account name in any names, commands, URLs, etc.] Then clone
your repo on a local host, such as your workstation or a *nix
system where you have shell access.

1. Ensure your [fork is up to
date](https://help.github.com/articles/syncing-a-fork/), especially
prior to creating a new branch (every time you create a new branch). 

2. Optionally push any updates from the upstream `CVEProject/cvelist` 
master back to Github.com (eg, `git push`). 

2. Create a new branch, separate from `master`, for each submission. 
We encourage you to include in that multiple, related updates whenever
possible.  For example, if you publish monthly advisories, you might
name your branch `Nov-2017` and use that to send us assignment
information for all the CVE ids you assigned in that month.  If
instead you publish advisories only as needed, you might name your
branch using the advisory id (eg, `SA-2017-11-03`) and include in 
that assignment information for the CVE ids you assigned for only
this one advisory. For now, let's assume you've named your branch 
`$YOUR_BRANCH` (eg, `git checkout -b $YOUR_BRANCH`).

3. Make changes to one or more files.  **NB:** limit your changes to
only those portions of the JSON that need to be updated rather than
naively overwriting the entire file. 

4. Validate any files you change against the JSON schema and 
ensure they pass.

5. **Review your updates carefully** and make sure they contain
**only information you intend to make public**.  Once those reach
Github.com, it's extremely difficult if not impossible to put it back
under wraps.  For example, you may be able to check that every CVE id
is mentioned in one of the references associated with it to avoid
making public information about a vulnerability ahead of schedule. 
Also, review the details in the description.  Do they agree with
information in the associated references?

6.  Commit your changes (eg, `git commit -av`) and, if necessary, push
your branch from your local copy of your repo to Github.com (eg, `git
push origin $YOUR_BRANCH`). 

7.  Create a pull request to merge the changes in your new branch into
`CVEProject/cvelist` master.  You can do this by browsing to
https://github.com/$YOU/cvelist/pull/new/master and then filling in
the form.  There are several fields that you need to worry about :

* `base fork` is the upstream repo in which you want your updates merged - `CVEProject/cvelist`
* `base` is the branch in the upstream repo in which the changes should be placed - `master`
* `head fork` is your repo from which the updates should be taken; eg, `$YOU/cvelist`
* `compare` is the branch in your repo where the changes are; eg, `$YOUR_BRANCH`

If you created your pull request using the URL above, make sure that
Github reports that the branches can be merged.  If not, say because
you forgot to ensure your fork was synched with the upstream master,
make additional commits in your branch to resolve the merge conflicts. 

After a pull request has been submitted, the CVE Team will review the
submission and work with you to resolve issues.  Then the CVE Team
will merge the updated files into the "master" branch and use the
supplied information to update the associated entries in the CVE List
itself. 

Here is a visual respresentation of the git process:

```
github.com/CVEProject/cvelist --> fork --> github.com/$YOU/cvelist
    ^                                                          |
    | merge                                                    |
    |                                                     git clone
    `-------- Accepted?                                        |
                  ^                                            V
                  |                                /localpath/repo/cvelist
           create | pull request                      |              |
                  |                                 git branch     git branch
  github.com/$YOU/cvelist/$YOUR_BRANCH                |              |
                  |                                   |              V
                  |                                   V             some_other_branch
                  `-- push to your github <-- $YOUR_BRANCH
```

## Contact

Direct questions, comments, or concerns about use of this repo to the CVE
Team using the [CVE Request web form](https://cveform.mitre.org). 

