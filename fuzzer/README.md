# Fuzzer CVE integration

This directory will host a proof of concept on how we could integrate a high-confidence fuzzer into automatic CVE generation.

## Deduplication

Vulnerability collisions are common, specially on the fuzzing space. In addition, duplicates of CVEs can cause unecessary work for their consumers, which is why accurate deduplication of issues should be a blocking requirement for any CVE automation.

The problem of deduplication is hence divided in two:
 * Deduplication of crashes - that is minimizing the number of duplicate findings from the fuzzing source
 * Deduplication of CVEs - that is minimizing the number of duplicate CVEs from the existing CVEs (in case of bug collisions, for example)

### Deduplication of crashes

Scanners often find the exact same issues multiple times. Despite best efforts, it's extremely difficult to deduplicate an issue fully automatically consistently. As such, when sourcing from a fuzzer, every input should be considered a potential duplicate.

The trivial way to minimize the noise is to **deduplicate by the fix**. That is, if the scanner can identify the version that fixed an issue, then we can consider all issues fixed by the same version as the same vulnerability. This works best in cases when versions are highly granular (eg, commits) where a single fix resolves a single commit.

It's important to take into consideration backports when deduplicating, as they can wrongly appear to fix different issues when they might fix the same one.

### Deduplication of CVEs

Since fuzzing is public, and mostly open-source, it is very common for two people to find the same vulnerability independently, and possibly issue the same CVE. Similar to the deduplication of crashes, one can check the references of the affected version. For open-source fuzzers, linking to the public tracker, crash and any other references can also help identify any potential concerns.

Additionally, listing the CVEs automatically on the fuzzing dashboards can help avoid duplication of effort. Reserving a CVE ID, and waiting for some time before populating its details can also help the community unify along a single CVE identifier (and if a duplicate is published in the meantime, then one would just avoid issuing a duplicate).

## Repeatability

Crashes that have obscure or hard to nail down issues are common in fuzzers. One important component for a valid vulnerability is that of it being reproducible. This allows to know objectively whether a bug exists in code or not.

If a given vulnerability has no reproducer, it might be thought to be fixed, but it might not be in reality. As such, for any vulnerability to be considered valid, it should be possible to objectively observe it.

## Exploitability

The main distinction between security bugs and normal bugs is their ability to affect users security.

For the purposes of CVEs, the bar to qualify for a CVE is reasonably low, however, most CVEs need to meet a minimum bar of security impact for them to be taken seriously by anyone. Determining the impact of a vulnerability is mostly manual analysis and it requires understanding the impact of every issue. Doing so automatically for any type of bug is challenging.

A possible solution is to simply have a high bar for what counts as a valid vulnerability, and only file issues above that bar. Anything else would need manual analysis.
