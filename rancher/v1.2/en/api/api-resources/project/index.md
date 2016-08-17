---
title: Rancher API - project
layout: rancher-api-default
version: v1.2
lang: en
---

## Project

A "project" in the API is referred to as an environment in the UI and Rancher documentation. In the API documentation, we'll use the UI terminology.  All hosts and any Rancher resources (i.e. containers, load balancers, etc.) are created and belong to an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/).  Access control to who can view and manage these resources are then defined by the owner of the environment.  Rancher currently supports the capability for each user to manage and invite other users to their environment and allows for the ability to create multiple environments for different workloads.  For example, you may want to create a "dev" environment and a separate "production" environment with its own set of resources and limited user access for your application deployment.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the project
kubernetes | boolean | Optional | Yes | - | 
members | array[[projectMember]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/projectMember/)] | Optional | - | - | 
mesos | boolean | Optional | Yes | - | 
name | string | Optional | Yes | - | 
publicDns | boolean | Optional | Yes | - | 
servicesPortRange | [servicesPortRange]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/servicesPortRange/) | Optional | Yes | - | 
swarm | boolean | Optional | Yes | - | 
virtualMachine | boolean | Optional | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.



### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/projects/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/account/">account</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/projects/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/account/">account</a> resource</span>
</div></div>

<div class="action">
<span class="header">
setmembers
<span class="headerright">POST:  <code>/v1/projects/${ID}?action=setmembers</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong> setProjectMembersInput</span>

<br>{% highlight json %}{
	"members": "array[projectMember]"
}{% endhighlight %}<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/setProjectMembersInput/">setProjectMembersInput</a> resource</span>
</div></div>


