# Webhooks

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
