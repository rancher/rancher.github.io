---
title: Accounts
layout: rancher-default
---

## Accounts
---

### What are Accounts?

Accounts are the users who have access to Rancher. In the **Admin** > **Accounts** tab, admins can edit the account details (name, account type, and description) and the status of the account. 

### GitHub/LDAP Authentication

When [GitHub]({{site.baseurl}}/rancher/configuration/access-control/#github) or [LDAP]({{site.baseurl}}/rancher/configuration/access-control/#ldap) authentication is enabled, the **Accounts** tab displays the list of users who have logged in and authenticated against Rancher. In order to log in, they must be either given the privilege to have the [site access]({{site.baseurl}}/rancher/configuration/access-control/#site-access) or added to an [environment]({{site.baseurl}}/rancher/configuration/environments/). 

### Local Authentication

When [local authentication is enabled]({{site.baseurl}}/rancher/configuration/access-control/#local-authentication), accounts can be added to Rancher in the **Accounts** tab. Click the **Add Account** button to add accounts into the Rancher database. 
