---
title: External DNS Service
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 外部DNS服务
---

在[应用商店]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/)中，Rancher提供了多种的DNS服务并且这些服务可以监听rancher-metadata的事件，并根据metadata的更变生成DNS记录。我们会以Route53作为例子说明外部DNS是如何工作的，但Rancher还有其他由其他DNS服务商提的供社区版服务。

### 最佳实践

* 在每个你启动的Rancher环境中，应该有且只有1个 `route53` 服务的实例。
* 多个Rancher实例不应该共享同一个 `hosted zone`。

### 需要配置AWS IAM权限

下面的IAM权限是Route53 DNS所需要的最小权限。
请确保你设置的主机AWS安全密钥(Access Key ID / Secret Access Key)或者主机IAM权限至少被配置了如下权限。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:GetHostedZone",
                "route53:GetHostedZoneCount",
                "route53:ListHostedZonesByName",
                "route53:ListResourceRecordSets"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource": [
                "arn:aws:route53:::hostedzone/<HOSTED_ZONE_ID>"
            ]
        }
    ]
}
```

> **注意：** 当使用这个JSON文档在AWS中创建自定义IAM规则时，请使用Route53所在区域或者通配符('*')来替换`<HOSTED_ZONE_ID>`。

### 启动 Route53 服务

在 **应用商店** 标签页中，你可以选择 **Route53 DNS Stack**。

为你的应用栈填写 **名称**，并填写必要的 **描述**。

在 **配置选项** 中，你需要提供一下的信息：


名称| 值
---|---
AWS Access Key | 访问AWS API的Access key
AWS Secret Key | 访问AWS API的Secret key
AWS Region | 在AWS中的区域名称。我们建议你填写一个与你服务器相近的区域。他会转换成Rancher Route53发送DNS更新请求的地址。
Hosted Zone | Route53 hosted zone。这个必须在你的Route53实例上预创建。

<br>
在完成表单后，点击 **创建**。一个带有 `route53` 服务的应用栈将会被创建，你只需要启动这个服务。


### 使用Route53的服务

`route53`服务只会为在Host上映射端口的服务生成DNS记录，每一个Rancher生成的DNS记录，他使用一下的格式为服务创建一个fqdn：

```
fqdn=<serviceName>.<stackName>.<environmentName>.<yourHostedZoneName>
```

在AWS的Route 53中，他会以name=fqdn，value=[服务所在的host的ip地址列表]的一个记录集合呈现。Rancher `route53` 服务只会管理以<environmentName>.<yourHostedZoneName>结尾的记录集合。当前TTL的时间为300秒。

一旦DNS记录被设置在AWS的Route 53上，生成的fqdn会返回到Rancher，并会设置 **服务.fqdn** 字段。你可以在服务下拉菜单的 **在API中查看** 并查询 **fqdn** 找到fqdn字段。

当在浏览器使用fqdn，他会被指向到服务中的其中一个容器。如果服务中容器的IP地址发生了变化，这些变化会在AWS的Route 53服务同步更新。由于用户一直在使用fqdn，所有这些更变对用户是透明的。

> **注意：** 在 `route53` 服务被启动后，任何已经部署并使用了host端口的服务都会获得一个fqdn。


### 删除 Route53 服务

当 `route53` 从Rancher被移除，在AWS Route 53服务中的记录并**不会**被移除。这些记录需要在AWS中手工移除。

### 为外部DNS使用特定的IP

在默认下，Rancher DNS选择注册在Rancher Server中的主机IP去暴露服务。其中会有一个应用场景是主机在一个私有网络中，但主机将需要使用外部DNS在公网中暴露服务。你需要在启动外部DNS服务前添加一个[主机标签]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#主机标签)，来指定在外部DNS中使用的IP地址。

在启动外部服务前，需要添加以下标签到主机上。标签的值需要是Rancher的Route53 DNS服务上要用到的IP。如果这个标签没有设置在主机上，Rancher的Route53服务将会默认使用主机注册在Rancher上的IP的地址。

```
io.rancher.host.external_dns_ip=<IP_TO_BE_USED_FOR_EXTERNAL_DNS>
```
