---
title: Scheduling with Rancher
layout: rancher-default

---

## Container Scheduling in Rancher

Rancher supports container scheduling policies that are modeled closely after Docker Swarm.  They include scheduling based on:

* port conflicts
* shared volumes
* host tagging
* shared network stack: --net=container:dependency
* strict and soft affinity/anti-affinity rules using both env var (Swarm) and labels (Rancher)

In addition, Rancher supports scheduling service triggers that allow users to specify rules such as on "host add" or "host label" to automatically scale services onto hosts with specific labels.

Read more about how to use scheduling with [rancher-compose]({{site.baseurl}}/rancher/rancher-compose/scheduling/), or in the [UI]({{site.baseurl}}/rancher/rancher-ui/scheduling/).

### Similarities and differences to/from Docker Swarm

Much thought was taken into trying to keep Rancher's scheduler compatible with Docker Swarm's scheduling; however, there are some differences.  Perhaps, the most noteable is that Swarm currently uses environment variables to specify the scheduling rules.  See <a href="https://docs.docker.com/swarm/scheduler/filter/">Swarm scheduling/filters</a> for more details.  Although, we've mainly covered using labels for specifying the scheduling rules in Rancher above, Rancher also supports many of Swarm's scheduling rules via environment variables.

<table>
<tr><th>Swarm</th><th>Rancher</th></tr>
<tr><td>
Swarm's <strong>Constraint Filter</strong> allows containers to be deployed to a specific docker daemon.  When starting up a docker daemon, it's possible to associate labels to it.<br/><br/>
For example:<br/>
<code>$ docker -d --label storage=ssd</code><br/><br/>
The same label can also be applied to other docker daemons to essentially create a group of available hosts.  To target a docker container to be deployed to docker daemons with this label using Swarm, you can specify the environment variable.<br/><br/>
From the command line:<br/>
<code>$ docker run -d -P -e constraint:storage==ssd --name db mysql</code><br/><br/>
 or within a <code>compose.yml</code> file:<br/>
<pre>
  environment:
    constraint:storage==ssd
</pre>
</td><td>
In Rancher, instead of applying labels to docker daemons, you can specify and update the labels for individual hosts.<br/><br/>
For specifying <strong>host affinity</strong>, you can use the same environment variable as Swarm.  Alternatively, you can specify host affinity using the label <code>io.rancher.scheduler.affinity:host_label: key=value</code><br/><br/>
Within a <code>compose.yml</code> file:<br/>
<pre>
  labels:
    - "io.rancher.scheduler.affinity:host_label: storage=ssd"
</pre>
</td></tr>
<tr><td>
<strong>Container affinity</strong> can be achieved with the environment variable <code>affinity:container==frontend</code> where <code>frontend</code> specifies the name of a container
</td><td>
Rancher supports the same environment variable syntax used by Swarm, in addition to the label syntax described in the previous section
</td></tr>
<tr><td>
<strong>Container label affinity</strong> can be specified using the environment variable <code>affinity:com.example.type==frontend</code> where the container label is <code>com.example.type==frontend</code>
</td><td>
Rancher's environment variable for specifying container label affinity is slightly different.  Using the same example, it would look like: <code>affinity:container_label:com.example.type==frontend</code>.  Although, Rancher tries to stay compatible with Docker as much as possible, both stacks are being developed and changing at an incredible pace and minor differences occasionally occurs.
</td></tr>
</table>

_Rancher supports the same hard/soft affinity syntax used in environment variables as Swarm._

_Unfortunately, Rancher currently does not support globbing or regular expression for matching when specifying the affinity scheduling rules._


### Other similarities/differences between Rancher's scheduler and Swarm's scheduler

#### Similarities

**Ports and dependency filters**: Swarm's scheduler tries to avoid port conflicts and co-locate containers to the same host for:

- shared volumes (`--volumes-from=dependency`)
- links (`--link=dependency:alias`)
- shared network stack (`--net=container:dependency`)

Similarly, Rancher tries to avoid port conflicts and co-locate containers according to their dependencies

#### Differences

**Image affinity** allows you to schedule a container to run only on nodes where a specific image is already pulled.  _This is currently not supported by Rancher._

Swarm provides a set of **Standard Constraints** that are based off the information from doing a `docker info`.  These include:

- node ID
- storagedriver
- executiondriver
- kernelversion
- operatingsystem.

_This is currently not supported by Rancher._

Swarm's filter tries to provide an available host that fulfills various <a href="https://docs.docker.com/reference/run/#runtime-constraints-on-cpu-and-memory">rresource requirements</a> for the container.  For example: `$ docker run -ti -m 300M ubuntu:14.04 /bin/bash` specifies to run on a host that has a minimum of 300MB.

_This is currently not supported by Rancher._
