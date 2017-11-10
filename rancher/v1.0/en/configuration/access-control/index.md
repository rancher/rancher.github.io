---
title: Access Control for Rancher
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## Access Control
---

### What is Access Control?

Access Control is how Rancher limits the users who have the access permissions to your Rancher instance. By default, Access Control is not configured. This means anyone who has the IP address of your Rancher instance will be able to use it and access the API. Your Rancher instance is open to the public! We highly recommend configuring Access Control soon after launching Rancher. Upon enabling Access Control, you can share your Rancher instance to who you want to. They will be required to authenticate to the instance before being able to access it. The API becomes only accessible to those who have the valid API keys to the instance. 

The first account that authenticates with Rancher will become the **admin** of the account. For more information, see [permissions of an admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin). 

> **Note:** Switching between Access Control Providers is not supported.

### Enabling Access Control

In the **Admin** tab, click **Access Control**.

Currently, Rancher supports four methods of authentication: Active Directory, GitHub, Local and OpenLDAP. After authenticating your Rancher instance, Access Control will be considered enabled. With Access Control enabled, you will be able to manage different [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) and share them with different groups of people. 

When Access Control is enabled, the API is locked and requires either being authenticated as a user or by using an [API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/api-keys/) to access it.

#### Active Directory

Select the **Active Directory** icon. If you want to use Active Directory using TLS, ensure that you have [started Rancher server with the appropriate certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#ldap). Fill in the sections and authenticate Rancher by clicking **Authenticate**. When Active Directory is enabled, you'll automatically be logged in as the username that was authenticated. You will also be logged in as an admin of Rancher.

#### GitHub

Select the **GitHub** icon and follow the directions in the UI to register Rancher as a GitHub application. After clicking **Authenticate with GitHub**, Access Control is enabled and you are automatically logged into Rancher with your GitHub login credentials and as an admin of Rancher. 

#### Local Authentication

Local authentication allows you to create your own set of accounts that is saved in the Rancher database. 

Select the **Local** icon. Create an admin user by providing the **Login Username**, **Full Name**, and **Password**. Click **Enable Local Auth** to turn on local authentication. By clicking this button, the admin is created and saved in the database. You are automatically logged into the Rancher instance as the admin account that was just created.

#### OpenLDAP

Select the **OpenLDAP** icon. If you want to use a OpenLDAP using TLS, ensure that you have [started Rancher server with the appropriate certificate]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#ldap). Fill in the sections and authenticate Rancher by clicking **Authenticate**. When OpenLDAP is enabled, you'll automatically be logged in as the username that was authenticated. You will also be logged in as an admin of Rancher.

### Site Access

Anyone who is a member or owner of an environment will also have access to the Rancher instance. Alternatively, you can invite members to access the Rancher instance, but when they log in, they will have their own environment. These members, who are added by using **Access Control** or **Accounts** options, will not be able to see other environments until they are added as a member to them.

Anyone with the permissions to view the Rancher instance will be given user permissions. However, they will not be able to view the **Admin** tab. In order for users to view different [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/), they will need to be added by an owner to the environment.

#### Active Directory/OpenLDAP

Once Active Directory or OpenLDAP is enabled, any user will be able to access the Rancher site. Eventually, we will be adding in the ability to restrict the Rancher instance to specific users and group members. Rancher still has [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) to keep resources protected from other users and groups, but anyone part of your LDAP server will be able to access the Rancher instance.

#### GitHub

If you wanted to add users to Rancher without sharing your environment, you can add them in the **Site Access** section. Click the **Customize** button.

**Option 1: Allow any GitHub user** 

This would allow anyone with a GitHub account to access your site.  

**Option 2: Restrict to specific GitHub users and organization members**

By clicking the drop-down menu icon next to the **+** button, you'll see the list of organizations that you are a member of. When you click any of those organizations, Rancher adds their name to the list of _Authorized Users and Organizations_. You can also add individual users by typing in their username into the text box and clicking the **+**. This will just add the users/organizations to the list, but you will still need to save!

> **Note: Save your configuration!** For either option, you must click the **Save authorization configuration** button in order for any changes to take affect. If you leave the page before saving, your changes will be lost.

#### Local Authentication

Once local authentication is enabled, the admin can create additional admins/users by accessing the **Admin** > **Accounts** tab. Click **Add Account** and fill in the details of the account you want to add. You can select their account type as an **Admin** or **User**. An admin has the ability to view the **Admin** tab while users of Rancher instance would not have the visibility to the tab.  

Once an account has been created, the admin/user can be added to any [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/).

### Account Types

The account type determines whether or not an account will have access to the admin tab. For each environment in Rancher, there are [membership roles]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/#membership-roles) that provide different level of access for a specific environment. 

#### Admin

The first user that authenticates Rancher becomes an admin of Rancher. Only admins will have permissions to view the **Admin** tab. 

When managing environment, admins have the ability to view all the [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) in Rancher even if the admin is not added as a member to the environment. In an admin's environment drop-down menu, the members will only see the environments that they are on the membership list.

Admins can add other users to be an admin of Rancher. They can change a user's role on the **Admin** > **Accounts** page after the user has logged into Rancher. In the **Admin** > **Accounts** tab, click  **Edit** next to the account name and change the account type to _Admin_. Click **Save**. 

#### Users

Besides the user that authenticates Rancher, any other user will automatically be added with user permissions. They will not be able to see the **Admin** tab. 

They will only be able to view the environments that they are members of. 

### Disabling Access Control

If you decide that you no longer want Access Control, click the **Disable access control** button. This will make your Rancher instance open to the public and anyone can access your API. This is **not** recommended.
