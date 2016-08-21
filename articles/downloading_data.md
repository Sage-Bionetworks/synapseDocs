---
title: "Downloading data"
layout: article
excerpt: Tutorial on how to download data from synapse with the clients 
---

## Downloading a file

Every entity in synapse has a unique synapse Id associated with it.  It can be found on every entity page next to `Synapse ID:`, starting with `syn` ending with numbers (ie. `syn00123`)


### Entities

There are six different types of entities

* Project
* Folder
* File
* Link
* Table
* Wiki

Each of these entities will have attached metadata and annotations, except wikis, which users can extract. For file entities, there is an option for the `R` and `python` client to not download the file by setting `downloadFile = false`.

{% tabs %}
	{% tab Command %}
		{% highlight bash %}
synapse get syn00123
		{% endhighlight %}
	{% endtab %}

	{% tab Python %}
		{% highlight python %}
Entity = syn.get("syn00123", downloadFile=False)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
Entity = synGet("syn00123", downloadFile= FALSE)
		{%endhighlight %}
	{% endtab %}

{% endtabs %}



###Downloading File Entities
`File` entities can be downloaded by using the `get` command. Without specifying the optional parameters, the file entity downloaded will always be the most recent version (See [versioning](http://docs.synapse.org/articles/versioning.html) for more details) and downloaded to the user's synapse cache directory `~/.synapseCache`.

####Versions
By default, the most recent version of the file is always downloaded unless specified.

{% tabs %}
	{% tab Command %}
		{% highlight bash %}
synapse get syn00123 -v 1
		{% endhighlight %}
	{% endtab %}

	{% tab Python %}
		{% highlight python %}
syn.get("syn00123", version=1)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
synGet("syn00123", version=1)
		{%endhighlight %}
	{% endtab %}

{% endtabs %}


####Download Location
By default the download location will always be the synapse cache directory, except for the command line client where the default download location is your current working directory.

{% tabs %}
	{% tab Command %}
		{% highlight bash %}
synapse get syn00123 --downloadLocation ./path/to/folder
		{% endhighlight %}
	{% endtab %}

	{% tab Python %}
		{% highlight python %}
syn.get("syn00123", downloadLocation="./path/to/folder")
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
synGet("syn00123", downloadLocation="./path/to/folder")
		{%endhighlight %}
	{% endtab %}

{% endtabs %}


####Command line download
The synapse command line client offers two ways of downloading synapse files that the other clients don't.  First, it allows for recursive downloading of files, maintaining the folder structure that is present on syanpse.  Second, users can pass in a query statement (See [here](http://docs.synapse.org/articles/annotation_and_query.html#queries) to learn more about query statements) to download all the files that is returned from that query statement.

```
# syn00123 has to be a folder or a project
syanpse get -r syn00123
# In the case below, syn00123 has to be a project.  Any query statement would work. 
synapse get -q 'select id from entity where projectId == "syn00123"'
```

####Download Tables

Please view [here](http://docs.synapse.org/articles/tables.html#making-changes-to-tables) to learn how to use table entities.


####Download Wikis
The structure of a project's wikipage can be extracted through the `R` and `python` client.  The id, title and parent wikipage of each subwikipage is also determined through the same method.


{% tabs %}

	{% tab Python %}
		{% highlight python %}
syn.getWikiHeaders("syn00123")
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
entity <- synGet("syn00123")
synGetWikiHeaders(entity)
		{%endhighlight %}
	{% endtab %}

{% endtabs %}


The markdown and other information of a project subwikipage can be obtained by knowing the id of the wiki id.  The wikipage id can either be obtained through the above method or can be found in the url: "www.synapse.org/#!Synapse:syn00123/wiki/12345" where 12345 is the wikipage id. 


{% tabs %}

	{% tab Python %}
		{% highlight python %}
syn.getWiki("syn00123",12345)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
entity <- synGet("syn00123")
synGetWiki(entity,12345)
		{%endhighlight %}
	{% endtab %}

{% endtabs %}