---
title: Rancher API - storagePool
layout: rancher-api-default
version: latest
lang: en
---

## StoragePool

A storage pool is a list of hosts that can participate in shared storage.

### Resource Fields

Field | Type | Create | Update | Default | Notes
---|---|---|---|---|---
blockDevicePath | string | - | - | - | 
description | string | Optional | Yes | - | 
driverName | string | - | - | - | 
externalId | string | - | - | - | 
id | int | - | - | - | The unique identifier for the storagePool
name | string | Optional | Yes | - | 
volumeAccessMode | string | - | - | - | 
volumeCapabilities | array[string] | - | - | - | 

<br>
Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.



### Actions
<div class="action">
<span class="header">
activate
<span class="headerright">POST:  <code>/v1/storagePools/${ID}?action=activate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/storagePool/">storagePool</a> resource</span>
</div></div>

<div class="action">
<span class="header">
deactivate
<span class="headerright">POST:  <code>/v1/storagePools/${ID}?action=deactivate</code></span></span>
<div class="action-contents">

<br>
<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/storagePool/">storagePool</a> resource</span>
</div></div>


