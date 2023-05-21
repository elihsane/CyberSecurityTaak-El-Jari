# CyberSecurityTaak-El-Jari

This repository is for the Cybersecurity & Virtualisation course at [HoGent] (https://hogent.be).

## Content

On the 5th of October 2021, a CVE detailing a path traversal attack on Apache HTTP Server 2.4.49 was released. Assigned the number CVE-2021-41773, it was released with the following description:

A flaw was found in a change made to path normalization in Apache HTTP Server 2.4.49. An attacker could use a path traversal attack to map URLs to files outside the expected document root. If files outside of the document root are not protected by "require all denied" these requests can succeed. Additionally (sic) this flaw could leak the source of interpreted files like CGI scripts. This issue is known to be exploited in the wild. This issue only affects Apache 2.4.49 and not earlier versions.

This repository contains a Lab where this can be tested. You can look at the [Documentation](./Documentation/Documentation.md) for more details.