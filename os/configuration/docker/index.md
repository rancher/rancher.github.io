---
title: Docker
layout: os-default

---

## Configuring Docker

Both system-docker and docker daemons can be configured with cloud-config. Put system-docker config under `rancher.system_docker` key, and docker config - under `rancher.docker` key. Both configs use roughly the same set of properties:

  - `args` - required, list of strings. Docker daemon process args list, starting with `daemon`. Default value: `[daemon, --log-opt, max-size=25m, --log-opt, max-file=2, -s, overlay, -G, docker, -H, 'unix:///var/run/docker.sock', --userland-proxy=false]`
  
  - `extra_args` - optional, list of strings. Extra docker daemon process args, appended to `args` value. Default value: `[]`
  
  - `environment` - optional, list of strings. Default value: `[]`
  
  - `tls` - optional, boolean. (User) docker only. Default value: `false`
  
  - `tls_args` - optional (used if `tls: true`), list of strings. (User) docker only. Default value: `[]`
  
  - `server_key` - optional (used if `tls: true`), string. (User) docker only. PEM encoded server TLS key. Default value: ""
  
  - `server_cert` - optional (used if `tls: true`), string. (User) docker only. PEM encoded server TLS certificate. Default value: ""
  
  - `ca_key` - optional (used if `tls: true`), string. (User) docker only. PEM encoded CA TLS key. Default value: ""
  
  - `ca_cert` - optional (used if `tls: true`), string. (User) docker only. PEM encoded CA TLS certificate. Default value: ""
  
  - `storage_context` - optional. (User) docker only. Specifies the name of the system container in whose context to run the docker daemon process. Default value: "`console`"
