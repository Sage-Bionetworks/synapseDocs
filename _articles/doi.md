---
title: "Digital Object Identifiers (DOIs) in Synapse"
layout: article
excerpt: Mint DOIs in Synapse to cite your research.
category: reproducible-research
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

A Digital Object Identifier (DOI) is a persistent identifier assigned to uniquely identify a digital object. A DOI is defined by a digital location like a URL and a description of the object. This description includes attribution and a creation or publication date. Creating and assigning a new DOI is commonly known as "minting". Minting a DOI for things in Synapse allows you to reference them when used elsewhere, such as in a publication or on an external website.

DOIs are available in Synapse for Projects, Files, Folders, Tables, and Views. DOIs that are for objects stored in Synapse have a prefix of `doi:10.7303`. They are then followed by the Synapse ID of the object being linked to, such as `syn2580853`, which is a Synapse project. The DOI `doi:10.7303/syn2580853` can be represented as a URL, [https://doi.org/10.7303/syn2580853](https://doi.org/10.7303/syn2580853), which automatically redirects to the associated Synapse Project, the [AMP-AD Knowledge Portal](https://www.synapse.org/#!Synapse:syn2580853).  

DOIs can be minted for specific versions of Files, Tables, and Views, which ensures that other researchers access the same data that you published, even if it's updated later. When minting a DOI for a version, the synID and URL will have ".xx" appended to it, where "xx" indicates the version number (for example,  `10.7303/syn3539963.2`). If a new version is created, a new DOI will also need to be created to reference the new version.

If a DOI is minted without a version number, then the DOI will always link to the latest version of the object. This can be useful when referencing a living, changing document, where consistent access to the same set of data is less crucial.

While DOIs are designed to be public, minting a DOI does not change the [Sharing Settings](sharing_settings.md) on an object. However, the metadata minted with a DOI, such as title and authors, will be retrievable from other sources, such as [CrossCite](https://citation.crosscite.org/), even if the object is private in Synapse.

## Minting DOIs

1. Navigate to the data or project you'd like to create a DOI for.
1. From the Tools Menu, select the option for "Create DOI" for the object in question, or choose "Create DOI" from the "Project Settings" menu if minting a DOI for an entire project.
1. Fill out the form as needed - you can add other creators if there are other individuals who contributed to the object. You can select a resource type which describes what type of object it is. The title and publication year can be changed, but this is not advisable.

If you do not see these options, you likely do not have permission to create a DOI for the object. Only users with Edit access or above may mint DOIs for objects. You can also update an existing DOI if information has changed.
