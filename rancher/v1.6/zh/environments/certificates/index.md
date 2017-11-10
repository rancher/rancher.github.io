---
title: Certificates in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 证书
---

### 添加证书

可以在**基础架构** -> **证书**页面把证书添加到你的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)里。这个页面已经列出了所有已添加到Rancher环境的证书。你可以点击**添加证书**添加一个新证书。

1. 填写证书**名称**和**描述**。

2. 填写证书**私钥**。你可以点击**从文件读取**导入文件或粘贴私钥到文本框。

3. 填写**证书**。你可以点击**从文件读取** 导入文件或粘贴证书到文本框。

4. (可选) 如果你有其它的**证书链**，你也可以通过**从文件读取**导入文件或粘贴证书链到文本框。

### 使用证书

添加到环境的证书可用作[负载均衡的SSL终端]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#ssl会话终止)或[Kubernetes入口的TSL终端]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/#tls)。
