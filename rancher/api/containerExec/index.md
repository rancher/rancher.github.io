---
title: API
layout: rancher-default
---

## containerExec

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
attachStdin | boolean | Optional | - | true | The attachStdin for the containerExec
attachStdout | boolean | Optional | - | true | The attachStdout for the containerExec
command | array[string] | Yes | - | - | The command for the containerExec
tty | boolean | Optional | - | true | The tty for the containerExec






### Actions



<span class="action">
<span class="header">
Create
<span class="headerright">POST:  <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %} 
{

	"attachStdin": true,

	"attachStdout": true,

	"command": "[string, string, string...]",

	"tty": true

} 
{% endhighlight %}
</div>
</span>













​