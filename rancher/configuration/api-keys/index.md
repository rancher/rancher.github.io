---
title: API & Keys
layout: rancher-default
---

## API & Keys
---

The API endpoint can be found by going to the account settings dropdown menu and clicking on **API & Keys**. The endpoint URL provided when creating an API key will direct you to the specific environment that you are in. 

If [access control]({{site.baseurl}}/rancher/configuration/access-control/) is not configured, anyone with the IP address will have access to your Rancher's API. It's highly recommended to enable access control.

Once access control is enabled, an API key will need to be created for each [environment]({{site.baseurl}}/rancher/configuration/environments/) in order to access the API for the specific environment. 

Within Rancher, all objects can be viewed in the API by selecting the **View in API** option in the object's dropdown menu. The endpoint URL provided when creating the API key also gives all the links to the various portions of the API.

Example:

```bash
curl -sn http://rancher.example.org:8080/v1/projects/1a5 | jq

{
  "id": "1a5",
  "type": "project",
  "links": {
    "self": "http://rancher.example.org:8080/v1/projects/1a5",
    "certificates": "http://rancher.example.org:8080/v1/projects/1a5/certificates",
    "containerEvents": "http://rancher.example.org:8080/v1/projects/1a5/containerevents",
    "credentials": "http://rancher.example.org:8080/v1/projects/1a5/credentials",
    "environments": "http://rancher.example.org:8080/v1/projects/1a5/environments",
    "externalEvents": "http://rancher.example.org:8080/v1/projects/1a5/externalevents",
    "globalLoadBalancers": "http://rancher.example.org:8080/v1/projects/1a5/globalloadbalancers",
    "hosts": "http://rancher.example.org:8080/v1/projects/1a5/hosts",
    "images": "http://rancher.example.org:8080/v1/projects/1a5/images",
    "instanceLinks": "http://rancher.example.org:8080/v1/projects/1a5/instancelinks",
    "instances": "http://rancher.example.org:8080/v1/projects/1a5/instances",
    "ipAddresses": "http://rancher.example.org:8080/v1/projects/1a5/ipaddresses",
    "labels": "http://rancher.example.org:8080/v1/projects/1a5/labels",
    "loadBalancerConfigListenerMaps": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancerconfiglistenermaps",
    "loadBalancerConfigs": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancerconfigs",
    "loadBalancerHostMaps": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancerhostmaps",
    "loadBalancerListeners": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancerlisteners",
    "loadBalancerTargets": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancertargets",
    "loadBalancers": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancers",
    "mounts": "http://rancher.example.org:8080/v1/projects/1a5/mounts",
    "networks": "http://rancher.example.org:8080/v1/projects/1a5/networks",
    "physicalHosts": "http://rancher.example.org:8080/v1/projects/1a5/physicalhosts",
    "ports": "http://rancher.example.org:8080/v1/projects/1a5/ports",
    "projectMembers": "http://rancher.example.org:8080/v1/projects/1a5/projectmembers",
    "serviceConsumeMaps": "http://rancher.example.org:8080/v1/projects/1a5/serviceconsumemaps",
    "serviceEvents": "http://rancher.example.org:8080/v1/projects/1a5/serviceevents",
    "serviceExposeMaps": "http://rancher.example.org:8080/v1/projects/1a5/serviceexposemaps",
    "services": "http://rancher.example.org:8080/v1/projects/1a5/services",
    "snapshots": "http://rancher.example.org:8080/v1/projects/1a5/snapshots",
    "storagePools": "http://rancher.example.org:8080/v1/projects/1a5/storagepools",
    "volumes": "http://rancher.example.org:8080/v1/projects/1a5/volumes",
    "accounts": "http://rancher.example.org:8080/v1/projects/1a5/accounts",
    "apiKeys": "http://rancher.example.org:8080/v1/projects/1a5/apikeys",
    "clusters": "http://rancher.example.org:8080/v1/projects/1a5/clusters",
    "containerExecs": "http://rancher.example.org:8080/v1/projects/1a5/containerexecs",
    "containers": "http://rancher.example.org:8080/v1/projects/1a5/containers",
    "dnsServices": "http://rancher.example.org:8080/v1/projects/1a5/dnsservices",
    "dockerBuilds": "http://rancher.example.org:8080/v1/projects/1a5/dockerbuilds",
    "environmentUpgrades": "http://rancher.example.org:8080/v1/projects/1a5/environmentupgrades",
    "externalServices": "http://rancher.example.org:8080/v1/projects/1a5/externalservices",
    "externalStoragePoolEvents": "http://rancher.example.org:8080/v1/projects/1a5/externalstoragepoolevents",
    "externalVolumeEvents": "http://rancher.example.org:8080/v1/projects/1a5/externalvolumeevents",
    "hostAccesses": "http://rancher.example.org:8080/v1/projects/1a5/hostaccesses",
    "identities": "http://rancher.example.org:8080/v1/projects/1a5/identities",
    "loadBalancerServices": "http://rancher.example.org:8080/v1/projects/1a5/loadbalancerservices",
    "machines": "http://rancher.example.org:8080/v1/projects/1a5/machines",
    "passwords": "http://rancher.example.org:8080/v1/projects/1a5/passwords",
    "projects": "http://rancher.example.org:8080/v1/projects/1a5/projects",
    "pullTasks": "http://rancher.example.org:8080/v1/projects/1a5/pulltasks",
    "register": "http://rancher.example.org:8080/v1/projects/1a5/register",
    "registrationTokens": "http://rancher.example.org:8080/v1/projects/1a5/registrationtokens",
    "registries": "http://rancher.example.org:8080/v1/projects/1a5/registries",
    "registryCredentials": "http://rancher.example.org:8080/v1/projects/1a5/registrycredentials",
    "schemas": "http://rancher.example.org:8080/v1/projects/1a5/schemas",
    "settings": "http://rancher.example.org:8080/v1/projects/1a5/settings",
    "statsAccesses": "http://rancher.example.org:8080/v1/projects/1a5/statsaccesses",
    "subscribe": "http://rancher.example.org:8080/v1/projects/1a5/subscribe",
    "typeDocumentations": "http://rancher.example.org:8080/v1/projects/1a5/typedocumentations",
    "hostStats": "http://rancher.example.org:8080/v1/projects/1a5/projects/1a5/hoststats"
  },
  "actions": {},
  "name": "Production",
  "state": "active",
  "created": "2015-10-21T14:44:57Z",
  "createdTS": 1445438697000,
  "description": null,
  "kind": "project",
  "members": null,
  "removed": null,
  "transitioning": "no",
  "transitioningMessage": null,
  "transitioningProgress": null,
  "uuid": "adminProject"
}

```

### Adding API Keys

Before adding any API Keys, please confirm that you are in the correct environment. _Each API Key is environment specific_. Click on **Add API Key**. Rancher will generate and display your API Key for your environment. In Rancher, an API Key is a combination of a username and a password (secret key) - both are needed to authenticate when performing API calls.

Provide a **Name** for the API Key and click on **Save**. 

### Using API Keys

When access control is configured and you go to the API endpoint, you will be prompted for your API key. The username is the access key and the password is the secret key. 

If you are using `cURL`, you can use the API Key by specifying a `-u` parameter in the form `username:password` or by adding a line to your `.netrc` file.

### Editing API Keys

All options for an API key are accessible through the dropdown menu on the right hand side of the listed key.

For any _Active_ key, you can **Deactivate** the key, which would prohibit the use of those credentials. The key will be labeled in an _Inactive_ state.

For any _Inactive_ key, you have two options. You can **Activate** the key, which will allow the credentials to access the API again. Alternatively, you can **Delete** the key, which will remove the credentials from the environment.

You can **Edit** any key, which allows you to change the name and description of the API key. You will not be able to change the actual access key or secret key. If you want a new key pair, you'll need to add a new one.

