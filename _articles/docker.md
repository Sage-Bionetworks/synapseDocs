---
title: Synapse Docker Registry
layout: article
excerpt: The Synapse Docker registry provides a space for Synapse users to store and distribute their Docker images per Synapse project.
category: reproducible-research
---

Docker is a tool for creating, running, and managing lightweight virtual machines. These virtual machines make it possible to distribute executable environments with all of the dependencies that can easily be run by others. These Docker images can then be stored and distributed on a Docker registry, a collection of these images. There are a number of open registries on the web, and Synapse hosts a private registry, freely available to our users, which will allow users to create software on a per project basis which can be easily shared across Synapse. Learn more about [Docker](https://www.docker.com/products/overview) and [Docker registry](https://www.docker.com/products/docker-registry).

Registered Synapse users interact with the Synapse Docker registry using the standard Docker client. If you have not yet created an account, please first [register for Synapse](https://docs.synapse.org/articles/getting_started.html#create-your-account). 

In Synapse, Docker containers are represented as versioned 'repositories' under the 'Docker' tab. As with Files and Tables, repositories are organized by project and inherit the access permissions from the parent project. [Local Sharing Settings](https://docs.synapse.org/articles/sharing_settings.html#sharing-files-folders-and-tables) can be applied directly to the repository if permissions should differ from the project.

To learn more about working with Docker using one of our programmatic clients, including code examples for the below tasks, see:

* Docker in [Python Docs](https://python-docs.synapse.org/build/html/Entity.html?highlight=docker#synapseclient.entity.DockerRepository).
* Docker in [R Docs](https://r-docs.synapse.org/articles/docker.html).


## Creating a new Docker image

Let's begin by creating a custom Docker image.  Users can choose to either modify an existing Docker image or build a Docker image from a Dockerfile.  Docker images must be tagged with 'docker.synapse.org/synapseProjectId/myreponame' to allow images to be saved.

**Tagging an existing Docker image to save onto the Synapse registry**

``` console
docker pull ubuntu
```

To tag an existing Docker image, users can use the IMAGE ID or the repo name.  The IMAGE ID can be found by doing:

``` console
docker images
#REPOSITORY	TAG	IMAGE ID	CREATED	SIZE
#ubuntu	latest	f8d79ba03c00	6 days ago	126.4 MB
```

Tag the Docker image:

``` console
docker tag f8d79ba03c00 docker.synapse.org/syn12345/mytestrepo:version1
#or
docker tag ubuntu:latest docker.synapse.org/syn12345/mytestrepo:version1
#syntax: docker.synapse.org/<projectId>/<repoName>:<tag>
```

You can also choose to not tag your image with an explicit tag, which will by default tag it with `latest`.

``` console
docker tag f8d79ba03c00 docker.synapse.org/syn12345/mytestrepo
```

**Build your own image from a Dockerfile**
When building a Docker image from a Dockerfile, add a `-t` to the docker build command with the correct Synapse Docker registry tag.

``` console
docker build -t  docker.synapse.org/syn12345/my-repo path/to/dockerfile
```

Learn more about building [Docker images](https://docs.docker.com/engine/getstarted/step_four/).  

## Storing Docker images in the Synapse Docker registry

To store Docker images, use the `docker push` command.  To push to the Synapse Docker registry, users must be logged into the registry, be a Synapse certified user and have edit permissions:

``` console
docker login -u <synapse username> -p <synapse password> docker.synapse.org
```

After logging in, view your images and decide which ones to push into the registry.

``` console
docker images
#REPOSITORY                                 TAG                 IMAGE ID            CREATED             SIZE
#docker.synapse.org/syn12345/mytestrepo   version1            f8d79ba03c00        6 days ago          126.4 MB
#ubuntu                                     latest              f8d79ba03c00        6 days ago          126.4 MB
#docker.synapse.org/syn12345/my-repo	latest	df323sdf123d	2 days ago	200.3 MB


docker push docker.synapse.org/syn12345/mytestrepo:version1

docker push docker.synapse.org/syn12345/my-repo
```

Note: There is a 100GB limit per repository [image layer](https://docs.docker.com/storage/storagedriver/#images-and-layers).

Note: An alternate way to log in, rather than using a user name and password, is with an OAuth access token.  This is unusual when using the Docker command line client, but may occur when using a Docker client within a system that authenticates using the OAuth protocol.  In this case the 'user' field is ignored and the 'password' field is interpreted as the access token.  To perform `docker pull` operations the OAuth token must have `download` scope.  To perform `docker push` operations the token must have `download` and `modify` scopes.

``` console
docker login -u <anything> -p <access token> docker.synapse.org
```

## Using Docker images stored in the Synapse Docker registry

To access the Docker images stored in Synapse, use the `docker pull` command. To pull from the Synapse Docker registry, users must be logged into the registry and have download permissions:

{% include tip.html content="By default, if you do not specify a tag, it will attach latest as the tag.  If you specified a tag on your repository, be sure to pull the repository with the tag." %}

``` console
docker login -u <synapse username> -p <synapse password> docker.synapse.org
docker pull docker.synapse.org/syn12345/my-repo
```

Docker tags can be assigned to later commits. If you want to be explicit about the version of an image then instead of referencing a tag you can reference a digest:

``` console
docker pull docker.synapse.org/syn12345/mytestrepo@sha256:2e36829f986351042e28242ae386913645a7b41b25844fb39b29af0bdf8dcb63
```

where the digest for a commit is printed to the command line after a successful `docker push`. The Synapse web portal displays current digests for a repository's tags on the repository's Synapse page.

{% include note.html content="You can add external repositories, i.e. repositories that live in other registries like DockerHub and quay.io. For these repositories there is no tight integration (Synapse doesn't contact these external registries) but it allows you to list Docker repositories that are relevant to the project but are not within Synapse.
" %}

## Debugging Issues

While using the Docker client with the Synapse Docker registry, you may encounter an `unauthorized: authentication required` error. 

To rule out an erroneous user name or password, try logging in: 

```
docker login docker.synapse.org
```

Once login succeeds, the correct credentials will be cached on the machine and any further issues can be attributed to insufficient access permissions or a deleted container. 

To pull a container from a Synapse Docker repository, you must have download permissions in the sharing settings of the Synapse Docker repository. In Synapse, Docker repositories have names of the form: docker.synapse.org/syn123456/repo-name, where syn123456 is the project ID. Navigate to syn123456 to check the project's sharing settings. To push a new container to a Synapse Docker repository, you must be a Synapse certified user and have edit permissions. To push a change to an existing Synapse Docker repository, you must also have edit permissions. If the container is in the trash can, all operations will fail.
