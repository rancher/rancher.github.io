---
title: Rancher Settings
layout: rancher-default
---

## Rancher Settings
---

In the **Settings** page of Rancher, we allow customization of Rancher for different areas of the product.

## Host Registration

Before launching any hosts, you will be asked to complete the host registration. This registration sets up how your Rancher server is going to connect with your hosts. If you have already set up [access control]({{site.baseurl}}/rancher/configuration/access-control), you will not be prompted to set host registration as Rancher assumes that your URL will be accessible.

![Host Registration on Rancher 1]({{site.baseurl}}/img/rancher/rancher_hosts_registration_1.png)

The setup determines the base URL your hosts will use to connect to the Rancher API. By default, Rancher selects the base URL you used to access the UI.  If you choose to change the address, make sure to specify the port that should be used to connect to the Rancher API. If you are configuring Rancher with SSL, be sure to change the protocol to `https`. This registration setup determines what the command will be for [adding custom hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/custom/).

If [access control]({{site.baseurl}}/rancher/configuration/access-control/) is turned on for Rancher, only the **admin** will be able to change the host registration. By default, the first **admin** is the first user to authenticate with Rancher when access control was configured. If access-control is still not configured, any users to the site can update the host registration. This option can be updated in the **Admin** > **Host Registation** tab. 

## Catalog

By default, the [catalog]({{site.baseurl}}/rancher/rancher-ui/applications/catalog/) is populated with templates from the Rancher Catalog [repository](https://github.com/rancher/rancher-catalog). 

An admin has the ability to add or remove catalogs to Rancher. Adding a catalog is as simple as adding a catalog name and the git URL. The correct format of the girl URL can be found [here](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a). Whenever you add a catalog entry, it will be immediately available in your [catalog]({{site.baseurl}}/rancher/rancher-ui/applications/catalog/).

### Creating Private Catalogs

The Rancher catalog service requires private catalogs to be structured in a specific format in order for the catalog service to translate it into Rancher. 

#### Directory Structure

```
templates -> template-name -> template-version
```

In the main directory, you will need a **templates** folder. The `templates` folder will contain folders of each catalog entry that you have created. We recommend that each catalog entry have a simple template name as the folder name. 

In the catalog entry folder, there will be folders for each version that you have created for your catalog entry. 

The first version should be `0` and each subsequent version will be an incremental value. For example, version 2 will be in the `1` folder. By providing a new version folder number, it provides a way to upgrade your stack from a previous version of the template. Alternatively, you could update the templates in the `0` folder and just re-deploy the entry. 

#### Rancher Catalog Files to Display in Rancher Catalog

Within the catalog entry folder, the details of how to display your catalog entry in the Rancher catalog are located in two files.

* The first file `config.yml` contains the details of your entry.

     ```yaml
     name: # Name of the Catalog Entry 
     description: |
        # Description of the Catalog Entry
     version: # Version of the Catalog to be used 
     category: # Category to be used for searching catalog entries
     ```
<br>
* The second file is a the icon image for the catalog entry. The file must be prefixed with `catalogIcon-`. 

For every catalog entry, there will be a minimum of three items: `config.yml`, `catalogIcon-entry.svg`, and the `0` folder, which holds the first version of the catalog entry. 

#### Rancher Catalog Templates 

The `docker-compose.yml` and `rancher-compose.yml` are located within the version folder number (i.e. `0`, `1`, etc.). Rancher uses these files to run [rancher-compose]({{site.baseurl}}/rancher/rancher-compose/) to launch the services into Rancher.

The `docker-compose.yml` should be a file that could also be launched using `docker-compose up`. The services follow the docker-compose format.

The `rancher-compose.yml` will contain additional information to help customize your catalog entries. In the `.catalog` section, there are some fields that will be required in order to have your catalog entry interprested correctly.

An optional `README.md` is possible to be created, which provides a lengthy description or notes on how to use the catalog service. 


**`rancher-compose.yml`**

```yaml
.catalog
  name: # Name of the versioned template of the Catalog Entry 
  version: # Version of the versioned template of the Catalog Entry 
  description: # Description of the versioned template of the Catalog Entry
  uuid: # Unique identifier to be used for upgrades. Please see note. 
  questions: #Used to request user input for configuration options
```
<br>
> **Note:** The `uuid` is a required parameter that is used for upgrade scenarios. Each `uuid` must be unique and each later version should be incremental. The recommended format is to use the name of the catalog entry and suffixed with a `-0`. As versions are introduced, you would increment the `-0` to `-1` for the next entry. 

**Questions in the `rancher-compose.yml`**

The `questions` section of `.catalog` is used to be able to show questions to the user and allow users to provide different configuration options. 

Each question is a list item in the `questions` section.

```yaml
.catalog
  questions:
    - variable: # A single word that is used to pair the question and answer.
      label: # The "question" to be answered.
      description: # The description of the question to show the user how to answer the question.
      default: # A default value that will be pre-populated into the UI
      required: # Whether or not an answer is required. By default, it's considered `false`.
      type: # The format type of the response. Eligible formats are `"string"`, `"int"`, `enum`,  `"multiline"`, `"service"`
      options: # List of options if using type of `enum`
        - Option 1
        - Option 2
```
<br>
> **Note:** The `type` section of the question can be multiple formats. For a drop-down menu, you would select `enum` and provide the options in the `options` section. The options would need to be in list format. 









