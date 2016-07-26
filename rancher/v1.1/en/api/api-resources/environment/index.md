---
title: API
layout: rancher-default
version: latest
lang: en
---

## environment

An "environment" in the API is referred to as a stack in the UI and the Rancher documentation. In the API documentation, we'll use the UI terminology. A Rancher stack mirrors the same concept as a Docker Compose project. It represents a group of services that make up a typical application or workload.

### Resource Fields

| Field                 | Type          | Create   | Update | Default | Notes |
| --------------------- | ------------- | :------: | :----: | :-----: | ----- |
| `description`         | `string`      | Optional | Yes    | -       | |
| `dockerCompose`       | `string`      | Optional | -      | -       | The `docker-compose.yml` file for the stack. |
| `environment`         | `map[string]` | Optional | -      | -       | |
| `externalId`          | `string`      | Optional | Yes    | -       | Arbitrary string. If it's of the form `catalog://<template-id>`, then it's used by the UI to determine if upgrades to the stack from a new version of the catalog template are available. |
| `healthState`         | `string`      | -        | -      | -       | |
| `id`                  | `int`         | -        | -      | -       | The unique identifier for the environment. |
| `name`                | `string`      | Yes      | Yes    | -       | Name of the stack. |
| `outputs`             | `map[string]` | Optional | Yes    | -       | Not used. |
| `previousEnvironment` | `map[string]` | Optional | Yes    | -       | Stores the previous `environment` map during an upgrade. |
| `previousExternalId`  | `string`      | Optional | Yes    | -       | Stores the previous `externalID` during an upgrade. |
| `rancherCompose`      | `string`      | Optional | -      | -       | The `rancher-compose.yml` file for the stack. |
| `startOnCreate`       | `boolean`     | Optional | -      | -       | Whether or not the services in the stack should automatically started after creation. |

Please read more about the [common resource fields]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/common/). These fields are read only and applicable to almost every resource. We have segregated them from the list above.

### Operations
{::options parse_block_html="true" /}

<div class="action">
<span class="header">
Create
<span class="headerright">POST: <code>/v1/environment</code></span>
</span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"dockerCompose": "string",
	"environment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"externalId": "string",
	"name": "string",
	"outputs": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousEnvironment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousExternalId": "string",
	"rancherCompose": "string",
	"startOnCreate": true
}
{% endhighlight %}
</div>
</div>

<div class="action">
<span class="header">
Update
<span class="headerright">PUT: <code>${links.self}</code></span>
</span>
<div class="action-contents">
{% highlight json %}
{
	"description": "string",
	"externalId": "string",
	"name": "string",
	"outputs": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousEnvironment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"previousExternalId": "string"
}
{% endhighlight %}
</div>
</div>

<div class="action">
<span class="header">
Delete
<span class="headerright">DELETE: <code>${links.self}</code></span></span>
<div class="action-contents">
{% highlight json %}

{% endhighlight %}
</div>
</div>

### Actions

<div class="action">
<span class="header">
activateservices
<span class="headerright">POST: <code>${actions.activateservices}</code></span></span>
<div class="action-contents">
To activateservices the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
addoutputs
<span class="headerright">POST: <code>${actions.addoutputs}</code></span></span>
<div class="action-contents">
To addoutputs the environment
<br>

<span class="input">
<strong>Input:</strong> addOutputsInput
</span>

| Field     | Type          | Required | Default | Notes |
| --------- | ------------- | :------: | ------- | ----- |
| `outputs` | `map[string]` | Yes      |         |       |

{% highlight json %}
{
	"outputs": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	}
}
{% endhighlight %}

<br>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
cancelrollback
<span class="headerright">POST: <code>${actions.cancelrollback}</code></span></span>
<div class="action-contents">
To cancelrollback the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
cancelupgrade
<span class="headerright">POST: <code>${actions.cancelupgrade}</code></span></span>
<div class="action-contents">
To cancelupgrade the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
deactivateservices
<span class="headerright">POST: <code>${actions.deactivateservices}</code></span></span>
<div class="action-contents">
To deactivateservices the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
error
<span class="headerright">POST: <code>${actions.error}</code></span></span>
<div class="action-contents">
To error the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
exportconfig
<span class="headerright">POST: <code>${actions.exportconfig}</code></span></span>
<div class="action-contents">
To exportconfig the environment

<span class="input">
<strong>Input:</strong> composeConfigInput
</span>

| Field        | Type                        | Required | Default | Notes |
| ------------ | --------------------------- | :------: | ------- | ----- |
| `serviceIds` | `array[reference[service]]` | No       |         | The list of Service IDs in the `docker-compose.yml`. |


{% highlight json %}
{
	"serviceIds": "array[reference[service]]"
}
{% endhighlight %}

<br>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/composeConfig/">composeConfig</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
finishupgrade
<span class="headerright">POST: <code>${actions.finishupgrade}</code></span></span>
<div class="action-contents">
To finishupgrade the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
remove
<span class="headerright">POST: <code>${actions.remove}</code></span></span>
<div class="action-contents">
To remove the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
rollback
<span class="headerright">POST: <code>${actions.rollback}</code></span></span>
<div class="action-contents">
To rollback the environment

<span class="input">
<strong>Input:</strong>This action has no inputs</span>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>

<div class="action">
<span class="header">
upgrade
<span class="headerright">POST: <code>${actions.upgrade}</code></span></span>
<div class="action-contents">
To upgrade the environment

<span class="input">
<strong>Input:</strong> environmentUpgrade
</span>

| Field            | Type          | Required | Default | Notes |
| ---------------- | ------------- | :------: | ------- | ----- |
| `dockerCompose`  | `string`      | No       |         | The `docker-compose.yml` file for the stack. |
| `environment`    | `map[string]` | No       |         | |
| `externalId`     | `string`      | No       |         | |
| `rancherCompose` | `string`      | No       |         | The `rancher-compose.yml` file for the stack. |

{% highlight json %}
{
	"dockerCompose": "string",
	"environment": {
		"key1": "value1",
		"key2": "value2",
		"keyN": "valueN"
	},
	"externalId": "string",
	"rancherCompose": "string"
}
{% endhighlight %}

<br>

<span class="output"><strong>Output:</strong> An updated copy of the <a href="/rancher/api/api-resources/environment/">environment</a> resource</span>
</div>
</div>
