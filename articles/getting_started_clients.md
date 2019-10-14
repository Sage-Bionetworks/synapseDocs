---
title: "Getting Started with the Synapse API Clients"
layout: article
excerpt: Use Synapse programmatically.
category: apiclient
order: 1
---

The API clients provide a way to use Synapse programmatically. This page shows you how to install and login to get you started. Packages to interface and access data within Synapse are available for:

* Command Line
* Python
* R

To manage stored login credentials, visit the [Client Configuration page](client_configuration.md).

## Command Line

The Synapse command line client is implemented in Python and comes with the Synapse Python package. To install the Synapse command line client, please make sure that you have `Python` and `pip` installed.
[Instruction on `Python` installation](https://www.python.org/downloads/)
[Instruction on `pip` installation](https://pip.pypa.io/en/stable/installing/)

After installing `pip` and `python`, in your terminal (Mac OS or GNU/Linux) or Command Prompt (Windows), run the following command:

```console
pip install synapseclient
```

```console
synapseclient login "username" "password"
synapseclient -h
```

For more documentation on the command line client, see the [`synapseclient` docs](https://python-docs.synapse.org/build/html/CommandLineClient.html).

## Python

The `synapseclient` package is available to use Python to access Synapse. See the [Python client docs](https://python-docs.synapse.org/build/html/index.html#overview) for supported versions of Python.

```python
pip install synapseclient
```

For complete documentation of the Python client, visit the [`synapseclient` docs](https://python-docs.synapse.org/build/html/index.html).

## R

The `synapser` package is available for R version 3.4 and 3.5.

```R
install.packages("synapser", repos=c("http://ran.synapse.org", "http://cran.fhcrc.org"))
install.packages("synapser")
```

```R
library(synapser)
synLogin("username", "password")
```

For more documentation on the R client, see [`synapser` R docs](https://r-docs.synapse.org).

# To Report an Issue

Report client-specific issues or bugs at the [R client](https://github.com/Sage-Bionetworks/synapser/issues) or [Python (including the command line client)](https://github.com/Sage-Bionetworks/synapsePythonClient/issues) GitHub Issues pages. If you have questions on how to use the clients to interact with Synapse, please ask in the [Synapse Help Forum](https://www.synapse.org/#!SynapseForum:default).
