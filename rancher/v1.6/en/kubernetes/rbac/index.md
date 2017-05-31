---
title: Kubernetes RBAC Integration in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Rancher Kubernetes RBAC integration
---

Enabling Kubernetes RBAC allows Rancher  users and groups to be given granular permissions to the various resources within Kubernetes. Authentication is integrated with [Rancher access control](https://docs.rancher.com/rancher/v1.6/en/configuration/access-control/#azure-ad) which means any external authentication system supported by Rancher can be used for Kubernetes RBAC roles.

An understanding of namespaces is a requirement to making use of RBAC permissions. To learn more about namespaces you can reference the [Kubernetes docs on this feature](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/).

### Default Roles

Environment owners are given admin access to the cluster. This means they will be able to read and write to any resource, as well as apply new roles for other users. Users with any other role will have no access by default and will only receive permissions explicitly granted to them.

Removing a user from an environment will take away all of their access to the cluster. Demoting an environment owner will remove their admin access to the cluster. Likewise, promoting any environment member will give them admin access.

### Applying New Roles

New roles are created by applying two Kubernetes resource types: `RoleBindings` and `ClusterRoleBindings`. `ClusterRoleBindings` add permissions at the global level and `RoleBindings` apply within a particular namespace.

##### Global Access

Global access allows access to resources across all namespaces. For example, suppose anyone from the Github organization `mycompany-research` should have read-only access to the cluster. The following resource can be created with `kubectl apply` and will allow this type of access.

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: edit-dev
  namespace: dev
subjects:
  - kind: Group
    name: github_team:mycompany-research
roleRef:
  kind: ClusterRole
  name: edit
  apiGroup: rbac.authorization.k8s.io
```

Any member of the team `mycompany-research` should now have the ability to view, but not modify, most resources in the cluster.

##### Access Within Namespaces

Users can be given specific privileges within particular namespaces. There are three convenient roles that come out of the box with Kubernetes.

view - Read-only access to most objects in a namespace.
edit - Read and write access to most objects in a namespace.
admin - Includes all permissions from the edit role and allows the creation of new roles and role bindings.

For example, suppose users `developer1` and `developer2` should have the ability to write and read nearly all resources within the `dev` namespace. We could tie the `edit` role to them with the following role binding. This can be applied with the `kubectl apply` command.

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: edit-dev
  namespace: dev
subjects:
  - kind: User
    name: developer1
  - kind: User
    name: developer2
roleRef:
  kind: ClusterRole
  name: edit
  apiGroup: rbac.authorization.k8s.io
```

Notice how a namespace is specified unlike with the previous global example. This role binding still applies to a single namespace even though a cluster role is used.

Similarly we could grant user `developer2` read-only access to the `qa` namespace with the following role binding.

```yaml
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: view-qa
  namespace: qa
subjects:
  - kind: User
    name: developer2
roleRef:
  kind: ClusterRole
  name: view
  apiGroup: rbac.authorization.k8s.io
```

To updates subjects in a role binding, simply add or remove them from the resource file and reapply with `kubectl apply`.

##### Custom Roles

Custom roles allow more control than built-in roles such as `admin`, `edit`, and `view`. For information on building more specific roles refer to the [Kubernetes RBAC documentation](https://kubernetes.io/docs/admin/authorization/rbac/).

### Known Issues

Helm and Tiller do not currently respect RBAC roles. Anyone with access to either of these will have admin access to the cluster.
