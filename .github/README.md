# ashbox (acme.sh box)

A box to keep and use acme.sh within.

* Installs, configures, and contains a managed acme.sh setup.
* Centralised portable certificate storage.
* Raw, CSV, or JSON listing of installed certs.
* Generate configuration for misc system and services.
	* acme.sh CLI Config
	* Apache 2.4 SSL Config
	* Gitea SSL Config



# Requirements

* Git
* Bash

*Note: Having prior experience with acme.sh will be helpful this project is not far enough along yet to fully abstract it.*



# Install

```
$ git clone https://github.com/bobmagicii/ashbox
$ cd ashbox
$ chmod +x ./ashbox.sh
```

```
$ ./ashbox.sh install ssl@my-web-company.tld
```

One of the things acme.sh does is add an entry to crontab to handle automatically rewewing certs. That can be verified by checking the output of `crontab -l` - it would be good to edit the crontab to change the time that suits you afterwards with `crontab -e`.

```
$ crontab -l | grep ashbox

20 4 * * * "/opt/ashbox/.ash"/acme.sh --cron --home "/opt/ashbox/.ash" --config-home "/opt/ashbox/.cfg" > /dev/null
```



# Config

### DNS API Keys

Each of the DNS supported by acme.sh have their variables you set to make their script work. Paste those variables into the `.cfg/account.conf` file.

* [DNS Mode Documentation for acme.sh](https://github.com/acmesh-official/acme.sh/wiki/dnsapi)

```text
# example: make --dns dns_porkbun work

PORKBUN_API_KEY='...'
PORKBUN_SECRET_API_KEY='...'
```

*Note: After the first time acme.sh uses them they will be renamed to be prefixed with SAVED_, acme.sh just does that.*



# Usage

Call `ashbox.sh` with no arguments, or see the files within the `.docs` directory for detailed usage help.

### Cert Management

Issue and fetch a cert for the specified domain(s) using DNS API Mode. See the `issue` command with no argument for more info and a list of defined DNS aliases. It can take the same inputs `acme.sh --issue`.

```
$ ./ashbox.sh issue domain.tld --porkbun
```

```
$ ./ashbox.sh issue domain.tld --webroot /opt/web-domain/www
```

Remove a certificate from the system.

```
$ ./ashbox.sh remove domain.tld
```

List all the certificates tracked by this system.

```
$ ./ashbox.sh list
```
```
Main_Domain|KeyLength|SAN_Domains|Profile|CA|Created|Renew
atl.pegasusgate.net|"ec-256"|no||LetsEncrypt.org|2026-01-22T03:40:27Z|2026-02-20T03:40:27Z
new.pegasusgate.net|"ec-256"|no||LetsEncrypt.org|2026-01-22T03:41:53Z|2026-02-20T03:41:53Z
pegasusgate.net|"ec-256"|*.pegasusgate.net||LetsEncrypt.org|2026-01-22T03:28:12Z|2026-02-20T03:28:12Z
```

```
$ ./ashbox.sh list --json
```
```
[
	{ "Main_Domain": "atl.pegasusgate.net", "KeyLength": "ec-256", "SAN_Domains": "no", "Profile": "-", "CA": "LetsEncrypt.org", "Created": "2026-01-22T03:40:27Z", "Renew": "2026-02-20T03:40:27Z" },
	{ "Main_Domain": "new.pegasusgate.net", "KeyLength": "ec-256", "SAN_Domains": "no", "Profile": "-", "CA": "LetsEncrypt.org", "Created": "2026-01-22T03:41:53Z", "Renew": "2026-02-20T03:41:53Z" },
	{ "Main_Domain": "pegasusgate.net", "KeyLength": "ec-256", "SAN_Domains": "*.pegasusgate.net", "Profile": "-", "CA": "LetsEncrypt.org", "Created": "2026-01-22T03:28:12Z", "Renew": "2026-02-20T03:28:12Z" }
]
```

### Configuration Tools

Get the CLI args that make acme.sh work.

```
$ ./ashbox.sh conf:acmesh:shell:args
```
```
--home /opt/ashbox/.ash --cert-home /opt/ashbox/certs --config-home /opt/ashbox/.cfg
```

Get the SSL configuration for Apache 2.4 configuration.

```
$ ./ashbox.sh conf:apache:vhost:ssl pegasusgate.net
```
```
SSLCertificateFile    "/opt/ashbox/certs/pegasusgate.net_ecc/pegasusgate.net.cer"
SSLCertificateKeyFile "/opt/ashbox/certs/pegasusgate.net_ecc/pegasusgate.net.key"
SSLCACertificateFile  "/opt/ashbox/certs/pegasusgate.net_ecc/fullchain.cer"
```



# Information

```
If Installed To: /opt/ashbox
Certs Dir:       /opt/ashbox/certs
acme.sh Install: /opt/ashbox/.ash
acme.sh Config:  /opt/ashbox/.cfg
```

New commands can be added by adding a new `command-whatever.sh` file to the `.fn` directory that register with the plugin system.

```bash
AshboxRegisterCommand "whatever" "CommandWhatever"

function CommandWhatever() {(
	echo "whatever."
	exit $KTHXBAI
)}
```
