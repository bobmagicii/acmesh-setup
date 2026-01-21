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

# List Tracked Certs

> `bash ashbox.sh list`

# Issue New Cert

> `bash ashbox.sh issue domain.tld`

# Remove Existing Cert

> `bash ashbox.sh remove domain.tld`
