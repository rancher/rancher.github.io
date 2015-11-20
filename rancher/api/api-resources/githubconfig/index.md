---
title: API
layout: rancher-default
---

## githubconfig

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accessMode | enum | Yes | - | unrestricted | The accessMode for the githubconfig
allowedIdentities | array[identity] | Optional | - | - | The allowedIdentities for the githubconfig
clientId | string | Optional | - | - | The clientId for the githubconfig
clientSecret | string | Optional | - | - | The clientSecret for the githubconfig
enabled | boolean | Optional | - | - | The enabled for the githubconfig
hostname | string | Optional | - | - | The hostname for the githubconfig
scheme | string | Optional | - | - | The scheme for the githubconfig




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
name | string | Optional | Yes | - | The name for the githubconfig




### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"accessMode": "unrestricted",

	"allowedIdentities": "array[identity]",

	"clientId": "string",

	"clientSecret": "string",

	"enabled": true,

	"hostname": "string",

	"name": "string",

	"scheme": "string"

} 
{% endhighlight %}
</div>
</span>











<span class="action">
<span class="header">
Update
<span class="headerright">PUT:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"name": "string"

} 
{% endhighlight %}
</div>
</span>









​