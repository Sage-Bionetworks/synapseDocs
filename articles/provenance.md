---
title: "Provenance"
layout: article
excerpt: Learn about how Synapse visualizes and tracks the relationships of files and projects for reproducibility.  
---

<style>
#image {
 width: 55%;
 border: 1px solid #1e7098;
}
</style>

## Provenance

Reproducible research is a fundamental responsibility of scientists, but the best practices for achieving it are not established in computational biology. The Synapse “Provenance” system is one of many solutions you can use to make your work reproducible by you and others.

Provenance is a concept describing the origin of something; in Synapse it is used to describe the connections between workflow steps that derive a particular file of results. Data analysis often involves multiple steps to go from a raw data file to a finished analysis.  Synapse’s Provenance Tools allow users to keep track of each step involved in an analysis, and share those steps with other users. 

### The basic elements of Synapse provenance


The model Synapse uses for provenance is based on the [W3C provenance spec](https://www.w3.org/standards/techs/provenance#w3c_all){:target="_blank"} where items are derived from an **activity** which has components that were **used**  and components that were **executed**.  Think of the used items as input files and executed items as software or code.  Both used and executed can either be items in Synapse or URLs such as a link to a github commit or a link to specific version of a software tool.  

The Synapse clients for command line, Python, and R support creating and editing of provenance relationships. The Web client allows editing of provenance once the file has been uploaded.

Below is a Synapse visualization of provenance relationships that is demonstrated in the following section using our programmatic and web clients. in this example, we have two scripts, one that generates random numbers and another that takes a list of numbers and computes their squares. The project's workflow looks like this:

<img id="image" src="/assets/images/provenanceWorkflowDemo.png">

<br/>

### Step-by-step using command line, Python, R, or Web

* **Generate random data**

Generate a file containing a list of normally distributed random numbers. This will mean that you have a script file that was used to create a data file to upload to Synapse. For example, using command line:


````
# running Python code
python generate_random_data.py > random_numbers.txt

# running R code
Rscript generate_random_data.R > random_numbers.txt
````


Now we have the script: `generate_random_data.py` and the file it generated: `random_numbers.txt`.

* **Add Synapse entities**

For this example, we'll assume the project already exists (syn7118141). We'll add our code and data files to this project, or in Synapse terminology, the project will be the parent of the new entities. 

{% tabs %}

{% tab Command %}
{% highlight bash %}
# Add the script to Synapse
synapse add -description "A script that generates normally distributed random numbers" -parentId syn7118141 generate_random_data.py

# Add the data file to Synapse
synapse add random_numbers.txt -description "A few normally distributed random numbers" -parentId syn7118141
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
# Add the script to Synapse
file = File(path="generate_random_numbers.py", parent="syn7118141", synapseStore=True, description="A script that generates normally distributed random numbers")

# Add the data file to Synapse
file = File(path="random_numbers.txt", parent="syn7118141", synapseStore=True, description="A few normally distributed random numbers")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Add the script to Synapse
file = File(path="generate_random_numbers.R", parentId="syn7118141", synapseStore=True, description="A script that generates normally distributed random numbers")

# Add the data file to Synapse
file = File(path="random_numbers.txt", parentId="syn7118141", synapseStore=True, description="A few normally distributed random numbers")
{% endhighlight %}
{% endtab %}

{% tab Web %}
Navigate to the **Files** tab on the project and click on **Upload or Link to File**. In the resulting pop-up, click the **Choose File** button and select the file(s) you would like to upload.
{% endtab %}

{% endtabs %}

<br/>

As you upload files onto Synapse, the new entity's synId will be provided. For this example, the new synId for the uploaded script file will be `syn7118143` and for the data file will be `syn7118147`. 

{% include note.html content="Currently the web application does not support setting provenance when uploading a file." %}

* **Provenance**

There are a couple ways to set provenance information for a Synapse entity. The `used` and `executed` arguments specify resources used and code executed in the process of creating the entity. Code can be stored in Synapse or, better yet, linked by URL to a source code versioning system like Github or SVN.
As an example, we'll specify 3 somewhat contrived sources of provenance:    
   1. synapse entity, syn7118143 (the script)     
   2. URL to a page describing normal distributions     
   3. And entity in Synapse specified by a local path (http://www.synapse.org/#!Synapse:syn1738330, or simply, #!Synapse:syn1738330)


{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse set-provenance -id syn7118147 -executed syn7118143 -used http://mathworld.wolfram.com/NormalDistribution.html 'http://www.synapse.org/#!Synapse:syn1738330' -name "Random numbers"
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
file = syn.store(file, executed="syn7118143", used=["http://mathworld.wolfram.com/NormalDistribution.html", "#!Synapse:syn1738330"], activityName="Random numbers")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
file <- synStore(file, executed="syn121212", used=list("http://mathworld.wolfram.com/NormalDistribution.html", "#!Synapse:syn1738330"),  activityName = "Random numbers")
{% endhighlight %}
{% endtab %}

{% tab Web %}
To update the provenance on a file, navigate to the `File's` tab and click on the `File` that you would like to update. Click on the **Tools** dropdown in the upper right hand corner and select **Edit Provenance**. In the resulting pop-up, enter the relevant information. In this example **Name**: Random numbers and **Description**: A few normally distributed random numbers.
To add the executed code, under **Executed** select **Add Synapse Reference** and enter **syn7118143** and under **Used**, select **Add External URL Reference** to add http://mathworld.wolfram.com/NormalDistribution.html and #!Synapse:syn1738330.

<img src="/assets/images/editProvenance.png">

{% endtab %}

{% endtabs %}

Alternatively, in command line, we could have specified `used` and `executed` arguments to the `synapse add` command, adding the new entity and setting its provenance in one step:

````
synapse add random_numbers.txt -parentId syn7118141 -description "A few normally distributed random numbers" -executed syn7118143 -used http://mathworld.wolfram.com/NormalDistribution.html 'http://www.synapse.org/#!Synapse:syn1738330'
````


* **Computing derived data**

Now, we'll derive some new results from our initial data file:
For example, using command line:


````
# running Python code
python square.py random_numbers.txt > squares.txt

# running R code
Rscript square.R random_numbers.txt > squares.txt
````

<br/>

**Add the code entity:**

{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse add -parentid syn7118141 -description "A script that squares a list of numbers" square.py
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
file = File(path="square.py", parentId="syn7118141", synapseStore=True)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
file <- File(path="square.R", parentId="syn7118141", synapseStore=True)
{% endhighlight %}
{% endtab %}

{% tab Web %}
Navigate to the **Files** tab on the project and click on **Upload or Link to File**. In the resulting pop-up, click the **Choose File** button and select the file(s) you would like to upload.{% endtab %}

{% endtabs %}

<br/>

**Add the list of squared numbers:**

{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse add squares.txt -parentid syn7118141 -description "Squares of random numbers" -used syn7118147 -executed syn7118154 
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
file = syn.store(file, executed="syn7118154", used="syn7118147", activityName = "Squaring")
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
file <- synStore(file, executed=list("syn987654"), used=list("232323"), activityName = "Squaring")
{% endhighlight %}
{% endtab %}

{% tab Web %}
Navigate to the **Files** tab on the project and click on **Upload or Link to File**. In the resulting pop-up, click the **Choose File** button and select the file(s) you would like to upload.{% endtab %}

In Web, to set the provenance, you will first have to upload the file and then navigate to **Tools** and **Edit Provenance** to update/set the information.

<img src="/assets/images/editProvenance2.png">

{% endtabs %}

<br/>

**Now, show the provenance relationship you created:**

{% tabs %}

{% tab Command %}
{% highlight bash %}
synapse get-provenance -id syn7118162
{% endhighlight %}
{% endtab %}

{% tab Python %}
{% highlight python %}
syn.getProvenance(file)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
provenance <- generatedBy(file)
provenance
{% endhighlight %}
{% endtab %}

{% tab Web %}
Navigate to the `File's` page to view its provenance. Clicking on the triple dots above entities will expand it to show the `File's` full provenance.

<img id="image" src="/assets/images/expandProvenance.png">
{% endtab %}

{% endtabs %}

<br/>

### Reusing an Activity for multiple files

An `Activity` is a Synapse object that helps keep track of what objects were 'used' in an analysis step ... as well as what objects were generated. Thus, all relationships between Synapse objects and an `Activity` are governed by dependencies. That is, an `Activity` needs to know what it 'used' -- and outputs need to know what `Activity` they were 'generatedBy'. A couple of points for clarity:

* An `Activity` can 'use' many things (i.e. many inputs to an analysis)
* Many outputs can be 'generatedBy' the same `Activity`

If an activity isn't assigned to an entity and then stored, a separate graph will be created for each file that the activity generated. 
The following example is used to assign the same activity to multiple files resulting in one provenance graph: 

{% tabs %}

{% tab Command %}
{% highlight bash %}
Unfortunately, command line currently does not support assigning the same activity to multiple files.
{% endhighlight %}
{% endtab %}


{% tab Python %}
{% highlight python %}
# Code used to generate the file
code_file = syn.get("syn123456")

# Files used to generate the information
expr_file = syn.get("syn246810")
filter_file = syn.get("syn135791")

# Activity to assign to multiple files
act = Activity(name="filtering",
                used=[expr_file, filter_file],
                executed=code_file)
syn.store(final_file, activity=act)

# Get the activity now associated with an entity
act = syn.getProvenance(final_file)

# Now you can set this activity to as many files as you want (file1, file2, etc are Synapse Files)
file_list = [file_1, file_2, file_3]
file_list = map(lambda x: syn.store(x, activity=act), file_list)

{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Code used to generate the file
codeFile <- synGet("syn123456")

# Files used to generate the information
expr_file = synGet("syn246810")
filter_file = synGet("syn135791")

# Activity to assign to multiple files
act <- Activity(name="filtering",
                used=list(
                  list(entity=codeFile, wasExecuted=T),
                  list(entity=exprFile, wasExecuted=F),
                  list(entity=filterFile, wasExecuted=F)))
finalFile <- synStore(finalFile, activity=act)

# Get the activity now associated with an entity
act <- synGetActivity(finalFile)

# Now you can set this activity to as many files as you want (file1, file2, etc are Synapse Files)
finalList <- c(file1, file2, file3)
finalList <- lapply(finalList, function(x) synStore(x, activity=act))

{% endhighlight %}
{% endtab %}

{% tab Web %}
Unfortunately, the web interface currently does not support assigning the same activity to multiple files.
{% endtab %}

{% endtabs %}


### Details on using provenance

{:.markdown-table}
| Full Docs |
| -- |
| [python docs](http://docs.synapse.org/python/)
| -- |
| [R docs](http://docs.synapse.org/r)
| -- | -- |
| [command line docs](http://docs.synapse.org/python/CommandLineClient.html) |



