---
title: Managing Custom Metadata in Scale
layout: article
excerpt: A vignette of how to update metadata in bulk using file views and programmatic clients.
category: inpractice
---

# Managing Custom Metadata in Scale

This vignette will string together some of the concepts from [Annotations and Queries](/articles/annotation_and_query.md) and [Views](/articles/views.md) in order to bulk **upload**, **edit**, and **delete** annotations on files. 

## Annotation dictionaries
The Sage Bionetworks Systems Biology and Computational Oncology teams maintain [annotation dictionaries](https://github.com/sage-bionetworks/synapseAnnotations) in GitHub. You can use the terms found in the synapseAnnotations GitHub repo as a starting point for you own annotations.

 <a href="https://github.com/sage-bionetworks/synapseAnnotations" target="_blank" class="btn btn-info btn-lg active" role="button" aria-pressed="true">Annotation Dictionaries</a>

## Before we begin...
For this tutorial to be most effective, we'll be making a couple of assumptions. Please ensure that you have: (1) a Synapse Account, and (2) Python Client >= 1.7.4 installed. If not, head on over to the [Getting Started](/articles/getting_started.md) article to learn how to register for a Synapse account and install/update the Python Client. All good? Great, let's get annotating!

## Step 1: Create a Manifest
The easiest way to batch upload the files with annotations is by using a function called `syncToSynapse` in our Python client. This function requires the use of a tab-delimited manifest which contains, at minimum, the columns `path` and `parent`. But the real magic happens when you start to add additional columns which are annotations. So for example, your manifest might have the following headers: `path`, `parent`, `specimenID`, `assay`, `species`, `platform`, `sex`, and `fileFormat`. Let's break that down a bit:

**path**: is the local path to your file <br>
**parent**: is the Synapse ID (in the format syn123456) that the files will be uploaded to <br>
**specimenID**: is the unique identifier for each of your specimens <br>
**assay**: is the technology used to generate the data in this file (e.g. rnaSeq, ChIPSeq, wholeGenomeSeq, etc) <br>
**species**: is the species of your sample (e.g. Mouse, Human, Triceratops etc) <br>
**platform**: is hardware used to generate the data (e.g. HiSeq2500, Affy6.0, HoodDNASequencer, etc) <br>
**sex**: e.g. male or female <br>
**fileFormat**: is the type of file (e.g. fastq, R script, etc) <br>

And here it is in a visual example: 

{:.markdown-table}
| path | parent | specimenID | assay | species | platform | sex | fileFormat |
| --- | --- | --- | --- | --- | --- | --- | --- |
| /local/path/to/velociraptor_b.fastq | syn123 | blue_1 | wholeGenomeSeq | Velociraptor mongoliensis | HoodDNASequencer | female | fastq |
| /local/path/to/velociraptor_d.fastq | syn123 | delta_1 | wholeGenomeSeq | Velociraptor mongoliensis | HoodDNASequencer | female | fastq |

<br>

We'll **save** this file in a tab-delimited format and call it something like `velociraptor_manifest.txt`. And now onto Step 2!

## Step 2: Batch Upload the Files with Annotations (Python)
Now that you've created a manifest file with annotations, we can upload them all in one go using the Synapse Python Client. You can batch upload your files with your tab-delimited manifest using the commands below. If you'd like to do a "dry run" validation of the file before uploading, you can add the parameter `dryRun = True` to the `syncToSynapse` call (e.g. `foo = synapseutils.syncToSynapse(syn, manifestFile='velociraptor_manifest.txt', dryRun=True)`. Please note that the `dryRun` feature checks everything but does **not** upload the files.

{% highlight python %}
# open a Python shell and load required libraries
import synapseclient
import synapseutils

# login to Synapse
syn = synapseclient.login(email='me@example.com', password='secret', rememberMe=True) 

# upload the files
foo = synapseutils.syncToSynapse(syn, manifestFile='velociraptor_manifest.txt')

{% endhighlight %}

<br>

And ta-da! Your files have been uploaded!

## Step 3: Create a File View (Web)
Now you might be thinking "Why do I need to create a File View?" and that's a great question. Since the files have been uploaded with annotations, a file view allows us to  be able to query, facet, and bulk manipulate the files and their metadata. It also has the added benefit of seeing all your files of interest in a nice tabular UI.

To create your File View: 
1. Navigate to your Project.
2. Go to the `Tables` tab, select **Tools** in the upper right corner, and click **Add File View**.
3. In the resulting pop-up, give the new file view a name. 
4. Select the container (Synapse Project or Folder) of files, and click **Next**. In this case, you would want the synID of where the files were uploaded to: the `parent` column of your manifest.
5. Select the columns you would like to keep. Since we are going to edit the annotations later, please make sure you have the column `etag` listed as one of your columns.
6. You can use the **Add All Annotations** button at the end of the opened window to add all existing annotations. 
7. Click **Finish** to create the file view.


If you'd like to make single changes, whether it's and edit or a deletion, go on **[Step 4a](/articles/managing_custom_metadata_in_scale.html#step-4a-do-a-one-off-annotation-update-web)** and **[Step 5a](/articles/managing_custom_metadata_in_scale.html#step-5a-do-a-one-off-annotation-deletion-web)**, respectively. If you'd like to know how to do bulk edits or deletions, go on to **[Step 4b](/articles/managing_custom_metadata_in_scale.html#step-4b-do-a-bulk-annotation-update-web--python)** and **[Step 5b](/articles/managing_custom_metadata_in_scale.html#step-5b-do-a-bulk-annotation-deletion-web--python)**, respectively.

## Step 4a: Do a One-Off Annotation Update (Web)
But what if you upload all your nicely annotated files and realize, oops, your `specimenID`:`delta_1` was actually suppose to be `specimenID`:`echo_1`?  To edit the one value via the Web client:

1. Click the **edit button** to the right of the query bar of the file view (the middle button of the three buttons). When you hover over the icon, you will see "Edit query results". 
2. Find the value you want to change in the pop-up and edit the field. 
3. Scroll down to the bottom and click **Save** to update the file view.
 
More information on how to query on a file view can be found in the [Views article](/articles/views.html){:target="_blank"}.

## Step 4b: Do a Bulk Annotation Update (Web + Python)
But what if you upload all your nicely annotated files and realize, oops, your `species`:`Velociraptor mongoliensis` was actually in reality `Utahraptor ostrommaysorum`?  

We'll use a combination of the web client and Python commands to make bulk edits to annotations. We'll start at the web client, make edits using Python, and  push the changes via the web client to populate the changes in Synapse. 

1. Navigate to the file view that you created. 
2. Click the **download** button to the right of the query bar of the file view. When you hover over the icon, you will see "Download query results". 
3. Click **Next** and then **Download** to download the file view. Be sure to have `Include row metadata (Row Id and Row Version)` selected when downloading. 

Now that you have the file view downloaded, you can edit the values using your tool of preference, whether that's Python, R, Excel, LibreOffice, etc. In this example, we'll edit the values in `species` using Python, but any other way of editing the file would work as well.

{% highlight python %}
# load libraries
import pandas as pd

# read in the file view
fv = pd.read_csv('downloaded_fileview.csv')

# modify all the values in the species column
fv['species'] = 'Utahraptor ostrommaysorum'

# save/write the changes to the csv file
fv.to_csv('downloaded_fileview.csv', index=False)

{% endhighlight %}

<br>

With the changes saved, go back to the file view in your browser. 
1. Click **Tools** located at the upper right of the file view and 
2. Select **Upload Data to Table** from the dropdown. 
3. Browse and choose the file that you edited, and then 
4. Click **Next** to preview the uploaded file. 
5. Click **Update Table** to update the file view and populate the changes to all the files in Synapse.
 
Please note - depending on the number of files you're editing, it might take longer to update all the annotations!

## Step 5a: Do a One-Off Annotation Deletion (Web)
We're moving right along with all these scenarios! Now we're at our final example: what do you do if your lab technician walks into your lab and says that there was a mix-up and no one can seem to figure out what platform specimenID `blue1` was sequenced on. They're pretty sure it was the `HoodDNASequencer` but then again, it might've been `HiSeq2500`. So you decide that the `HoodDNASequencer` annotation for specimen `blue_1` should be removed until it gets figured out. 
To delete one value via the Web client:

1. Click the **edit button** to the right of the query bar of the file view (the middle button of the three buttons). When you hover over the icon, you will see "Edit query results". 
2. Find the value you want to remove in the pop-up and delete the entry. 
3. Scroll down to the bottom and click **Save** to update the file view.


## Step 5b: Do a Bulk Annotation Deletion (Web + Python)
We're moving right along with all these scenarios! Now we're at our final example: what do you do if your lab technician walks into your lab and says that there was a mix-up and no one can seem to figure out what platform was used to actually sequence all the data. So you decide to remove that particular annotation until the mystery is solved. 
To bulk removed values 

Like in Step 4a, we'll use a combination of the web client and Python commands to make bulk deletions to annotations. We'll start at the web client, remove values using Python, and  push the changes via the web client to populate the changes in Synapse. 

1. Navigate to the file view that you created. 
2. Click the **download** button to the right of the query bar of the file view. When you hover over the icon, you will see "Download query results". 
3. Click **Next** and then **Download** to download the file view. Be sure to have `Include row metadata (Row Id and Row Version)` selected when downloading. 

Now that you have the file view downloaded, you can remove the values using your tool of preference, whether that's Python, R, Excel, LibreOffice, etc. In this example, we'll remove the values in `platform` using Python, but any other way of editing the file would work as well. 

To delete all the annotations of a key, you have to keep the column in the file view but remove the entries. So for example:

{% highlight python %}
# load libraries
import pandas as pd

# read in the file view
fv = pd.read_csv('downloaded_fileview.csv')

# replace the values in platform with None or fillna()
fv['platform'] = None

# save/write the changes to the csv file
fv.to_csv('downloaded_fileview.csv', index=False)

{% endhighlight %}

<br>

With the changes saved, go back to the file view in your browser. 
1. Click **Tools** located at the upper right of the file view and 
2. Select **Upload Data to Table** from the dropdown. 
3. Browse and choose the file that you edited, and then 
4. Click **Next** to preview the uploaded file. 
5. Click **Update Table** to update the file view and populate the changes to all the files in Synapse.

## Conclusion
Thanks for joining us on this Annotations Adventure! 