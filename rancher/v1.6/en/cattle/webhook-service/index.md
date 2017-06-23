---
title: Webhooks in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

##  Webhooks
---

In Rancher, you can create receiver hooks, which provides a URL that can be used to trigger an action inside of Rancher. For example, the receiver hooks can be integrated with an external monitoring systems to increase or decrease containers of a service. In **API** -> **Webhooks**, you can view and create new receiver hooks.

### Adding Receiver Hooks

To create a receiver hook, navigate to **API** -> **Webhooks**. Click on **Add Receiver**.

* Provide a **Name** for the receiver, which will allow you to easily identify it.
* Select the **Kind** of receiver that you'd like to create.
* Determine the action of the receiver based on the type of receiver.

Click on **Create**. After it's created, the URL is provided next to the newly added receiver hook.

### Using a Receiver Hook

To use the trigger URL, you'll need to do a `POST` to the specific URL. There is no authentication or body needed to `POST` to the URL.

### Kinds of Receiver Hook

* [Scale a Service](#scaling-a-service)
* [Scale the number of Hosts](#scaling-hosts)
* [Upgrade a Service based on DockerHub Tag Updates](#upgrading-a-service-based-on-docker-hub-webhooks)

<a id="scaling-service-example"></a>

#### Scaling a Service

For scaling a service, you must configure your webhook:

* Scale up/down a service (i.e. add or remove containers in a service)
* Select from the list of services in the environment
* Scale up/down by how many containers at a time
* The minimum/maximum amount of containers for the service

<a id="autoscaling-example"></a>

##### Example of Using a Receiver Hook for Autoscaling of a service

By using a receiver hook to scale services, you can implement autoscaling by integrating with external services. In our example, we'll use Prometheus to monitor the services and Alertmanager to `POST` to the URL.

##### Installing Prometheus

Prometheus is offered through the [Rancher Catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) and can be found under the **Catalog**. Select **Prometheus** and launch the catalog entry. Within the Prometheus stack, find the service called `prometheus`, which is exposed on port `9090`. Exec into the container and go to `/etc/prom-conf`. The prometheus configuration file, `prometheus.yml` would be present there. In order to add alerts, create a separate file for alerts, and provide the path to this file in `prometheus.yml`. For example if the alerts file you created is called `rules.conf`, add it to `prometheus.yml` at the end by adding these two lines:

```
rule_files:
  - rules.conf
```

The file `rules.conf` can have multiple alerts, following is an example of an alert

###### Example Alert in `/etc/prom-conf/rules.conf`

```yaml
ALERT CpuUsageSpike
IF rate(container_cpu_user_seconds_total{container_label_io_rancher_container_name="Demo-testTarget-1"}[30s]) * 100 > 70
LABELS {
  severity="critical",
  action="up"
}
ANNOTATIONS {
  summary = "ADDITIONAL CONTAINERS NEEDED",
  description = "CPU usage is above 70%"
}
```
After the alerts have been added, restart the service.

##### Adding Alertmanager

In order to call the receiver hook, Alertmanager will need to be launched. You can add it to the Prometheus stack. Click on **Add Service** in the Prometheus stack. Use the `prom/alertmanager` to add a service. Make sure to map port `9093:9093` when adding the service. After the service has started, exec into the container to update the `etc/alertmanager/config.yml`. In the file, add the URL of the webhook so that it will send a `POST` request to the URL when the alert is fired. After the file is updated with the URL information, restart the service.

###### Example `etc/alertmanager/config.yml`

```yaml
route:
  repeat_interval: 5h
  routes:
  - match:
      action: up
    receiver: "webhook-receiver-up"
  - match:
      action: down
    receiver: "webhook-receiver-down"
receivers:
- name: "webhook-receiver-up"
  webhook_configs:
  - url: <WEBHOOK_URL>
    send_resolved: true
- name: "webhook-receiver-down"
  webhook_configs:
  - url: <WEBHOOK_URL>
    send_resolved: true
```

##### Autoscaling

After Prometheus and Alertmanager have been updated with alerts and hooks, make sure the services were restarted in order to have the configurations updated and active. For the services that alerts have been added, the services will automatically be scaled up or down based on the receiver hook that was created.

#### Scaling Hosts

Rancher is able to scale hosts by cloning an existing host, which were created through Rancher (i.e. Docker Machine). This means that hosts added using the [custom command]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/) cannot be scaled.

Using [labels on the host]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#host-labels), hosts can be grouped together in a scaling group. We recommend using unique labels on hosts to help differentiate scaling groups. Any hosts with the same label, regardless of how the host was added into Rancher, will be counted as part of a scaling group. When creating the webhook, the label is not required to be on any host, but when using the webhook, there must be at least 1 host with the label so that the webhook would have a host to clone in order to scale up. When scaling up hosts, Rancher will use a clone-able host that has been in the scaling group the longest.

For scaling a host, you must configure your webhook:

* Scale up/down a host (i.e. add or remove hosts)
* Add a host selector label. This label is the label on the hosts that will group hosts into a scaling group.
* Select the amount of hosts to add or remove at a time.
* Select the minimum and maximum number of hosts allowed in a host scaling group. If adding hosts, the number of hosts in the scaling group cannot exceed the maximum number. If removing hosts, the number of hosts in the scaling group cannot be lower than the minimum number.
* If you are creating a webhook to scale down hosts, you can choose the priority of the order of how to remove hosts (i.e. start removing by oldest or newest).

##### Notes on Scaling Hosts

* **Host Labels:** Labels are used to differentiate hosts into different scaling groups. Since these are added by the user, labels need to be selected, added and edited carefully. Any labels added on a host will automatically add the host into a scaling group and if the host is clone-able, it could be used for to clone to add more hosts.  Any labels removed on a host will automatically remove the host from the scaling group and will not be eligible to be cloned or deleted from the webhook service.
* **[Custom Hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/custom/):** Any type of host can be added into a scaling group as you only need to add a label to the host. Rancher will not be able to use these hosts to clone and create more hosts.
* **Cloning Hosts:** Since scaling up is cloning a host, all configurations including resource allocation, Docker engine, etc. will be duplicated on any new host. Rancher will always use the oldest host for cloning.
* **Hosts in Error State:** Any hosts in `Error` state will not be considered in the count for a scaling group.
* **Order of Deleting Hosts:** When deleting hosts from Rancher, any hosts in a scaling group will first delete hosts in these states (`Inactive`, `Deactivating`, `Reconnecting` or `Disconnected`) before starting to delete `Active` hosts.

#### Upgrading a service based on Docker Hub Webhooks

Utilizing Docker Hub's webhooks, you can add in Rancher's receiver hook so that when a specific image has been pushed, a `POST` will be sent to Rancher to trigger the receiver hook. Using this combination of webhooks, you can automate so that when a specific `image:tag` is pushed in Docker Hub, any services using a matching versions will automatically get upgraded. To select the group of services to be upgraded, you would use a selector label that will pick up any services that contain the matching label. Labels should be added to a service when creating the service. If the label doesn't exist, you will need to upgrade the service in Rancher to add the label for the webhook.

In order to upgrade a service, you must configure your webhook:

* Select the tag that will be upgraded
* Select the label to find the services to be upgraded
* Determine the number of containers to be upgraded at a time (i.e. Batch Size)
* Determine the number of seconds between starting the next container during upgrade (i. e. Batch Interval)
* Select whether or not the new container should start before the old container was stopped

After the receiver hook is created, you need to use the **Trigger URL** in your your Docker Hub webhook. When the Docker Hub triggers its webhook, services picked up by the Rancher receiver hook will be upgraded. By default, the  Rancher receiver hook expects specific information that the Docker Hub webhook provides. To use Rancher's receiver hook with another webhook, the `POST` would need to contain these fields:

```json
{
    "push_data": {
        "tag": <pushedTag>
    },
    "repository": {
        "repo_name": <image>
    }
}
```
