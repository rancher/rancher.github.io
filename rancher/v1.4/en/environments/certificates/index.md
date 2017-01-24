---
title: Certificates in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Certificates
---

### Adding Certificates

In order to add certificates to your [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), go to the **Infrastructure** -> **Certificates** page. The page will list out all certificates added to your Rancher environment. To add a new certificate, click on **Add Certificate**.

1. Provide a **Name** and if desired, **Description** for the certificate.

2. Provide the **Private Key** of the certificate. You can either click on **Read from File** to import from your computer or paste the private key into the text box.

3. Provide the **Certificate**. You can either click on **Read from File** to import from your computer or paste the certificate into the text box.

4. (Optional) If you have additional chained certificates, you can add them as well using the *Read from File** to import from your computer or paste the certificate into the text box.

### Using Certificates

Certificates loaded in the environment can be used for [SSL termination of a load balancer]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/adding-load-balancers/#ssl-termination) or [TLS termination for a Kubernetes Ingress]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/kubernetes/ingress/#example-using-tls).
