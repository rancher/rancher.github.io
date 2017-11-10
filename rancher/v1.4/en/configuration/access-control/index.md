---
title: Access Control in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Access Control
---

### What is Access Control?

Access Control is how Rancher limits the users who have the access permissions to your Rancher instance. By default, Access Control is not configured. This means anyone who has the IP address of your Rancher instance will be able to use it and access the API. Your Rancher instance is open to the public! We highly recommend configuring Access Control soon after launching Rancher. Upon enabling Access Control, you can share your Rancher instance with whom you wish. They will be required to authenticate to the instance before being able to access it. The API becomes accessible only to those who have the valid API keys to the instance.

The first account that authenticates with Rancher will become the **admin** of the account. For more information, see [permissions of an admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin).

> **Note:** Switching between Access Control Providers is not supported.

### Enabling Access Control

In the **Admin** tab, click **Access Control**.

After authenticating your Rancher instance, Access Control will be considered enabled. With Access Control enabled, you will be able to manage different [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) and share them with different groups of people.

When Access Control is enabled, the API is locked and requires either being authenticated as a user or by using an [API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/) to access it.

#### Active Directory

Select the **Active Directory** icon. If you want to use Active Directory using TLS, ensure that you have [started Rancher server with the appropriate certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#ldap). Fill in the sections and authenticate Rancher by clicking **Authenticate**. When Active Directory is enabled, you'll automatically be logged in as the username that was authenticated. You will also be logged in as an admin of Rancher.

#### Azure AD

Select the **Azure AD** icon. Fill in the sections and authenticate Rancher by clicking **Authenticate with Azure**. When Active Directory is enabled, you'll automatically be logged in as the username that was authenticated. You will also be logged in as an admin of Rancher.

#### GitHub

Select the **GitHub** icon and follow the directions in the UI to register Rancher as a GitHub application. After clicking **Authenticate with GitHub**, Access Control is enabled and you are automatically logged into Rancher with your GitHub login credentials and as an admin of Rancher.

#### Local Authentication

Local authentication allows you to create your own set of accounts that is saved in the Rancher database.

Select the **Local** icon. Create an admin user by providing the **Login Username**, **Full Name**, and **Password**. Click **Enable Local Auth** to turn on local authentication. By clicking this button, the admin is created and saved in the database. You are automatically logged into the Rancher instance as the admin account that was just created.

#### OpenLDAP

Select the **OpenLDAP** icon. If you want to use a OpenLDAP using TLS, ensure that you have [started Rancher server with the appropriate certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#ldap). Fill in the sections and authenticate Rancher by clicking **Authenticate**. When OpenLDAP is enabled, you'll automatically be logged in as the username that was authenticated. You will also be logged in as an admin of Rancher.

#### Shibboleth

Select the **Shibboleth** icon. Fill in the configuration for the Shibboleth account, **Save** the information and **Test** that access control is working.

With Shibboleth, there are some known issues that you should be aware of if you are configuring to validate against it.

* There is no search or lookup support. When adding in users, the exact IDs must be inputted for the correct users to get access.
* When adding users to an [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), group IDs are not supported unless the admin, who turned on access control, is a member of the group.

### Site Access

Depending on your authentication type, Rancher provides different levels of site access.

#### Active Directory/GitHub/Shibboleth

If you have authenticated with AD or GitHub, there will be 3 options available.

* **Allow any valid Users** - Any user within GitHub or Active Directory would be able to access your Rancher instance. This is **not** recommended for GitHub as it would be any user in GitHub!
* **Allow members of Environments, plus Authorized Users and Organizations** - Any user who is a member or owner of an environment will also have access to the Rancher instance as well as any user added to the _Authorized Users and Organizations_ list.
* **Restrict access only to Authorized Users and Organizations** - Only users who are added to the _Authorized Users and Organizations_ would have access to the Rancher instance. Even if a user has been added to an environment, they would not have access unless they are **also** added to the _Authorized Users and Organizations_ section.

Anyone with the permissions for the Rancher instance will be given [user]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#users) permissions. They will not be able to view the **Admin** tab. You would explicitly need to change their account to be an [admin account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#admin).

In order for users to view different [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), they will need to be added to the environment by an [owner]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#owners) of the environment.

#### Azure AD/OpenLDAP

For Azure AD and OpenLDAP, any user that is a member of your setup will be able to access the Rancher site.

#### Local Authentication

Once local authentication is enabled, the admin can create additional admins/users by accessing the **Admin** > **Accounts** tab. Click **Add Account** and fill in the details of the account you want to add. You can select their account type as an **Admin** or **User**. An admin has the ability to view the **Admin** tab while users of Rancher instance would not have the visibility to the tab.  

Once an account has been created, the admin/user can be added to any [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/).

### Account Types

The account type determines whether or not an account will have access to the admin tab. For each environment in Rancher, there are [membership roles]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#membership-roles) that provide different level of access for a specific environment.

#### Admin

The first user that authenticates Rancher becomes an admin of Rancher. Only admins will have permissions to view the **Admin** tab.

When managing environment, admins have the ability to view all the [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) in Rancher even if the admin is not added as a member to the environment. In an admin's environment drop-down menu, the members will only see the environments that they are on the membership list.

Admins can add other users to be an admin of Rancher. They can change a user's role on the **Admin** > **Accounts** page after the user has logged into Rancher. In the **Admin** > **Accounts** tab, click  **Edit** next to the account name and change the account type to _Admin_. Click **Save**.

#### Users

Besides the user that authenticates Rancher, any other user will automatically be added with user permissions. They will not be able to see the **Admin** tab.

They will only be able to view the environments that they are members of.

### Disabling Access Control

If you decide that you no longer want Access Control, click the **Disable access control** button. This will make your Rancher instance open to the public and anyone can access your API. This is **not** recommended.
