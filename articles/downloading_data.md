---
title: "Downloading Data"
layout: article
excerpt: Learn the best practices of finding and downloading files.
category: intro
order: 3
---

Data in Synapse can be downloaded using the programmatic clients (Python, R, and command line) as well as the web client.

## Downloading a File

Every entity in Synapse has a unique synID associated with it.  It can be found on every entity page next to `Synapse ID:`, starting with `syn` ending with numbers (i.e. `syn00123`).
`Files` can be downloaded by using the `get` command. By default, the `File` downloaded will always be the most recent version. If the current version of the `File` has already been downloaded, it will not re-download the `File`.

When using the Python, R, or command line clients, files downloaded using the `get` command are stored and/or registered in a cache. By default, the cache location is in your home directory in a hidden folder named `.synapseCache`. Whenever the `get` function is invoked, the cache is checked to see if the same file is already present by checking its MD5 checksum. If it already exists, the file will not be downloaded again.

For the Python and R clients the default download location is the Synapse cache. The command line client downloads to your current working directory. On the web, your own browser settings determine the download location for files. The Synapse cache is not updated to reflect downloads through a web browser. In all cases you can specify the directory in which to download the file.

For example, to get the experimental protocol file on [Adult Mouse Cardiac Myocyte Isolation](https://www.synapse.org/#!Synapse:syn3158111) (syn3158111) from the [Progenitor Cell Biology Consortium (PCBC)](https://www.synapse.org/#!Synapse:syn1773109) you would run the following:

##### Command line

```bash
synapse get syn3158111
```

##### Python

```python
import synapseclient
syn = synapseclient.Synapse()
syn.login()
entity = syn.get("syn3158111")
```

##### R

```r
library(synapser)
synLogin()
entity <- synGet("syn3158111")
```

Once a `File` has been downloaded, you can find the filepath using the following:

##### Command line

```bash
# When downloading using the command line client, it will print the filepath of where the file was saved to.
```

##### Python

```python
filepath = entity.path
```

##### R

```r
filepath <- entity$path
```

### Versions

If there are multiple versions of a `File`, a specific version can be downloaded by passing the `version` parameter.

In this example, there are multiple versions of an [miRNA FASTQ file](https://www.synapse.org/#!Synapse:syn3260973) (syn3260973) from the Progenitor Cell Biology Consortium. To download the first version:

##### Command line

```bash
synapse get syn3260973 -v 1
```

##### Python

```python
entity = syn.get("syn3260973", version=1)
```

##### R

```r
entity <- synGet("syn3260973", version=1)
```

See [versioning](versioning.md) for more details.

### Links

When you click on a Link entity on the Synapse website, it will redirect you to the linked entity.  The `followLink` parameter will have to be specified when using the programmatic clients or you will only retrieve the link itself without downloading the linked entity.

##### Command line

```bash
synapse get syn1234 --followLink
```

##### Python

```python
import synapseclient
syn = synapseclient.login()
linkEnt = syn.get("syn1234")
entity = syn.get("syn1234", followLink=True)
```

##### R

```r
library(synapser)
synLogin()
linkEnt = synGet("syn1234")
entity = synGet("syn1234", followLink=TRUE)
```

### Download Location

To override the default download location (to not download to the Synapse cache directory, for example), you can specify the `downloadLocation` parameter.

##### Command line

```bash
synapse get syn00123 --downloadLocation /path/to/folder
```

##### Python

```python
entity = syn.get("syn00123", downloadLocation="/path/to/folder")
```

##### R

```r
entity <- synGet("syn00123", downloadLocation="/path/to/folder")
```

## Finding and Downloading Files

Files can be [annotated](annotation_and_query.md) to facilitate finding them. In order to search the annotations, a [File View](views.md) must be created first. It is possible to query based on any of the annotations attached to the files.

For example, the [PCBC Project](https://www.synapse.org/#!Synapse:syn1773109) has a [table](https://www.synapse.org/#!Synapse:syn7511263) listing sequencing data files that have been annotated. To find all **mRNA fastq** files originating from **CD34+ cells** in the we can query by:

##### Command line

```bash
synapse query 'select * from syn7511263 where dataType="mRNA" AND fileType="fastq" AND Cell_Type_of_Origin="CD34+ cells"'
```

##### Python

```python
results = syn.tableQuery('select * from syn7511263 where dataType="mRNA" AND fileType="fastq" AND Cell_Type_of_Origin="CD34+ cells"')
```

##### R

```r
results <- synTableQuery('select * from syn7511263 where dataType="mRNA" AND fileType="fastq" AND Cell_Type_of_Origin="CD34+ cells"')
df <- as.data.frame(results)
```

Once you've queried for the files of interest, they can be downloaded using the following:

##### Command line

```bash
synapse get -q 'select * from syn7511263 where dataType="mRNA" AND fileType="fastq" AND Cell_Type_of_Origin="CD34+ cells"'
```

##### Python

```python
results = syn.tableQuery('select * from syn7511263 where dataType="mRNA" AND fileType="fastq" AND Cell_Type_of_Origin="CD34+ cells"')

entity = [syn.get(r['file.id']) for r in results]
```

##### R

```r
results <- synTableQuery('select * from syn7511263 where dataType="mRNA" AND fileType="fastq" AND Cell_Type_of_Origin="CD34+ cells"')
df <- as.data.frame(results)
entity <- lapply(df$file.id, function(x) synGet(x))
```

### Recursive Downloads

The folder structure that is present on Synapse can be maintained by recursive downloading.

##### Command line

```bash
synapse get -r syn2390898
```

##### Python

```python
import synapseutils
import synapseclient
syn = synapseclient.login()
files = synapseutils.syncFromSynapse(syn, 'syn2390898')
```

##### R

```r
# Unfortunately, this feature is not currently available in the R client
```

### Download Tables

Please view [here](tables.md) to learn how to use `Tables`.

### Download Wikis

The structure of a project's `Wiki` page can be extracted through the R and Python clients.  The id, title and parent `Wiki` page of each sub-`Wiki` page is also determined through the same method.

##### Python

```python
wiki = syn.getWikiHeaders("syn00123")
```

##### R

```r
entity <- synGet("syn00123")
wiki <- synGetWikiHeaders(entity)
```

The Markdown and other information of a `Project` sub-`Wiki` page can be obtained by knowing the id of the `Wiki`. The `Wiki` page id can either be obtained through the above method or can be found in the URL "www.synapse.org/#!Synapse:syn00123/wiki/**12345**" where 12345 is the `Wiki` page id.

##### Python

```python
wiki = syn.getWiki("syn00123", 12345)
```

##### R

```r
entity <- synGet("syn00123")
wiki <- synGetWiki(entity, 12345)
```

### Downloading in Bulk

Files can be downloaded in bulk using the `syncFromSynapse` function found in the [synapseutils](https://python-docs.synapse.org/build/html/synapseutils.html#synapseutils.sync.syncFromSynapse) helper package. This function crawls all the subfolders of the project/folder that you specify and retrieves all the files that have not been downloaded. By default, the files will be downloaded into your `synapseCache`, but a different download location can be specified with the `path` parameter. If you do download to a location out side of `synapseCache`, this function will also create a tab-delimited manifest of all the files along with their metadata (path, provenance, annotations, etc).

##### Python

```python
# Load required libraries
import synapseclient
import synapseutils

# login to Synapse
syn = synapseclient.login(email='me@example.com', password='secret', rememberMe=True)

# download all the files in folder syn123 to a local folder called "myFolder"
all_files = synapseutils.syncFromSynapse(syn, entity='syn123', path='/path/to/myFolder')
```

##### R

```r
# Load required libraries
library(synapser)
library(synapserutils)

# login to Synapse
synLogin(email='me@example.com', password='secret', rememberMe=TRUE)

# download all the files in folder syn123 to a local folder called "myFolder"
all_files = syncFromSynapse(entity='syn123', path='/path/to/myFolder')
```

# See Also

[Versioning](versioning.md), [Tables](tables.md), [Wikis](wikis.md), [File Views](views.md), [Annotations and Queries](annotation_and_query.md)
