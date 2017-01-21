---
title: Accounts in Rancher
layout: rancher-default-v1.1
version: v1.1
lang: en
redirect_from:
  - /rancher/v1.1/zh/configuration/accounts/
---

## Accounts
---

### What are Accounts?

Accounts are the users who have access to Rancher.

### Active Directory/GitHub/OpenLDAP Authentication

When [Active Directory]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#active-directory), [Azure AD]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#azure-ad), [GitHub]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#github), or [OpenLDAP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#openldap) authentication is enabled, the **Accounts** tab displays the list of users who have logged in and authenticated against Rancher. In order to log in, they must be either given the privilege to have the [site access]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#site-access) or added to an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/).

### Local Authentication

When [local authentication is enabled]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#local-authentication), accounts can be added to Rancher in the **Accounts** tab. Click the **Add Account** button to add accounts into the Rancher database. When creating accounts, the account type can be specified as an admin or user.

### Account Types

The account type determines whether or not an account will have access to the admin tab. For each environment in Rancher, there are [membership roles]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles) that provide different level of access for a specific environment.

#### Admin

The first user that authenticates Rancher becomes an admin of Rancher. Only admins will have permissions to view the **Admin** tab.

When managing environment, admins have the ability to view all the [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) in Rancher even if the admin is not added as a member to the environment. In an admin's environment drop-down menu, the members will only see the environments that they are on the membership list.

Admins can add other users to be an admin of Rancher. They can change a user's role on the **Admin** > **Accounts** page after the user has logged into Rancher. In the **Admin** > **Accounts** tab, click  **Edit** next to the account name and change the account type to _Admin_. Click **Save**.

#### Users

Besides the user that authenticates Rancher, any other user will automatically be added with user permissions. They will not be able to see the **Admin** tab.

They will only be able to view the environments that they are members of.
