#  Webhook Service </h1>

Rancher now provides webhook service. Webhooks provide the application with real-time data. So your application doesn't have to keep polling for a particular event to happen, the webhook will notify your application once the event occurs. In 1.4, we have implemented scaling up and down of services using webhooks. Changing the scale of a service would otherwise involve API calls, but now a webhook can be added to do the required action (scale up/scale down). This can be used for autoscaling of a service by integrating with an external monitoring system.

<h2> Webhook creation </h2>

- Webhooks can be added by selecting `Webhooks` from the dropdown on the `API` tab on Rancher UI. ([rancher_server]:8080/env/[envId]/api/hooks)
- All existing webhooks for the current environment will be listed here. 
- On the webhooks page, click on `Add Receiver` next to `Receiver Hooks`. Enter the details such as `Name` of the webhook, under `Kind` we have only one option for 1.4, that is `Scaling a Service`. Select the service to be scaled, if it's to be scaled up (increase in number of containers) or down (decrease in number of containers), and the amount by which the service should be scaled. There are fields for the minimum and maximum amount that a webhook can scale a service to. Click on `Create` once all details are entered.
- The webhook gets created and listed on Webhooks page. A POST request to the Trigger URL is what will actually execute the scaling up/down of the service. The options button is right next to it, and includes options for cloning and deleting the webhook.
- Once the webhook is active, copy the Trigger URL to use with a monitoring service.

<h2> Webhook drivers </h2>

- Webhook service has drivers for different actions. These drivers execute cattle API calls for the corresponding actions.
- The trigger URL obtained after creating a webhook consists of an API endpoint and a token. This token is a JWT containing JSON payload for the driver.
- Currently there's one driver for changing the scale of a service, we plan on adding more drivers, for example adding/removing a host, redeploying a service.

<h2> Implementing autoscaling using Webhooks </h2>

We have implemented autoscaling using webhooks, by integrating with external services such as Prometheus and Alertmanager. </br>

- Go to `Catalogs` tab, select `Prometheus` from Community catalog and launch it. You can see it in the `Stacks` tab under User Stacks. Prometheus will monitor the service to be autoscaled. For that it needs to be configured to add rules. There will be six services running in the Prometheus stack, among those the Prometheus service will be on port 9000. Prometheus needs to be configured to add alerts by making changes to the `/etc/prom-conf/prometheus.yml` file and adding a file for alerts, following is an example of an alert:
```
ALERT CpuUsageSpike
IF rate(container_cpu_user_seconds_total{container_label_io_rancher_container_name="Demo-testTarget-1"}[30s]) * 100 > 70
LABELS {
  severity="critical",
  action="up"
}
ANNOTATIONS {
  summary = "ADDITIONAL CONTAINERS NEEDED",
  description = "CPU usage is above 10%"
}
```
- To actually fire an active alert, Alertmanager needs to be added to the Prometheus stack. Using the image `prom/alertmanager` add a service named `alertmanager` with port mapping 9093:9093. The webhook Trigger URL should be added to `/etc/alertmanager/config.yml` file of the alertmanager. Alertmanager has a webhook_config for that. Adding the previously generated Trigger URL to this webhook config will send a POST request to the URL once the alert is fired. Following is an example of the config.yml
```
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
  - url: 'Trigger URL'
    send_resolved: true
- name: "webhook-receiver-down"
  webhook_configs:
  - url: 'Trigger URL'
    send_resolved: true

```
- Once both services are configured, restart them. This will handle scaling of the service to be monitored using the webhooks generated for them.
