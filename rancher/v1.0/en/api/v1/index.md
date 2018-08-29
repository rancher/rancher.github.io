---
title: API Common Resource Fields
layout: rancher-api-v1-default-v1.0
version: v1.0
lang: en
apiVersion: v1
---

## How to use the API
---

The API has its own user interface accessible from a web browser.  This is an easy way to see resources, perform actions, and see the equivalent cURL or HTTP request & response.  To access it, click on **API** to find the URL endpoint.

## Terminology

Some of the resource type names used in the API do not match the current terminology used in the UI.  In particular:

| UI | API | Description |
|----|-----|-------------|
| [Environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/) | [project]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/project) | A group of physical resources, such as [hosts]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/host) |
| [Stack]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/rancher-ui/applications/stacks/) | [environment]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/environment) | An (API) environment is a group of services and the level at which rancher-compose operates. |

In the documentation, we have used the UI term in descriptions and have provided additional disclaimers on the differences.  This confusion will be cleared up in a future `/v2` of the API.

## Authentication

API requests must include authentication information if [Access Control]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/) is enabled.  Authentication is done with HTTP basic authentication using [API Keys]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/apiKey/).  API keys can either belong to a single (UI) Environment / (API) [Project]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/project/) with access to just that Environment, or to a [Account]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/{{page.apiVersion}}/api-resources/account) with access to all Environments the account belongs to, and the ability to create new ones.  There is also a separate JSON Web Token interface primarily for the UI.

### API keys for an Environment

Environment API keys can be created in the UI, see [API & Keys]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/api-keys/).  The key is owned by the Environment and has full access to manage that Environment, but no access to any others.  [Membership roles]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/#membership-roles) do not apply to these keys.

### API keys for an Account

Account API keys are not currently exposed in the UI.  You can create one by clicking into the API in a browser:

  - Click on the Endpoint link in the UI
  - Navigate to `/v1/apikeys`
  - Click `Create`
  - Choose the appropriate `accountId` that you want to create a key for
  - Optionally set a `name` and `description`
  - Click `Show Request`, then `Send Request`
  - Save the `publicValue` and `secretValue` in the response

Account keys can create new Environments,  and have can be used to access multiple Environments via `/v1/projects/`.  [Membership roles]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/environments/#membership-roles) apply to these keys and restrict what Environments the account can see and what actions they can take.

## Scoping

- Most resources are owned by an environment and accessible under `/v1/projects/<project_id>/<resource>`
- Since Environment credentials only ever have access to one Environment (project), you can optionally skip the `/project/<project_id>` part.
- For example, if you are working with project `1a5` using an Environment API key, `/v1/projects/1a5` is the same as `/v1` and `/v1/projects/1a5/hosts` is the same as `/v1/hosts`.
- The documentation will generally refer to the shorter `/v1/<type>` version.  If using an Account key, add in the path for the appropriate environment.

## Making requests

The API is generally RESTful but has several features to make the definition of everything discoverable by a client so that generic clients can be written instead of having to write specific code for every type of resource.  For detailed info about the generic API spec, [see here](https://github.com/rancher/api-spec/blob/master/specification.md).

- Every type has a Schema which describes:
  - The URL to get to the collection of this type of resources
  - Every field the resource can have, along with their type, basic validation rules, whether they are required or optional, etc.
  - Every action that is possible on this type of resource, with their inputs and outputs (also as schemas).
  - Every field that filtering is allowed on
  - What HTTP verb methods are available for the collection itself, or for individual resources in the collection.


- So the theory is that you can load just the list of schemas and know everything about the API.  This is in fact how the UI for the API works, it contains no code specific to Rancher itself.  The URL to get Schemas is sent in every HTTP response as a `X-Api-Schemas` header.  From there you can follow the `collection` link on each schema to know where to list resources, and other `links` inside of the returned resources to get any other information.


- In practice, you will probably just want to construct URL strings.  We highly suggest limiting this to the top-level to list a collection (`/v1/<type>`) or get a specific resource (`/v1/<type>/<id>`).  Anything deeper than that is subject to change in future releases.

- Resources have relationships between each other called links.  Each resource includes a map of `links` with the name of the link and the URL to retrieve that information.  Again you should `GET` the resource and then follow the URL in the `links` map, not construct these strings yourself.

- Most resources have actions, which do something or change the state of the resource.  To use these, send a HTTP `POST` to the URL in the `actions` map for the action you want.  Some actions require input or produce output, see the individual documentation for each type or the schemas for specific information.

- To edit a resource, send a HTTP `PUT` to the `links.self` link on the resource with the fields that you want to change.  Unknown fields and ones that are not editable are ignored.

- To delete a resource, send a HTTP `DELETE` to the `links.self` link on the resource.  Note that some resources may need to be deactivated before they can be deleted, and deleted resources can still be retrieved from the API if you ask specifically for them by ID.

- To create a new resource, HTTP `POST` to the collection URL in the schema (which is `/v1/<type>`).

## Filtering

Most collections can be filtered on the server-side by common fields using HTTP query parameters.  The `filters` map shows you what fields can be filtered on and what the filtered values were for the request you made.  The API UI has controls to setup filtering and show you the appropriate request.  For simple "equals" matches it's just `field=value`.  Modifiers can be added to the field name, e.g. `field_gt=42` for "field is greater than 42".  See the [API spec](https://github.com/rancher/api-spec/blob/master/specification.md#filtering) for full details.

## Sorting

Most collections can be sorted on the server-side by common fields using HTTP query parameters.  The `sortLinks` map shows you what sorts are available, along with the URL to get the collection sorted by that.  It also includes info about what the current response was sorted by, if specified.

## Pagination

API responses are paginated with a limit of 100 resources per page by default.  This can be increased to up to 1000 with the `limit=1000` query parameter.  The `pagination` map in collection responses tells you whether or not you have the full result set and has a link to the next page if you do not.

## WebSockets

Several Rancher features such as container logs, shell access, and statistics use WebSockets to stream information.  To use these from the API:

  - Follow the appropriate link or execute the appropriate action
  - The response will include a URL (starting with `ws://` or `wss://`) and a long `token` string.
  - Open a WebSocket client pointed at the URL returned.
  - The token is signed by the Rancher server and allows the host the container is on to authorize the request, so it must be sent to the server as a HTTP header, `Authorization: Bearer <token_string>`.
  - If you are making a request from a web browser you won't be able to send arbitrary HTTP headers, so you can optionally add it as a `token=<token_string>` query parameter on the URL instead.
