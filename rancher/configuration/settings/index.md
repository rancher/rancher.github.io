---
title: Rancher Settings
layout: rancher-default
---

## Rancher Settings
---

In the **Admin** -> **Settings** page of Rancher, we allow customization of Rancher for different areas of the product.

## Host Registration

Before launching any hosts, you will be asked to complete the host registration. This registration sets up how your Rancher server is going to connect with your hosts. If you have already set up [access control]({{site.baseurl}}/rancher/configuration/access-control), you will not be prompted to set host registration as Rancher assumes that your URL will be accessible.

![Host Registration on Rancher 1]({{site.baseurl}}/img/rancher/rancher_hosts_registration_1.png)

The setup determines the base URL your hosts will use to connect to the Rancher API. By default, Rancher selects the base URL you used to access the UI.  If you choose to change the address, make sure to specify the port that should be used to connect to the Rancher API. If you are configuring Rancher with SSL, be sure to change the protocol to `https`. This registration setup determines what the command will be for [adding custom hosts]({{site.baseurl}}/rancher/rancher-ui/infrastructure/hosts/custom/).

If [access control]({{site.baseurl}}/rancher/configuration/access-control/) is turned on for Rancher, only the **admin** will be able to change the host registration. By default, the first **admin** is the first user to authenticate with Rancher when access control was configured. If access-control is still not configured, any users to the site can update the host registration. This option can be updated in the **Admin** -> **Host Registration** tab. 

## Catalog

By default, the [catalog]({{site.baseurl}}/rancher/catalog/) is populated with templates from the Rancher Catalog [repository](https://github.com/rancher/rancher-catalog). 

An admin has the ability to add or remove catalogs to Rancher. Adding a catalog is as simple as adding a catalog name and the git URL. The correct format of the git URL can be found [here](https://git-scm.com/docs/git-clone#_git_urls_a_id_urls_a). Whenever you add a catalog entry, it will be immediately available in your catalog.

If you want to create your own private catalog to add, the git repository must be set up in a [specific format]({{site.baseurl}}/rancher/catalog/#creating-private-catalogs).

