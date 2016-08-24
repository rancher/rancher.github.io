---
title: Rancher API - account
layout: rancher-api-default
version: v1.2
lang: en
---

## Account

All resources in Rancher are owned or created by an account.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
description | string | Optional | Yes | - | 
id | int | - | - | - | The unique identifier for the account
name | string | Optional | Yes | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.



### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/accounts/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/accounts/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/">account</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/accounts/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>
<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/accounts/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-resources/account/">account</a> resource</span>
</div></div>




### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/accounts/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
To create a new account, send a POST request to <code>/v1/accounts/${ID}?action=activate</code>.

</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/accounts/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
To create a new account, send a POST request to <code>/v1/accounts/${ID}?action=deactivate</code>.

</div></div>


