---
title: Rancher API - machineDriver
layout: rancher-api-default
version: v1.2
lang: en
---

## MachineDriver



### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
activateOnCreate | boolean | Optional | - | - | 
builtin | boolean | Optional | - | - | 
checksum | string | Optional | Yes | - | 
defaultActive | boolean | - | - | - | 
description | string | Optional | Yes | - | 
externalId | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the machineDriver
name | string | - | - | - | 
uiUrl | string | Optional | Yes | - | 
url | string | Yes | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.



### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/machineDrivers/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/machineDrivers/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machineDriver/">machineDriver</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/machineDrivers/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/machineDrivers/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machineDriver/">machineDriver</a> resource</span>
</div></div>

<div class="action">
<span class="header">
reactivate
<span class="headerright">POST:  <code>/v1/machineDrivers/${ID}?action=reactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/machineDrivers/${ID}?action=reactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machineDriver/">machineDriver</a> resource</span>
</div></div>


