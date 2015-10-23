---
title: Rancher Compose Environment Interpolation
layout: rancher-default

---

## Environment Interpolation 
---

Using `rancher-compose`, environment variables from the machine running `rancher-compose` can be used within the `docker-compose.yml` file. This is only supported in rancher-compose commands and not in the Rancher UI.  

### How to use it in Docker-Compose.yml

Within the `docker-compose.yml` file, you can reference the environment variables on your machine. If there is no environment variable on the machine, it will replace the variable with a blank string. `Rancher-compose` will provide a warning on which environment variables are not set.  If using environment variables for image tags, please note that rancher-compose will not strip the `:` from the image to fetch the latest image. Since the image name, i.e. `<imagename>:` is an invalid image name, no container will be deployed. It's up to the user to ensure that all environment variables are present and valid on the machine. 

#### Example:

On our machine running `rancher-compose`, we have an environment variable, `IMAGE_TAG=14.04`. 

```bash
# Image tag is set as environment variable
$ env | grep IMAGE
$IMAGE_TAG=14.04
# Run rancher-compose
$ rancher-compose up
```

**Docker-Compose.yml**

```yaml
ubuntu:
  tty: true
  image: ubuntu:$IMAGE_TAG
  stdin_open: true
```

In Rancher, an `Ubuntu` service will be deployed with an `ubuntu:14.04` image. 

### Environment Interpolation Formats

`Rancher-compose` supports the same formats as `docker-compose`. 

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