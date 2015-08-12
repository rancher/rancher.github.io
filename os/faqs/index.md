---
title: FAQs
layout: os-default

---

## Frequently Asked Questions
---

###What is required to run RancherOS?

RancherOS runs on any laptop, physical, or virtual servers.

###What are some commands?

Command | Description
--------|------------
`docker`| Good old Docker, use that to run stuff.
`system-docker` | The docker instance running the system containers.  Must run as root or using `sudo`
`ros` | Control and configure RancherOS


### Why are my changes to the console being lost?

The console and all system containers are ephemeral.  This means on each reboot of the system all changes to the console are lost.  Any changes in `/home` or `/opt` will be persisted though.  Additionally, on startup of the console container, if `/opt/rancher/bin/start.sh` exists, it will be executed.  You can add anything to that script to configure your console the way you want it.

In the future, we will allow one to provide a custom image for the console container, but we just haven't gotten around yet to enabling that.
