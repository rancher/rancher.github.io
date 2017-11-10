---
title: Variable Interpolation in Rancher CLI
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 变量替换
---

使用`rancher up`时，可以在`docker-compose.yml`和`rancher-compose.yml`文件中使用运行`rancher`命令的机器中的环境变量。 这仅仅在`rancher`命令中支持，在Rancher UI中不支持。

### 如何使用

通过使用`docker-compose.yml`和`rancher-compose.yml`文件，你可以引用机器上的环境变量。 如果机器上没有环境变量，它将用空白字符串替换。 `Rancher`将会提示一个警告，指出哪些环境变量没有设置。 如果使用环境变量作为镜像标签时，请注意，`rancher`不会从镜像中自动删除`：`来获取latest镜像。 因为镜像名，比如`<镜像名>：`是一个无效的镜像名，所以不会部署成功。用户需要确定机器中所有的环境变量的有效性。

#### 例子

在我们运行`rancher`的机器上，我们有一个环境变量`IMAGE_TAG = 14.04`。

```bash
# Image tag is set as environment variable
$ env | grep IMAGE
IMAGE_TAG=14.04
# Run rancher
$ rancher up
```

**例子： `docker-compose.yml`**

```yaml
version: '2'
services:
  ubuntu:
    tty: true
    image: ubuntu:$IMAGE_TAG
    stdin_open: true
```

<br>

在Rancher中，一个`ubuntu`服务将使用`ubuntu:14.04`镜像来部署。

### 变量替换格式

`Rancher`支持与'docker-compose'相同的格式。

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

### 模板

在`docker-compose.yml`里面，Rancher能够支持使用[Go模板系统](https://golang.org/pkg/text/template/)，这样我们可以在`docker-compose.yml`里面使用逻辑条件语句。


模板可以与Rancher CLI一起使用，也可以与[应用商店]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)组合使用，这样可以让你配置你的应用商店模板，也可以让你根据答案来改变你的模板文件。

> **注意：**目前我们只支持对`string`的比较。

#### 例子

如果你希望能够生成一个在内部暴露端口或者在外部暴露端口的服务，那么你可以设置逻辑条件来实现这样的功能。 在这个例子中，如果`public`变量设置为`ture`，那么`ports`下面的`8000`端口将对外开放。 否则，这些端口将在`expose`下开放。在我们的示例中，默认值为true。

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

#### 应用栈名称替换

从Rancher v1.6.6开始，我们支持在`docker-compose.yml`文件中替换{% raw %} `{{ .Stack.Name }}` {% endraw %}。这样可以在compose文件中使用应用栈名称。

Docker Compose文件可以用于创建新的应用栈，可以通过Rancher命令行或UI来创建。 如下面中的例子，你可以创建一个基于应用栈名称的标签。

##### 示例 `docker-compose.yml`

{% raw %}
```yaml
version: '2'
services:
  web:
    image:  nginx
    labels:
      stack-name: {{ .Stack.Name }}
```
{% endraw %}

如果你通过Rancher命令行来创建应用，例如`rancher up -s myawesomestack -f docker-compose.yml`，那么这个应用将会创建一个带有标签`stack-name=myawesomestack`的服务。

> **注意：** 替换只是发生在应用栈创建时，之后对应用名称的修改无法触发替换。


#### 双括号使用

随着Rancher引入了模板系统，双括号 {% raw %}(`{{` or `}}`){% endraw %} 将被视为模板的一部分。如果你不想将这些字符转换为模板，你可以在包含字符的compose文件的顶部添加上`＃notemplating`。

{% raw %}
```yaml
# notemplating

version: '2'
services:
  web:
    image: nginx
    labels:
      key: "{{`{{ value }}`}}"
```
{% endraw %}
