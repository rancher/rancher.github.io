---
title: API
layout: rancher-default
---

## machine

Machines are created whenever Rancher uses `docker-machine` to create hosts in Rancher. Adding any type of host through the UI that is not the custom command option is calling `docker-machine` and a machine entry will be created as well as a [host]({{site.baseurl}}/rancher/api/api-resources/host).

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
authCertificateAuthority | string | Optional | - | - | 
authKey | string | Optional | - | - | 
description | string | Optional | Yes | - | 
dockerVersion | string | Optional | - | - | 
driver | string | - | - | - | 
engineEnv | map[string] | Optional | - | - | 
engineInsecureRegistry | array[string] | Optional | - | - | 
engineInstallUrl | string | Optional | - | - | 
engineLabel | map[string] | Optional | - | - | 
engineOpt | map[string] | Optional | - | - | 
engineRegistryMirror | array[string] | Optional | - | - | 
engineStorageDriver | string | Optional | - | - | 
externalId | string | - | - | - | 
id | int | - | - | - | The unique identifier for the machine
labels | map[string] | Optional | - | - | 
name | string | Yes | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/machine</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"authCertificateAuthority": "string",

	"authKey": "string",

	"description": "string",

	"dockerVersion": "string",

	"engineEnv": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"engineInsecureRegistry": [

		"string1",

		"string2",

		"...stringN"

	],

	"engineInstallUrl": "string",

	"engineLabel": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"engineOpt": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"engineRegistryMirror": [

		"string1",

		"string2",

		"...stringN"

	],

	"engineStorageDriver": "string",

	"labels": {

		"key1": "value1",

		"key2": "value2",

		"keyN": "valueN"

	},

	"name": "string"

} 
{% endhighlight %}
</div>
</span>















<span class="action">
<span class="header">
Delete
<span class="headerright">DELETE:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
 
{% endhighlight %}
</div>
</span>




​
### Actions

<span class="action">
<span class="header">
bootstrap
<span class="headerright">POST:  <code>${actions.bootstrap}</code></span>
</span>
<div class="action-contents">
To bootstrap the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
error
<span class="headerright">POST:  <code>${actions.error}</code></span>
</span>
<div class="action-contents">
To error the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

<span class="action">
<span class="header">
remove
<span class="headerright">POST:  <code>${actions.remove}</code></span>
</span>
<div class="action-contents">
To remove the machine
<br>

<span class="input">
<strong>Input:</strong>This action has no inputs
<br>

<br>
</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/physicalHost/">physicalHost</a> resource
</span>
</div>
</span>
</span>
</span>

