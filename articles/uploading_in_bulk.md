---
title: Batch Processing
layout: article
excerpt: Learn about uploading files and associated annotations and provenance in bulk.
category: howto
---

# Overview

Uploading a large number of files can be tedious when done one at a time, especially if you want to set [annotations](http://docs.synapse.org/articles/annotation_and_query.html) and [provenance](http://docs.synapse.org/articles/provenance.html). The command line and Python client have a convenience function for bulk upload and download called `sync`. The uploads are done through a tab delimited *manifest* where each file to be uploaded and it's metadata is specified as a row in the manifest file. In this article we will cover how to: 
	
* create a manifest 
* upload the files in bulk
* modify files in bulk using a manifest

<br/>

Read more about the helper functions on the **[synapseutils](https://python-docs.synapse.org/build/html/synapseutils.html)** page.

## Uploading Data in Bulk

#### Creating a Manifest

Files to be uploaded are specified in a tab separated (`.tsv`) manifest. The manifest has columns that contain information about each file to be uploaded along with metadata (annotations) that will be associated with the file in Synapse. Specifically, the manifest has a set of required columns (the directory `path` of the file to be uploaded, the Synapse id of the folder or `parent` the file will be uploaded to), and columns for provenance and annotations. Here's an example manifest that uploads a single file:

{:.markdown-table}
| path | parent | name | used | executed | emotion| species |
| --- | --- | --- | --- | --- | --- | --- |
| /path/to/file.csv | syn123 | Tardar Sauce | syn654 | https://github.com/your/code/repo | grumpy | cat |

<br/>

The above manifest describes a "file.csv" that will be uploaded to the Synapse folder `syn123` and named "Tardar Sauce". The manifest describes the provenance of the file indicating that it was generated using code deposited in GitHub (https://github.com/your/code/repo) from the data in `syn654`. Additionally, the file has been annotated with; `emotion:grumpy` and `species:cat`. Additonal annotations would be added through more columns (e.g. assay, fileFormat, cellType, etc.).


For reference:
[Tables](https://python-docs.synapse.org/build/html/Table.html#module-synapseclient.table) in the Synapse python docs.

Tables from synapseutils docs

To review:
* the **path** and **parent** columns are required
* the **name** is only necessary if the displayed name in Synapse should be different than the name of the uploaded file
* **used** and **executed** are for provenance and optional (but helpful!),
* **emotion** and **species** are for annotations and also optional (but also helpful!)

<br/>

Download the [template](/assets/downloads/example_manifest_template.tsv).

#### Validate the Manifest

The format of the manifest file (called 'filesToUpload.tsv' in this example) can be validated prior to uploading by using the parameter `dryRun = True` in `syncToSynapse`:

{% highlight python %}
# Load required libraries
import synapseclient
import synapseutils

# login to Synapse
syn = synapseclient.login(email='me@example.com', password='secret', rememberMe=True) 

# validate the manifest
foo = synapseutils.syncToSynapse(syn, manifestFile='filesToUpload.tsv', dryRun=True)
{% endhighlight %}

<br/>

#### Uploading Files

Using the validated manifest above, you can now upload the files to Synapse. Once the upload has completed you will receive an email notification. This notification will also notify you if there were any errors during upload. 

{% highlight python %}
# upload files using manifest
bar = synapseutils.syncToSynapse(syn, manifestFile='filesToUpload.tsv')
{% endhighlight %}

<br/>



## Downloading Data in Bulk

Files can be downloaded in bulk using the `syncFromSynapse` function found in `synapseutils`. This function allows you to download all the files in a folder or project along with all the annotations and provenance on those files. If the files are being downloaded to a specific location outside of the Synapse Cache, it will create a manifest that can be used to upload those files back up to Synapse.

For example, to download all the files in `syn123` to a folder called "myFolder" on your local computer:

{% highlight python %}
# Load required libraries
import synapseclient
import synapseutils

# login to Synapse
syn = synapseclient.login(email='me@example.com', password='secret', rememberMe=True) 

# download all the files in folder syn123
all_files = synapseutils.syncFromSynapse(syn, entity='syn123', path='/path/to/myFolder')
{% endhighlight %}


## Editing in Bulk

You can edit files in bulk by changing the values in the manifest and pushing it up to Synapse using the `syncToSynapse` function. The manifest allows you to modify everything: file path, provenance, annotations, and versions. However, if only annotations are being updated, we recommend using our [File Views](/articles/fileviews.html) feature. 


Please note that you cannot move things with a manifest. If the parentId is changed, it will create a copy and the file will exist in two different locations. 


{% include note.html content="Changing the parent synId in a manifest creates a copy of the file. It does not move it." %}


### See Also
[Downloading Data](/articles/downloading_data.html), [Provenance](/articles/provenance.html), [Annotations and Queries](/articles/annotation_and_query.html), [File Views](/articles/fileviews.html), [Files and Versioning](/articles/files_and_versioning.html)
