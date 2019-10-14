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

A Digital Object Identifier (DOI) is a persistent identifier assigned to uniquely identify a digital object. A DOI is defined by a digital location like a URL and a description of the object. This description includes attribution and a creation or publication date. Creating and assigning a new DOI is commonly known as "minting". Minting a DOI for things in Synapse allow you to reference them when used elsewhere, such as in a publication or on an external website.

DOIs are available in Synapse for Projects, Files, Folders, and Tables. DOIs that are for objects stored in Synapse have a prefix of `doi:10.7303`. They are then followed by the Synapse ID of the object being linked to, such as `syn2580853`, which is a Synapse project. The DOI `doi:10.7303/syn2580853` can be represented as a URL, [https://doi.org/10.7303/syn2580853](https://doi.org/10.7303/syn2580853), which automatically redirects to the associated Synapse Project, the [AMP-AD Knowledge Portal](https://www.synapse.org/#!Synapse:syn2580853).

## Minting DOIs

1. Navigate to the data or project you'd like to create a DOI for.
1. From the Tools Menu, select the option for "Create DOI" for the object in question, or choose "Create DOI" from the "Project Settings" menu if minting a DOI for an entire project.
1. Fill out the form as needed - you can add other creators if there are other individuals who contributed to the object. You can select a resource type which describes what type of object it is. The title and publication year can be changed, but this is not advisable.

If you do not see these options, you either do not have permission to do so. Only users with Edit access or above may mint DOIs for objects. You can also update an existing DOI if information has changed.

Files in Synapse can have multiple versions. Their DOI format includes the version number appended at the end, like `10.7303/syn3539963.1`. If a new version is created, a new DOI will also need to be created.
