---
title: Rancher Catalog
layout: rancher-default-v1.2
version: v1.2
lang: en
redirect_from:
  - /rancher/v1.2/zh/catalog/
---

## Catalog
---

Rancher provides a catalog of application templates that make it easy to deploy these complex stacks. By accessing the **Catalog** tab, you can view all the templates that are available in the [enabled catalogs]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/settings/#catalog). The **Library** catalog contains templates from the [Rancher certified catalog](https://github.com/rancher/rancher-catalog) and the **Community** catalog contains templates from the  [community-catalog](https://github.com/rancher/community-catalog). Rancher will only be maintaining support for the _certified_ templates in the library.

An [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) of Rancher has the ability to add or remove catalogs in Rancher. The catalogs within Rancher can be found at **Admin** -> **Settings**. Adding a catalog is as simple as adding a catalog name, a URL and a branch name. The URL needs to be one that `git clone` [can handle](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a). The branch name must be a branch that is in your catalog URL. It will use `master` by default. Whenever you add a catalog entry, it will be immediately available in your catalog.

If you are running Rancher server behind a proxy, you will need to [start Rancher with certain environment variables]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#http-proxy) in order for the Rancher catalog to work in Rancher.  

### Infrastructure Services in the Catalog

The [infrastructure services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-services/) that are available to be enabled in an [environment template]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template), are from the `infra-templates` folder of any catalog enabled in Rancher.

These services are also available from the **Catalog** tab, and you will be able to see all the infrastructure services even though they may not work with the selected orchestration type. It's recommended to select infrastructure services during environment template creation versus launching them directly from the catalog.  

### Launching Templates

Search for your desired template or use the filters for category or catalog. Once you have found your template, click on **Launch**. Fill in the required information for the template.

1. By default, latest **version** of a template is selected, but if desired, you could select an older version.
2. Select a **stack** name and if desired, **description** of the stack.
3. Fill in the **Configuration Options**, which are questions specific to the selected template.
4. Click on **Create** to create the stack based on the template. You can review the `docker-compose.yml` and `rancher-compose.yml` files that are being used to generate the stacks by expanding **Preview** before creating the stack.

After you click on **Create**, the stack is immediately created, but none of the services have started. Click on **Start Services** from the stack dropdown menu to start all the services of the stack.

### Upgrading Templates

The great thing about Rancher is that if a newer version of a template has been uploaded to the catalog, we'll inform you that a newer version is available to upgrade to. When you click on **Upgrade Available**, you can select which version you want to upgrade to. Always review the information about the version before upgrading, so that you are aware of all potential risks. After selecting the version, the **Configuration Options** will need to be reviewed before clicking on **Save**.

After all the services have been upgraded, the stack and services will be in an **Upgraded** state. If you are satisfied with your upgrade, the last step is to confirm the upgrade by clicking on the **Finish Upgrade** in the stack dropdown menu. **Note: Once you have finished your upgrade, you will not be able to revert to the older version.**

#### Rolling back

If something went wrong during your upgrade and you need to revert to the previous version, you would want to select **Rollback** in the stack dropdown menu.
