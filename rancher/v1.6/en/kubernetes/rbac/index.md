---
title: Kubernetes RBAC Integration in Rancher
metaTitle: "Kubernetes RBAC | RBAC Implementation | Rancher"
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Rancher Kubernetes RBAC integration
---

_Available as of Rancher v1.6.3_

By default, any users in a Rancher environment running Kubernetes have access to all the resources within Kubernetes. Enabling [Kubernetes RBAC](https://kubernetes.io/docs/admin/authorization/rbac/) allows [owners of environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#owners) to restrict access to the various resources within Kubernetes to specific users in the environment.

Authentication is integrated with [Rancher's access control options](https://docs.rancher.com/rancher/v1.6/en/configuration/access-control/#enabling-access-control), which means any external authentication system supported by Rancher can be used for Kubernetes RBAC roles.

An understanding of namespaces is a requirement to making use of Kubernetes RBAC permissions. To learn more about namespaces please reference the [Kubernetes docs](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/).

### Enabling Kubernetes RBAC Implementation

In order to enable Kubernetes RBAC, you will need to make sure to [configure Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/#configuring-kubernetes) and select to enable Kubernetes RBAC. If you've already launched the Kubernetes infrastructure service, you can click on the **Up to Date** to update the configuration options for Kubernetes.

### Default Roles

[Owners of environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#owners) are given admin access to the Kubernetes cluster in the environment. Having admin access means these users will be able to read and write to any Kubernetes resource, as well as create the permissions to other users in the Kubernetes environment by creating roles for them.

> **Important:** By default, any non-owners of an environment will not have any access to any resources in the Kubernetes cluster until they are  explicitly granted to them.

Removing a user from an environment will take away all of their access to the Kubernetes cluster. Demoting an environment owner will remove their admin access to the cluster. Likewise, promoting any users to an environment to an owner will give them admin access.

### Known Issues

Helm and Tiller do not currently respect RBAC roles. Anyone with access to either of these will have admin access to the Kubernetes cluster.

### Applying New Roles to Users/Groups

In order to provide permissions to non-owners to the Kubernetes resources, owners will need to create new roles and apply them to the users. There are two Kubernetes resource types: `RoleBindings` and `ClusterRoleBindings`. `RoleBindings` apply permissions to a specific namespace in an environment while `ClusterRoleBindings` add permissions at the global level (i.e. all namespaces in an environment).

Role bindings can be applied with the `kubectl apply` command. You can update any permissions by simply adding or removing them from the resource file and re-applying with `kubectl apply`.

### Group Name Syntax

When applying groups to role bindings, your Rancher [authentication]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) will determine the syntax of the name of your group.

Authentication Provider | Group Name Syntax
---|---
Active Directory | `ldap_group:<NAME>`
Azure AD | `azuread_group:<NAME>`
Github Organizations | `github_org:<NAME>`
Github Teams | `github_team:<NAME>`
OpenLDAP | `openldap_group:<NAME>`
Shibboleth | `shibboleth_group:<NAME>`

<br>

#### Roles

Users can be given specific privileges within particular namespaces. There are three convenient roles that come out of the box with Kubernetes.

* view - Read-only access to most objects in a namespace.
* edit - Read and write access to most objects in a namespace.
* admin - Includes all permissions from the edit role and allows the creation of new roles and role bindings.

Custom roles allow more control than built-in roles such as `admin`, `edit`, and `view`. For information on building specific roles, refer to the [Kubernetes RBAC documentation](https://kubernetes.io/docs/admin/authorization/rbac/).

### Examples

#### Giving edit access to 2 users to a specific namespace

In this example, we are granting permissions to two users, `developer1` and `developer2`, so that they have the ability to write and read nearly all resources in the `dev` namespace. We tie the `edit` role to them with the following role binding.

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: edit-dev
  namespace: dev # Specify which namespace you want these permissions granted in
subjects:
  - kind: User
    name: developer1
  - kind: User
    name: developer2
roleRef:
  kind: ClusterRole
  name: edit # Specify which type of role you want the users to have
  apiGroup: rbac.authorization.k8s.io
```

#### Giving read only access to a user to a specific namespace

In this eample, we are granting permissions to one user, `developer2`, so that they have the ability to read nearly all resources in the `qa` namespace. We tie the `view` role to them with the following role binding.


```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: view-qa
  namespace: qa # Specify which namespace you want these permissions granted in
subjects:
  - kind: User
    name: developer2
roleRef:
  kind: ClusterRole
  name: view # Specify which type of role you want the users to have
  apiGroup: rbac.authorization.k8s.io
```

#### Giving read only access to a group to a specific namepsace

In this example, we are granting permissions to all users in a specific Github team, `mycompany-research`, so that the team has the ability to read nearly all resources in the `dev` namespace.  We tie the `edit` role to them with the following role binding.


```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: view-dev-group
  namespace: dev # Specify which namespace you want these permissions granted in
subjects:
  - kind: Group # Specify that this is a group instead of individual users
    name: github_team:mycompany-research
roleRef:
  kind: ClusterRole
  name: view # Specify which type of role you want the users to have
  apiGroup: rbac.authorization.k8s.io
```

Any member of the team `mycompany-research` should now have the ability to view, but not modify, most resources in the cluster.

#### Giving all users access to list namespaces

Switching between namespaces in the Kubernetes Dashboard is difficult if a user does not have access to list all namespaces. The following cluster role and associated binding will give all users the ability to list namespaces.

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

The following resources might also be useful to include in `default-reader` depending on your needs.

 * componentstatuses
 * events
 * endpoints
 * namespaces
 * nodes
 * persistentvolumes
 * resourcequotas
 * services
