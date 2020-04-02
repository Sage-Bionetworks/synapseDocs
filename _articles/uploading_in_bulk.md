---
title: Upload and Download Data in Bulk
layout: article
excerpt: Learn how to upload and download data in bulk using a manifest file and the Synapse programmatic clients. 
category: managing-data
---

Working with a large number of files on the web can be tedious, especially if you want to download, upload, or set [annotations]({{ site.baseurl }}{% link _articles/annotation_and_query.md %}) and [provenance]({{ site.baseurl }}{% link _articles/provenance.md %}). The command line, Python client and R client have convenience functions for bulk upload and download. Uploading require a tab delimited *manifest* where each file to be uploaded and, optionally, annotations to be applied, are specified as a row in the file. Downloading in bulk requires identifying a container (`Folder`, `Project`, `Table`, or `View`) that contains the files of interest. In this article we will cover how to:

* create a manifest
* upload the files in bulk
* modify files in bulk using a manifest
* download the files in bulk

## Uploading Data in Bulk

### Creating a Manifest

Files to be uploaded are specified in a tab separated (`.tsv`) manifest. The manifest has columns that contain information about each file to be uploaded along with annotations that will be associated with the file in Synapse.

The required columns in the manifest are:

* `path`: the directory of the file to be uploaded
* `parent`: the Synapse ID of the Folder to upload to

 It is optional to link provenance - the `used` column can indicate files that were used to create the one being uploaded, and the `executed` column can indicate code (in Synapse or on the web) that was used to generate the file. Here is an example manifest that uploads a single file:

{:.markdown-table}
| path | parent | name | used | executed | emotion| species |
| --- | --- | --- | --- | --- | --- | --- |
| /path/to/file.csv | syn123 | Tardar Sauce | syn654 | https://github.com/your/code/repo | grumpy | cat |

The above manifest describes a "file.csv" that will be uploaded to the Synapse folder `syn123` and named "Tardar Sauce". The manifest describes the provenance of the file indicating that it was generated using code deposited in GitHub (https://github.com/your/code/repo) from the data in `syn654`. Additionally, the file has been annotated with `emotion: grumpy` and `species: cat`. Additional annotations could be associated with the file by adding more columns.

To review:

* the **path** and **parent** columns are required
* the **name** is only necessary if the displayed name in Synapse should be different than the name of the uploaded file
* **used** and **executed** are optional for provenance (but helpful!),
* **emotion** and **species** are optional annotations (but also helpful!)

Download the [template](../assets/downloads/example_manifest_template.tsv).

### Validate the Manifest and Upload Files

The format of the manifest file (called 'filesToUpload.tsv' in this example) can be validated prior to upload by using the parameter `dryRun` in `syncToSynapse`.

* validate the manifest in the [Python client or command line](https://python-docs.synapse.org/build/html/synapseutils.html#synapseutils.sync.syncToSynapse).
* validate the manifest in the [R client](https://github.com/Sage-Bionetworks/synapserutils#batch-process). 

Using the validated manifest above, you can now upload the files to Synapse by removing the `dryRun` parameter. Once the upload is complete, you will receive an email notification. This notification will also delineate errors from the upload.

## Downloading Data in Bulk

Files can be downloaded in bulk using the `syncFromSynapse` function. This function allows you to download all the files in a folder or project along with all the annotations and provenance on those files. A manifest file called SYNAPSE_METADATA_MANIFEST.tsv that contains the metadata will also be added in the path.

* download files in the [Python client or command line](https://python-docs.synapse.org/build/html/synapseutils.html#synapseutils.sync.syncFromSynapse).
* download files in the [R client](https://github.com/Sage-Bionetworks/synapserutils#download-data-in-bulk).

## Editing in Bulk

You can edit files in bulk by changing the values in the manifest and pushing it up to Synapse using the `syncToSynapse` function. The manifest allows you to modify everything: file path, provenance, annotations, and versions. If you only want to update the file annotations, we recommend using our [File Views]({{ site.baseurl }}{% link _articles/views.md %}) feature. However, updating annotations is still possible using the manifest. If the files have not changed, adding the manifest column `forceVersion` with the value of `False` for each row will stop `syncToSynapse` from uploading new versions of the files.

Please note that you cannot move things with a manifest. If the parentId is changed, it will create a copy and the file will exist in two different locations.

{% include note.html content="Changing the parent synId in a manifest creates a copy of the file. It does not move it." %}

# See Also

[Downloading Data]({{ site.baseurl }}{% link _articles/downloading_data.md %}), [Provenance]({{ site.baseurl }}{% link _articles/provenance.md %}), [Annotations and Queries]({{ site.baseurl }}{% link _articles/annotation_and_query.md %}), [File Views]({{ site.baseurl }}{% link _articles/views.md %}), [Files and Versioning]({{ site.baseurl }}{% link _articles/files_and_versioning.md %})
