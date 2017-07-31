---
title: Health Checks in Rancher
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/cattle/health-checks/
---

## Health Checks
---

In Cattle environments, Rancher implements a health monitoring system by running a `healthcheck` infrastructure service, which launch `healthcheck` containers across its hosts to co-ordinate the distributed health checking of containers and services. These containers internally utilize HAProxy to validate the health status of your applications. When health checks are enabled either on an individual container or a service, each container is then monitored by up to three `healthcheck` containers running on separate hosts. The container is considered healthy if at least one HAProxy instance reports a "passed" health check and it is considered unhealthy when all HAProxy instances report a "unhealthy" health check.

> **Note:** The only exception to this model is when your environment contains a single host, in this instance the health checks will be performed by the same host.

Rancher handles network partitions and is more efficient than client-based health checks. By using HAProxy to perform health checks, Rancher enables users to specify the same health check policy across applications and load balancers.

> **Note:** Health checks will only work for services that are using the managed network. If you select any other network choice, it will **not** be monitored.

### Configuration

Use the following options to configure Health Checks:

**Check type**: There are two types of checks - _TCP Connection Opens_ (only verifies that the port is open) and _HTTP Responds 2xx/3xx_ (performs an HTTP request and ensures a good response is received).

**HTTP request**: If the check is of type _HTTP Responds 2xx/3xx_, you must specify a URL path to be queried. You can select the request method (`GET`, `POST`, etc) as well as the HTTP version (`HTTP/1.0`, `HTTP/1.1`).

**Port**: The port to perform the check against.

**Initializing Timeout:** The number of milliseconds before we exit initializing.

**Re-Initializing Timeout:** The number of milliseconds before we exit reinitializing.

**Check interval**: The number of milliseconds between checks.

**Check Timeout**: The number of milliseconds before a check without response times out.

**Healthy threshold**: The number of successful check responses before a (currently marked unhealthy) container is considered healthy again.

**Unhealthy threshold**: The number of failed check responses before a (currently marked healthy) container is considered unhealthy.

**When Unhealthy**: There are 3 options of what to do when a container is considered unhealthy. `Take no action` means that the container will remain in unhealthy state. `Re-create` means that Rancher will destroy the unhealthy container and create a new container for the service.  `Re-create, only when at least X container is healthy` means that if there are `X` number of containers healthy, then the unhealthy container will be destroyed and re-created.

### Adding Health Checks in the UI

For [services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/) or [load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/), health checks can be added by navigating to the **Health Check** tab. You can check TCP connections or HTTP responses for services and change the default values for the health check configuration.

### Adding Health Checks to Services in Rancher Compose

Using [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/), health checks can be added in the `rancher-compose.yml`.

In our example, we show the health check configuration for the three different strategies if a container is found unhealthy.

```yaml
version: '2'
services:
  service1:
    scale: 1
    health_check:
      # Which port to perform the check against
      port: 80
      # For TCP, request_line needs to be '' or not shown
      # TCP Example:
      # request_line: ''
      request_line: GET /healthcheck HTTP/1.0
      # Interval is measured in milliseconds
      interval: 2000
      initializing_timeout: 60000
      reinitializing_timeout: 60000
      unhealthy_threshold: 3
      # Strategy for what to do when unhealthy
      # In this service, no action will occur when a container is found unhealthy
      strategy: none
      healthy_threshold: 2
      # Response timeout is measured in milliseconds
      response_timeout: 2000
  service2:
    scale: 1
    health_check:
      # Which port to perform the check against
      port: 80
      # Interval is measured in milliseconds
      interval: 2000
      initializing_timeout: 60000
      unhealthy_threshold: 3
      # Strategy for what to do when unhealthy
      # In this service, Rancher will recreate any unhealthy containers
      strategy: recreate
      healthy_threshold: 2
      # Response timeout is measured in milliseconds
      response_timeout: 2000
  service3:
    scale: 1
    health_check:
      # Which port to perform the check against
      port: 80
      # Interval is measured in milliseconds
      interval: 2000
      initializing_timeout: 60000
      unhealthy_threshold: 3
      # Strategy for what to do when unhealthy
      # In this service, Rancher will recreate any healthy containers only if there   is at least 1 container
      # that is healthy
      strategy: recreateOnQuorum
      recreate_on_quorum_strategy_config:
        quorum: 1
      healthy_threshold: 2
      # Response timeout is measured in milliseconds
      response_timeout: 2000
```


### Failure Scenarios

Scenario | Response
----|----
The container being monitored stops responding to health checks. | All the active HAProxy instances that are monitoring the container would detect the failure and mark the container as "unhealthy". If the container is part of a service then Rancher restores the service to its pre-defined scale through its service HA functionality.
A host running containers with health checks enabled loses network connectivity or the agent on that host. | When network connectivity is lost to a host, the connection to the agent is lost from the Rancher server. Since the agent is not accessible, the host is marked as "reconnecting". At this time all that's known is that Rancher server can't connect to the host agent for that host. Health checking in Rancher is done against the container itself and not the host; as a result, the container would be unreachable to all of its active HAProxy instances. If the container is part of a service then Rancher restores the service to its pre-defined scale through its service HA functionality.
A host running containers with health checks enabled has a complete failure. | When a host suffers a complete failure such as a power outage, the connection to the agent is lost from the Rancher server. Since the agent is not accessible, the host is marked as "reconnecting". At this time all that's known is that Rancher server can't connect to the host agent for that host. Health checking in Rancher is done against the container itself and not the host; as a result the container would be uncontactable by all of its active HAProxy instances. If the container is part of a service then Rancher restores the service to its pre-defined scale through its service HA functionality.
A Host's agent fails but host remains online and the containers are running and are passing health checks. | In this instance, as the previous cases, the connection to the agent is lost from the Rancher server. Since the agent is not accessible, the host is marked as "reconnecting". At this time all that's known is that Rancher server can't connect to the host agent for that host. Health checking in Rancher is done against the container itself and not the host; as a result, the container would be unreachable to all of its active HAProxy instances. If the container is part of a service then Rancher restores the service to its pre-defined scale through its service HA functionality.

<br>
Depending on the result of health checks, a container is either in the green or red state. A service is in the green (or "up") state if all the containers implementing that service are in the green state, and alternatively, in the red (or "down") state if all the containers are subsequently in the red state.  A service is in the yellow (or "degraded") state if Rancher has detected that at least one of the containers is either in the red state or in the process of returning it to a green state.

The time taken to detect a failure is controlled through the 'interval' value, which is defined when creating the health check through either compose or the UI.

> **Note:** The failure recovery actions are only executed after the container has become _green_. That is if a service has a long start-up time, the container won't be immediately restarted because the service takes longer than 2000ms to start. The Health Check first need to turn the container green before taking any other actions.
