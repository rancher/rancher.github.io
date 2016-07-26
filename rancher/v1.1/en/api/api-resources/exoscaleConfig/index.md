---
title: API
layout: rancher-default
version: latest
lang: en
---

## exoscaleConfig

The configuration to launch an instance in exoscale using [machine]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/machine). Rancher is calling `docker-machine`, so any available options in `docker-machine` for specific drivers are exposed in Rancher. The default fields from `docker-machine` are not listed in the Rancher API, and they can be found in the `docker-machine` documentation. The notes on which fields are **required** are from the `docker-machine` documentation.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | Yes | - | <strong>required</strong> Your API key
apiSecretKey | string | Optional | Yes | - | <strong>required</strong> Your API secret key
availabilityZone | string | Optional | Yes | - | The exoscale availability zone
diskSize | string | Optional | Yes | - | The disk size for the host in GB
image | string | Optional | Yes | - | The image name for exoscale
instanceProfile | string | Optional | Yes | - | The instance profile
securityGroup | array[string] | Optional | Yes | - | The security group to use in exoscale, which will be created if it doesn’t exist
url | string | Optional | Yes | - | Your API endpoint


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/exoscaleConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"apiKey": "string",

	"apiSecretKey": "string",

	"availabilityZone": "string",

	"diskSize": "string",

	"image": "string",

	"instanceProfile": "string",

	"securityGroup": [

		"string1",

		"string2",

		"...stringN"

	],

	"url": "string"

} 
{% endhighlight %}
</div>
</div>










