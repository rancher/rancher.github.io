---
title: Rancher Catalog
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Rancher Catalog 
---

Rancher provides a catalog of application templates that make it easy to deploy these complex stacks. By accessing the **Catalog** tab, you can view all the templates that are available in the [enabled catalogs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#catalog). The **Library** catalog contains templates from the [Rancher certified catalog](https://github.com/rancher/rancher-catalog) and the [community-catalog](https://github.com/rancher/community-catalog). Rancher will only be maintaining support for the _certified_ templates in the library.

An [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) of Rancher has the ability to add or remove catalogs to Rancher. The catalogs within Rancher can be found at **Admin** -> **Settings**. Adding a catalog is as simple as adding a catalog name and a URL. The URL needs to one that `git clone` [can handle](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a). Whenever you add a catalog entry, it will be immediately available in your catalog.

If you are running Rancher server behind a proxy, you will need to [start Rancher with certain environment variables]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#http-proxy) in order for the Rancher catalog to work in Rancher.  

### Launching Templates 

Search for your desired template or use the filters for category or catalog. Once you have found your template, click on **Launch**. Fill in the required information for the template.

1. By default, latest **version** of a template is selected, but if desired, you could select an older version. 
2. Select a **stack** name and if desired, **description** of the stack. 
3. Fill in the **Configuration Options**, which are questions specific to the selected template. 
4. Click on **Create** to create the stack based on the template. You can review the `docker-compose.yml` and `rancher-compose.yml` files that are being used to generate the stacks by expanding **Preview** before creating the stack. 

After you click on **Create**, the stack is immediately created, but none of the services have started. Click on **Start Services** from the stack dropdown menu to start all the services of the stack. 

### Upgrading Templates

The great thing about Rancher is that if a newer version of a template has been uploaded to the catalog, we'll inform you that a newer version is available to upgrade to. When you click on **Upgrade Available**, you can select which version you want to upgrade to. After selecting the version, the **Configuration Options** will need to be reviewed before clicking on **Save**. 

After all the services have been upgraded, the stack and services will be in an **Upgraded** state. If you are satisfied with your upgrade, the last step is to confirm the upgrade by clicking on the **Finish Upgrade** in the stack dropdown menu. **Note: Once you have finished your upgrade, you will not be able to revert to the older version.**

#### Rolling back 

If something went wrong during your upgrade and you need to revert to the previous version, you would want to select **Rollback** in the stack dropdown menu. 

## Creating Private Catalogs
---

The Rancher catalog service requires private catalogs to be structured in a specific format in order for the catalog service to be able to translate it into Rancher. 

### Directory Structure

Catalog templates are displayed in Rancher based on what cluster management type of environment that you are in. 

* _Cattle_ environment: Entries in the UI are from the `templates` folder 
* _Kubernetes_ environment: Entries in the UI are from the `kubernetes-templates` folder 
* _Swarm_ environment: Entries in the UI are from the `swarm-templates` folder 

```
-- templates OR kubernetes-templates OR swarm-templates
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

#### Rancher Catalog Files to Display in Rancher Catalog

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
* The second file is a the icon image for the catalog entry. The file must be prefixed with `catalogIcon-`. 

For every catalog entry, there will be a minimum of three items: `config.yml`, `catalogIcon-entry.svg`, and the `0` folder, which holds the first version of the catalog entry. 

#### Rancher Catalog Templates

The `docker-compose.yml` and `rancher-compose.yml` are the **required** files to be able to launch the services in Rancher using [rancher-compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-compose/). These files are located within the version folder number (i.e. `0`, `1`, etc.). 

The `docker-compose.yml` should be a file that could also be launched using `docker-compose up`. The services follow the docker-compose format.

The `rancher-compose.yml` will contain additional information to help customize your catalog entries. In the `.catalog` section, there are some fields that will be required in order to have your catalog entry interpreted correctly.

An optional `README.md` is possible to be created, which provides a lengthy description or notes on how to use the catalog service. 


**`rancher-compose.yml`**

```yaml
.catalog:
  name: # Name of the versioned template of the Catalog Entry 
  version: # Version of the versioned template of the Catalog Entry 
  description: # Description of the versioned template of the Catalog Entry
  uuid: # Unique identifier to be used for upgrades. Please see note. 
  minimum_rancher_version: # The minimum version of Rancher that supports the template
  questions: #Used to request user input for configuration options
```
<br>

> **Note:** The `uuid` is a required parameter that is used for upgrade scenarios. Each `uuid` must be unique and each later version should be incremental. The recommended format is to use the name of the catalog entry and suffixed with a `-0`. As versions are introduced, you would increment the `-0` to `-1` for the next entry. 

#### Questions in the `rancher-compose.yml`

The `questions` section of `.catalog` is used to allow the user to change the configuration options of the services. The `answers` would be populated within the `docker-compose.yml` before the services are launched.

Each configuration option is a list item in the `questions` section of the `rancher-compose.yml`.

```yaml
.catalog:
  questions:
    - variable: # A single word that is used to pair the question and answer.
      label: # The "question" to be answered.
      description: | # The description of the question to show the user how to answer the question.
      default: # (Optional) A default value that will be pre-populated into the UI
      required: # (Optional) Whether or not an answer is required. By default, it's considered `false`.
      type: # How the questions are formatted and types of response expected 
```
<br>

**_Type_**

The `type` section controls how the questions are formatted in the UI as well as the types of responses that are expected. 

Eligible formats are:

`string`

A textbox will be shown in the UI to capture the answer, and the answer will be formatted to a string.

`int`

A textbox will be shown in the UI to capture the answer, and the answer will be formatted to a number. The UI will validate whether or not it's a valid number before launching the template.

`boolean`

A radio button will be shown in the UI to capture the answer, and the answer will be formatted to `true` or `false`. If the radio button is selected, the answer will be formatted to `true`.

`password`

A textbox will be shown in the UI to capture the answer, and the answer will be formatted to a string.

`service`

A drop-down of all services in the environment will be displayed. 

`enum`

A drop-down menu will be shown in the UI and the `options` section will be populated in the drop-down.

```yaml
.catalog:
  questions:
    - variable:
      label:
      description: |
      type: enum   
      options: # List of options if using type of `enum`
        - Option 1
        - Option 2
```
<br>
`multiline`

A multiple line textbox will be shown in the UI. 

```yaml
.catalog:
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

<br>

`certificate`

A drop down of all available certificates in the environment.

```yaml
.catalog:
  questions:
    - variable:
      label:
      description: |
      type: certificate
```









