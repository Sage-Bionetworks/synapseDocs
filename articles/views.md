---
title: "Views"
layout: article
excerpt: Use project and file views to query across multiple projects and folders.
category: howto
---

<style>
#image {
    width: 90%;
}
</style>


# Overview 
A view is a type of Synapse [Table](/articles/tables.html) that queries across metadata ([Annotations](/articles/annotation_and_query.html)) for particular items (currently: projects or files) with a particular "scope". A `File View` lists all `Files` or `Tables` within one or more `Folders` or `Projects`. A `Project View` lists all `Projects` you've added to the view. Views can:

 * Allow `Projects`, `Files`, and `Tables` to be easily searched and queried
 * Allow view/editing metadata attributes in bulk
 * Provide a way of isolating or linking data based on similarities
 * Provide the ability to link `Projects`, `Files`, and `Tables` together by their annotations
 
 <br/>


## Create a File View

To create a `File View`, select the `Project` in which you would like to create the view. The `Project` you choose does not have to contain the files you are including in your view. You will select the files of interest by defining the scope, which is the `Project(s)` and `Folders` that contain your files. 
{% include note.html content= "The scope of a File View can have a maximum of 10,000 folders or sub-folders." %}

{% tabs %}

{% tab Python %}
{% highlight python %}
import synapseclient
from synapseclient import EntityViewSchema
syn = synapseclient.login()

# define your scope, you can do this by getting the entity with "syn.get" or by using just the synId
# two folders will be defined in this scope using both methods
folder1 = syn.get('syn111')
folder2 = 'syn222'

# create a view named "My Fileview" to upload to project syn333
entity_view = EntityViewSchema(name='My Fileview', parent='syn333', scopes=[folder1, folder2])

# store the view in Synapse
entity_view = syn.store(entity_view)

{% endhighlight %}
{% endtab %}

{% tab Web %}
<iframe width="100%" height="480" src="https://www.youtube.com/embed/qWjVlw2_n2w?rel=0" frameborder="0" allowfullscreen></iframe>
{% endtab %}

{% endtabs %}

## Create a Project View

To create a `Project View`, select the `Project` in which you would like to create the view. You will select the projects of interest by defining the scope as above. The only notable difference between creating a `Project View` and a `File View` is that for project views, there is a 1:1 relationship between the projects you select in your scope and the projects that are shown in the view. 

## Query a View
A view can be queried exactly the same as any other `Table` in Synapse. Please see [Tables](/articles/tables.html) for more examples. For example, to query for everything in `syn123`:

{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse query 'SELECT * FROM syn123'
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
query = syn.tableQuery('SELECT * FROM syn123')
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
query <- synTableQuery('SELECT * FROM syn123')
{% endhighlight %}
{% endtab %}

{% tab Web %}

See the [Using Simple Search](/articles/fileviews.html#using-simple-search) and [Using Advanced Search](/articles/fileviews.html#using-advanced-search) sections below.
{% endtab %}

{% endtabs %}

<br/>

## Update Annotations in Bulk

Views can be used to update annotations in bulk. To update other metadata in bulk, such as provenance, please see the [Bulk Processing](/articles/uploading_in_bulk.html) article.

For example, if you would like to update the annotation `dogSays`:`bark` to `dogSays`:`woof` in every file in a `File View` with the synId syn456, you can do:

{% tabs %}

{% tab Python %}
{% highlight python %}
from synapseclient import Table

foo = syn.tableQuery('select * from syn456')

bar = foo.asDataFrame()

# add in annotation as a column 
bar['dogSays'] = 'woof'

# store the fileview with the new annotation in Synapse
fv = syn.store(synapseclient.Table(foo.tableId, bar))

{% endhighlight %}
{% endtab %}

{% tab Web %}

<iframe width="100%" height="480" src="https://www.youtube.com/embed/ij9AqLsoDk0?rel=0" frameborder="0" allowfullscreen></iframe>

{% endtab %}

{% endtabs %}



### Using Simple Search
Views are in `Simple Search` mode by default. You can filter out `Projects` or `Files` of interest by selecting what characteristics you like using the facet menu on the left. You can toggle between simple and advanced search using the `Show advanced search/Show simple search` link.

<img id="image" src="/assets/images/fileViewFacetedSearch.png">


### Using Advanced Search
In advanced search, you can use a SQL-like query to search for items in that view. In the example below, we're selecting for all files that have a `Cell Type` of `PSC`. 

<img id="image" src="/assets/images/fileViewAdvancedSearch.png">


## Insert a View into a Wiki
Views can also be placed inside a [`Wiki`](/articles/wikis.html) once they have been created. You can embed the entire view or a subset of a query on it. 

To insert a file view with a synId of `syn8146547`:

In the **Edit Project Wiki** window, select **Table: Query on a Synapse Table/View** under the **Insert** dropdown. To embed the entire file view into the wiki enter `SELECT * FROM syn8146547` in the resulting pop-up.


To embed a subset of the file view, like the advanced search query in the previous example, enter `SELECT * FROM syn8146547 WHERE Cell_Type = 'PSC'`. 

<img id="image" src="/assets/images/subsetFileViewWiki.png">


**Save** the query and the edits to the `Wiki` to embed the file view.


## See Also
[Annotations and Queries](/articles/annotation_and_query.html), [Tables](/articles/tables.html), [Wikis](/articles/wikis.html)
