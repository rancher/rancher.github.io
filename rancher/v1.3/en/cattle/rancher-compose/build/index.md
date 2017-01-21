---
title: Building with AWS S3 in Rancher Compose
layout: rancher-default-v1.3
version: v1.3
lang: en
redirect_from:
  - /rancher/v1.3/zh/cattle/rancher-compose/build/
---

## Building with AWS S3
---

Docker builds are supported in two ways.  First is to set `build:` to a git or HTTP URL that is compatible with the using the [Docker Remote API](https://docs.docker.com/reference/api/docker_remote_api_v1.18/#build-image-from-a-dockerfile). The second approach is to set `build:` to a local directory and the build context will be uploaded to S3 and then built on demand on each node.

### Requirements

* Docker
* Rancher Compose
* AWS account
* Rancher Server running with 1 Host

In our example, we'll define our application in the `docker-compose.yml` and place the file in a `composetest` directory. The compose file defines a service called `web`, that opens port `5000` of the container to be exposed on the host. There is also a link to a service called `redis`. The application running inside the `web` container will also be able to reach the `redis` container by its hostname `redis`.

```yaml
version: '2'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    links:
      - redis

  redis:
    image: redis
```

We'll also add a `rancher-compose.yml` file to the same `composetest` directory to be able use the `scale` attribute for Rancher. By default, if there is no `rancher-compose.yml` file or the service is not defined, the scale of the service will be one container.

```yaml
version: '2'
services:
  web:
    scale: 3
```

Once the files are set for Rancher Compose, the next step is to write the application itself and steps to build it.

Using the example from the `docker-compose` documentation, we'll create a filed named `app.py`. The application talks to a host called `redis`, which is expected to be running a redis KV store. It increments the value of a key in the store called `hits` and retrieves it.

```yaml
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    return 'Hello World! I have been seen %s times.' % redis.get('hits')

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)
```

The application is dependent on two libraries, so we will also create a file called `requirements.txt`.

```
flask
redis
```

Now, let's define the steps to build the application using a `Dockerfile`. Inside the `Dockerfile`, the instruction define how the application container should be built.

```
FROM python:2.7
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD python app.py
```

Since you already have Rancher server running, you need to set up your AWS credentials and just run Rancher Compose with your Rancher server URL and [API key]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/api/api-keys/).

```bash
# Set up your AWS credentials
$ aws configure
AWS Access Key ID []: AWS_ACCESS_KEY
AWS Secret Access Key []: AWS_SECRET_KEY
Default region name []: NOT_NEEDED_FOR_S3
Default output format [None]:
# Run rancher-compose in your composetest directory where all the files are created
$ rancher-compose --url URL_of_Rancher --access-key username_of_API_key --secret-key password_of_API_key up
```

With the command, the web container should be started on a host in your Rancher server. It will first upload the current directory to S3, which can be verified by going to S3 UI and checking for a new upload. After the image is uploaded, it will download it to the host and build a container using the files that were provided.

### Troubleshooting S3 Builds

If you are having issues with your S3 builds, you can test out your builds in Docker to make sure that your image can be built and the container can run. In the same location as you'd run your Rancher Compose command, use the following commands to test if it would work in Docker.

```bash
# Test building locally to see if works
$ docker build -t test .
# Test running the newly built image
$ docker run test
```
