---
title: API
layout: rancher-default
version: latest
lang: en
---

## ubiquityConfig

The configuration to launch a server in Ubiquity Hosting.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiToken | string | Optional | Yes | - | <strong>required</strong> Your Ubiquity Hosting Access Key
apiUsername | string | Optional | Yes | - | <strong>required</strong> Your Ubiquity Hosting Remote ID
clientId | string | Optional | Yes | - | <strong>required</strong> Your Ubiquity Hosting API Client ID
flavorId | string | Optional | Yes | - | The ID of the flavor that will be used for the machine
imageId | string | Optional | Yes | - | The ID of the image that will be used for the machine
zoneId | string | Optional | Yes | - | The ID of the zone that will be used for the machine


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/ubiquityConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"apiToken": "string",

	"apiUsername": "string",

	"clientId": "string",

	"flavorId": "string",

	"imageId": "string",

	"zoneId": "string"

} 
{% endhighlight %}
</div>
</div>










