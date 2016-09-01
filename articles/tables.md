---
title: Tables
layout: article
excerpt: The basics of creating, modifying, and querying tabular data on Synapse.
---

<style>
#image {
    width: 50%;
}
</style>


## Tables
Synapse `Tables` is a feature designed to provide users the ability to create web-accessible, sharable, and queryable 
data where columns can have a user-specified structured schema. Users may define table columns to contain common primitive 
data types (text, numbers, dates, etc.) or references to other Synapse objects (e.g., `Files`). Therefore, it is possible to 
organize sample metadata into tables that include columns for desired sample fields, as well as columns that link the sample 
information to a heterogeneous collection of files.
`Tables` may be queried and edited through both the Synapse web portal as well as through our analytical clients 
that enable direct access to these data from analysis pipeline code. Unlike most NoSQL systems, the data in Synapse `Tables` 
is strongly consistent, not eventually consistent. This is an important design consideration for scientific data processing, 
as analysis on eventually-consistent data sources can limit the types of analysis performed, and may require special coding 
strategies to ensure reasonable accuracy.


### Table Schema
Synapse `Tables` contain metadata that specifies the types of columns included in the `Table`. These columns can be specified manually, 
or Synapse can recommend column types when a user uploads a data file.

### Table Data
The data contained within a Synapse `Table` can be retrieved by using a SQL-like query language either through the web portal or through 
the analytical clients. **See the [API docs](http://docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html) for an enumeration of the types of queries that can be performed.** Here are a couple of simple 
examples.

To get all of the columns from a `Table` with id syn3079449, the following query would be used:

````
SELECT * FROM syn3079449
````

To get only the two columns called "age" and "gender":

````
SELECT age, gender FROM syn3079449
````   

To count the number of rows:

````
SELECT count(*) FROM syn3079449
````

To get all columns, but only rows where age is greater that 50:

````
SELECT * FROM syn3079449 WHERE age > 50
````
    
To get all columns, but only rows where age is greater that 50 - and sort by treatmentArm:

````
SELECT * FROM syn3079449 WHERE age > 50 ORDER BY "treatmentArm" ASC
````


## Using Tables

### Overview  
Synapse allows you to create, modify and query tabular data.
A `Table` has a Schema and holds a set of rows conforming to that schema.
A Schema is defined in terms of Column objects that specify types from the following choices: 
STRING, DOUBLE, INTEGER, BOOLEAN, DATE, ENTITYID, FILEHANDLEID.

<br>

### Creating a Table

**1. Start with a dataframe:**

{% tabs %}

{% tab Python %}
{% highlight python %}
import synapseclient
syn = synapseclient.login()

# Pandas (For Python only): Pandas is a popular library for working with tabular data. 
# If you have Pandas installed, the goal is that Synapse Tables will play nice with it.
# Convert a .csv to a Pandas DataFrame
import pandas as pd
df = pd.read_csv("/path/to/foo.csv", index_col=False)

{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
require(synapseClient)
synapseLogin()

#Begin with a data frame in your session:
df <- data.frame("n"=c(1.1, 2.2, 3.3),
                 "c"=c("foo", "bar", "bar"),
                 "i"=as.integer(c(10,10,20)))
{% endhighlight %}
{% endtab %}

{% tab Web %}
Navigate to the **Tables** tab on your project. You have to option to insert data directly by clicking on the **Add Table** button or upload a **.csv** or **.tsv** file by clicking the **Upload Table** button. 
<br>
<img id="image" src="/assets/images/addOrUploadTable.png">

{% endtab %}

{% endtabs %}

<br>

**2. Create table schema:** Each client has a utility function to create Columns from a data frame. 
Python uses `synapseclient.as_table_columns` and R uses `as.tableColumns`.

{% tabs %}

{% tab Python %}
{% highlight python %}

cols = synapseclient.as_table_columns(df)

schema = synpaseclient.Schema(name='My Schema', columns=cols, parent=project)

{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
tcresult <- as.tableColumns(df)
cols <- tcresult$tableColumns

schema <- TableSchema(name="mySchema", columns=cols, parent=project)
{% endhighlight %}
{% endtab %}

{% tab Web %}
If you upload a file, the Web interface will automatically detect the table schema. After a few prompts, you will arrive at the option to name your table. You can adjust the schema(e.g. Column Name, Column Type, etc) here by clicking on the **Schema Options** button underneath the name. 
<br>
<img id="image" src="/assets/images/tableSchema.png">
{% endtab %}

{% endtabs %}

<br>

The Table() function takes two arguments, a schema object and data in some form, which can be:

- a path to a CSV file
- a [Pandas](http://pandas.pydata.org/){:target="_blank"} [DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe){:target="_blank"} (This is a Python-only feature)
- a `RowSet` object
- a list of lists where each of the inner lists is a row

<br>

**3. Store table in Synapse:**

{% tabs %}

{% tab Python %}
{% highlight python %}
table = synapseclient.Table(schema, df)
table = syn.store(table)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
table <- Table(schema, df)
table <- synStore(table)
{% endhighlight %}
{% endtab %}

{% tab Web %}
Upload the table into Synapse by clicking the **Create** button.

<img id="image" src="/assets/images/createTable.png">
{% endtab %}

{% endtabs %}

<br>

**4. Query the table:**
Python returns an iterator and R returns a data frame. To return a data frame in Python using Pandas `results.asDataFrame()`.

{% tabs %}

{% tab Python %}
{% highlight python %}
results = syn.tableQuery("select * from %s where c='bar'" % table.schema.id)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
queryResult <- synTableQuery(sprintf("select * from %s where c='bar'", table@schema$id))
{% endhighlight %}
{% endtab %}

{% tab Web %}
Tables can be queried by using the Query bar above each table. 
<br>
<img id="image" src="/assets/images/table_query.png">
{% endtab %}

{% endtabs %}

<br>

### Making changes to tables

Once the schema is settled, changes can be made by adding, appending, and deleting.

In Python, updating requires an *etag*, which identifies the most recent change set plus row IDs and version numbers for 
each row to be modified. We get those by querying before updating. Minimizing changesets to contain only rows that actually 
change will make processing faster.

The etag is used by the server to prevent concurrent users from making conflicting changes, a technique called optimistic concurrency. 
In case of a conflict, your update may be rejected. You then have to do another query and try your update again.
           
**Updating existing values**

{% tabs %}

{% tab Python %}
{% highlight python %}
results = syn.tableQuery("select * from %s where n='2.2'" %table.schema.id)
df = results.asDataFrame()
df['n'] = [pi]
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
#Update values in the second row, column "n" with the value "pi"
queryResult@values[2, "n"] <- pi
table <- synStore(queryResult, retrieveData=TRUE)
table@values
{% endhighlight %}
{% endtab %}

{% tab Web %}
Click on the **edit** icon to the right of the **Query** button to update table values.
<br>
<img id="image" src="/assets/images/table_update_values.png">
{% endtab %}

{% endtabs %}

<br>

#### Changing Columns

{% include note.html content="To be compatible across multiple languages the common practice of using dots (.) in column names in R is not supported in Synapse Tables." %}
**Adding new columns**

{% tabs %}

{% tab Python %}
{% highlight python %}
#Define a new column
new_column = syn.store(synapseclient.Column(name='new', columnType='STRING'))
#Add the new column to existing schema
synpaseclient.Schema.addColumn(new_column)
schema = syn.store(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
#Define a new column
newColumn <- TableColumn(name="new", columnType="STRING")
#Add the new column to existing schema
schema <- synAddColumn(schema, newColumn)
schema <- synStore(schema)
{% endhighlight %}
{% endtab %}

{% tab Web %}
To add columns, click on the **Schema** button. From there, select the **Edit Schema** button and then add columns using the **Add Column** button located at the bottom of the pop-up.
<br>
<img id="image" src="/assets/images/table_updating_columns.png">
{% endtab %}

{% endtabs %}

<br>

**Deleting columns**

{% tabs %}


{% tab Python %}
{% highlight python %}
cols = syn.getTableColumns(schema)
for col in cols:
    if col.name == "new":
        synapseclient.Schema.removeColumn(col)
schema = syn.store(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}

schema <- synRemoveColumn(schema, aColumn)

schema <- synStore(schema)
{% endhighlight %}
{% endtab %}

{% tab Web %}
To delete columns, click on the **Schema** button. From there, click the **Edit Schema** button and then select the columns you would like to delete and delete them by clicking the **trash can** icon at the top.
<br>
<img id="image" src="/assets/images/table_deleting_columns.png">
{% endtab %}

{% endtabs %}

<br>

**Modifying existing columns**

{% tabs %}

{% tab Python %}
{% highlight python %}
# Renaming or otherwise modifying a column involves removing the column and adding a new column
cols = syn.getTableColumns(schema)
for col in cols:
    if col.name == "new":
        synapseclient.Schema.removeColumn(col)
new_column2 = syn.store(synapseclient.Column(name='new2', columnType='STRING'))
synapseclient.Schema.addColumn(new_column2)
schema = syn.store(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Renaming or otherwise modifying a column involves removing the column and adding a new column
newColumn <- TableColumn(name="new", columnType="STRING")
schema <- synAddColumn(schema, newColumn)
schema <- synStore(schema)
table <- synTableQuery(sprintf("select * from %s", propertyValue(schema, "id")), 
                       loadResult=TRUE)
#Replace NAS in the new column with other values
table@values["new"] <- c("one", "two", "three")
table <- synStore(table, retrieveData=TRUE)
table@values
{% endhighlight %}
{% endtab %}

{% tab Web %}
To modify information in a column, first begin by **adding** a new column, then **copy** the data from the column you would like to change into the newly created column, make the changes in the new column, and **delete** the old one.
 In this example, we are chaning the **Column Type** of **Header_1** into **Boolean** and setting the **Default Value** to **true**.
 <img id="image" src="/assets/images/table_modifying_columns.png">
{% endtab %}

{% endtabs %}

<br> 


#### Changing Rows

**Adding new rows**

{% tabs %}

{% tab Python %}
{% highlight python %}
new_rows = [["4.4", "moar", 100],
            ["5.5", "stuff", 90],
            ["6.6", "here", 80]]
table = syn.store(synapseclient.Table(schema, new_rows))
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
newRows <- data.frame("n"=c(4.4, 5.5, 6.6), 
                       "c"=c("moar", "stuff", "here"), 
                       "i"=as.integer(c(100,90,80)))
tableToAppend <- Table(schema, newRows)
table <- synStore(tableToAppend, retrieveData=TRUE)
table@values
{% endhighlight %}
{% endtab %}

{% tab Web %}
Click on the **Edit icon** to the right of the query button to get to the **Edit Rows** pop-up. From there, you can add rows by click the **+** at the top. 
<br>
<img id="image" src="/assets/images/table_add_rows.png">
{% endtab %}

{% endtabs %}

<br>

**Deleting rows**

{% tabs %}

{% tab Python %}
{% highlight python %}
# Query for the rows you want to delete and call syn.delete on the results:
rowsToDelete = syn.tableQuery("select * from %s where c='foo'" %table.schema.id)
a = syn.delete(rowsToDelete.asRowSet())
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Query for the rows you want to delete and call synDeleteRows on the results:
rowsToDelete <- synTableQuery(sprintf("select * from %s where c='foo'", table@schema$id)))
synDeleteRows(rowsToDelete)
{% endhighlight %}
{% endtab %}

{% tab Web %}
Click on the **Edit icon** to the right of the query button to get to the **Edit Rows** pop-up. From there, you can delete rows by checking the boxes of the rows you would like to delete and then clicking the **Trash Can** icon.
<br>
<img id="image" src="/assets/images/table_delete_rows.png">
{% endtab %}

{% endtabs %}

<br>

**Modifying existing rows**

{% tabs %}

{% tab Python %}
{% highlight python %}
results = syn.tableQuery("select * from %s where c='bar'" %table.schema.id)
df = results.asDataFrame()
df['i'] = [50, 60]
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
results <- synTableQuery(sprintf("select * from %s, table@schema$id))
results@values[c(2,3), "c"] <- pi
{% endhighlight %}
{% endtab %}

{% tab Web %}
To modify row entries, click on the **Edit icon** to the right of the **Query** button. In the resulting pop-up, you can adjust each entry as you please. In this example, the first and last entry of row two have been updated.
<br>
<img id="image" src="/assets/images/table_modify_rows.png">
{% endtab %}

{% endtabs %}

<br>

#### Deleting the whole table

**Delete the entire table**

{% tabs %}

{% tab Python %}
{% highlight python %}
#Deleting the schema deletes the whole table and all rows
syn.delete(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
#Deleting the schema deletes the whole table and all rows
synDelete(table@schema$id)
{% endhighlight %}
{% endtab %}

{% tab Web %}
To delete the entire Table, click on **Tools** and then select **Delete Table** from the resulting dropdown.
<br>
<img id="image" src="/assets/images/delete_table.png">
{% endtab %}

{% endtabs %}

<br>

## More on tables
There are additional docs available for `Tables` in both Python and R that cover more advanced topics such as table attached files and uploading .csv data via the Python client without using Pandas.

For **Python** check out our [Python Docs](http://docs.synapse.org/python/Table.html#module-synapseclient.table).

For **R**, open up your R session and check out our vignettes by typing `vignette("tables", package="synapseClient")` into your console.
