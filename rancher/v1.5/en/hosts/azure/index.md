---
title: Adding Azure Hosts
layout: rancher-default-v1.5
version: v1.5
lang: en
---

## Adding Azure Hosts
---

Rancher supports provisioning [Microsoft Azure](https://azure.microsoft.com) hosts using Docker Machine.

### Prerequisites

Before you can launch a host on Azure, you will need to gather your **Subscription ID**, **Client ID** and **Client Secret**. The **Client ID** and **Client Secret** are created by creating an **App registration**. You can find more information on this at the [Microsoft documentation site](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal).

#### Using the Azure portal

Go to [https://portal.azure.com](https://portal.azure.com) and login with your credentials.

##### Subscription ID

To retrieve the Subscription ID, go to **More services**, search for **Subscriptions** and open it. The Subscription ID should be shown in the **SUBSCRIPTION ID** column next to your Subscription name.

##### App registration

Follow the steps below to create an App registration and the corresponding **Client ID** and **Client Secret**.

1. Select **Azure Active Directory**.
1. Select **App registrations**.
1. Select **New application registration**.
1. Choose a **Name**, select `Web app / API` as **Application Type** and a **Sign-on URL** which can be anything in this case.
1. Select **Create**.

In the **App registrations** view, you should see your created App registration. The value shown in the column **APPLICATION ID** is what you need to use as **Client ID**. The next step is to generate the **Client Secret**:

1. Open your created App registration.
1. In the **Settings** view, open **Keys**.
1. Enter a **Key description**, select an expiration time and select **Save**.
1. The generated value shown in the column **Value** is what you need to use as **Client Secret**. This value will only be shown once.

Last thing you will need to do, is assign the appropriate permissions to your App registration.

1. Go to **More services**, search for **Subscriptions** and open it.
1. Open **Access control (IAM)**.
1. Select **Add**.
1. For **Role**, select `Contributor`.
1. For **Select**, select your created App registration name.
1. Select **Save**.

### Launching Azure Host(s)

1. Provide a **Name** for the host(s).
1. Select the number of hosts by using the slider beneath **Quantity**.
1. Select which **Region** your Azure resources are part of.
1. The **Environment** defaults to `AzurePublicCloud` but if you are using any government cloud, you should change this here.
1. You can enter specific names for **Availability Set** and **Resource Group**, those will be created or re-used if they already exist.
1. Supply the correct information for **Subscription ID**, **Client ID** and **Client Secret** as gathered above.
1. Update the **Network** settings if you want to customize them from the default settings.
1. Select the **Image** that you want launched. Whatever `docker-machine` supports for Azure is also supported by Rancher. If you change this, don't forget to update the **SSH User** to the correct value for the image.
1. Select the **Size** of the image.
1. Update the **Docker port** and **Storage Type** if they will be different from the default.
1. (Optional) Add **[labels]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/hosts/#labels)** to hosts to help organize your hosts and to [schedule services/load balancers]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/scheduling/) or to [program external DNS records using an IP other than the host IP]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/external-dns-service/#using-a-specific-ip-for-external-dns).
1. (Optional) In **Advanced Options**, customize your `docker-machine create` command with [Docker engine options](https://docs.docker.com/machine/reference/create/#specifying-configuration-options-for-the-created-docker-engine).
1. When complete, click **Create**.

Once you click on create, Rancher will create the Azure virtual machine and launch the _rancher-agent_ container. In a couple of minutes, the host will be active and available to start [adding services]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-services/).
