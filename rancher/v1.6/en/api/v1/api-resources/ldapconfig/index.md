---
title: Rancher API - ldapconfig
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/ldapconfig/
---

## Ldapconfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessMode | enum | Yes | - | unrestricted | The options are `unrestricted`, `restricted`, `required`.
allowedIdentities | array[[identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity/)] | Optional | - | - | 
connectionTimeout | int | Yes | - | 1000 | 
domain | string | Yes | - | - | 
enabled | boolean | Optional | - | - | 
groupMemberMappingAttribute | string | Optional | - | memberOf | 
groupNameField | string | Yes | - | name | 
groupObjectClass | string | Yes | - | group | 
groupSearchField | string | Yes | - | sAMAccountName | 
loginDomain | string | Optional | - | - | 
port | int | Yes | - | 389 | 
server | string | Yes | - | - | 
serviceAccountPassword | string | Yes | - | - | 
serviceAccountUsername | string | Yes | - | - | 
tls | boolean | Yes | - | - | 
userDisabledBitMask | int | Optional | - | 2 | 
userEnabledAttribute | string | Optional | - | userAccountControl | 
userLoginField | string | Yes | - | sAMAccountName | 
userMemberAttribute | string | Optional | - | memberOf | 
userNameField | string | Yes | - | name | 
userObjectClass | string | Yes | - | person | 
userSearchField | string | Yes | - | sAMAccountName | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
name | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/ldapconfigs</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
-H 'Content-Type: application/json' \
-d '{
	"accessMode": "unrestricted",
	"allowedIdentities": "array[identity]",
	"connectionTimeout": 1000,
	"domain": "string",
	"enabled": false,
	"groupMemberMappingAttribute": "memberOf",
	"groupNameField": "name",
	"groupObjectClass": "group",
	"groupSearchField": "sAMAccountName",
	"loginDomain": "string",
	"port": 389,
	"server": "string",
	"serviceAccountPassword": "string",
	"serviceAccountUsername": "string",
	"tls": false,
	"userDisabledBitMask": 2,
	"userEnabledAttribute": "userAccountControl",
	"userLoginField": "sAMAccountName",
	"userMemberAttribute": "memberOf",
	"userNameField": "name",
	"userObjectClass": "person",
	"userSearchField": "sAMAccountName"
}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/ldapconfigs'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v1/projects/${PROJECT_ID}/ldapconfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{}' 'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/ldapconfigs/${ID}'
{% endhighlight %}
</div></div>



