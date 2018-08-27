---
title: Building with AWS S3 in Rancher Compose
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 利用 AWS S3 构建
---

构建 docker 镜像可以有两种方法。第一种方法是通过给 build 命令一个 git 或者 http URL参数来利用远程资源构建，另一种方法则是让 build 利用本地目录，那么会上传构建上下文到 S3 并在需要时在各个节点执行

### 前置条件

* Docker
* Rancher Compose
* AWS 账户
* Rancher Server 和1台主机

在我们这个例子里，我们会在`docker-compose.yml`里定义我们的应用，并且把这个文件放在`composetest`下。这个`compose`文件会定义个`web`服务，它会打开`5000`端口并映射到主机上，还会链接`redis`服务，这样可以让在`web`中运行的服务可以通过`redis`这个主机名来访问`redis`容器

```yaml
version: '2'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    links:
      - redis

  redis:
    image: redis
```

我们还会添加一个 `rancher-compose.yml` 到同一个 `composetest` 目录下来使用 Rancher的`缩放`能力。缺省情况下，如果没有`rancher-compose.yml`文件或者服务在`rancher-compose.yml`中没有定义，那么容器数量默认为1个。

```yaml
version: '2'
services:
  web:
    scale: 3
```

当提供给 Rancher Compose 的这些文件准备好后，下一步就是实现这个程序并按照步骤来构建它。

使用`docker-compose`文档中的例子，我们会创建一个名为`app.py`的文件。这个应用会访问一个名为`redis`的主机，这个主机会运行 redis KV 存储服务。它会递增redis 中的键为 `hits` 的键值，然后取回这个值。

```yaml
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    return 'Hello World! I have been seen %s times.' % redis.get('hits')

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```

这个应用会依赖两个库，所以我们同时会创建一个名为 `requirements.txt` 的文件。

```
flask
redis
```

现在我们会在`Dockerfile`文件中定义应用的构建步骤。在`Dockerfile`文件里的指令会定义出要怎么构建出这个应用容器。


```
FROM python:2.7
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD python app.py
```

因为你已经运行着Rancher Server了，所以你只需要配置好你 AWS 认证信息，然后用你的 Rancher Server URL 和[API key]({{site.baseurl}}/rancher/{{page.version}}/en/api/v2-beta/api-keys/)来运行 Rancher Compose 。

```bash
# Set up your AWS credentials
$ aws configure
AWS Access Key ID []: AWS_ACCESS_KEY
AWS Secret Access Key []: AWS_SECRET_KEY
Default region name []: NOT_NEEDED_FOR_S3
Default output format [None]:
# Run rancher-compose in your composetest directory where all the files are created
$ rancher-compose --url URL_of_Rancher --access-key username_of_API_key --secret-key password_of_API_key up
```

根据上面的指令，这个 web 容器会在一台 Rancher Server 管理的主机上运行起来。`rancher-compose` 会先上传当前目录到 S3，而你可以到 S3的 UI 上检索到这个目录。当镜像上传成功后，它会下载这个些文件到主机上构建起一个容器。

### 问题解答

如果你在利用 S3构建时出现了一些问题，你可以先在本机测试一下是否可以构建并运行。在你运行`rancher-compose`的同一目录下，使用下面的命令来校验是否在 docker 中可以正常工作。

```bash
# Test building locally to see if works
$ docker build -t test .
# Test running the newly built image
$ docker run test
```
