---
title: Secrets in Rancher
layout: rancher-default-v1.4
version: v1.4
lang: en
---

## Secrets
---

In Rancher 1.4 Rancher Secrets are being introduced as an experimental feature. A user can now create named secrets for use in their containers. Rancher interfaces with an encryption backend, either a local key AES or Vault Transit, to securely store the values within in Rancher. 


### Configuration

By default Rancher server has the local key backend enabled. This will use a locally stored AES256 encryption key to perform the encryption of secrets. The encrypted values are then stored in the Rancher MySQL database.

Alternatively, you could configure the encryption service to use Vault Transit to perform the encryption. To use Vault, you will first need to mount the Vault transit backend, create a key named `rancher`, and a token that can encrypt/decrypt using that key.

To configure Vault as the Rancher backend, you need to alter the Docker run command of `rancher/server` command line to:

```
docker run -d --restart unless-stopped -p 8080:8080 -e VAULT_ADDR=https://<vault_server> -e VAULT_TOKEN=<token_for_vault_access> rancher/server
```

Once the server is up and running, on the Admin-Settings tab under `Advanced` change the value of `secrets.backend` from `localkey` to `vault`
> Note: as of this time you can not switch between backend. 

> Note: The token used for the Vault backend should be scoped with a policy to just the Rancher servers use of Vault Transit endpoints for:
> 
>  transit/random/_key_
> 
>  transit/hmac/_key_
> 
>  transit/encrypt/_key_
> 
>  transit/decrypt/_key_
> 
>  transit/verify/_key_
> 
> Where _key_ will need to be `rancher` at this time.

In order to consume secrets in containers, you need to launch the `Rancher Secrets` experimental catalog entry in the 'Library' catalog. Otherwise, you can create secrets, but you can't consume them.

### Creating Secrets

Secrets are created and scoped at an environment level. Applications can share these secrets, for instance a database password `db_password` can be used in both the database container and the Wordpress container. 

To create a secret from the UI go to the Infrastructure->Secrets tab. There you can create a key value pair for the secret. 

Secrets can not be edited or updated. In order to update a secret the user has to create a new, or delete/recreate the password and redeploy the services with the updated secret.

Deleting the secret in Rancher does not remove the secret or file from the host.

### Adding Secrets to Services/Containers

Rancher secrets largely lines up with the UX of Docker secrets API. 

> Note: Support in the CLI is coming in a future release.

Within the UI, on the create container or create service modal there is now a `Secrets` tab. 

* Select Add Secret
* Select the secret from the drop down
* You can optionaly set the name of the file it will be written to.
* If you need finer grained controls click the `customize file ownership & permissions` link. There you can set UID, GID and Mode for the file.

Click `Create`

The Secret will be written to a tmpfs volume mounted at `/run/secrets` inside the container. The filename will be either the secret name or the aliased name. And it will be writen with the designated file mode (default: 0444), UID (default: 0) and GID (default: 0)

If you are using images from the Docker Hub Library, there is support in popular images to give the environment variable with an additional `_FILE`. For example when launching the MySQL container you can set enviornment variables like so:

`-e MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db_password`

The `MYSQL_ROOT_PASSWORD` env var will use the value from the file. 

### Security Threat Model

* Compromised management server exposes the encryption keys. 

The secrets stored in Rancher provide about the same level of trust as CI systems such as TravisCI and Drone. The encryption keys are stored on the Management servers, and a compromise of the server should be treated as a compromise of your secret data.

We recognize this as a short coming, and will be working to mitigate this condition in future releases. 

Again, if you are using Vault create a policy that limits access of the token used by the management server.

* Compromised compute nodes

If a compute node is compromised, the attacker has access to the secrets on the host. The attacker can not list or request additional secrets be placed on the host. 

* Console within the UI

If a user gains access to the container consoles in the UI, they can enter the container and get at the contents of the secrets stored in the volume.