---
title: API & Keys
layout: rancher-default-v1.0
version: v1.0
lang: en
---

## API & Keys
---

Click on **API** to find the API endpoint. Whenever you create an environment API key, the endpoint URL provided will direct you to the specific [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) that you are currently working in. 

If [access control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is not configured, anyone with the IP address will have access to your Rancher's API. It's highly recommended to enable access control.

Once access control is enabled and not logged in, an environment API key will need to be created for each [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) in order to access the API for the specific environment. 

Within Rancher, all objects can be viewed in the API by selecting the **View in API** option in the object's dropdown menu. The endpoint URL provided when creating the environment API key also gives all the links to the various portions of the API. Read more about how to use our [API]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api).

### Adding Environment API Keys

Before adding any environment API Keys, please confirm that you are in the correct [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/). Click on **Add Environment API Key**. Provide a **Name** and if desired, **Description**. Click **Create**. Rancher will generate and display your environment API Key. An API Key is a combination of a username (access key) and a password (secret key) - both are needed to authenticate when performing API calls. After you have copied down the information, click **Close**. 

> **Note:** Once you close the window, you will not be able to retrieve the password (secret key) of your API key, so please make sure to save it some place safe. 

### Using Environment API Keys

When access control is configured and you are not logged in, if you try to go to the API endpoint, then you will be prompted for an environment API key. The username is the access key and the password is the secret key. 

If you are using `cURL`, you can use the environment API Key by specifying a `-u` parameter in the form `username:password` or by adding a line to your `.netrc` file.

### Editing Environment API Keys

All options for an environment API key are accessible through the dropdown menu on the right hand side of the listed key.

For any _Active_ key, you can **Deactivate** the key, which would prohibit the use of those credentials. The key will be labeled in an _Inactive_ state.

For any _Inactive_ key, you have two options. You can **Activate** the key, which will allow the credentials to access the API again. Alternatively, you can **Delete** the key, which will remove the credentials from the environment.

You can **Edit** any key, which allows you to change the name and description of the environment API key. You will not be able to change the actual access key or secret key. If you want a new key pair, you'll need to add a new one.

