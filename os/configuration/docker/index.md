---
title: Docker
layout: os-default

---

## Configuring Docker

In RancherOS, you can configure `system-docker` and `docker` daemons by using [cloud-config]({{site.baseurl}}/os/cloud-config/). 

### Configuring Docker

In your cloud config, the docker configuration is under the `rancher.docker` key. 

```yaml
#cloud-config
rancher:
  docker:
    tls: true
    tls_args: [--tlsverify, --tlscacert=ca.pem, --tlscert=server-cert.pem, --tlskey=server-key.pem, '-H=0.0.0.0:2376']
    args: [daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -G, docker, -H, 'unix:///var/run/docker.sock', --userland-proxy=false]
```    

#### Valid Keys for Docker

Key | Value | Default | Description
---|---|---| ---
`args` | List of Strings (required)|  `[daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -G, docker, -H, 'unix:///var/run/docker.sock', --userland-proxy=false]` | Docker daemon process args list, starting with `daemon`. 
`extra_args` | List of Strings (optional) |  `[]`| Extra docker daemon process args, appended to `args` value. 
`environment` | List of Strings (optional) |`[]` | 
`tls` | Boolean (optional) | `false` | When [setting up TLS]({{site.baseurl}}/os/configuration/setting-up-docker-tls/), this key needs to be set to true.
`tls_args` | List of Strings (optional, used only if `tls: true`) | `[]` | 
`server_key` | String (optional, used only if `tls: true`)| `""` | PEM encoded server TLS key. 
`server_cert` | String (optional, used only if `tls: true`) | `""` | PEM encoded server TLS certificate.
`ca_key` | String (optional, used only if `tls: true`) | `""` | PEM encoded CA TLS key. 
`storage_context` | String  (optional) | `console` | Specifies the name of the system container in whose context to run the docker daemon process. 

### Configuring System-Docker

In your cloud config, the system-docker configuration is under the `rancher.system_docker` key. 

```yaml
#cloud-config

rancher:
  system_docker:
    args: [daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -b, docker-sys, --restart=false, -g, /var/lib/system-docker, -G, root, -H, 'unix:///var/run/system-docker.sock', --userland-proxy=false]
```
     
#### Valid Keys for System-Docker

Key | Value | Default | Description
---|---|---| ---
`args` | List of Strings (required)|  `[daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -b, docker-sys, --restart=false, -g, /var/lib/system-docker, -G, root, -H, 'unix:///var/run/system-docker.sock', --userland-proxy=false]` | Docker daemon process args list, starting with `daemon`. 
`extra_args` | List of Strings (optional) |  `[]`| Extra docker daemon process args, appended to `args` value. 
`environment` | List of Strings (optional) |`[]` | 
  

### Proxy settings

Docker uses the standard `HTTP_PROXY`, `HTTPS_PROXY`, and `NO_PROXY` environment variables to configure proxy support.  These can be set in the `docker` section of the Cloud Config as follows:

```yaml
#cloud-config
rancher:
  docker:
    environment:
    - HTTPS_PROXY=https://myproxy.example.com
    - NO_PROXY=localhost,127.0.0.1
```


### Certificates for Private Registries

Certificates can be stored in the standard locations in `/etc/docker/certs.d` following the [Docker documentation](https://docs.docker.com/registry/insecure).  This can be done in the Cloud Config with write files.

```yaml
#cloud-config
write_files:
  - path: /etc/docker/certs.d/myregistrydomain.com:5000/ca.crt
    permissions: "0644"
    owner: root
    content: |
      -----BEGIN CERTIFICATE-----
      MIIDJjCCAg4CCQDLCSjwGXM72TANBgkqhkiG9w0BAQUFADBVMQswCQYDVQQGEwJB
      VTETMBEGA1UECBMKU29tZS1TdGF0ZTEhMB8GA1UEChMYSW50ZXJuZXQgV2lkZ2l0
      cyBQdHkgTHRkMQ4wDAYDVQQDEwVhbGVuYTAeFw0xNTA3MjMwMzUzMDdaFw0xNjA3
      MjIwMzUzMDdaMFUxCzAJBgNVBAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMSEw
      HwYDVQQKExhJbnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQxDjAMBgNVBAMTBWFsZW5h
      MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxdVIDGlAySQmighbfNqb
      TtqetENPXjNNq1JasIjGGZdOsmFvNciroNBgCps/HPJphICQwtHpNeKv4+ZuL0Yg
      1FECgW7oo6DOET74swUywtq/2IOeik+i+7skmpu1o9uNC+Fo+twpgHnGAaGk8IFm
      fP5gDgthrWBWlEPTPY1tmPjI2Hepu2hJ28SzdXi1CpjfFYOiWL8cUlvFBdyNqzqT
      uo6M2QCgSX3E1kXLnipRT6jUh0HokhFK4htAQ3hTBmzcxRkgTVZ/D0hA5lAocMKX
      EVP1Tlw0y1ext2ppS1NR9Sg46GP4+ATgT1m3ae7rWjQGuBEB6DyDgyxdEAvmAEH4
      LQIDAQABMA0GCSqGSIb3DQEBBQUAA4IBAQA45V0bnGPhIIkb54Gzjt9jyPJxPVTW
      mwTCP+0jtfLxAor5tFuCERVs8+cLw1wASfu4vH/yHJ/N/CW92yYmtqoGLuTsywJt
      u1+amECJaLyq0pZ5EjHqLjeys9yW728IifDxbQDX0cj7bBjYYzzUXp0DB/dtWb/U
      KdBmT1zYeKWmSxkXDFFSpL/SGKoqx3YLTdcIbgNHwKNMfTgD+wTZ/fvk0CLxye4P
      n/1ZWdSeZPAgjkha5MTUw3o1hjo/0H0ekI4erZFrZnG2N3lDaqDPR8djR+x7Gv6E
      vloANkUoc1pvzvxKoz2HIHUKf+xFT50xppx6wsQZ01pNMSNF0qgc1vvH
      -----END CERTIFICATE-----
```
