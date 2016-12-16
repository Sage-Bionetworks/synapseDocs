---
title: Tables
layout: article
excerpt: The basics of creating, modifying, and querying tabular data on Synapse.
category: howto
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
the analytical clients. **See the [API docs](http://docs.synapse.org/rest/org/sagebionetworks/repo/web/controller/TableExamples.html){:target="_blank"} for an enumeration of the types of queries that can be performed.** Here are a couple of simple examples.

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
Synapse allows you to create, modify and query tabular data. A `Table` has a Schema and holds a set of rows conforming to that schema. A Schema is defined in terms of Column objects that specify types from the following choices: 

{:.markdown-table}
| \<columnType> |
| ---- |
| STRING |
| DOUBLE|
| INTEGER |
| BOOLEAN |
| DATE |
| ENTITYID |
| FILEHANDLEID |

<br/>

For the following code examples, we'll be using the [Wondrous Research Project (syn1901847)](https://www.synapse.org/#!Synapse:syn1901847/){:Target="_blank"}. The .csv file used in the example below can be downloaded [here](https://www.synapse.org/#!Synapse:syn7256188){:target="_blank"}.


### Creating a Table

**1. Start with a dataframe, .csv, or .tsv:**

{% tabs %}

{% tab Python %}
{% highlight python %}
import synapseclient
syn = synapseclient.login()

# Convert a .csv to a Pandas DataFrame (this requires that you have Pandas installed)
import pandas as pd
df = pd.read_csv('path/to/jazzAlbums.csv', index_col=False)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
require(synapseClient)
synapseLogin()

csvFile <- read.csv('path/to/jazzAlbums.csv')

# Convert to a data frame in your session:
df <- as.data.frame(csvFile)

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
project = syn.get('syn1901847')
cols = synapseclient.as_table_columns(df)

schema = synpaseclient.Schema(name='Jazz Albums', columns=cols, parent=project)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
project <- synGet('syn1901847')
tcresult <- as.tableColumns(df)
cols <- tcresult$tableColumns

schema <- TableSchema(name='Jazz Albums', columns=cols, parent=project)
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
- a dataframe
- a [`RowSet` object](http://docs.synapse.org/rest/org/sagebionetworks/repo/model/table/RowSet.html){:target="_blank"}
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
Python returns an iterator and R returns a data frame by default. To return a data frame in Python use Pandas `results.asDataFrame()`.

{% tabs %}

{% tab Python %}
{% highlight python %}
results = syn.tableQuery('select * from syn7264701')
df = results.asDataFrame()
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
queryResult <- synTableQuery('select * from syn7264701')
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

When updating, begin by querying the table to ensure you have the latest schema and values.
           
**Updating existing values**

{% tabs %}

{% tab Python %}
{% highlight python %}
# Change the album value 'Vol. 2' to 'Volume 2' 
schema = syn.get(table.schema.id)
query = syn.tableQuery("select * from %s where album='Vol. 2'" %table.schema.id)
df = query.asDataFrame()
df['album'] = 'Volume 2'
syn.store(Table(schema, df))
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Change the album value 'Vol. 2' to 'Volume 2' 
queryResult <- synTableQuery("select * from syn7266590 where album='Vol. 2'")
queryResult@values['album'] <- 'Volume 2'

table <- synStore(queryResult)
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
new_column = syn.store(synapseclient.Column(name='purchased', columnType='STRING'))
#Add the new column to existing schema
schema.addColumn(new_column)
schema = syn.store(schema)
# Query for the newest schema
results = syn.tableQuery('select * from syn7264701')
df = results.asDataFrame()
# Add values into the new column
df['purchased'] = ['yes', 'yes', 'no', 'yes']
# Store the new table
syn.store(Table(schema, df))
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Define a new column
newColumn <- TableColumn(name="purchased", columnType="STRING")
# Add the new column to existing schema
schema <- synAddColumn(schema, newColumn)
schema <- synStore(schema)
# Query for the newest schema
queryResult <- synTableQuery('select * from syn7264701')
# Add values
queryResult@values['purchased'] <- c('yes', 'yes', 'no', 'yes') 
# Store the new table
table <- synStore(queryResult)
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
    if col.name == 'purchased':
        schema.removeColumn(col)
schema = syn.store(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Get the latest table
table <- synGet('syn7264701')
# delete the 'purchased' column
schema <- synRemoveColumn(table, table@columns[[5]])
# store the new table
table <- synStore(schema)
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
    if col.name == 'purchased':
        schema.removeColumn(col)
new_column2 = syn.store(synapseclient.Column(name='sold', columnType='STRING'))
schema.addColumn(new_column2)
schema = syn.store(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Get the latest table
table <- synGet('syn7266590')
# delete the 'purchased' column
schema <- synRemoveColumn(table, table@columns[[5]])
# store the new table
table <- synStore(schema)
# get the latest table
table <- synGet('syn7264701')
# Define the new column
newColumn <- TableColumn(name='sold', columnType='STRING')
# Add the new column to the existing schema
schema <- synAddColumn(table, newColumn)
schema <- synStore(schema)
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
new_rows = [['Charles Mingus', 'Blues & Roots', 1960, 'SD 1305'],
            ['Eugen Cicero', 'Rokoko-Jazz', 1965, 'SB 15027']]
table = syn.store(synapseclient.Table(schema, new_rows))
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
newRows <- data.frame('artist'=c('Charles Mingus', 'Eugen Cicero'), 
                      'album'=c('Blues & Roots', 'Rokoko-Jazz'), 
                      'year'=as.integer(c(1960, 1965)),
                      'catalog'=c('SD 1305', 'SB 15027'))
schema <- synGet('syn7266590')
tableToAppend <- Table(schema, newRows)
table <- synStore(tableToAppend)
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
rowsToDelete = syn.tableQuery("select * from %s where artist='Sonny Rollins'" %table.schema.id)
a = syn.delete(rowsToDelete.asRowSet())
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Query for the rows you want to delete and call synDeleteRows on the results:
rowsToDelete <- synTableQuery("select * from syn7264701 where artist='Sonny Rollins'")
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
results = syn.tableQuery("select * from %s where artist='Sonny Rollins'" %table.schema.id)
df = results.asDataFrame()
df['purchased'] = ['yes', 'yes']
table = syn.store(synapseclient.Table(schema, df))
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
results <- synTableQuery("select * from syn7264701 where artist='Sonny Rollins'")
results@values['purchased'] <- c('yes', 'yes')
table <- synStore(results)
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

### Working with Files in a Table

#### Table attached files

Synapse `Tables` support a special column type called `File` which contain a file handle, an identifier of a file stored in Synapse. Here’s an example of how to upload files into Synapse, associate them with a table and read them back later.

**1. Add a new column for files in the table we're currently working with**

{% tabs %}

{% tab Python %}
{% highlight python %}
# Add a column for files
col = syn.store(Column(name='covers', columnType='FILEHANDLEID'))
schema.addColumn(col)
schema = syn.store(schema)
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# Add a column for files
fileColumn <- TableColumn(name='covers', columnType='FILEHANDLEID')
schema <- synAddColumn(schema, fileColumn)
schema <- synStore(schema)
{% endhighlight %}
{% endtab %}

{% tab Web %}
To add columns, click on the **Schema** button. From there, select the **Edit Schema** button and then add columns using the **Add Column** button located at the bottom of the pop-up and set the **Column Type** as **File**.
<br>
<img id="image" src="/assets/images/table_updating_columns.png">
{% endtab %}

{% endtabs %}

<br/>

**2. Retrieve the most current table and save as a data frame**

{% tabs %}

{% tab Python %}
{% highlight python %}
# retrieve the most current table
results = syn.tableQuery('select * from syn7264701')
df = results.asDataFrame()
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# get the latest table
table <- synTableQuery('select * from syn7264701')
{% endhighlight %}
{% endtab %}

{% tab Web %}
Click **Save** to save your latest schema. 

<img id="image" src="/assets/images/save_table.png">
{% endtab %}

{% endtabs %}

<br/>

**3. Upload the files:** The files used in this example can be downloaded [here](https://www.synapse.org/#!Synapse:syn7274194){:target="_blank"}. It is assumed that the files are in your current working directory.

{% tabs %}

{% tab Python %}
{% highlight python %}
## the actual data
files = ['./coltraneBlueTrain.jpg', './rollinsBN1558.jpg', 
		'./rollinsBN4001.jpg','./burrellWarholBN1543.jpg']

# Upload to filehandle service
files = [syn._uploadToFileHandleService(f) for f in files]

# get the filehandle ids
fileHandleIds = [i['id'] for i in files]

# assign the filehandle ids to the new column
df['covers'] = fileHandleIds

# store the new column
syn.store(Table(schema, df))
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
# the actual data
files <- c('./coltraneBlueTrain.jpg', './rollinsBN1558.jpg', 
         './rollinsBN4001.jpg','./burrellWarholBN1543.jpg')

# upload to filehandle service
files <- lapply(files, function(f) synapseClient:::chunkedUploadFile(f))

# get the filehandle ids
fileHandleIds <- sapply(files, function(i) i[1]$id)

# assign the filehandle ids to the new column
table@values['covers'] <- fileHandleIds

# store the new column
synStore(table)
{% endhighlight %}
{% endtab %}

{% tab Web %}
Click on the **Edit icon** to the right of the **Query** button. In the resulting pop-up, you can upload files by clicking the **Upload icon** then **Browse** and selecting the file from your local directory. Save the new table. 

<img id="image" src="/assets/images/upload_files_to_table.png">
{% endtab %}

{% endtabs %}

<br/>

**4. Query the table and download the album cover files**

{% tabs %}

{% tab Python %}
{% highlight python %}
results = syn.tableQuery("select covers from %s where artist = 'Sonny Rollins'" % schema.id)
cover_files = syn.downloadTableColumns(results, ['cover'])
{% endhighlight %}
{% endtab %}

{% tab R %}
{% highlight r %}
results <- synTableQuery('select covers from syn7264701')
coverFiles <- synDownloadTableColumns(results, 'covers')
{% endhighlight %}
{% endtab %}

{% tab Web %}
Clicking on any file will download it.

<img id="image" src="/assets/images/download_files_from_table.png">
{% endtab %}
{% endtabs %}


## More on tables
There are additional docs available for `Tables` in both Python and R that cover more advanced topics.

For **Python** check out our [Python Docs](http://docs.synapse.org/python/Table.html#module-synapseclient.table).

For **R**, open up your R session and check out our vignettes by typing `vignette("tables", package="synapseClient")` into your console.
