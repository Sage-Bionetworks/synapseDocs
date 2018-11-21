---
title: Client Configuration
layout: article
excerpt: How to fine-tune your config file.
category: howto
---

# Overview

The programmatic clients in Synapse can use a configuration file (called `.synapseConfig`) that can store frequently used client-interactions. The most commonly used example is storing your login credentials for quick and easy authentication when using the programmatic clients. However, this config file can take many more parameters, such as:

- specifying a new cache location
- add credentials to access files stored outside of Synapse storage (e.g. AWS-S3, etc.)


# Example Config File

The code block below displays an example config file with the available parameters commented out. This file should be named `.synapseConfig` and saved to your home directory. Please note the period at the beginning of the file which makes this a hidden, system file on Linux-like OS's since it will contain sensitive information.

```bash
###########################
# Login Credentials       #
###########################
## Used for logging in to Synapse.
## You may also specify an API key instead of a password. If both password and API key are specified, the API key is ignored.
## Using an API key allows you to authenticate your scripts for an indefinite amount of time. It is important that you treat your API key with the same security as your password.
#[authentication]
#username = <username>
#password = <password>
#apikey = <apikey>
 
 
## If you have projects that need to be stored in an S3-like (e.g. AWS S3, Openstack) storage but cannot allow Synapse
## to manage access your storage you may put your credentials here.
## To avoid duplicating credentials with that used by the AWS Command Line Client,
## put the profile name form your ~/.aws/credentials file
## more information about aws credentials can be found here http://docs.aws.amazon.com/cli/latest/userguide/cli-config-files.html
#[https://s3.amazonaws.com/bucket_name] # this is the bucket's endpoint
#profile_name=local_credential_profile_name
 
 
###########################
# Debugging               #
###########################  
## If this section is specified, then the Synapse client will print out debug information
# [debug]
 
 
###########################
# Caching                 #
###########################
## your downloaded files are cached to avoid repeat downloads of the same file. change 'location' to use a different folder on your computer as the cache location
# [cache]
# location = <your cache location>
```

<br/>

## Example Synapse client configuration

When you install the [Synapse Python client](https://python-docs.synapse.org/build/html/index.html#installation), a `.synapseConfig` file filled with examples, much like the sample above, should appear in your home directory if a configuration file is not already present. You can uncomment and fill out the parameters of interest for you to use. 

Currently, this feature is not available in `synapser` (the Synapse R client).

## See Also

[Getting Started](docs.synapse.org/articles/getting_started.html), [Custom Storage Locations](http://docs.synapse.org/articles/custom_storage_location.html), [Downloading Data](http://docs.synapse.org/articles/downloading_data.html)
