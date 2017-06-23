---
title: Webhooks in Rancher
layout: rancher-default-v1.4
version: v1.4
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
