---
title: Rancher API - host
layout: rancher-api-v1-default-v1.6
version: v1.6
lang: en
apiVersion: v1
#redirect_from:
#  - /rancher/v1.6/zh/api/v1/api-resources/host/
---

## Host

Hosts are the most basic unit of resource within Rancher and is represented as any Linux server, virtual or physical, with the following minimum requirements. <br> <br> * Any modern Linux distribution with a [supported version of Docker]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#supported-docker-versions). <br> * Must be able to communicate with the Rancher server via http or https through the pre-configured port (Default is 8080). <br> * Must be routable to any other hosts belonging to the same environment to leverage Rancher's cross-host networking for Docker containers.<br> <br> Rancher also supports Docker Machine and allows you to add your host via any of its supported drivers.

### Resource Fields

#### Writeable Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
apiProxy | string | - | Yes | - | 
description | string | Optional | Yes | - | 
name | string | Optional | Yes | - | 


#### Read Only Fields

Field | Type   | Notes
---|---|---
agentId | [agent]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/agent/)  | The unique identifier of the associated agent
agentState | string  | 
amazonec2Config | [amazonec2Config]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/amazonec2Config/)  | 
authCertificateAuthority | string  | 
authKey | string  | 
azureConfig | [azureConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/azureConfig/)  | 
computeTotal | int  | 
data | map[json]  | 
digitaloceanConfig | [digitaloceanConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/digitaloceanConfig/)  | 
dockerVersion | string  | 
driver | string  | 
engineEnv | map[string]  | 
engineInsecureRegistry | array[string]  | 
engineInstallUrl | string  | 
engineLabel | map[string]  | 
engineOpt | map[string]  | 
engineRegistryMirror | array[string]  | 
engineStorageDriver | string  | 
hostTemplateId | [hostTemplate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostTemplate/)  | 
hostname | string  | 
id | int  | The unique identifier for the host
info | json  | 
labels | map[string]  | A map of key value pairs to be used as labels for the host
packetConfig | [packetConfig]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/packetConfig/)  | 
physicalHostId | [physicalHost]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/physicalHost/)  | 
publicEndpoints | array[[publicEndpoint]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/publicEndpoint/)]  | 


<br>

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.




### Actions

<div class="action" id="activate">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}?action=activate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/">host</a> resource</span>
</div></div>

<div class="action" id="deactivate">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}?action=deactivate'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host/">host</a> resource</span>
</div></div>

<div class="action" id="dockersocket">
<span class="header">
dockersocket
<span class="headerright">POST:  <code>/v1/projects/${PROJECT_ID}/hosts/${ID}?action=dockersocket</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<br>
{% highlight json %}
curl -u "${RANCHER_ACCESS_KEY}:${RANCHER_SECRET_KEY}" \
-X POST \
'http://${RANCHER_URL}:8080/v1/projects/${PROJECT_ID}/hosts/${ID}?action=dockersocket'
{% endhighlight %}
<br>
<span class="output"><strong>Output:</strong> An updated copy of the <a href="{{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/hostAccess/">hostAccess</a> resource</span>
</div></div>


