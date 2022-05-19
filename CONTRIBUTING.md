# How to contribute

## Notes

1.  Only [Roots]([https://cve.mitre.org/cve/cna.html](https://www.cve.org/PartnerInformation/Partner)) or other members of the CVE Automation Working Group should create
pull requests or open issues in this repository currently.  Going
forward, we hope to allow wider participation; e.g., from
security researchers and other cybersecurity
community members.  Until then, others who wish to contribute should
use the [CVE Request web form](https://cveform.mitre.org). If you are a sub-CNA you MUST push within your hierarchy first according to the rules within that hierarchy.  

2.  Only submit information to the CVE Program cvelist repo that is intended to become public
immediately.  There is **no support** for embargoed submissions!!

3.  Understand that this is only a pilot - it could be changed
significantly or even halted. 

4.  Submissions should be made subject to the [CVE Submissions
License Terms of Use](https://www.cve.org/Legal/TermsOfUse). 

5.  It is **strongly recommended** that submissions use [signed
commits](https://help.github.com/articles/signing-commits-with-gpg/). Please note that some hierarchies require all submissions to be signed. 

6.  Submissions from CNAs should be formatted using the [CVE JSON
format](https://github.com/CVEProject/automation-working-group/tree/master/cve_json_schema). 
If you are not familiar with that or do not have tools to work with
that, have a look at [Vulnogram](https://vulnogram.github.io/), which
offers a web-based interface for creating and editing information
about one CVE at a time. 


## Sending Data about CVE Records to the CVE Program

0. If you haven't done so already, create an account on GitHub.com
and fork the _cvelist_ repository (i.e., you would fork [CVEProject/cvelist](https://github.com/CVEProject/cvelist/)). You can either fork into your own account (e.g., from the command line this is the default), for example, if your account name
is `$YOU`, this will result in a new repo named $YOU/cvelist. 
[**NB**: `$YOU` is used throughout the rest of this file; substitute
your own account name in any names, commands, URLs, etc.] You can also clone in to an organization
in GitHub via the web interface at https://github.com/CVEProject/cvelist by selecting "Fork" and then any of the organizations listed in the box (all organizations that you are a member of and have appropriate permissions to will be listed). Then clone your repo on a local host, such as your workstation or a *nix system where you have shell access. Once you have cloned it do not forget to set the upstream value for your git repo, for example if you are a root CNA you would set it to `git@github.com:CVEProject/cvelist.git`: 

```
git remote add upstream git@github.com:CVEProject/cvelist.git
```

1. Ensure your [fork is up to
date](https://help.github.com/articles/syncing-a-fork/), especially
prior to creating a new branch (every time you create a new branch). The command for this are:

```
git fetch upstream
git checkout master
git merge upstream/master
```

2. Optionally push any updates from the upstream `CVEProject/cvelist` 
master back to you fork on Github.com:

```
git push
```

2. Create a new branch, separate from `master`, for each submission. 
We encourage you to include in that multiple, related updates whenever
possible.  For example, if you publish monthly advisories, you might
name your branch `Nov-2017` and use that to send us assignment
information for all the CVE IDs you assigned in that month.  If
instead you publish advisories only as needed, you might name your
branch using the advisory id (e.g., `SA-2017-11-03`) and include in 
that assignment information for the CVE ids you assigned for only
this one advisory. If you are working on multiple branches make sure you explicitly branch against master otherwise future branches may include work from other local branches:

```
git branch $YOUR_BRANCH master
```

For now, let's assume you've named your branch `$YOUR_BRANCH` you can then change to your branch:

```
git checkout $YOUR_BRANCH
```

By branching against master explicitly you can have multiple current branches that can be submitted to your parent CNA seperately. 

3. Make changes to one or more files.  **NB:** limit your changes to
only those portions of the JSON that need to be updated rather than
naively overwriting the entire file. 

4. Validate any files you change against the JSON schema and 
ensure they pass. You can use command line Python for example to validate that the file is valid JSON:

```
python -m json.tool < CVE-2017-1234.json
```

You can also validate against the schema using a variety of tools, e.g. Python jsonschema:

```
jsonschema -i CVE-2017-1234.json CVE_JSON_4.0_min_public.schema
```

The schema file is available in the [CVE Automation Working Group](https://github.com/CVEProject/automation-working-group/tree/master/cve_json_schema) and [version 4](https://raw.githubusercontent.com/CVEProject/automation-working-group/master/cve_json_schema/CVE_JSON_4.0_min_public.schema) is currently in use.


5. **Review your updates carefully** and make sure they contain
**only information you intend to make public**.  Once those reach
GitHub.com, it's extremely difficult if not impossible to put it back
under wraps.  For example, you may be able to check that every CVE ID
is mentioned in one of the references associated with it to avoid
making public information about a vulnerability ahead of schedule. 
Also, review the details in the description.  Do they agree with
information in the associated references?

6.  Commit your changes (e.g., `git commit -av`) and, if necessary, push
your branch from your local copy of your repo to GitHub.com (e.g., `git
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
GitHub reports that the branches can be merged.  If not, say because
you forgot to ensure your fork was synched with the upstream master,
make additional commits in your branch to resolve the merge conflicts. 

After a pull request has been submitted, several checks will be
launched automatically, such as to perform schema validation and check
ownership.  The checks may add comments and labels to the pull request
and, by default, GitHub should notify you via email of those
automatically.  If the checks identify issues, you will need to
address them before processing can continue. 

Next, the CVE Team generally will also review the pull request,
ensuring that descriptions contain product and version information,
references provide provenance, etc.  As before, reviewers will add
comments and labels to the pull request if additional issues are
found, and you will need to address those before processing can
continue. 

Finally, the CVE Team will add an "accepted" label in the pull
request, merge the updated files into the "master" branch, and use the
supplied information to populate the associated entries in the CVE
List itself. 

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

Note that you may contact the CVE Team using the [CVE Request web
form](https://cveform.mitre.org) if you wish to discuss something
privately.  Note also that pull requests left open for more than 21
days will be rejected. 


## Contact

Direct questions, comments, or concerns about use of this repo to the CVE
Team using the [CVE Request web form](https://cveform.mitre.org). 

