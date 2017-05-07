---
title: Rancher API - openldapconfig
layout: rancher-api-v2-beta-default-v1.6
version: v1.6
lang: en
apiVersion: v2-beta
#redirect_from:
#  - /rancher/v1.6/zh/api/v2-beta/api-resources/openldapconfig/
---

## Openldapconfig



### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
accessMode | string | Yes | - | unrestricted | 
allowedIdentities | array[[identity]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/identity/)] | Optional | - | - | 
connectionTimeout | int | Yes | - | 1000 | 
domain | string | Yes | - | - | 
enabled | boolean | Optional | - | - | 
groupDNField | string | Optional | - | entryDN | 
groupMemberMappingAttribute | string | Yes | - | memberUid | 
groupMemberUserAttribute | string | Optional | - | entryDN | 
groupNameField | string | Yes | - | cn | 
groupObjectClass | string | Yes | - | posixGroup | 
groupSearchDomain | string | Optional | - | - | 
groupSearchField | string | Yes | - | cn | 
loginDomain | string | Optional | - | - | 
port | int | Yes | - | 389 | 
server | string | Yes | - | - | 
serviceAccountPassword | string | Yes | - | - | 
serviceAccountUsername | string | Yes | - | - | 
tls | boolean | Yes | - | - | 
userDisabledBitMask | int | Optional | - | - | 
userEnabledAttribute | string | Optional | - | - | 
userLoginField | string | Yes | - | uid | 
userMemberAttribute | string | Yes | - | memberOf | 
userNameField | string | Yes | - | givenName | 
userObjectClass | string | Yes | - | inetOrgPerson | 
userSearchField | string | Yes | - | uid | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
name | string  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}
<a id="create"></a>
<div class="action"><span class="header">Create<span class="headerright">POST:  <code>/v2-beta/projects/${PROJECT_ID}/openldapconfigs</code></span></span>
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
	"groupDNField": "entryDN",
	"groupMemberMappingAttribute": "memberUid",
	"groupMemberUserAttribute": "entryDN",
	"groupNameField": "cn",
	"groupObjectClass": "posixGroup",
	"groupSearchDomain": "string",
	"groupSearchField": "cn",
	"loginDomain": "string",
	"port": 389,
	"server": "string",
	"serviceAccountPassword": "string",
	"serviceAccountUsername": "string",
	"tls": false,
	"userDisabledBitMask": 0,
	"userEnabledAttribute": "string",
	"userLoginField": "uid",
	"userMemberAttribute": "memberOf",
	"userNameField": "givenName",
	"userObjectClass": "inetOrgPerson",
	"userSearchField": "uid"
}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/openldapconfigs'
{% endhighlight %}
</div></div>
<a id="update"></a>
<div class="action"><span class="header">Update<span class="headerright">PUT:  <code>/v2-beta/projects/${PROJECT_ID}/openldapconfigs/${ID}</code></span></span>
<div class="action-contents"> {% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X PUT \
-H 'Content-Type: application/json' \
-d '{}' 'http://${RANCHER_URL}:8080/v2-beta/projects/${PROJECT_ID}/openldapconfigs/${ID}'
{% endhighlight %}
</div></div>



