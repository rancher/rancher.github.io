---
title: Rancher Compose Variable Substitution
layout: rancher-default

---

## Rancher Compose - Variable Substitution
---

In `rancher-compose`, environment variables from your host can be used within the `docker-compose.yml` file. Currently, this is only supported in rancher-compose commands and not in the Rancher UI.  

### How to use Variable Substitution

On your host, you can have as many variables as you want. Within the `docker-compose.yml` file, you can reference the environment variable on the host.

If there is no environment variable on the host, it will replace the variable with a blank string. If using environment variables for image tags, please note that rancher-compose will not strip the `:` from the image to fetch the latest image. It will provide an error of `invalid image`. It's up to the user to ensure that all environment variables are present and valid on hosts. We recommend using [scheduling rules]({{site.baseurl}}/ranhcer/rancher-compose/scheduling/) to ensure that services are started on the hosts that have the environment variables. 

#### Example:

On Host A, we have an environment variable, `IMAGE_TAG=14.04`. On Host B, we have a different environment variable, `IMAGE_TAG=15.04`. To reference the environment variable, you'd use `$IMAGE_TAG` to get the value of the environment variable from the host. 

```yaml
ubuntu:
  tty: true
  image: ubuntu:$IMAGE_TAG
  stdin_open: true
```

For any containers launched on Host A, the tag would be `14.04`, but for any containers launched on Host B, the tag would be `15.04`. 

### Variable Substition Formats

Rancher-compose supports the same formats as docker-compose. 

```yaml
web:
  # unbracketed name
  image: "$IMAGE"

  # bracketed name
  command: "${COMMAND}"

  # array element
  ports:
  - "${HOST_PORT}:8000"

  # dictionary item value 
  labels:
    mylabel: "${LABEL_VALUE}"

  # unset value - this will expand to "host-"
  hostname: "host-${UNSET_VALUE}"

  # escaped interpolation - this will expand to "${ESCAPED}"
  command: "$${ESCAPED}"
```