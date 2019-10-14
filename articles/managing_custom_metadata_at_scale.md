---
title: Managing Custom Metadata at Scale
layout: article
excerpt: Update metadata in bulk using file views and programmatic clients.
category: inpractice
---

This vignette will combine concepts from [Annotations and Queries](annotation_and_query.md), [Views](views.md), [Uploading and Downloading Data in Bulk](uploading_in_bulk.md) in order to **create a manifest** `velociraptor_manifest.txt`, **upload** 100 files and **edit** annotations on these files using the Synapse clients.

## Annotation dictionaries

The Sage Bionetworks Systems Biology and Computational Oncology teams maintain [annotation dictionaries](https://github.com/sage-bionetworks/synapseAnnotations) in GitHub. You can use the terms found in the synapseAnnotations GitHub repo as a starting point for you own annotations.

## Create a Manifest and Batch Upload the Files with Annotations

To batch upload files, create a tab-delimited manifest which contains, at minimum, the columns `path` and `parent`. You can also add additional annotations as columns in your manifest. For example, your manifest might have the following headers: `path`, `parent`, `specimenID`, `assay`, `species`, `platform`, `sex`, and `fileFormat`.  

**path**: is the local path to your file
**parent**: is the Synapse ID (in the format syn123456) that the files will be uploaded to
**specimenID**: is the unique identifier for each of your specimens
**assay**: is the technology used to generate the data in this file (e.g. rnaSeq, ChIPSeq, wholeGenomeSeq)
**species**: is the species of your sample (e.g. Mouse, Human, Triceratops)
**platform**: is hardware used to generate the data (e.g. HiSeq2500, Affy6.0, HoodDNASequencer)
**sex**: e.g. male or female
**fileFormat**: is the type of file (e.g. fastq, R script)

Here it is in a visual example:

{:.markdown-table}
| path | parent | specimenID | assay | species | platform | sex | fileFormat |
| --- | --- | --- | --- | --- | --- | --- | --- |
| /local/path/to/velociraptor_b.fastq | syn123 | blue_1 | wholeGenomeSeq | Velociraptor mongoliensis | HoodDNASequencer | female | fastq |
| /local/path/to/velociraptor_d.fastq | syn123 | delta_1 | wholeGenomeSeq | Velociraptor mongoliensis | HoodDNASequencer | female | fastq |

See **Creating a Manifest** in [Uploading and Downloading Data in Bulk](uploading_in_bulk.md#Creating-a-Manifest) for additional details.

**Save** this file in a tab-delimited format called `velociraptor_manifest.tsv`.

Files can be uploaded in one go with a manifest file. If you would like to do a "dry run" validation of the file before uploading, you can add the parameter `dryRun = True` to the function `syncToSynapse`. Please note that the `dryRun` feature checks everything but does **not** upload the files.

* validate the manifest and upload files in the [Python client](https://python-docs.synapse.org/build/html/synapseutils.html#synapseutils.sync.syncToSynapse).
* validate the manifest and upload files in the [R client](https://github.com/Sage-Bionetworks/synapserutils#batch-process). 

And ta-da! Your files have been uploaded!

## Create a File View (Web)

Since the files have been uploaded with annotations, a file [View](views.md) allows users to query, facet, and bulk manipulate the files and metadata.

To create your File View:

1. Navigate to your Project.
2. Go to the Tables tab, select **Tables Tools** in the upper right corner, and click **Add File View**.
3. In the resulting pop-up, give the new View a name. 
4. Select the container (Synapse Project or Folder) of files, and click **Next**. In this case, you would want the synID of the `parent` column in the manifest.
5. Select the columns you would like to keep. Since we are going to edit the annotations later, please make sure you have the column `etag` listed as one of your columns.
6. **Add All Annotations** at the end of the opened window will add all existing annotations.
7. Click **Finish** to create the View.

## Perform a One-time Annotation Update or Deletion (Web)

An annotation for a single file can be modified in the Web client View in the case that `specimenID`:`delta_1` needs to be updated to `specimenID`:`echo_1`.

1. Select **Tables Tools** and **Edit Query Results**.
2. Find the value you want to change or delete in the pop-up and edit the field.
3. Scroll down to the bottom and click **Save** to update the file View.

## Do a Bulk Annotation Update or Deletion

A bulk annotation update is required in the case that `species`:`Velociraptor mongoliensis` should be modified to `Utahraptor ostrommaysorum` in all 100 files.

### Web

To download the annotation values from the Web client:

1. Navigate to the file View of choice.
2. Click the **Download Options** button to the right of the query bar of the file View.
3. Click **Export Table** to download the file View. Be sure to have `Include row metadata (Row Id and Row Version)` selected when downloading.

Now that you have the file View downloaded, you can edit the values using your tool of preference, whether that is Python, R, Excel, LibreOffice, etc.

With the changes saved, go back to the file View in your browser.

1. Click **View Tools** located at the upper right of the file View
2. Select **Upload Data to View** from the dropdown.
3. Browse and choose the edited file.
4. Click **Next** to preview the uploaded file.
5. Click **Update Table** to update the file View and populate the changes to all the files in Synapse.

### Programmatic Clients

Alternatively, download the View with the R or Python client:

1. Query for the View with [`synTableQuery()`](https://r-docs.synapse.org/reference/synTableQuery.html) or [`syn.tableQuery()`](https://python-docs.synapse.org/build/html/Client.html#synapseclient.Synapse.tableQuery). **To delete all the annotations of a key, you have to keep the column in the file view but remove the values.**
2. Update and then store the annotations in the [R client](https://r-docs.synapse.org/articles/views.html#updating-annotations-using-view) or [Python client](https://python-docs.synapse.org/build/html/Views.html#updating-annotations-using-view).
