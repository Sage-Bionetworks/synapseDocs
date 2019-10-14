---
title: Client Configuration
layout: article
excerpt: How to store login credentials and fine-tune your config file.
category: apiclient
order: 2
---

## For Users

Store login credentials from the current `login()` using the `rememberMe = TRUE` parameter. You should use the `rememberMe` feature on a personal computer of which you are the only Synapse user.
Visit the [Python `synapseclient` docs](https://python-docs.synapse.org/build/html/Client.html#synapseclient.Synapse.login) and [R `synapser` docs](https://r-docs.synapse.org/reference/synLogin.html) for examples.

## For Developers

### Customize the Synapse Configuration File

Synapse configuration parameters for frequently used client-interactions can be set in a specific file. By default, the file is in the user's home directory and is called `.synapseConfig`. For example, you can set:

- a new cache location
- credentials to access files stored outside of Synapse (e.g. AWS-S3, etc.)
- an API key to authenticate login

Please note the period at the beginning of the file which makes this a hidden, system file on Linux-like OS's since it will contain sensitive information. 

When you install the [Synapse Python client](https://python-docs.synapse.org/build/html/index.html#installation), a [`.synapseConfig` file filled with examples](https://github.com/Sage-Bionetworks/synapsePythonClient/blob/master/synapseclient/.synapseConfig) should appear in your home directory if a configuration file is not already present. You can uncomment and fill out the parameters of interest.

You may also [customize a `.synapseConfig` file](https://r-docs.synapse.org/articles/manageSynapseCredentials.html#letting-the-operating-system-manage-your-synapse-credentials) when you install the [Synapse R client](https://r-docs.synapse.org/index.html#installation).

### Where to find your API Key

From your [Synapse homepage](https://www.synapse.org/), navigate to your user menu and select **Settings** from the drop-down menu. Your Synapse API key is made visible by selecting **Show API Key**. In the case the confidentiality of the API key is compromised, or you would like to invalidate your API key, select **Change API Key**.

## See Also

[Getting Started](getting_started.md), [Custom Storage Locations](custom_storage_location.md), [Downloading Data](downloading_data.md)
