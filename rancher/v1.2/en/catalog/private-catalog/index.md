---
title: Creating Private Catalogs
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/catalog/private-catalog/
---

## Creating Private Catalogs
---

The Rancher catalog service requires private catalogs to be structured in a specific format in order for the catalog service to be able to translate it into Rancher.

### Template Folders

Catalog templates are displayed in Rancher based on what container orchestration type that was selected for the environment.

#### Templates based on Orchestration type

* _Cattle_ orchestration: Entries in the UI are from the `templates` folder
* _[Kubernetes]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/)_ orchestration: Entries in the UI are from the `kubernetes-templates` folder
* _[Swarm]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/swarm/)_ orchestration: Entries in the UI are from the `swarm-templates` folder
* _[Mesos]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/mesos/)_ orchestration: Entries in the UI are from the `mesos-templates` folder

### Infrastructure Services Templates

The [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) that are available to be enabled in an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), are from the `infra-templates` folder of any catalog enabled in Rancher.

These services are also available from the **Catalog** tab, and you will be able to see all the infrastructure services even though they may not work with the selected orchestration type. It's recommended to select infrastructure services during environment template creation versus launching them directly from the catalog.

### Directory Structure

```
-- templates (Or any of templates folder)
  |-- cloudflare
  |   |-- 0
  |   |   |-- docker-compose.yml
  |   |   |-- rancher-compose.yml
  |   |-- 1
  |   |   |-- docker-compose.yml
  |   |   |-- rancher-compose.yml
  |   |-- catalogIcon-cloudflare.svg
  |   |-- config.yml
...
```
<br>

In the main directory, you will need a `templates` folder. The `templates` folder will contain folders of each catalog entry that you have created. We recommend that each catalog entry have a simple template name as the folder name.

In the catalog entry folder (e.g. `cloudflare`), there will be folders for each version that you have created for your catalog entry. The first version should be `0` and each subsequent version will be an incremental value. For example, version 2 will be in the `1` folder. By providing a new version folder number, it provides a way to upgrade your stack from a previous version of the template. Alternatively, you could update the templates in the `0` folder and just re-deploy the entry.

> **Note:** Each catalog entry will need to be a single word, so please use `-` instead of spaces for longer catalog names. You can use spaces in the `name` section of the `config.yml`.

### Rancher Catalog Files to Display in Rancher Catalog

Within the catalog entry folder, the details of how to display your catalog entry in the Rancher catalog are located in two files.

* The first file `config.yml` contains the details of your entry.

```yaml
name: # Name of the Catalog Entry
description: |
  # Description of the Catalog Entry
version: # Version of the Catalog to be used
category: # Category to be used for searching catalog entries
maintainer: # The maintainer of the catalog entry
license: # The license
projectURL: # A URL related to the catalog entry
```
<br>

* The second file is the icon image for the catalog entry. The file must be prefixed with `catalogIcon-`.

For every catalog entry, there will be a minimum of three items: `config.yml`, `catalogIcon-entry.svg`, and the `0` folder, which holds the first version of the catalog entry.

### Rancher Catalog Templates

The `docker-compose.yml` and `rancher-compose.yml` are the **required** files to be able to launch the services in Rancher using [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/#adding-services-with-rancher-compose). These files are located within the version folder number (i.e. `0`, `1`, etc.).

The `docker-compose.yml` should be a file that could also be launched using `docker-compose up`. The services follow the docker-compose format.

The `rancher-compose.yml` will contain additional information to help customize your catalog entries. In the `catalog` section, there are some fields that will be required in order to have your catalog entry interpreted correctly.

An optional `README.md` is possible to be created, which provides a lengthy description or notes on how to use the catalog service.


**`rancher-compose.yml`**

```yaml
version: '2'
catalog:
  name: # Name of the versioned template of the Catalog Entry
  version: # Version of the versioned template of the Catalog Entry
  description: # Description of the versioned template of the Catalog Entry
  minimum_rancher_version: # The minimum version of Rancher that supports the template, v1.0.1 and 1.0.1 are acceptable inputs
  maximum_rancher_version: # The maximum version of Rancher that supports the template, v1.0.1 and 1.0.1 are acceptable inputs
  upgrade_from: # The previous versions that this template can be upgraded from
  questions: #Used to request user input for configuration options
```
<br>

For `upgrade_from`, there are three types of values that can be used.

1. Allowing upgrading only from 1 version: `1.0.0`
2. Being able to select higher or lower than a specific version: `>=1.0.0.`, `<=2.0.0`
3. Being able to define a [range of versions](https://github.com/blang/semver#ranges): `>1.0.0 <2.0.0 || >3.0.0`

### Questions in the `rancher-compose.yml`

The `questions` section of `catalog` is used to allow the user to change the configuration options of the services. The `answers` would be populated within the `docker-compose.yml` before the services are launched.

Each configuration option is a list item in the `questions` section of the `rancher-compose.yml`.

```yaml
version: '2'
catalog:
  questions:
    - variable: # A single word that is used to pair the question and answer.
      label: # The "question" to be answered.
      description: | # The description of the question to show the user how to answer the question.
      default: # (Optional) A default value that will be pre-populated into the UI
      required: # (Optional) Whether or not an answer is required. By default, it's considered `false`.
      type: # How the questions are formatted and types of response expected
```
<br>

#### Type

The `type` section controls how the questions are formatted in the UI as well as the types of responses that are expected.

Eligible formats are:

* `string` A textbox will be shown in the UI to capture the answer, and the answer will be formatted to a string.
* `int` A textbox will be shown in the UI to capture the answer, and the answer will be formatted to a number. The UI will validate whether or not it's a valid number before launching the template.
* `boolean` A radio button will be shown in the UI to capture the answer, and the answer will be formatted to `true` or `false`. If the radio button is selected, the answer will be formatted to `true`.
* `password` A textbox will be shown in the UI to capture the answer, and the answer will be formatted to a string.
* `service` A drop-down of all services in the environment will be displayed.
* `enum` A drop-down menu will be shown in the UI and the `options` section will be populated in the drop-down.

```yaml
version: '2'
catalog:
  questions:
    - variable:
      label:
      description: |
      type: enum   
      options: # List of options if using type of `enum`
        - Option 1
        - Option 2
```

* `multiline` A multiple line textbox will be shown in the UI.

```yaml
version: '2'
catalog:
  questions:
    - variable:
      label:
      description: |
      type: multiline
      default: |
        Each line
        would be shown
        on a separate
        line.
```

* `certificate` A drop down of all available certificates in the environment.

```yaml
version: '2'
catalog:
  questions:
    - variable:
      label:
      description: |
      type: certificate
```

### Catalog Generator based on Yeoman

There is an [open-source project](https://github.com/slashgear/generator-rancher-catalog) based on [Yeoman](http://yeoman.io/), that can be used to create the templates of an empty catalog entry.
