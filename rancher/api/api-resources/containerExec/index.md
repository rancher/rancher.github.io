---
title: API
layout: rancher-default
---

## containerExec

Collection Test Description

​
### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
attachStdin | boolean | Optional | - | true | Attach to standard in stream. <code>-a stdin</code> in a <code>docker run</code> command
attachStdout | boolean | Optional | - | true | Attach to standard out stream. <code>-a stdout</code> in a <code>docker run</code> command
command | array[string] | Yes | - | - | Overwrite the default commands set by the image
tty | boolean | Optional | - | true | Allocate a pseudo-tty. <code>-t</code> in a <code>docker run</code> command

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/api/common/). 
These fields are read only and applicable to almost every resource. We have segregated them from the list above.
​

### Operations



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>/v1/containerExec</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"attachStdin": true,

	"attachStdout": true,

	"command": [

		"string1",

		"string2",

		"...stringN"

	],

	"tty": true

} 
{% endhighlight %}
</div>
</span>












​