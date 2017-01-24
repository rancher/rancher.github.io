---
title: Setting up Access Control using the API
layout: rancher-api-v2-beta-default-v1.4
version: v1.4
lang: en
apiVersion: v2-beta
---

## Setting up Access Control using the API
---

Rancher has two methods of authentication in the API. There is our original method of authentication which has its own top-level API type for configuration specific to each authentication provider.  
There is also an [authentication service that runs as a separate go micro-service](https://github.com/rancher/rancher-auth-service/wiki), which has a general configuration that can be used for many authentication providers.

### Authentication Providers using top-level API

* Active Directory: `/v2-beta/ldapconfig`
* Azure AD: `/v2-beta/azureadconfig` (this is a web service available Azure and has nothing to do with actual Active Directory)
* OpenLDAP: `/v2-beta/openldapconfig`
* Local Rancher DB: `/v2-beta/localauthconfig`

### Authentication Providers using Authentication service

* Public & Enterprise Github: `/v1-auth/config`
* Shibboleth (SAML): `v1-auth/config`

### Access Modes

The authentication provider may have many users in it (i.e. the whole world, for public GitHub), so it may be desired to restrict access to Rancher to a subset of the valid users that it contains.  The `accessMode` and `allowedIdentities` parameters in each driver control this.

#### Provider + Access Mode availability:

Provider         | Config URL          | Config Schema   | Unrestricted | Restricted    | Required
-----------------|---------------------|-----------------|--------------|---------------|---------
Active Directory | `/v2-beta/ldapconfig`      | ldapconfig      | 1.0          | 1.1-dev5      | 1.1-dev5
Azure AD         | `/v2-beta/azureadconfig`   | azureadconfig   | 1.1-dev5     | Future        | Future
OpenLDAP         | `/v2-beta/openldapconfig`  | openldapconfig  | 1.0          | Future        | Future
GitHub*          | `/v1-auth/config`    | config    | 1.0       | 1.0           | 1.1-dev5         
Rancher Local    | `/v2-beta/localauthconfig` | localauthconfig | 1.0          | N/A**          | N/A**
Shibboleth          | `/v1-auth/config`    | config    | 1.2        | 1.2           | 1.2        

<br>

*: The GitHub provider supports both public GitHub and private GitHub Enterprise installations.
**: Users are directly defined and managed in Rancher local auth, so restricted/required are not needed.

#### Access Modes:
* `unrestricted`
  * Any valid user in the auth provider can login.
* `restricted`
  * The specific set of users/groups in `allowedIdentities` can login.
  * In addition, anyone added as a member of a Environment (in the UI; `project` in the API) can login.
* `required`
  * Strictly the specific set of users/groups in `allowedIdentities` can login.  
  * A member of an Environment must also be in the `allowedIdentities` list to login.

### Enabling Access Control

The Rancher UI performs a 3-step process to safely enable access control.  If you are automating and are sure the configuration is correct, you can skip the first two requests and go straight to [Enabling](#enabling).

#### Configure the desired provider

Generate a completed config object for the desired provider, with `enabled: false`.  

Depending on your provider, you either submit it as the body of `POST /v2-beta/<desired provider config>` or `POST /v1-auth/config`.

#### Test the generation of an access token

`POST /v2-beta/token` `{code: "<code string for provider>"}`

See [Generating an Auth Token](#generating-an-auth-token) below for more info.  If token generation fails, something is wrong with the config and you would have probably been locked out if `enabled` were set to `true`.

#### Enabling

Re-submit the config object to `POST /v2-beta/<desired provider config>` or `POST /v1-auth/config`, this time with `enabled:true`.

##### Generating an Auth Token
`POST /v2-beta/token {code: "<code string for provider>"}`

For GitHub, the code string is the value sent back from the GitHub Oauth redirect.  For other providers, the string is separated by a colon between user credentials (i.e. `<username>:<password>`).

If authentication succeeds a token good for 16 hours will be returned and the configuration is working.  This can be sent as an `Authorization: Bearer <token>` header to authenticate future requests.

### Looking up Identities

Users, groups, and/or organizations can be looked up with the `/v2-beta/identities` endpoint.  For most providers, `GET /v2-beta/identities` will return the groups or organizations the authenticated user is a member of.  Other names can be searched for with `GET /v2-beta/identities?name=<NAME>`.

### Managing Allowed Identities

Identities minimally consist of an `externalIdType`, which identifies what provider & resource type the user/group/org is, and `externalId` which is the specific identifier for that resource.  Identities should be looked up (as above) rather than manually generated.  For example in GitHub the `externalId` is the user/org's user_id, which is not generally well known.

In supported provider configs there is an `allowedIdentities` array which contains the list of allowed users/groups/orgs for "restricted" and "required" `accessMode`s.  To update the list, `POST /v2-beta/<configured provider config>` with a new list.  The secret parts of the config (e.g. service account passwords) can be left null to keep their current values.

### Getting the currently enabled access control provider

`GET /v2-beta/token` with no Authorization information sent will return the provider that is configured, along with the public pieces of information needed to use it.  For example, with Github a `redirectUrl` which contains the protocol and Enterprise `hostname`, if configured, will be returned.

### Disabling Access Control

`POST /v2-beta/<enabled provider config>` or `POST /v1-auth/config` with `enabled: false`

### Changing Access Control providers

In general we do not recommend this.  Once access control is disabled, it can be re-enabled for a different provider.  Rancher has no way to know who to associate to what account to what identity when you switch providers, so the `externalId`/`externalIdType` will not be modified on existing accounts.  Existing accounts and environments will no longer be accessible.  This can be manually corrected in the database or the API by going through each account (i.e. `/v2-beta/accounts?kind=admin` and `/v2-beta/accounts?kind=user`) and editing those fields.
