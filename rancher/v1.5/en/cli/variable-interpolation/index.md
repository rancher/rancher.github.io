---
title: Variable Interpolation in Rancher CLI
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Variable Interpolation
---

Using `rancher up`, environment variables from the machine running `rancher` can be used within the `docker-compose.yml` and `rancher-compose.yml` files. This is only supported in `rancher` commands and not in the Rancher UI.  

### How to use it

With the `docker-compose.yml` and `rancher-compose.yml` files, you can reference the environment variables on your machine. If there are no environment variables on the machine, it will replace the variable with a blank string. `Rancher` will provide a warning on which environment variables are not set.  If using environment variables for image tags, please note that `rancher` will not strip the `:` from the image to fetch the latest image. Since the image name, i.e. `<imagename>:` is an invalid image name, no container will be deployed. It's up to the user to ensure that all environment variables are present and valid on the machine.

#### Example

On our machine running `rancher`, we have an environment variable, `IMAGE_TAG=14.04`.

```bash
# Image tag is set as environment variable
$ env | grep IMAGE
IMAGE_TAG=14.04
# Run rancher
$ rancher up
```

**Example `docker-compose.yml`**

```yaml
version: '2'
services:
  ubuntu:
    tty: true
    image: ubuntu:$IMAGE_TAG
    stdin_open: true
```

<br>

In Rancher, an `ubuntu` service will be deployed with an `ubuntu:14.04` image.

### Variable Interpolation Formats

`Rancher` supports the same formats as `docker-compose`.

```yaml
version: '2'
services:
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

### Templating

Inside the `docker-compose.yml`, Rancher supports the ability to use conditional logic by using the [Go template system](https://golang.org/pkg/text/template/).

Templating can be used with the Rancher CLI or combined with [Rancher Catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) allow you to be able to configure your catalog templates to answer questions and change your files based on the answers.

> **Note:** Currently we only support evaluating `string` comparisons.

#### Example

If you wanted to have the ability to produce a service that publishes ports externally versus internally, you would be able to set conditional logic to support this. In the example, port `8000` will be published under `ports` if the `public` variable is `true`. Otherwise, the ports will be published under `expose`. Using the catalog ability to answer [questions]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/#questions-in-the-rancher-composeyml) is how the user will answer. In our example, the default value is true.

`docker-compose.yml`

{% raw %}
```yaml
version: '2'
services:
  web:
    image: nginx
    {{- if eq .Values.PUBLIC "true" }}
    ports:
    - 8000
    {{- else }}
    expose:
    - 8000
    {{- end }}
```
{% endraw %}

`rancher-compose.yml`

```yaml
version: '2'
catalog:
  name: Nginx Application
  version: v0.0.1
  questions:
  - variable: PUBLIC
    label: Publish Ports?
    required: true
    default: true
    type: boolean
```

`config.yml`

```yaml
name: "Nginx Application"
version: v0.0.1
```

#### Escaping Double Brackets

With the introduction to templating to Rancher, double brackets {% raw %}(`{{` or `}}`){% endraw %} will now be treated as part of a template. If you need to require these characters without having it be converted to a template, they can be escaped by wrapping the the section in another pair of brackets with backticks. For example, the following label value is escaped.

{% raw %}
```
# This value is unescaped
labels:
  key: "{{ value }}"
```
{% endraw %}

{% raw %}
```
# This value is escaped
labels:
  key: "{{`{{ value }}`}}"
```
{% endraw %}
