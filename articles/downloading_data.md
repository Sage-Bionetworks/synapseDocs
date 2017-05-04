---
title: "Downloading Data"
layout: article
excerpt: Learn the best practices of finding and downloading files.
category: intro
order: 3
---

# Overview

Data in Synapse can be downloaded using the programmatic clients (Python, R, and command line) as well as the web client. 

## Downloading a File

Every entity in Synapse has a unique synID associated with it.  It can be found on every entity page next to `Synapse ID:`, starting with `syn` ending with numbers (i.e. `syn00123`).
`Files` can be downloaded by using the `get` command. By default, the `File` downloaded will always be the most recent version. If the current version of the `File` has already been downloaded, it will not re-download the `File`.

For example, to get the experimental protocol file on [Adult Mouse Cardiac Myocyte Isolation](https://www.synapse.org/#!Synapse:syn3158111){:target="_blank"} (syn3158111) from the [Progenitor Cell Biology Consortium (PCBC)](https://www.synapse.org/#!Synapse:syn177310){:target="_blank"} you would run the following:


{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse get syn3158111
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
import synapseclient
syn = synapseclient.Synapse()
syn.login()
entity = syn.get("syn3158111")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
library(synapseClient)
synapseLogin()
entity <- synGet("syn3158111")
{%endhighlight %}
{% endtab %}

{% endtabs %}

<br/>

Once a `File` has been downloaded, you can find the filepath using the following:

{% tabs %}

{% tab Command %}
{% highlight bash %}
# When downloading using the command line client, it will print the filepath of where the file was saved to.
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
filepath = entity.path
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
filepath <- entity@filePath
{% endhighlight %}
{% endtab %}

{% endtabs %}


### Versions

If there are multiple versions of a `File`, a specific version can be downloaded by passing the `version` parameter.

In this example, there are multiple versions of an [miRNA FASTQ file](https://www.synapse.org/#!Synapse:syn3260973){:target="_blank"} (syn3260973) from the Progenitor Cell Biology Consortium. To download the first version:

{% tabs %}
{% tab Command %}
{% highlight bash %}
synapse get syn3260973 -v 1
{% endhighlight %}
{% endtab %}
{% tab Python %}
{% highlight python %}
entity = syn.get("syn3260973", version=1)
{% endhighlight %}
{% endtab %}
{% tab R %}
{% highlight r %}
entity <- synGet("syn3260973", version=1)
{%endhighlight %}
{% endtab %}

{% endtabs %}

<br/>

See [versioning](http://docs.synapse.org/articles/versioning.html) for more details.


### Download Location

By default, for the Python and R clients, the download location will always be in the Synapse cache whereas the command line client downloads to your current working directory. In each case you can specify the `downloadLocation` parameter.

{% tabs %}
{% tab Command %}
{% highlight bash %}
synapse get syn00123 --downloadLocation /path/to/folder
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
entity = syn.get("syn00123", downloadLocation="/path/to/folder")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
entity <- synGet("syn00123", downloadLocation="/path/to/folder")
{%endhighlight %}
{% endtab %}

{% endtabs %}



## Finding and Downloading Files

Files in projects can be annotated to facilitate finding them with the information from the metadata tables. Most projects will have a page dedicated to the types of annotations available for query. It is possible to query based on any of the annotations attached to the files.

For example, to find all **mRNA fastq** files originating from **CD34+ cells** in the [PCBC project](https://www.synapse.org/#!Synapse:syn1773109){:target="_blank"} we can query by:

{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse query "select * from file where projectId=='syn1773109' AND dataType=='mRNA' AND fileType=='fastq' AND Cell_Type_of_Origin=='CD34+ cells'"
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
results = syn.chunkedQuery("select * from file where projectId=='syn1773109' AND dataType=='mRNA' AND fileType=='fastq' AND Cell_Type_of_Origin=='CD34+ cells'")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
results <- synQuery("select * from file where projectId=='syn1773109' AND dataType=='mRNA' AND fileType=='fastq' AND Cell_Type_of_Origin=='CD34+ cells'")
{% endhighlight %}
{% endtab %}

{% endtabs %}

Once you've queried for the files of interest, they can be downloaded using the following:


{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse get -q "select * from file where projectId=='syn1773109' AND dataType=='mRNA' AND fileType=='fastq' AND Cell_Type_of_Origin=='CD34+ cells'"
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
results = syn.chunkedQuery("select * from file where projectId=='syn1773109' AND dataType=='mRNA' AND fileType=='fastq' AND Cell_Type_of_Origin=='CD34+ cells'")

entity = [syn.get(r['file.id']) for r in results]
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
results <- synQuery("select * from file where projectId=='syn1773109' AND dataType=='mRNA' AND fileType=='fastq' AND Cell_Type_of_Origin=='CD34+ cells'")

entity <- lapply(results$file.id, function(x) synGet(x))
{% endhighlight %}
{% endtab %}

{% endtabs %}

### Recursive Downloads

The folder structure that is present on Synapse can be maintained by recursive downloading. 

{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse get -r syn2390898
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
# This feature is only available in synapseclient >= 1.6.1
import synapseutils
import synapseclient
syn = synapseclient.login()
files = synapseutils.syncFromSynapse(syn, 'syn2390898')
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Unfortunately, this feature is not currently available in the R client
{% endhighlight %}
{% endtab %}

{% endtabs %}

### Download Tables

Please view [here](http://docs.synapse.org/articles/tables.html#making-changes-to-tables) to learn how to use `Tables`.


### Download Wikis

The structure of a project's `Wiki` page can be extracted through the R and Python clients.  The id, title and parent `Wiki` page of each sub-`Wiki` page is also determined through the same method.


{% tabs %}

{% tab Python %}
{% highlight python %}
wiki = syn.getWikiHeaders("syn00123")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
entity <- synGet("syn00123")
wiki <- synGetWikiHeaders(entity)
{%endhighlight %}
{% endtab %}

{% endtabs %}


The Markdown and other information of a `Project` sub-`Wiki` page can be obtained by knowing the id of the `Wiki`. The `Wiki` page id can either be obtained through the above method or can be found in the URL "www.synapse.org/#!Synapse:syn00123/wiki/**12345**" where 12345 is the `Wiki` page id. 


{% tabs %}

{% tab Python %}
{% highlight python %}
wiki = syn.getWiki("syn00123", 12345)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
entity <- synGet("syn00123")
wiki <- synGetWiki(entity, 12345)
{%endhighlight %}
{% endtab %}

{% endtabs %}

<br/>

### See Also
[Versioning](/articles/versioning.html), [Tables](/articles/tables.html), [Wikis](/articles/wikis.html) 
