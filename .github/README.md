# ashbox (acme.sh box)

A box to keep and use acme.sh within. There are only a few things you ever
need to do to manage certs for projects and this aims to make it just a little easier to deal with.

* Installs, configures, and contains a managed acme.sh setup.
* Simplify and centralise a portable certificate store.
* Simplify interacting with the certificate system.
* Simplify generating configuration for services (like Apache).



# Requirements

* Git
* Bash

*Note: Having experience with acme.sh before will be very helpful this project is not far enough along yet to fully abstract it from you.*



# Install

```
$ git clone https://github.com/bobmagicii/ashbox
$ cd ashbox
$ chmod +x ./ashbox.sh
```

```
$ ./ashbox.sh install ssl@my-web-company.tld
```

When it is done, a crontab entry will have been automatically created to handle the renewals of certificates. That can be verified by checking the output of `crontab -l` afterwards.



# Config

### DNS API Keys

Each of the DNS supported by acme.sh have their variables you set to make their script work. Paste those variables into the `.cfg/account.conf` file.

> Example: to make --dns dns_porkbun work in acme.sh...
```text
PORKBUN_API_KEY='...'
PORKBUN_SECRET_API_KEY='...'
```

* [DNS Mode Documentation for acme.sh](https://github.com/acmesh-official/acme.sh/wiki/dnsapi)

*Note: After the first time acme.sh uses them they will be renamed to be prefixed with SAVED_, acme.sh just does that.*



# Usage

Call `ashbox.sh` with no arguments, or see the files within the `.docs` directory for detailed usage help.

### Quick Examples

> Issue and fetch a cert for the specified domain(s). See the issue command with no argument for a full list of defined dns --alias options.
```
./ashbox.sh issue domain.tld --dns dns_porkbun
./ashbox.sh issue domain.tld --porkbun
```

> List all the certificates tracked by this system.
```
./ashbox.sh list
```

> Remove a certificate from the system.
```
./ashbox.sh remove domain.tld
```

> Get the CLI args that make acme.sh work.
```
$ ./ashbox.sh conf:acmesh

--home /opt/ashbox/.ash --cert-home /opt/ashbox/certs --config-home /opt/ashbox/.cfg
```

> Get the SSL configuration info for Apache configuration.
```
$ ./ashbox.sh conf:apache pegasusgate.net

VHOST SSL CONFIG
================

SSLCertificateFile    /opt/ashbox/certs/pegasusgate.net_eec/pegasusgate.net.cer
SSLCertificateKeyFile /opt/ashbox/certs/pegasusgate.net_eec/pegasusgate.net.key
SSLCACertificateFile  /opt/ashbox/certs/pegasusgate.net_eec/fullchain.cer
```



# Information


### acme.sh

* acme.sh is installed to the `.ash` directory within ashbox.
* acme.sh config is stored in the `.cfg` directory within ashbox.
* acme.sh can be called directly via `.ash/acme.sh`


### Certificates

* Certificates are installed to the `certs` directory within ashbox.
