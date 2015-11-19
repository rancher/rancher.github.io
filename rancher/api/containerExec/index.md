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
attachStdin | boolean | Optional | - | true | 
attachStdout | boolean | Optional | - | true | 
command | array[string] | Yes | - | - | 
tty | boolean | Optional | - | true | 





### Operations



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