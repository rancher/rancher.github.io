---
title: What are API Keys
layout: rancher-api-v2-beta-default-v1.2
version: v1.2
lang: en
apiVersion: v2-beta
redirect_from:
  - /rancher/v1.2/en/api/api-keys/
  - /rancher/v1.2/zh/api/v2-beta/api-keys/
---

## What are API Keys
---

There are two types of API keys that Rancher supports, Account API keys and Environment API keys.  An account API key can add additional [accounts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/), CRUD any environment that the account has access to and be used to work with [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/). An environment API key is tied to a specific [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), can only manipulate resources within the environment and is used with [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/). Usage of API keys are required when [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is turned on.

Within Rancher, all objects can be viewed in the API by selecting the **View in API** option in the object's dropdown menu. The endpoint URL provided when creating the environment API key also gives all the links to the various portions of the API. Read more about how to use our [API]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/).

### Account API Keys

Click on **API** to find the API endpoint for your account. If you are an [admin]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#admin) of Rancher, you will have the ability to edit Rancher settings and manipulate all environments regardless if you have access to the environment. If you are a [user]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#user) of Rancher, you will only have the ability to manipulate environments that you have access to.

> **Note:** If you are using [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/), then you use an account API key to configure Rancher and the CLI.

#### Adding Account API Keys

Click on **Add Account API Key**. Provide a **Name** and if desired, **Description**. Click **Create**. Rancher will generate and display your account API Key. An API Key is a combination of  an access key (username) and a secret key (password) - both are needed to authenticate when performing API calls. After you have copied down the information, click **Close**.

> **Note:** Once you close the window, you will not be able to retrieve the secret key (password) of your API key, so please make sure to save it some place.

#### Using Account API Keys

When access control is configured and you are not logged in, if you try to go to an API endpoint, then you will be prompted for an API key. The username is the access key and the password is the secret key.

If you are using `cURL`, you can use the account API Key by specifying a `-u` parameter in the form `username:password` or by adding a line to your `.netrc` file.

#### Editing Account API Keys

All options for an account API key are accessible through the dropdown menu on the right hand side of the listed key.

For any _Active_ key, you can **Deactivate** the key, which would prohibit the use of those credentials. The key will be labeled in an _Inactive_ state.

For any _Inactive_ key, you have two options. You can **Activate** the key, which will allow the credentials to access the API again. Alternatively, you can **Delete** the key, which will remove the credentials from Rancher.

You can **Edit** any key, which allows you to change the name and description of the account API key. You will not be able to change the actual access key or secret key. If you want a new key pair, you'll need to add a new one.

### Environment API Keys

Click on **API** -> **Advanced Options** to find the API endpoint for your specific environment. Whenever you create an environment API key, the endpoint URL provided will direct you to the specific [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) that you are currently working in.

Once access control is enabled, an environment API key will need to be created for each [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) in order to access the API for the specific environment.

> **Note:** If you are using [Rancher Compose]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/), then you would want to use an environment API key to be able to directly launch services into that specific environment. We recommend using [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/) over Rancher Compose as Rancher CLI supports the same functionality to launch services.

#### Adding Environment API Keys

Before adding any environment API Keys, please confirm that you are in the correct [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/). Click on **Add Environment API Key**. Provide a **Name** and if desired, **Description**. Click **Create**. Rancher will generate and display your environment API Key. An API Key is a combination of an access key (username) and a secret key (password) - both are needed to authenticate when performing API calls. After you have copied down the information, click **Close**.

> **Note:** Once you close the window, you will not be able to retrieve the secret key (password) of your API key, so please make sure to save it some place.

#### Using Environment API Keys

When access control is configured and you are not logged in, if you try to go to an API endpoint, then you will be prompted for an API key. Your environment API key will only work if you are trying to make changes in the specific environment.  The username is the access key and the password is the secret key.

If you are using `cURL`, you can use the environment API Key by specifying a `-u` parameter in the form `username:password` or by adding a line to your `.netrc` file.

#### Editing Environment API Keys

All options for an environment API key are accessible through the dropdown menu on the right hand side of the listed key.

For any _Active_ key, you can **Deactivate** the key, which would prohibit the use of those credentials. The key will be labeled in an _Inactive_ state.

For any _Inactive_ key, you have two options. You can **Activate** the key, which will allow the credentials to access the API again. Alternatively, you can **Delete** the key, which will remove the credentials from the environment.

You can **Edit** any key, which allows you to change the name and description of the environment API key. You will not be able to change the actual access key or secret key. If you want a new key pair, you'll need to add a new one.
