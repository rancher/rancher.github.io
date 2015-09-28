---
title: Health Checks with Rancher
layout: rancher-default

---

#### Health Checks

Rancher implements a health monitoring system by running managed network agent's across it's hosts to co-ordinate the distributed health checking of containers and services. These network agents internally utilize HAProxy to validate the health status of your applications. When health checks are enabled either on an individual container or a service, each container is then monitored by up to three network agents running on hosts seperate to that containers parent host. The container is considered healthy if at least one HAProxy instance reports a "passed" health check.

> **Note:** The only exception to this model is when your environment contains a single host, in this instance the health checks will be performed by the same host.

Rancher’s approach handles network partitions and is more efficient than client-based health checks. By using HAProxy to perform health checks, Rancher enables users to specify the same health check policy across applications and load balancers.

### Failure Scenarios

Scenario | Response
----|----
* The container being monitored stops responding to health checks. | All active HAProxy instances monitoring the container would detect the failure and mark the container as "unhealthy". If the container is part of a service then rancher will restore the service to it's pre-defined scale through it's service HA functionality.
* A host running containers with health checks enabled, loses network connectivity or the agent on that host. | When network connectivity is lost to a host, the connection to the agent is lost from the rancher server. Since the agent is not accessible, the host is marked as "reconnecting". At this time all that's known is that rancher server can't connect to the host agent for that host. Health checking in rancher is done against the container it's self and not the host, as a result the container would be uncontactable by all of it's active HAProxy instances. If the container is part of a service then rancher will restore the service to it's pre-defined scale through it's service HA functionality.
* A host running containers with health checks enabled, has a complete failure. | When a host suffers a complete failure such as a power outage, the connection to the agent is lost from the rancher server. Since the agent is not accessible, the host is marked as "reconnecting". At this time all that's known is that rancher server can't connect to the host agent for that host. Health checking in rancher is done against the container it's self and not the host, as a result the container would be uncontactable by all of it's active HAProxy instances. If the container is part of a service then rancher will restore the service to it's pre-defined scale through it's service HA functionality.
* A Host's agent fails but host remains online and the containers are running and are passing health checks. | In this instance, as above, the connection to the agent is lost from the rancher server. Since the agent is not accessible, the host is marked as "reconnecting". At this time all that's known is that rancher server can't connect to the host agent for that host. Health checking in rancher is done against the container it's self and not the host, as a result the container would be uncontactable by all of it's active HAProxy instances. If the container is part of a service then rancher will restore the service to it's pre-defined scale through it's service HA functionality.

Depending on the result of health checks, a container is either in a green or red state. A service is in green (or "up") state if all containers implementing that service are in a green state and alternatively, in a red (or "down") state if all containers are subsequently in a red state.  A service is in yellow (or "degraded") state if Rancher has detected that at least one of the containers is either in a red state or in the process of returning it to a green state.

The time taken to detect a failure is controlled through the 'interval' value, this is defined when creating the health check through either compose or the UI.

Read more about how to set up health checks using [rancher-compose]({{site.baseurl}}/rancher/rancher-compose/rancher-services/#health-check-for-services) or in the [UI]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/adding-services/#health-checks).