---
title: Configuring TLS
layout: os-default

---

## Configuring TLS

_In v0.3.1+, we changed the command from `rancherctl` to `ros`._

`ros tls` is used to generate both the client and server TLS certificates for Docker.

Remember, all `ros` commands needs to be used with `sudo` or as a `root` user.

### End to end example

#### Generate Server Certificate

A server certificate must be generated for the hostname under which you will access the server.  You can use an IP, "localhost", or "foo.example.com". You will need to set the directory of the certificates. Place them in `/home/rancher/.docker` using the `-d` option.

If you want to see the certificate, use `ros config export -p` to see all certificates.

```bash
$ sudo ros tls generate -s --hostname myserver.example.com --hostname localhost --hostname <IP_OF_SERVER> -d ~/.docker
```

#### Enable TLS for Docker

> **Note:** As of v0.4.0+, we have re-named `rancher.user_docker` to `rancher.docker`. In versions prior to v0.4.0, you'll need to use `rancher.user_docker` instead of `rancher.docker`.

```bash
$ sudo ros config set rancher.docker.tls true
$ sudo system-docker restart docker
```

#### Generate Client Certificates

One or more client certificates must be generated so that you can access Docker. Let's store them in `/.docker` by using the `-d` option.

```bash
$ sudo ros tls generate -d ~/.docker
# Change ownership to rancher user
$ sudo chown -R rancher .docker
```

After the certificates are created, you'll need to copy all 4 `.pem` files (`ca-key.pem`, `ca.pem`, `cert.pem`, `key.pem`) into your $HOME/.docker on your client machine.

#### Test certificates

In your client, set the docker host and test out if Docker commands work.

```bash
$ export DOCKER_HOST=tcp://<IP_OF_SERVER>:2376 DOCKER_TLS_VERIFY=1
$ docker ps
```
