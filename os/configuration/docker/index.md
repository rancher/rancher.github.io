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

```
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
  
