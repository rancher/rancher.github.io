---
title: API
layout: rancher-default-v1.0
version: v1.0
lang: zh
---

## packetConfig

The configuration to launch an instance in Packet.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiKey | string | Optional | Yes | - | <strong>required</strong> Your API key
billingCycle | string | Optional | Yes | - | The billing cycle to use for Packet instances
facilityCode | string | Optional | Yes | - | The region or facility code to launch packet
os | string | Optional | Yes | - | The OS to install
plan | string | Optional | Yes | - | The Packet server plan
projectId | string | Optional | Yes | - | The Packet project ID of where to launch your instance


Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.


### Operations
{::options parse_block_html="true" /}



<div class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/packetConfig</code></span></span>
<div class="action-contents">
{% highlight json %} 
{

	"apiKey": "string",

	"billingCycle": "string",

	"facilityCode": "string",

	"os": "string",

	"plan": "string",

	"projectId": "string"

} 
{% endhighlight %}
</div>
</div>










