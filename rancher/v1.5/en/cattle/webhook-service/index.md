---
title: Webhooks in Rancher
layout: rancher-default-v1.5
version: v1.5
lang: en
---

##  Webhooks

### Receiver Hooks

In Rancher, you can create receiver hooks, which provides a URL that can be used to trigger an action inside of Rancher. For example, the receiver hooks can be integrated with an external monitoring systems to increase or decrease containers of a service. In **API** -> **Webhooks**, you can view and create new receiver hooks. 

#### Adding Receiver Hooks

To create a receiver hook, navigate to **API** -> **Webhooks**. Click on **Add Receiver**.

* Provide a **Name** for the receiver, which will allow you to easily identify it. 
* Select the **Kind** of receiver that you'd like to create. 
* Determine the action of the receiver based on the type of receiver. 

Click on **Create**. After it's created, the URL is provided next to the newly added receiver hook. 

#### Using a Receiver Hook

To use the trigger URL, you'll need to do a `POST` to the specific URL. There is no authentication or body needed to `POST` to the URL.

<a id="scaling-service-example"></a>

##### Example of Scaling a Service

For scaling a service, the actions include:

* Scale up/down a service (i.e. add or remove containers in a service)
* Select from the list of services in the environment
* Scale up/down by how many containers at a time
* The minimum/maximum amount of containers for the service 

<a id="autoscaling-example"></a>

#### Example of Using a Receiver Hook for Autoscaling of a service

By using a receiver hook to scale services, you can implement autoscaling by integrating with external services. In our example, we'll use Prometheus to monitor the services and Alertmanager to `POST` to the URL. 

##### Installing Prometheus

Prometheus is offered through the [Rancher Catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/) and can be found under the **Catalog**. Select **Prometheus** and launch the catalog entry. Within the Prometheus stack, find the service called `prometheus`, which is exposed on port `9000`. Exec into the container and go to `/etc/prom-conf`. The prometheus configuration file, `prometheus.yml` would be present there. In order to add alerts, create a separate file for alerts, and provide the path to this file in `prometheus.yml`. For example if the alerts file you created is called `rules.conf`, add it to `prometheus.yml` at the end by adding these two lines:

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

## New drivers
In 1.5, we have added two additional drivers for webhook-service, one for scaling hosts and the second for redeploying a service based on Dockerhub webhooks. Rest of the framwework remains the same.

## Scaling host
Driver for scaling hosts is implemented by cloning a base host. Hosts will be differentiated into different scaling groups by labels. This label will be provided by the users. The labels should be unique so as to distinguish properly between different host scaling groups. All hosts with the same label, whether created manually or added through webhook-service will be considered in a single host scaling group. This label is a necessary field while adding the receiver hook. It's not mandatory to have any hosts with this label while adding the hook, but while executing there must exist at least one such host. This first host needs to be added by the user manually. The rest of the hosts added through webhook-service for any scaling group will be clones of the first added (least recently created) host.
These fields need to be entered for creating a receiver for scaling of hosts

- HostSelector: This field lets you select the label for your host scaling group.
- Amount: Specify number of hosts you want to add/remove
- Action: Select the action (up/down) for scaling
- Min/Max: Minimum & maximum number of hosts allowed using the webhook
- DeleteOption: While creating a hook for scaling down, you can choose whether to remove the most recently added or the least recently added hosts.

The url obtained after adding a receiver hook for this driver can be used in the same way as for the [scale service](https://github.com/rancher/rancher.github.io/blob/master/rancher/v1.4/en/cattle/webhook-service/index.md#using-a-receiver-hook) driver from 1.4

A few things about this driver I'd like to emphasize on:

- Labels will differentiate host scaling groups, and since these are user labels, they need to be added and edited carefully to maintain these scaling groups. 
If the selector label on some host is accidentally removed then it will not be considered a part of the scaling group by webhook-service anymore. In the same way any label of one scaling group accidentally added to some other host will make this host also a part of the scaling group.
- A custom added host can be made a part of host scaling group, but in order to actually scale up, there has to be at least one host added using machine drivers.
- Since scaling up actually is cloning hosts, the least recently created host from the host scaling group will be used. So the entire config such as resource allocation, docker engine and so on would be same as the least recently created host.
- A host in `Error` state won't be considered as a part of the scaling group.
- Webhook for deleting hosts has an option for removing least/most recently created hosts. Irrespective of this, any hosts that are in `Inactive`, `Deactivating`, `Reconnecting` or `Disconnected` will be removed first while scaling down.


## Redeploying service based on Docker Hub webhooks
Docker Hub sends a POST request to the user-added webhook endpoint, containing information about the latest pushed image and tag. Using this driver you can add a receiver hook in Rancher for all the services that should be upgraded with a particular image:tag once it's pushed to Docker Hub. This driver consumes the Docker Hub webhook information and redeploys/upgrades the services selected while adding the receiver hook. The services waiting for same image should be grouped together using labels. This label should be added by the user to all services. It is a necesssary field to be provided while adding a receiver hook. It is not a must to have any service with this label while adding the hook or while executing it. If there's no service with this label when the hook is executed, simply no action will be taken.
The following fields need to be entered for adding a hook for this driver

- ServiceSelector: This lets you select the label you added for grouping some services
- Tag: Enter the tag that the services are waiting on
- BatchSize, interval and start before stopping flag

Once the receiver hook is added, you need to use the Trigger URL as your Docker Hub webhook. After it is added as the Docker Hub webhook, services corresponding to the Rancher hook will be upgraded automatically once the specified tag is pushed to your Docker Hub image.

This driver relies on the POST request from Docker Hub. In order to use this webhook with services other than Docker Hub, the webhook can be triggered by a POST request with JSON body containing all necessary fields that Docker Hub would send.
These are the fields from Docker Hub request body that are a must for this webhook to work, other fields aren't required hence aren't included in the snippet below
```
{
    "push_data": {
        "tag": <pushedTag>
    },
    "repository": {
        "repo_name": <image>
    }
}
```
