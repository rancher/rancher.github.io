---
title: Service Accounts in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 服务账号
---

你创建了一个需要和Rancher API交互的容器，你需要创建服务账号API keys，这样我们就可以访问带有权限认证的API来。为了在服务中创建这些keys，需要给服务添加以下的标签。

Key | Value |描述
----|-----|---
`io.rancher.container.create_agent` | `true` | 标识服务账号栋API keys会被添加到每个容器的环境变量里。
`io.rancher.container.agent.role` | `environment` | 标识账号的角色。创建服务账号的值为`environment`.

当服务中的容器启动时，以下环境变量会被加入到容器中

Key| Value
---|---
`CATTLE_URL` | [主机注册地址]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#主机注册)的URL。
`CATTLE_ACCESS_KEY` | 启动的服务所在[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)的访问密钥。
`CATTLE_SECRET_KEY` | 访问密钥对应的安全密钥。
