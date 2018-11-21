---
title: "Digital Object Identifiers (DOIs) in Synapse"
layout: article
excerpt: Mint DOIs in Synapse to cite your research.
category: howto
---

<style>
#image {
    width: 35%;
}
#tableImage {
    width: 65%;
}
#tableImage:hover {
    transform: scale(3.0);
    outline: 1px solid #1e7098;
}
#image:hover {
    transform: scale(3.0);
    outline: 1px solid #1e7098;
}
</style>

# Overview

A Digital Object Identifier (DOI) is an alphanumeric string assigned to uniquely identify an object. It is tied to a metadata description of the object as well as to a digital location, such as a URL, where all the details about the object are accessible. In order to create new DOIs and assign them to your content, it is necessary to use a service to "mint" or create a DOI for your data or project. 

`DOIs` are available in Synapse both on the `Project` level and on `Files/Folders` to provide a mechanism to uniquely identify your data when used in a publication or linked to from elsewhere on the web. For example, the DOI `doi:10.7303/syn2580853` can be represented as a URL, [https://doi.org/10.7303/syn2580853](https://doi.org/10.7303/syn2580853), which automatically resolves to the Synapse `Project` it's associated with, the [AMP-AD Knowledge Portal](https://www.synapse.org/#!Synapse:syn2580853). 

## Minting DOIs

Navigate to the data or project you'd like to create a DOI for; for example, you can create DOIs for `Files`, `Folders`, or entire `Projects` (support for `Tables` coming soon). From the Tools Menu, select the option for "Create DOI" for the object in question, or choose "Create DOI" from the "Project Settings" menu if minting a DOI for an entire project. 

If you do not see these options, you either do not have permission to do so (only users with Edit or Administrator access may mint DOIs for objects), or a DOI may have already been created. Check the information below the object name for a DOI field; Synapse does not allow you to mint more than one DOI per object. 
