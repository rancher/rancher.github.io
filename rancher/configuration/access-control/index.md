---
title: Access Control for Rancher
layout: rancher-default
---

## Access Control
---

### What is Access Control?

Access Control is how Rancher limits the users who have access to your Rancher instance. By default, access control is not configured. This means anyone who has the IP address of your Rancher instance will be able to use it and access the API. Your Rancher instance is open to the public! We recommend configuring Access Control after launching Rancher. Upon enabling access control, you can share your Rancher instance to who you want to. They will be required to authenticate to the instance before being able to access it. The API becomes only accessible to those who have valid API keys to the instance. 

The first account that authenticates with Rancher will become the **admin** of the account. Only the admin will have permissions to view **Access Control** and **[Host Registration]({{site.baseurl}}/rancher/configuration/host-registration/)**. As an admin of the site, you also have the ability to view all [environments]({{site.baseurl}}/rancher/configuration/environments/) in the site even if you are not added as a member to the environment. In the admin's environment dropdown menu, they will only see the environments that they are added to, but all environments can be seen on the **Manage Environments** page.

### Enabling Access Control

In the account dropdown menu, click on **Access Control** within the Administration section or click on the **Settings** link in the red banner.

Currently, Rancher supports two methods of authentication, GitHub and LDAP. Click on the icons to switch between the two methods. After authenticating your Rancher instance, access control will be enabled. With access control enabled, you will be able to manage different [environments]({{site.baseurl}}/rancher/configuration/environments/) and share them with different groups of people. 

#### GitHub

Select the **GitHub** icon and follow the directions in the UI to register Rancher as a GitHub application. 

#### LDAP

_Available as of v0.34.0+_

Select the **LDAP** icon. You will need to make sure that you have [started Rancher server with the appropriate certificates]({{site.baseurl}}/rancher/installing-rancher/installing-server/#ldap). Fill in the sections and authenticate Rancher. 

### Site Access

Anyone who is a member or owner of an environment will have also access to the Rancher instance. Alternatively, you can also invite members to access the Rancher instance, but when they log in, they will have their own environment. These members who are added using the **Site Access** will not be able to see other environments until they are added as a member to them.

Anyone with permissions to view the Rancher instance will be given user permissions. They will not be able to view Access Control or Host Registration. The users will only be able to view environments that they are added to. 

#### GitHub

If you wanted to add users to Rancher without sharing your environment, you can add them in the **Site Access** section. Click on the **Customize** button.

**Option 1: Allow any GitHub user** 

This would allow anyone with a GitHub account to access your site.  

**Option 2: Restrict to specific GitHub users and organization members**

By clicking on the dropdown menu icon next to the **+** button, you'll see the list of organizations that you are a member of. When you click on any of those organizations, Rancher will add their name to the list of _Authorized Users and Organizations_. You can also add individual users by typing in their username into the text box and clicking on the **+**. This will just add the users/organizations to the list, but you will still need to save!

**Reminder: Save your configuration!**
For either option, you must click on the **Save authorization configuration** button in order for any changes to take affect. If you leave the page before clicking on save, your changes will be lost and those added to the site will still not have access.

#### LDAP

_Available as of v0.34.0+_

Once LDAP is enabled, any LDAP user will be able to access the Rancher site. We will be adding in the ability to restrict to specific users and group members. Rancher will still have [environments]({{site.baseurl}}/rancher/configuration/environments/) to keep resources protected from other users and groups, but anyone part of your company will be able to access Rancher.

### Disabling Access Control

If you decide that you no longer want access control, click on the **Disable access control** button. This will make the IP of your Rancher instance open to the public and anyone with the IP could access your API. This is **not** recommended.