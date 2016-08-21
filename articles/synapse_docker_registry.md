---
title: Synapse Docker Registry
layout: article
excerpt: The basics of using the synapse docker registry
---

##Synapse Docker Registry
Synapse now has its own docker registry which will allow you to have private docker repositories.  Please click [here](https://www.docker.com/products/overview) to learn how to use docker for mac, windows or linux. Below is a brief tutorial on how to use the synapse docker registry using the command line.

### Step 1. Check out or build some images
**Check out some images**

```
docker pull ubuntu
```

**Build your own image from a Dockerfile**

```
docker build -t  docker.synapse.org/syn12345/my-repo path/to/dockerfile
```

###Step 2. View your images
```
docker images
#REPOSITORY	TAG	IMAGE ID	CREATED	SIZE
#ubuntu	latest	f8d79ba03c00	6 days ago	126.4 MB
#docker.synapse.org/syn12345/my-repo	latest	df323sdf123d	2 days ago	200.3 MB
```

###Step 3. Tag your image
```
docker tag f8d79ba03c00 docker.synapse.org/syn12345/mytestrepo:version1 
#syntax: docker.synapse.org/<projectId>/<repoName>:<tag>
```
You can also choose to not tag your image with anything, which will by default tag it with `latest`.
```
docker tag f8d79ba03c00 docker.synapse.org/syn12345/mytestrepo
```

###Step 4. View the new tag
```
docker images
#REPOSITORY                                 TAG                 IMAGE ID            CREATED             SIZE
#docker.synapse.org/syn12345/mytestrepo   version1            f8d79ba03c00        6 days ago          126.4 MB
#ubuntu                                     latest              f8d79ba03c00        6 days ago          126.4 MB
#docker.synapse.org/syn12345/my-repo	latest	df323sdf123d	2 days ago	200.3 MB
```

###Step 5. Login to Synapse (optional if you are already logged in)
```
docker login docker.synapse.org
#Username: (Input Synapse username)
#Password: 
#Login Succeeded 
```

###Step 6. Push your images
```
docker push docker.synapse.org/syn12345/mytestrepo:version1
docker push docker.synapse.org/syn12345/my-repo
```

###Step 7. Go to Synapse to view your new repo entity.
Due to the fact that this feature has not been officially launched, it is still in alpha mode.  Read more about alpha mode here.

###Step 8. Pulling down a Synapse docker repository
```
docker pull docker.synapse.org/syn12345/my-repo
#By default, if you do not specify a tag, it will attach "latest" as the tag.  If you specified a tag on your repository, be sure to pull the repository with the tag.
docker pull docker.synapse.org/syn12345/mytestrepo:version1
```