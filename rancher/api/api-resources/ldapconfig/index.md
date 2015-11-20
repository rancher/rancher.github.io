---
title: API
layout: rancher-default
---

## ldapconfig

Collection Test Description
​
### Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
accessMode | enum | Yes | - | unrestricted | The accessMode for the ldapconfig
domain | string | Yes | - | - | The domain for the ldapconfig
enabled | boolean | Optional | - | - | The enabled for the ldapconfig
groupNameField | string | Yes | - | name | The groupNameField for the ldapconfig
groupObjectClass | string | Yes | - | group | The groupObjectClass for the ldapconfig
groupSearchField | string | Yes | - | sAMAccountName | The groupSearchField for the ldapconfig
loginDomain | string | Optional | - | - | The loginDomain for the ldapconfig
port | int | Yes | - | 389 | cluster
server | string | Yes | - | - | The server for the ldapconfig
serviceAccountPassword | string | Yes | - | - | The serviceAccountPassword for the ldapconfig
serviceAccountUsername | string | Yes | - | - | The serviceAccountUsername for the ldapconfig
tls | boolean | Yes | - | - | The tls for the ldapconfig
userDisabledBitMask | int | Optional | - | 2 | The userDisabledBitMask for the ldapconfig
userEnabledAttribute | string | Optional | - | userAccountControl | The userEnabledAttribute for the ldapconfig
userLoginField | string | Yes | - | sAMAccountName | The userLoginField for the ldapconfig
userNameField | string | Yes | - | name | The userNameField for the ldapconfig
userObjectClass | string | Yes | - | person | The userObjectClass for the ldapconfig
userSearchField | string | Yes | - | sAMAccountName | The userSearchField for the ldapconfig




### Common Resource Fields

Field | Type | Create | Update | Default | Description
---|---|---|---|---|---
name | string | - | - | - | The name for the ldapconfig




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

	"domain": "string",

	"enabled": true,

	"groupNameField": "name",

	"groupObjectClass": "group",

	"groupSearchField": "sAMAccountName",

	"loginDomain": "string",

	"port": 389,

	"server": "string",

	"serviceAccountPassword": "string",

	"serviceAccountUsername": "string",

	"tls": true,

	"userDisabledBitMask": 2,

	"userEnabledAttribute": "userAccountControl",

	"userLoginField": "sAMAccountName",

	"userNameField": "name",

	"userObjectClass": "person",

	"userSearchField": "sAMAccountName"

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
{} 
{% endhighlight %}
</div>
</span>









​