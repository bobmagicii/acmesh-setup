# ASHBOX

A box to keep and use acme.sh within. There are only a few things you ever
need to do to manage certs for projects and this aims to make it just a little
easier to deal with.

# Install

```shell
git clone https://github.com/bobmagicii/ashbox
cd ashbox
bash ashbox.sh install ssl@my-web-company.tld
```

# Config

### DNS API Keys

Paste the variables into `account.conf`

```shell
PORKBUN_API_KEY='...'
PORKBUN_SECRET_API_KEY='...'
```

# Usage

```text
* bash ashbox.sh issue <domain1> <...domain2> <...>
  Issue SSL certs for new domains.

* bash ashbox.sh remove <domain1> <...domain2> <...>
  Remove an SSL cert from the system.

* bash ashbox.sh list
  List all the domains tracked by acme.sh.

* bash ashbox.sh apacheconf <domain>
  Print the SSL config options for Apache configuration.

* bash ashbox.sh install
  Install acme.sh and configure within ashbox.
```
