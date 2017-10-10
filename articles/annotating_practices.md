---
title: "Best practices for annotating your data"
layout: article
excerpt: Synapse makes data queryable through sets of key-value pairs ascribed to each Synapse entity.
order: 2
category: inpractice
---

<style>
#image {
    width: 100%;
    }
</style>

# Overview 
To annotate your data properly it is important to consider the nature of the data you are sharing, how you are sharing it, and how you anticipate users querying it. For example, proper annotations will enable users to be able to find data by biological area of interest,data type that suits a particular form of analysis, or data derived from a project of interest.

# Plan file and folder structure
Before creating a project think about what data and metadata will be shared, who it will be shared with, and if there are any restrictions on the use of the data that people you are sharing it with have to comply with. Each Synapse Folder can be restricted to a set of users or Team of users, so data with the same sharing permissions should be in the same folder if possible.

# Determining a metadata dictionary
Due to the nature of metadata, it is important to have a fixed metadata dictionary across a project. This prevents conflicts in capitalization (e.g. rnaseq vs rnaSeq) or spacing (e.g. gene expression vs. geneExpression) that would break most programmatic queries.

## Annotation dictionaries
Sage Bionetworks currently maintains a set of key-value pairs that are reccommended for use by existing Synapse projects. Using existing metadata dictionaries enable cross-project queries so that any of your data files can be found by another user. There are multipel ways to exploer the annotation dictionaries maintained by Sage.
* Browse the metadata dictionaries using our [web tool](https://shiny.synapse.org/users/nsanati/annotationUI/)
* Search the [Synapse Table](https://www.synapse.org/#!Synapse:syn10242922) of available key-value pairs
* Navigate to the GitHub repository that we use to maintain and update our dictionary: http://www.github.com/sage-bionetworks/synapseAnnotations.  

## Annotation modules
It is not recommended to apply all annotations to all projects, as many projects produce different types of resources that require data-specific annotations. To accomodate this the Sage Bionetworks annotation dictionaries can be broken down into 'modules' that represent different classes of data or disease areas. These modules are represented by the checkboxes on the left side of the [web tool](https://shiny.synapse.org/users/nsanati/annotationUI/), highlighted in red below.

<img id="image" style="float:right" src="/assets/images/annotationUIwithModules.png">

# Applying annotations in bulk
There are multiple ways to apply annotations to files. The [annotation documentation page]() describes how to ascribe annotations to files within your workflow using the R, Python or web Synapse clients. This section will describe how to annotate files in bulk as you might want to do when preparing to share data with the broader scientific community. 

## Using the synapse command-line client
--> this is only available in the python client, would like to wait until we cna do this at command line

## Using utilities

# Using annotations in your project

## Using file views

## Querying programmatically 

