---
title: Annotations and Queries
layout: article
excerpt: Learn about annotations, how to assign and modify them, and how to query them for analysis. 
category: howto
---

<style>
#image {
    width: 75%;
}
</style>

## Annotations

Annotations in Synapse are semi-structured metadata that can be added to Projects, Files, Folders, and Tables.
Annotations can be based on an existing ontology (controlled vocabulary such as a disease Onotology (GO)), an agreed upon set of terms (e.g., describing the results of a sequencing pipeline), or be completely free form (like a tag system). These annotations can be used to systematically describe groups of entities, which provides a way to search and discover Synapse entities.

Synapse annotations are structured as key-value pairs: the key is the name of the annotation group while the value provides specifics. An example; let's say you have a collection of alignment files in the BAM file format from an RNA sequencing experiment, each representing a sample and replicate.
As is common, much of this information may be encoded in the file name (e.g., `Sample1_ConditionA.bam`).
However, this makes it difficult to find specific groups of files, such as all replicates of `Sample1`.
Adding this information as Synapse annotations enables a more complete description of the contents of the `File` and allows for discovery.

Continuing this example, the annotations you may want to add are:

* `assay = RNA-seq`
* `fileType = bam`
* `sample = 1`
* `condition = A`

All files you want to be able to search for should have a consistent set of annotations (ie, they should all have the same keys: `assay`, `fileType`, `sample`, and `condition`.) If these samples were part of a dataset with multiple assays, such as RNA-seq and ATAC-seq, you would annotate the file entities with either `assay = RNA-seq` or `assay = ATAC-seq`. Searching for the specific assay would therfore result in the assay specfic files

<br/>

### Types of Annotations

Annotations can be one of four basic types 

* Text (character limit=256)
* Integer
* Floating point
* Date (date and time)

<br/>

### How to assign annotations

It is easiest to add annotations when initially uploading a file. This can be done using the command line client, the Python client, the R client, or from the Web. Using the analytical clients facilitates batch and automated population of annotations across many files. The Web client is useful when uploading a single file, or if a minor change needs to be made to annotations on a few files.

#### Adding annotations 

{% tabs %}
	{% tab Command %}
		{% highlight bash %}
synapse store Sample1_ConditionA.bam --parentId syn00123 --annotations '{"fileType":"bam", "assay":"RNA-seq"}'
		{% endhighlight %}
	{% endtab %}

	{% tab Python %}
		{% highlight python %}
entity = File(path="Sample1_ConditionA.bam",parent="syn00123")
entity.annotations = {"fileType":"bam", "assay":"RNA-seq"}
syn.store(entity)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
entity <- File("Sample1_ConditionA.bam",parent="syn00123")
synSetAnnotations(entity) <- list(fileType = "bam", assay = "RNA-seq")
entity <- synStore(entity)
		{%endhighlight %}
	{% endtab %}
	
	{% tab Web %}
To add annotations through the web client, click the `Annotations` button in the upper right corner on a Project, Folder, or File page.

<img src="/assets/images/annotation-button.png">
	{% endtab %}

{% endtabs %}

<br/>

#### Modifying Annotations
If you have not decided on the annotations to add yet, you can add and modify the annotations at a later time as well, and you can manipulate annotations that have already been uploaded.


{% tabs %}
	{% tab Command %}
		{% highlight bash %}
synapse set-annotations --id syn123 --annotations '{"fileType":"bam", "assay":"RNA-seq"}'
		{% endhighlight %}
	{% endtab %}

	{% tab Python %}
		{% highlight python %}
entity = syn.get("syn123")

##### Assigning ONLY one annotation

entity.fileType = 'bam'
entity['fileType'] = 'bam'

##### Assigning a set of annotations

entity.annotations = {"fileType":"bam", "assay":"RNA-seq"}

syn.store(entity, forceVersion = F)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}

entity <- synGet("syn123")

##### Assigning ONLY one annotation

synSetAnnotation(entity, "filType") <- "bam"
# Assigning a set of annotations
synSetAnnotations(entity) <- list(fileType = "bam", assay = "RNA-seq")

entity <- synStore(entity, forceVersion = FALSE)
		{%endhighlight %}
	{% endtab %}
	
	{% tab Web %}
Click the `Edit` button in the resulting table to add, delete, or modify annotations.
Start by entering a Key (the name of the annotation), select the type (text, integer etc.,), and enter the Value. For example Key=assay - Value=RNA-seq. Click `Save` to store the annotations for this entity.
To enter multiple Values for a single Key click `Enter` with the cursor in the Value field.
<img src="/assets/images/annotation-edit-box.png">

	{% endtab %}

{% endtabs %}

<br/>


## Queries

Queries in Synapse look SQL-like:

```
SELECT * FROM <data type> WHERE <expression>
```

where currently supported `<data type>` are:

{:.markdown-table}
| \<data type\> | 
| --------- | 
| project   | 
| folder    |
| file      |
| entity    |

If you know the entity type you are looking for, searching in `Project`, `File`, or `Folder` is what you want.
To search over annotations of all entity types, use `Entity`.

The `<expression>` section are the conditions for limiting the search. Below demonstrates some examples of limiting searches.

For complete information on how to form queries and the types of limiting that can be performed, see the [Synapse Query API](https://sagebionetworks.jira.com/wiki/display/PLFM/Repository+Service+API#RepositoryServiceAPI-QueryAPI).

Along with annotations added by users, every entity has a number of fields useful for searching. For a complete list, see [here](http://hud.rel.rest.doc.sagebase.org.s3-website-us-east-1.amazonaws.com/org/sagebionetworks/repo/model/Entity.html). 

Here are some really useful ones:

* `projectId` which project the entity is associated with
* `parentId`: where the entity resides (inside a folder/sub-folder; may also be the project if in the root folder) - useful for finding all files if you know they are in a specific folder



<br/>

### Finding files in a specific project

To find all files in a specific `Project`, you need to know the `projectId`, which is a Synapse identifier (looks like `syn12345`).
For example, the TCGA Pan-Cancer Project has a `projectId` of syn300013.
So, the query to find all files and all annotations associated with this `Project` would be:

```
SELECT * FROM file WHERE projectId=="syn300013"
```


<br/>

### Listing files in a specific folder

To list the `Files` and annotations in a specific `Folder`, you need to know the Synapse ID of the `Folder` (for example syn1524884, which has data from TCGA related to melanoma). All entities in this `Folder` will have a `parentId` of syn1524884.

So, the query to find all `Files` and all annotations in this `Folder` would be:

```
SELECT * FROM file WHERE parentId=="syn1524884"
```

If you wanted to find all the sub-folders in this `Folder`, you would do:

```
SELECT * FROM folder WHERE parentId=="syn1524884"
```

If you wanted both `Files` and `Folders`, this would work:

```
SELECT * FROM entity WHERE parentId=="syn1524884"
```


<br/>

### Queries on annotations

Annotations are most useful for discovery of similar types of entities. Essentially, all annotations across Synapse are stored in a large table that can be queried to find entities with annotations matching your own criteria. While it can be useful to search for files that exist within an known project or folder, this requires that you know ahead of time where the files are.

If annotations have been diligently added to `Files`, they can be used to discover files of interest.
For example, you can identify all `Files` annotated as `bam` files (`fileType = bam`) uploaded to Synapse with the following query:

{% include note.html content="You will only be able to query the files you currently have permission to access." %}

```
SELECT * FROM file WHERE fileType=="bam"
```

<br/>
Likewise, if you had put the RNA-seq related files described in the section above into a project (for example syn12345) with the described annotations, then you could find all of the files for `Condition A` for `Sample 1`:

```
SELECT * FROM file WHERE projectId=="syn12345" AND sample=="1" AND condition=="A"
```

<br/>
Lastly, you can query on a subset of entities that have a specific annotation. You can limit the annotations you want displayed as following.

```
SELECT id,name,dataType,fileType FROM file WHERE projectId=="syn12345" AND sample=="1" AND condition=="A"
```

<br/>

Queries can be constructed using one of the analytical clients (command line, Python, and R) and on the web client, query results can be displayed in a table on a wiki page.. Using the example above this can be done as following:

{% tabs %}
	{% tab Command %}
		{% highlight bash %}
synapse query 'SELECT id,name,dataType,fileType FROM file WHERE projectId=="syn12345" AND sample=="1" AND condition=="A"'
		{% endhighlight %}
	{% endtab %}

	{% tab Python %}
		{% highlight python %}


result = syn.chunkedQuery('SELECT id,name,dataType,fileType FROM file WHERE projectId=="syn12345" AND sample=="1" AND condition=="A"')
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
result <- synQuery('SELECT id,name,dataType,fileType FROM file WHERE projectId=="syn12345" AND sample=="1" AND condition=="A"')
		{%endhighlight %}
	{% endtab %}
	
	{% tab Web %}	
On the wiki page, click `Tools` button in the upper right corner to `Edit Wiki`.
Click `Insert` and choose `Table: Query on Files/Folders`.
Enter your query in the box and click the **Insert** button. Once you save the wiki page, the results will be displayed as a table.

<img id="image" src="/assets/images/query-file-wiki.png">
    {% endtab %}

{% endtabs %}

<br/>

## How to download based on queries

You can download files in a folder using queries. Currently this feature is only available in the command line client. For example, if you want to download all files in a folder that has a synapse id of `syn00123`, use

```
synapse get -q 'SELECT * FROM file WHERE parentId == "syn00123"'
````
