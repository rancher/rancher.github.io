---
title: API Common Resource Fields
layout: rancher-default
---

## Experimenting with the API

- Click user menu -> keys -> endpoint
- Click around to navigate resources
- Action buttons in the top-right to crate/edit/delete resources
- Show request shows you the curl and HTTP request
- Send request makes the actual request from the browser

## Terminology

Currently, the v1 API terminology does not line up with with the UI. Please note the specific cases:

In the UI, there is an [environment]({{site.baseurl}}/rancher/configuration/environments/), which is the equivalent of a [project]({{site.baseurl}}/rancher/api/api-resources/project) in the API. Anything prefixed with "project" is referring to an environment in the UI. 

In the UI, there is a [stack]({{site.baseurl}}/rancher/rancher-ui/applications/stacks/), which is the equivalent of a [environment]({{site.baseurl}}/rancher/api/api-resources/environment) in the API. Anything prefixed with "environment" is referring to a stack in the UI. 

In the documentation, we have used the UI term in descriptions and have provided additional disclaimers on the differences.

## Authentication

### Creating an API key for a project

### Creating an API key for a user

### Users can create more projects and manage any project they have access to.

Clarification of what user API keys can do vs. project API keys

## Scoping

- Projects credentials only see their one project, so they can skip /v1/projects/:id
- /v1/projects/1a5 for a user === /v1 for a project

## Making requests

- Don't construct URL strings, except for top-level requests.
- Get all things with /v1/{type}
- Get a specific one with /v1/{type}/{id}
- For related resources, follow one of the URLs in the `links` map
- To perform actions on a resource, POST to the appropriate URL in the `actions` map.
- To edit, PUT to the links.self URL
- To delete, send DELETE to the links.self URL.
- To create a new resource, POST to the collection URL

## Filtering
- The same basic info as in the API spec..  {field}{_condition}={value}
- `filters` map on collections shows you which fields can be filtered on and what the filtered values were for the request
- Filters can be combined, but are always AND-ed together

## Sorting
- sortLinks tells you which fields can be sorted
- sort tells you the current sort, direction, and has link to reverse it.

## Pagination
- Default is 100 per page, max 1000
- pagination map tells you if you have the whole result and links to next page.

## WebSockets
- Some things (logs, stats, shell) are web sockets.. follow the link or execute the action and you'll get back a URL and a token.  Open web socket request to the URL and send the token as `Authorization: Bearer <token>` or add `token=<token>` as a query param to the URL if in a browser.