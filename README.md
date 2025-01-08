# resty

Proof of concept for a minimal development stack for microservices + microfrontends
using openresty on linux

Goals:

- Deploy backend services without disrupting other services
- No containers
- No database server; only embedded db's and builtin linux features
- Auth/Access handled by openresty
- Polyglot


## Basic installation - Ubuntu 24

Deploy the source

```sh
git clone https://github.com/zachwaite/resty.git /tmp
cd /tmp/resty
cp -r ./* /opt
```
Run the install script

```sh
cd /opt/.dev/
bash install.sh
```

## Installation in LXD container - Ubuntu 24


Prepare and get on the container - uses Justfile

```sh
cd .dev/
just container
just copy-id
just sync
just connect
```
Run the install script

```sh
cd /opt/.dev/
bash install.sh
```

## Running

Start the resty server

```sh
cd /opt
./resty dev
```

Start the proxied `example-form` service in a separate process

```sh
cd /opt/example-form/
./example-form
```
