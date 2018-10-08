---
title: Secrets in Rancher
layout: rancher-default-v1.6
version: v1.6
lang: en
---

## Secrets - Experimental
---

Rancher has introduced the ability to create named secrets to be used in containers. Rancher interfaces with an encryption backend, by using either a local AES (Advanced Encryption Standard) key or [Vault Transit](https://www.vaultproject.io/docs/secrets/transit/), to securely store the values within Rancher.

### Encryption Backend Configuration

By default, Rancher server is configured to use a locally stored AES256 encryption key to perform the encryption of secrets. These encrypted values are stored in the MySQL database that Rancher server uses.

#### Using Vault Transit

Instead of using the locally stored key, Rancher can be configured to use [Vault Transit](https://www.vaultproject.io/docs/secrets/transit/) to perform the encryption.

##### Installing Rancher Server using Vault Transit

Prior to installing Rancher Server, there are a couple of pre-requisites that need to be completed with Vault Transit.

1. Mount the Vault transit backend on the host that will be running Rancher server
2. Using the Vault CLI or API, create a new encryption key named `rancher`
3. Using the Vault CLI or API, create a Vault access token that can encrypt/decrypt using the `rancher` key
    * This token must be scoped with a policy for Rancher server to use the following Vault Transit endpoints. The `<KEY>` in this list is the `rancher` key that was created.

      ```
      path "transit/random/*" {
        capabilities = ["create", "update"]
      }

      path "transit/hmac/*" {
        capabilities = ["create", "update"]
      }

      path "transit/encrypt/rancher" {
        capabilities = ["create", "update"]
      }

      path "transit/decrypt/rancher" {
        capabilities = ["create", "update"]
      }

      path "transit/verify/rancher/*" {
        capabilities = ["create", "update", "read"]
      }

      path "transit/keys/*" {
        capabilities = ["deny"]
      }

      path "sys/*" {
        capabilities = ["deny"]
      }
      ```

3. Launch Rancher server and add environment variables to the command to connect to Vault.

   ```bash
   $ docker run -d --restart=unless-stopped -p 8080:8080 \
      -e VAULT_ADDR=https://<VAULT_SERVER> -e VAULT_TOKEN=<TOKEN_FOR_VAULT_ACCCESS> rancher/server
   ```

    > **Note:** Verify that you are running the desired [Rancher server tag]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#rancher-server-tags).

4. Once Rancher server is up, you will need to update the `service-backend` setting within Rancher. Under **Admin** -> **Settings** -> **Advanced Settings**, find the `secrets.backend` value. By default, it will have `localkey` as the value. You can edit it to the value of `vault`.

> **Note:** Currently, Rancher does not support switching between encryption backend types.

### Creating Secrets

Secrets are created and scoped at an environment level, which means there can only be one secret with the same name in an environment. Any container in the same environment can share the same secrets. For example, a database password, i.e. `db_password`, can be used in a database container and a Wordpress container. Once a secret is created, the secret value **cannot** be edited or updated. If you need to change an existing value of a secret, the only way to do so is to delete the secret. After a secret has been updated, any services using the secret will need to be re-launched with the updated secret.

#### Creating secrets using Rancher CLI

There are two ways to create secrets from the cli. One is by providing the secret value through standard input (stdin), and one by passing the filename containing the secret to be added.

##### Example of adding a secret through standard input (stdin)
```bash
$ rancher secrets create name-of-secret - <<< secret-value
```

##### Example of adding a secret by passing the filename containing the secret
```bash
$ echo secret-value > file-with-secret
$ rancher secrets create name-of-secret file-with-secret
```

#### Creating secrets in the UI

Go to **Infrastructure** -> **Secrets**. Provide a **Name** and a **Secret Value** and **Save** the secret.

### Deleting Secrets

> **Note:** Rancher CLI currently does not support deleting secrets.

In the UI, secrets can be deleted from Rancher, but it does not remove the secret (i.e. file) from any container using the secret or on the host that are running containers using a secret.

### Enabling Secrets in Containers

In order to consume secrets in containers, the **Rancher Secrets** service will need to be launched. This service can be deployed by either adding it to [environment templates]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#what-is-an-environment-template) so that it's deployed on all [environments]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/) or by launching it directly from the [Rancher Catalog]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/catalog/). If you are adding this service to an existing environment, navigate to **Catalog** -> **Library** and search for the **Rancher Secrets** entry. Without launching this catalog entry, you will only be able create secrets, but not be able to use them in your containers.

### Adding Secrets to Services/Containers

When secrets are added to a container, the secrets are written to a tmpfs volume, which can be accessible from the container and the host.

* Inside the container: The volume is mounted at `/run/secrets/`.
* On the host that is running the container using the secrets: The volume is mounted at `/var/lib/rancher/volumes/rancher-secrets/`.

#### Adding secrets using Rancher CLI

> **Note:** Secrets were introduced in compose file version 3. As Rancher does not support compose version 3, we enabled the use of secrets in version 2, which can be used with the [Rancher CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cli/), but not the [rancher-compose CLI]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/cattle/rancher-compose/). 

For default usage of secrets, you can reference the secret by name in the secrets array in the `docker-compose.yml`. The target filename will be the same name as the name of the secret. By default, the target filename will be created as User ID and Group ID `0`, and File Mode of `0444`. Setting `external` to `true` in the `secrets` part will make sure it knows the secret has already been created.

##### Example basic `docker-compose.yml`
```yaml
version: '2'
services:
  web:
    image: sdelements/lets-chat
    stdin_open: true
    secrets:
    - name-of-secret
    labels:
      io.rancher.container.pull_image: always
secrets:
  name-of-secret:
    external: true
```

If you want to change the default values of secrets, you can use `target` for the target filename, `uid` and `gid` for setting User ID and Group ID, and `mode` for setting File Mode.

##### Example changing parameters `docker-compose.yml`
```yaml
version: '2'
services:
  web:
    image: sdelements/lets-chat
    stdin_open: true
    secrets:
    - source: name-of-secret
      target: different-target-filename
      uid: "1"
      gid: "1"
      mode: 0400
    labels:
      io.rancher.container.pull_image: always
secrets:
  name-of-secret:
    external: true
```

You can also specify multiple secrets, and create the secret while starting the stack. To do this you specify the `file` parameter, the contents of the the specified file will be used to create the secret before creating the stack and starting the service(s).

##### Example multiple secrets `docker-compose.yml`
```yaml
version: '2'
services:
  web:
    image: sdelements/lets-chat
    stdin_open: true
    secrets:
    - name-of-secret
    - another-name-of-secret
    labels:
      io.rancher.container.pull_image: always
secrets:
  name-of-secret:
    external: true
  another-name-of-secret:
    file: ./another-secret
```

#### Adding secrets in the UI

Secrets can be added into a service/container under the **Secrets** tab during service/container creation.

1. Select **Add Secret**
2.  The list of available secrets that have been created in Rancher is available in a drop down. Select the secret that you'd like to use.
3.  (Optional) Input a different filename for the secrets file. By default, it will use the name of the secret for the filename.
4. (Optional) If the default file mode needs to be modified, click the **Customize file ownership & permissions** link. The User ID, Group ID and File Mode (octal) can be updated. By default, the User ID is `0`, the Group ID is `0` and the file mode is `0444`.
5. Click **Create**.

### Docker Hub Images

Docker has provided support in many of their official repositories to enable passing secrets through files. To take advantage of this, append `_FILE` to the environment variable name and the value would be `/run/secrets/<NAME>`. When the container starts up, the value in the file will be assigned to the environment variable.

For example, when launching a MySQL container you can set environment variables to:

```
-e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_password
```

The `MYSQL_ROOT_PASSWORD` environment variable will use the value from the file.

### Known Vulnerabilities

#### Compromised Rancher server container

Secrets stored in Rancher contain the same level of trust as CI systems such as Travis CI and Drone. Since the encryption keys are stored directly in the Rancher server container, any compromise of the Rancher server should be treated as a compromise of your secret data. Rancher will be working to mitigate this condition in a future release.

> **Note:** If you are using Vault for your encryption, create a policy that limits the access of the token used by Rancher server.

#### Compromised Host

If a host is compromised, secrets of all containers on the host can be accessed. The attacker can not list or request additional secrets to be placed on a host.

#### Container Access
If a user has access to be able to execute into a container, the secrets of the container can be accessed through the volume stored in the container. Containers can be accessed through the following methods:  

  * UI Access through "Exec Shell"
  * Rancher CLI
  * Docker
