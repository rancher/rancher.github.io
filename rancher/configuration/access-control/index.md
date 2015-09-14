---
title: Access Control for Rancher
layout: rancher-default
---

## Access Control
---

### What is Access Control?

Access Control is how Rancher limits the users who have access to your Rancher instance. By default, access control is not configured. This means anyone who has the IP address of your Rancher instance will be able to use it and access the API. Your Rancher instance is open to the public! We recommend configuring Access Control after launching Rancher. Upon enabling access control, you can share your Rancher instance to who you want to. They will be required to authenticate to the instance before being able to access it. The API becomes only accessible to those who have valid API keys to the instance. 

The first account that authenticates with Rancher will become the **admin** of the account. Please read more about the [permissions of an admin]({{site.baseurl}}/rancher/configuration/access-control/#admins). 

### Enabling Access Control

In the **Admin** tab, click on **Access Control**, or click on the **Settings** link in the red banner.

Currently, Rancher supports threee methods of authentication, GitHub, LDAP, or Local Authentication. After authenticating your Rancher instance, access control will be considered enabled. With access control enabled, you will be able to manage different [environments]({{site.baseurl}}/rancher/configuration/environments/) and share them with different groups of people. 

When access control is enabled, the API is also locked and requires either being authenticated as a user or using an [API key]({{site.baseurl}}/rancher/configuration/api-keys/) to access it.

#### GitHub

Select the **GitHub** icon and follow the directions in the UI to register Rancher as a GitHub application. After clicking on **Authenticate with GitHub**, access control is enabled and you are automatically logged into Rancher with your GitHub login credentials and as an admin of Rancher. 

#### LDAP

_Available as of v0.34.0+_

Select the **LDAP** icon. If you want to use a TLS enabled LDAP, you will need to make sure that you have [started Rancher server with the appropriate certificate]({{site.baseurl}}/rancher/installing-rancher/installing-server/#ldap). Fill in the sections and authenticate Rancher by clicking on **Authenticate**. When LDAP is enabled, you'll automatically be logged in as the username that was authenticated. You will also be logged in as an admin of Rancher.

#### Local Authentication

_Available as of v0.37.0+_

Local authentication allows you to create your own set of accounts that is saved in the Rancher database. 

Select the **Local** icon. Create an admin user by providing the **Login Username**, **Full Name**, and **Password**. Click on **Enable Local Auth** to turn on local authentication. By clicking this button, the admin is created and saved in the database. You are automatically logged into the Rancher instance as the admin account that was just created.

### Site Access

Anyone who is a member or owner of an environment will have also access to the Rancher instance. Alternatively, you can also invite members to access the Rancher instance, but when they log in, they will have their own environment. These members, who are added using within **Access Control** or **Accounts**, will not be able to see other environments until they are added as a member to them.

Anyone with permissions to view the Rancher instance will be given user permissions. They will not be able to view the **Admin** tab. In order for users to view different [environments]({{site.baseurl}}/rancher/configuration/environments/), they will need to be added by an owner to the environment.

#### GitHub

If you wanted to add users to Rancher without sharing your environment, you can add them in the **Site Access** section. Click on the **Customize** button.

**Option 1: Allow any GitHub user** 

This would allow anyone with a GitHub account to access your site.  

**Option 2: Restrict to specific GitHub users and organization members**

By clicking on the dropdown menu icon next to the **+** button, you'll see the list of organizations that you are a member of. When you click on any of those organizations, Rancher will add their name to the list of _Authorized Users and Organizations_. You can also add individual users by typing in their username into the text box and clicking on the **+**. This will just add the users/organizations to the list, but you will still need to save!

> **Note: Save your configuration!** For either option, you must click on the **Save authorization configuration** button in order for any changes to take affect. If you leave the page before clicking on save, your changes will be lost.

#### LDAP

_Available as of v0.34.0+_

Once LDAP is enabled, any LDAP user will be able to access the Rancher site. Eventually, we will be adding in the ability to restrict the Rancher instance to specific users and group members. Rancher still has [environments]({{site.baseurl}}/rancher/configuration/environments/) to keep resources protected from other users and groups, but anyone part of your LDAP server will be able to access the Rancher instance.

#### Local Authentication

_Available as of v0.37.0+_

Once local authentication is enabled, the admin can create additional admins/users by accessing the **Admin** -> **Accounts** tab. Click on **Add Account** and fill in the details of the account you want to add. You can select their account type as an **Admin** or **User**. An admin has the ability to view the **Admin** tab while users of Rancher instance would not have the visibility to the tab.  

Once an account has been made, the admin/user can be added to any [environments]({{site.baseurl}}/rancher/configuration/environments/).

### Account Types

#### Admin

The first user that authenticates Rancher becomes an admin of Rancher. Only admins will have permissions to view the **Admin** tab (_v0.37.0+) or the **Administration** options in the account dropdown menu (_anything v0.35.0 and prior_). This includes being able to configure **Access Control**, **Accounts**, and **[Host Registration]({{site.baseurl}}/rancher/configuration/host-registration/)**. 

When managing environment, admins have the ability to view all [environments]({{site.baseurl}}/rancher/configuration/environments/) in Rancher even if the admin is not added as a member to the environment. In an admin's environment dropdown menu, they will only see the environments that they are on the membership list.

As of _v0.37.0_, admins can add other users to be an admin of Rancher. They can change a user's role on the **Admin** -> **Accounts** page **after** the user has logged into Rancher. In the **Admin** -> **Accounts** tab, click on **Edit** next to the account name and change the account type to _Admin_. Click on **Save**. 

#### Users

Besides the user that authenticates Rancher, any other user will automatically be added with user permissions. They will not be able to see the **Admin** tab (_v0.37.0+) or the **Administration** options in the account dropdown menu (_anything v0.35.0 and prior_). 

They will only be able to view environments that they are on a membership list for. 

### Disabling Access Control

If you decide that you no longer want access control, click on the **Disable access control** button. This will make your Rancher instance open to the public and anyone can access your API. This is **not** recommended.