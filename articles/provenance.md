---
title: "Provenance"
layout: article
excerpt: Learn about how Synapse visualizes and tracks the relationships of files and projects for reproducibility.  
---

## Provenance

Reproducible research is a fundamental responsibility of scientists, but the best practices for achieving it are not established in computational biology. The Synapse “Provenance” system is one of many solutions you can use to make your work reproducible by you and others.

<img src="/assets/images/Prov_web_screenshot.png" align="right">

Provenance is a concept describing the origin of something; in Synapse it is used to describe the connections between workflow steps that derive a particular file of results. Data analysis often involves multiple steps to go from a raw data file to a finished analysis.  Synapse’s Provenance Tools allow users to keep track of each step involved in an analysis, and share those steps with other users. Synapse provides capabilities for tracking the relationship between digital assets (e.g. data, code, analytical results), regardless of the computing location on which the steps are executed.

On the right is a Synapse visualization of provenance relationships involved in creation of the file at the bottom: "pc_cases_DGE.R". To recapitulate this file, you can retrieve the elements from an upstream step and execute the same actions.


### The basic elements of Synapse provenance


The model Synapse uses for provenance is based on the [W3C provenance spec](https://www.w3.org/standards/techs/provenance#w3c_all){:target="_blank"} where items are derived from an **activity** which has components that were **used**  and components that were **executed**.  Think of the used items as input files and executed items as software or code.  Both used and executed can either be items in Synapse or URLs such as a link to a github commit or a link to specific version of a software tool.  

To edit Provenance information for an entity in Synapse, choose **Edit Provenance** from the Tools menu of the webpage for your entity. This will bring up a dialog that lets you name the **activity** and specify which elements were **used** and **executed** to create the file. The below example shows a filtering activity that has a synapse ID as an input (used) element and some code in github that was executed. You can specify more than one used and/or executed items if needed.

<img style="float: left;" src="/assets/images/Prov_web_editing.png">


### Using R, python, or bash

The Synapse clients for R, python, and bash support creation and editing of provenance relationships.

For example, create a file:

{% tabs %}

{% tab Command %}
{% highlight bash %}
Need code here
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
need code here
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
file <- File(path="filteredPathwayResults.txt", parentId="syn2367745")
{% endhighlight %}
{% endtab %}

{% tab Web %}
Need example here
{% endtab %}

{% endtabs %}

<br>


Store it, indicating that another entity was used to create it.

{% tabs %}

{% tab Command %}
{% highlight bash %}
Need code here
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
need code here
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
file <- synStore(file, used=list("syn2824593"))
{% endhighlight %}
{% endtab %}

{% tab Web %}
Need example here
{% endtab %}

{% endtabs %}

<br>

Now, show the provenance relationship you created in the previous step:

{% tabs %}

{% tab Command %}
{% highlight bash %}
Need code here
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
need code here
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
provenance <- generatedBy(file)
provenance{% endhighlight %}
{% endtab %}

{% tab Web %}
Need example here
{% endtab %}

{% endtabs %}



### Details on using provenance:

{:.markdown-table}
| Introduction | Full Docs |
| -- | -- |
| [python](https://www.synapse.org/#!Synapse:syn1768504/wiki/56099) | [python docs](http://docs.synapse.org/python/)
| -- | -- |
| [R](https://www.synapse.org/#!Synapse:syn1834618/wiki/55486) | [R docs](http://docs.synapse.org/r)
| -- | -- |
|  | [bash docs](http://docs.synapse.org/python/CommandLineClient.html) |



