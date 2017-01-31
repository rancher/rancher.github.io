---
title: Secrets in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Secrets - Experimental
---

Rancher has introduced the ability to create named secrets to be used in containers. Rancher interfaces with an encryption backend, by using either a local AES (Advanced Encryption Standard) key or [Vault Transit](https://www.vaultproject.io/docs/secrets/transit/), to securely store the values within Rancher. 

### Encryption Backend Configuration

By default, Rancher server is configured to use a locally stored AES256 encryption key to perform the encryption of secrets. These encrypted values are stored in the MySQL database that Rancher server uses. 

#### Using Vault Transit

Instead of using the locally stored key, Racnher can be configured to use [Vault Transit](https://www.vaultproject.io/docs/secrets/transit/) to perform the encryption. 

##### Installing Rancher Server using Vault Transit

Prior to installing Rancher Server, there are a couple of pre-requisites that need to be completed with Vault Transit: 

* Install the Vault transit backend on the host that will be running Rancher server
* Using Vault Transit, create a key named `rancher`
* Using Vault Transit, create a token that can encrypt/decrypt using the `rancher` key
  * This token must be scoped with a policy for Rancher server to use the following Vault Transit endpoints. The `<KEY>` in this list is the `rancher` key that was created.
      ```
      >  transit/random/<KEY>
      > 
      >  transit/hmac/<KEY>
      > 
      >  transit/encrypt/<KEY>
      > 
      >  transit/decrypt/<KEY>
      >  
      >  transit/verify/<KEY>
      ```
     

After these have been completed, you can launch Rancher server and add environment variables to the command to connect to Vault. 

```bash
$ docker run -d --restart=unless-stopped -p 8080:8080 \
    -e VAULT_ADDR=https://<VAULT_SERVER> -e VAULT_TOKEN=<TOKEN_FOR_VAULT_ACCCESS> rancher/server
```

> **Note:** Verify that you are running the desired [Rancher server tag]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#rancher-server-tags).

Once Rancher server is up, you will need to configure a setting within Rancher. Under **Admin** -> **Settings** -> **Advanced**, update the `secrets.backend` value. By default, it will have `localkey` and it needs to be changed to `vault`. 

> **Note:** Currently, Rancher does not support switching between encryption backend types. 

### Creating Secrets

Secrets are created and scoped at an environment level. Any containers can share the same secrets. For example, a database password, i.e. `db_password`, can be used in a database container and a Wordpress container. 

Currently, secrets can only be created in the UI, but Rancher is looking to add in CLI support. 

Go to **Infrastructure** -> **Secrets**. Create a key value pair for a secret. 

Once a secret is created, it **cannot** be edited or updated. If you need to change an existing secret, the only way to do so is to delete the secret. You can create either a brand new key value pair or use the same key with a new value. After the secret has been updated, any services using the secret will need to be re-launched with the updated secret. 

### Deleting Secrets

Secrets can be deleted from Rancher, but it does remove the secret (i.e. file) from the _??host (or container or both)??_.

### Enabling Secrets in Containers

In order to consume secrets in containers, the `Rancher Secrets` service will need to be launched. This service can be deployed by either adding it to [environment templates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) so that it's deployed on all [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) or by launching it directly from the [Rancher Catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/). If you are adding this service to an existing environment, navigate to **Catalog** -> **Library** and search for the `Rancher Secrets` entry. Without launching this catalog entry, you will only be able create secrets, but not be able to use them in your containers.

### Adding Secrets to Services/Containers

When secrets are added to a container, the secrets are written to a tmpfs volume mounted at `/run/secrets` inside the container. The filename will be either the secret name or the aliased name. The file is written in designated file mode (default: `0444`), UID (default: `0`) and GID (default: `0`). 

Secrets can be added into a service/container under the **Secrets** tab during service/container creation. 

* Select **Add Secret**
* The list of available secrets that have been created in Rancher are in a drop down menu. Select the secret that you'd like to use. 
* (Optional) Input a filename for the secrets file.
* (Optional) If the default file mode needs to be modified, click the **Customize file ownership & permissions** link. The Mode, UID and GID can be updated.

Click **Create**. 

### Docker Hub Images

There are many popular images in the Docker Hub library that support environment variables with an additional `_FILE`. 

For example, when launching a MySQL container you can set enviornment variables to:

`-e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_password`

By providing the location of the file, the `MYSQL_ROOT_PASSWORD` environment variable will use the value from the file. WHAT DOES THE KEY NEED TO BE IN THIS CASE?

> **Note:** CLI currently does not support using secrets in containers. 

### Security Threat Model

* Compromised management server exposes the encryption keys. 

The secrets stored in Rancher provide about the same level of trust as CI systems such as TravisCI and Drone. The encryption keys are stored on the Management servers, and a compromise of the server should be treated as a compromise of your secret data.

We recognize this as a short coming, and will be working to mitigate this condition in future releases. 

Again, if you are using Vault create a policy that limits access of the token used by the management server.

* Compromised compute nodes

If a compute node is compromised, the attacker has access to the secrets on the host. The attacker can not list or request additional secrets be placed on the host. 

* Console within the UI

If a user gains access to the container consoles in the UI, they can enter the container and get at the contents of the secrets stored in the volume.
