---
title: Kubernetes RBAC Integration in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## Rancher Kubernetes RBAC集成
---

_从Rancher v1.6.3开始支持_

在默认情况下，K8S所在的Rancher环境里的所有用户都可以访问K8S内的资源。启用[Kubernetes RBAC](https://kubernetes.io/docs/admin/authorization/rbac/)可以使得[环境的所有者]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#所有者)能够限制环境中的某些用户去访问K8S的资源。

认证模块集成在了[Rancher的访问控制选项]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/##启用访问控制)，这意味着Rancher所支持的全部外部认证系统都可以用在K8S的RBAC里。

在使用Kubernetes RBAC权限之前，你需要了解命名空间对定义。了解更多命名空间的内容，请参考[Kubernetes 文档](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/).

### 启用Kubernetes RBAC

为了启用Kubernetes RBAC，你需要确保正确[配置了Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#设置kubernetes)并且选择了启用Kubernetes RBAC。如果你已经部署了Kubernetes基础设施服务，你可以点击**已经为最新版本**来进行Kubernetes相关配置的修改。

### 默认角色

[环境的所有者]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#所有者)被授予了环境中Kubernetes集群对管理员权限。拥有管理员权限意味着用户可以对任何Kubernetes资源进行读写操作。同时，也可以通过创建角色给Kubernetes环境中的其他用户创建权限。

> **重要：** 在默认情况下，任何非环境所有者对用户对Kubernetes集群中任何的资源都没有权限，除非这些用户被赋予了相关权限后，才可以访问Kubernetes集群中的相应资源。

从环境中删除一个用户会移除掉该用户在Kubernetes集群中拥有的所有访问权限。给一个环境所有者降权会移除该用户对Kubernetes集群的管理员权限。类似的，如果将一个用户升级为所有者，这个用户将会拥有Kubernetes集群的管理员权限。

### 已知问题

Helm和Tiller目前不支持RBAC角色。任何可以访问它们其中之一的用户拥有Kubernetes集群的管理员权限。

### 向用户／组中添加新的角色

为了给非所有者用户提供访问Kubernetes集群资源的权限，所有者需要创建一个新的角色并且把这个角色应用到这些用户上。有两种Kubernetes资源类型`RoleBindings`和`ClusterRoleBindings`。`RoleBindings`可以将权限应用于环境中的某个命名空间里。`ClusterRoleBindings`可以把权限应用于全局。（例如，某个环境里的全部的命名空间）。

`kubectl apply`命令可以用来应用角色绑定。你也可以使用`kubectl apply`命令，通过简单的从资源文件中添加或者删除权限来实现权限的更新。

### 组名称规则

当将组应用到角色绑定时，你的Rancher[访问控制]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/)将会决定了组名称的语法规则。

认证方式 | 组名称规则
---|---
Active Directory | `ldap_group:<NAME>`
Azure AD | `azuread_group:<NAME>`
Github Organizations | `github_org:<NAME>`
Github Teams | `github_team:<NAME>`
OpenLDAP | `openldap_group:<NAME>`
Shibboleth | `shibboleth_group:<NAME>`

<br>

> **注意：** 目前，在kubernetes RBAC里，你可以把权限应用于特定的组，但是你必须把组内用户的个体添加到环境当中。目前，kubernetes RBAC不支持将整个组添加到一个环境当中。

#### 角色

用户可以在特定的命名空间中被授予特定的权限。Kubernetes内嵌了3种方便的角色。

* view - 对命名空间下的大多数资源拥有只读权限。
* edit - 对命名空间下的大多数资源拥有读写权限。
* admin - 拥有edit角色的全部权限，同时可以创建新的角色和角色绑定。

自定义角色相对于内嵌的角色（`admin`, `edit` 和 `view`）来说，允许更具体的管控。更多有关如何构建特定角色的信息，请参考[Kubernetes RBAC文档](https://kubernetes.io/docs/admin/authorization/rbac/)。

### 示例

#### 在特定命名空间里给两个用户授予修改权限

在这个例子里，我们给两个用户`developer1`和`developer2`添加权限。从而使这两个用户可以对`dev`命名空间下几乎全部的资源进行读写操作。我们使用如下的角色绑定把`edit`角色授予这两个用户。

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: edit-dev
  namespace: dev # 指定你想要把权限应用于哪个命名空间
subjects:
  - kind: User
    name: developer1
  - kind: User
    name: developer2
roleRef:
  kind: ClusterRole
  name: edit # 指定你想要把哪个角色应用于这两个用户
  apiGroup: rbac.authorization.k8s.io
```

#### 在特定命名空间里给一个用户授予只读权限

在这个例子里，我们给一个用户`developer2`添加权限。从而使这个用户可以对`qa`命名空间下几乎全部的资源进行只读操作。我们使用如下的角色绑定把`view`角色授予这个用户。

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: view-qa
  namespace: qa # 指定你想要把权限应用于哪个命名空间
subjects:
  - kind: User
    name: developer2
roleRef:
  kind: ClusterRole
  name: view # 指定你想要把哪个角色应用于用户
  apiGroup: rbac.authorization.k8s.io
```

#### 在特定命名空间里给一个组授予只读权限

在这个例子里，我们给一个Github团队`mycompany-research`中全部的成员添加权限。从而使这个团队可以对`dev`命名空间下几乎全部的资源进行只读操作。我们使用如下的角色绑定把`view`角色授予这个团队。

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: view-dev-group
  namespace: dev # 指定你想要把权限应用于哪个命名空间
subjects:
  - kind: Group # 指定这是一个组而不是独立用户
    name: github_team:mycompany-research
roleRef:
  kind: ClusterRole
  name: view # 指定你想要把哪个角色应用于用户
  apiGroup: rbac.authorization.k8s.io
```

任何`mycompany-research`团队中的成员都拥有这个集群中的大多数资源的只读权限。

> **注意：** 目前，在kubernetes RBAC里，你可以把权限应用于特定的组，但是你必须把组内用户的个体添加到环境当中。目前，kubernetes RBAC不支持将整个组添加到一个环境当中。

#### 给全部用户授予列出命名空间的权限

在Kubernetes Dashboard里切换名命名空间对某些用户来说比较困难。例如这个用户没有列出全部命名空间的权限。下面的集群角色和关联的绑定可以使全部的用户拥有列出命名空间的权限。

```
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: default-reader
rules:
  - apiGroups: [""]
    resources:
      - namespaces
    verbs: ["get", "watch", "list"]
  - nonResourceURLs: ["*"]
    verbs: ["get", "watch", "list"]

---

kind: ClusterRoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: default-reader-binding
subjects:
  - kind: Group
    name: system:authenticated
roleRef:
  kind: ClusterRole
  name: default-reader
  apiGroup: rbac.authorization.k8s.io
```

你可以根据自己的需要，将下面的资源也添加到`default-reader`当中。

 * componentstatuses
 * events
 * endpoints
 * namespaces
 * nodes
 * persistentvolumes
 * resourcequotas
 * services
