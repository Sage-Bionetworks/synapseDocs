---
title: Table Queries
layout: article
excerpt: The basics of creating, modifying, and querying tabular data on Synapse.
---

# Synapse Tables

Synapse Tables enable storage of tabular data in Synapse in a form that can be queried using a SQL-like query language.
Tables help to store and organize metadata in an easy-to-view format on the Synapse site. 

## **Synapse R Client Table Queries**


````
require(synapseClient)
````

### Overview

Synapse allows you to create, modify and query tabular data.  You provide data
in a data frame or csv file.

### Creating a Table

Begin with a data frame in your session:

````
{r makedf, include=TRUE, eval=TRUE}
df <- data.frame("n"=c(1.1, 2.2, 3.3), 
                 "c"=c("foo", "bar", "bar"), 
                 "i"=as.integer(c(10,10,20)))
````

The convenience function `as.tableColumns` creates table columns from your data frame:

````
{r createcols, include=TRUE, eval=FALSE}
tcresult <- as.tableColumns(df)
cols <- tcresult$tableColumns
````

`as.TableColumns` uploads your table in order to do its job.
It returns the ID of the uploaded file for later use.

````
{r getfilehandleid, include=TRUE, eval=FALSE}
fileHandleId <- tcresult$fileHandleId
````

You may adjust the column models before defining the table schema.
See "?TableColumn" for the available slots.

````
{r changecolsize, include=TRUE, eval=FALSE}
cols[[2]]@maximumSize <- as.integer(20)
````

Now store the Table schema in Synapse (using your own Project ID in place of "syn12345", below):

````
{r store, include=TRUE, eval=FALSE}
projectId <- "syn12345"
schema <- TableSchema(name="aschema", parent=projectId, columns=cols)
table <- Table(schema, fileHandleId)
table <- synStore(table, retrieveData=TRUE)
````

### Retrieving a Table

Query the table:

````
{r querythetbl, include=TRUE, eval=FALSE}
schemaId <- propertyValue(table@schema, "id")
queryResult <- synTableQuery(sprintf("select * from %s where c='bar'", schemaId))
````

### Updating Existing Values
The query result is a Table having a data frame in the 'values' slot. 
Now update the table and store it:

```` 
{r updatevals, include=TRUE, eval=FALSE}
queryResult@values[2, "n"] <- pi
table <- synStore(queryResult, retrieveData=TRUE)
table@values
````

### Adding Rows to a Table

To add more rows, put the additional rows in another data frame, embed in a Table, and call 'synStore', as shown:

````
{r addrows, include=TRUE, eval=FALSE}
moreData <- data.frame("n"=c(7.7, 8.8, 9.9), 
                       "c"=c("moar", "stuff", "here"), 
                       "i"=as.integer(c(100,90,80)))
tableToAppend <- Table(schema, moreData)
table <- synStore(tableToAppend, retrieveData=TRUE)
table@values
````

### Adding new Columns to a Table
The following example shows how to add a new column to a Table.  First, define a new column:

````
{r mknewcol, include=TRUE, eval=FALSE}
newColumn <- TableColumn(name="new", columnType="STRING")
````

Now add the new column to the existing schema:

````
{r addcol2schema, include=TRUE, eval=FALSE}
schema <- synAddColumn(schema, newColumn)
schema <- synStore(schema)
````

When the table is retrieved, the values in the new column are NA:

````
{r narows, include=TRUE, eval=FALSE}
table <- synTableQuery(sprintf("select * from %s", propertyValue(schema, "id")), 
                       loadResult=TRUE)
````

The NAs may be replaced with other values:

````
{r replacenas, include=TRUE, eval=FALSE}
table@values["new"] <- c("one", "two", "three", "four", "five", "six")
table <- synStore(table, retrieveData=TRUE)
table@values
````

### Deleting From a Table

You can delete selected rows from the table:

````
{r delrows, include=TRUE, eval=FALSE}
rowsToDelete <- synTableQuery(sprintf("select * from %s where c='foo'", schemaId))
synDeleteRows(rowsToDelete)
````

You can delete a column from a table:

````
{r removecol, include=TRUE, eval=FALSE}
schema <- synRemoveColumn(schema, aColumn)
schema <- synStore(schema)
````

You can also delete the entire table:

````
{r deltbl, include=TRUE, eval=FALSE}
synDelete(schemaId)
````


### Downloading a File Attachment

One of the column types provided by Synapse is `FILEHANDLEID`.  To download the file associated with a File Handle row:

````
{r getfilepath, include=TRUE, eval=FALSE}
filePath <- synDownloadTableFile(table, "0_0", "File Column Name")
````

i.e., the parameters include the row number/version and column name as available in a retrieved data frame.  The function returns the path to the downloaded file.

### Managing Tabular Data on the File System

Table creation and retrieval can be done with files on disk.
No need to load the data into memory first.
First we create a csv file to use:

````
{r mkcsv, include=TRUE, eval=FALSE}
df <- data.frame("n"=c(1.1, 2.2, 3.3), 
                 "c"=c("foo", "bar", "bar"), 
                 "i"=as.integer(c(10,10,20)))

file <- tempfile()
write.csv(df, file, row.names=FALSE)
rm(df)
````

Now we proceed using the created file only:

````
{r inmem, include=TRUE, eval=FALSE}
tcresult <- as.tableColumns(df)
cols <- tcresult$tableColumns
fileHandleId <- tcresult$fileHandleId

schema <- TableSchema(name="aschema", parent=projectId, columns=cols)
table <- Table(schema, fileHandleId)
table <- synStore(table, retrieveData=FALSE)
schemaId <- propertyValue(table@schema, "id")

queryResult <- synTableQuery(sprintf("select * from %s where c='bar'", schemaId), 
                             loadResult=FALSE)
queryResult@filePath
````

The returned file path contains the query results.


### Changing an existing column

Sometimes you may want to change an existing column.
What follows is an example of changing a column type, keeping the same data.

First, set the column name that you want to change, and the table it comes from.

````
{r, include=TRUE, eval=FALSE}
columnToChange <- "i"
````

Get the existing data.

````
{r, include=TRUE, eval=FALSE}
oldTable <- synGet(schemaId)
oldDataQuery <- synTableQuery(sprintf("SELECT * FROM %s", oldTable$properties$id))
oldData <- oldDataQuery@values
````

Now that you have the data, delete the column. The `newTable` is now without that column.

````
{r, include=TRUE, eval=FALSE}
collist <- setNames(oldTable$properties$columnIds, names(oldDataQuery@values))

oldTable$properties$columnIds <- setdiff(oldTable$properties$columnIds, collist[columnToChange])

newTable <- synStore(oldTable)
````

Make a new column with same name and save it to Synapse. Here, change `i` to a string.

````
{r, include=TRUE, eval=FALSE}
newcol <- TableColumn(name=columnToChange, columnType="STRING", maximumSize=50, defaultValue="")
newcol <- synStore(newcol)
````

Add that column to the table and save:

````
{r, include=TRUE, eval=FALSE}
newTable$properties$columnIds <- c(newTable$properties$columnIds, newcol@id)
newTable <- synStore(newTable)
````

Now, make changes and save to Synapse. In this case, just copy the old data to the new column.

````
{r, include=TRUE, eval=FALSE}
newQuery <- synTableQuery(sprintf("SELECT * FROM %s", newTable$properties$id))
newQuery@values[columnToChange] <- oldData[columnToChange]

## Commit the changes
synStore(newQuery)
````


### R sessionInfo()

````
{r sessionInfo}
sessionInfo()
````




## **Synapse Python Client Table Queries**


### Tables

Synapse Tables enable storage of tabular data in Synapse in a form that can be queried using a SQL-like query language.

### Tables is an BETA feature

The tables feature is in the beta stage. Please report bugs via [JIRA](https://sagebionetworks.jira.com/secure/Dashboard.jspa){:target="_blank"}.

A table has a [Schema](#schema) and holds a set of rows conforming to that schema.
A [Schema](#schema) is defined in terms of [Column](#column) objects that specify types from the following choices: STRING, DOUBLE, INTEGER, BOOLEAN, DATE, ENTITYID, FILEHANDLEID.

### Example

Preliminaries:

````
import synapseclient
from synapseclient import Project, File, Folder
from synapseclient import Schema, Column, Table, Row, RowSet, as_table_columns

syn = synapseclient.Synapse()
syn.login()

project = syn.get('syn123')
````

To create a Table, you first need to create a Table [Schema](#schema). This defines the columns of the table:

````
cols = [
    Column(name='Name', columnType='STRING', maximumSize=20),
    Column(name='Chromosome', columnType='STRING', maximumSize=20),
    Column(name='Start', columnType='INTEGER'),
    Column(name='End', columnType='INTEGER'),
    Column(name='Strand', columnType='STRING', enumValues=['+', '-'], maximumSize=1),
    Column(name='TranscriptionFactor', columnType='BOOLEAN')]

schema = Schema(name='My Favorite Genes', columns=cols, parent=project)
````

Next, let’s load some data. Let’s say we had a file, genes.csv:

````
Name,Chromosome,Start,End,Strand,TranscriptionFactor
foo,1,12345,12600,+,False
arg,2,20001,20200,+,False
zap,2,30033,30999,-,False
bah,1,40444,41444,-,False
bnk,1,51234,54567,+,True
xyz,1,61234,68686,+,False
````

Let’s store that in Synapse:

````
table = Table(schema, "/path/to/genes.csv")
table = syn.store(table)
````

The [Table()](#module-level-methods) function takes two arguments, a schema object and data in some form, which can be:

- a path to a CSV file
- a [Pandas](http://pandas.pydata.org/){:target="_blank"} [DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe){:target="_blank"}
- a ```RowSet``` object
- a list of lists where each of the inner lists is a row

With a bit of luck, we now have a table populated with data. Let’s try to query:

````
results = syn.tableQuery("select * from %s where Chromosome='1' and Start < 41000 and End > 20000" % table.schema.id)
for row in results:
    print(row)
````

### Pandas

[Pandas](http://pandas.pydata.org/){:target="_blank"} is a popular library for working with tabular data. If you have Pandas installed, the goal is that Synapse Tables will play nice with it.

Create a Synapse Table from a [DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe){:target="_blank"}:

````
import pandas as pd

df = pd.read_csv("/path/to/genes.csv", index_col=False)
schema = Schema(name='My Favorite Genes', columns=as_table_columns(df), parent=project)
table = syn.store(Table(schema, df))
````

Get query results as a [DataFrame](http://pandas.pydata.org/pandas-docs/stable/api.html#dataframe){:target="_blank"}:

````
results = syn.tableQuery("select * from %s where Chromosome='2'" % table.schema.id)
df = results.asDataFrame()
````

### Changing Data

Once the schema is settled, changes come in two flavors: appending new rows and updating existing ones.

**Appending** new rows is fairly straightforward. To continue the previous example, we might add some new genes from another file:

````
table = syn.store(Table(table.schema.id, "/path/to/more_genes.csv"))
````

To quickly add a few rows, use a list of row data:

````
new_rows = [["Qux1", "4", 201001, 202001, "+", False],
            ["Qux2", "4", 203001, 204001, "+", False]]
table = syn.store(Table(schema, new_rows))
````

**Updating** rows requires an etag, which identifies the most recent 
change set plus row IDs and version numbers for each row to be modified. We get 
those by querying before updating. Minimizing changesets to contain only 
rows that actually change will make processing faster.

For example, let’s update the names of some of our favorite genes:

````
results = syn.tableQuery("select * from %s where Chromosome='1'" %table.schema.id)
df = results.asDataFrame()
df['Name'] = ['rzing', 'zing1', 'zing2', 'zing3']
````

Note that we’re propagating the etag from the query results. Without it, we’d get 
an error saying something about an “Invalid etag”:

````
table = syn.store(Table(schema, df, etag=results.etag))
````

The etag is used by the server to prevent concurrent users from making conflicting 
changes, a technique called optimistic concurrency. In case of a conflict, your update may 
be rejected. You then have to do another query an try your update again.

### Changing Table Structure

Adding columns can be done using the methods [Schema.addColumn()](#schema) or ```addColumns()``` on the [Schema](#schema) object:

````
schema = syn.get("syn000000")
bday_column = syn.store(Column(name='birthday', columnType='DATE'))
schema.addColumn(bday_column)
schema = syn.store(schema)
````

Renaming or otherwise modifying a column involves removing the column and adding a new column:

````
cols = syn.getTableColumns(schema)
for col in cols:
    if col.name == "birthday":
        schema.removeColumn(col)
bday_column2 = syn.store(Column(name='birthday2', columnType='DATE'))
schema.addColumn(bday_column2)
schema = syn.store(schema)
````

### Table attached files

Synapse tables support a special column type called ‘File’ which contain a file handle, 
an identifier of a file stored in Synapse. Here’s an example of how to upload files into Synapse, 
associate them with a table and read them back later:

````
## your synapse project
project = syn.get(...)

covers_dir = '/path/to/album/covers/'

## store the table's schema
cols = [
    Column(name='artist', columnType='STRING', maximumSize=50),
    Column(name='album', columnType='STRING', maximumSize=50),
    Column(name='year', columnType='INTEGER'),
    Column(name='catalog', columnType='STRING', maximumSize=50),
    Column(name='cover', columnType='FILEHANDLEID')]
schema = syn.store(Schema(name='Jazz Albums', columns=cols, parent=project))

## the actual data
data = [["John Coltrane",  "Blue Train",   1957, "BLP 1577", "coltraneBlueTrain.jpg"],
        ["Sonny Rollins",  "Vol. 2",       1957, "BLP 1558", "rollinsBN1558.jpg"],
        ["Sonny Rollins",  "Newk's Time",  1958, "BLP 4001", "rollinsBN4001.jpg"],
        ["Kenny Burrel",   "Kenny Burrel", 1956, "BLP 1543", "burrellWarholBN1543.jpg"]]

## upload album covers
for row in data:
    file_handle = syn._uploadToFileHandleService(os.path.join(covers_dir, row[4]))
    row[4] = file_handle['id']

## store the table data
row_reference_set = syn.store(RowSet(columns=cols, schema=schema, rows=[Row(r) for r in data]))

## Later, we'll want to query the table and download our album covers
results = syn.tableQuery("select artist, album, year, catalog, cover from %s where artist = 'Sonny Rollins'" % schema.id, resultsAs="rowset")
for row in results:
    file_info = syn.downloadTableFile(results, rowId=row.rowId, versionNumber=row.versionNumber, column='cover')
    print("%s_%s" % (row.rowId, row.versionNumber), ", ".join(str(a) for a in row.values), file_info['path'])
````

### Deleting rows

Query for the rows you want to delete and call ```syn.delete``` on the results:

````
results = syn.tableQuery("select * from %s where Chromosome='2'" %table.schema.id)
a = syn.delete(results.asRowSet())
````

### Deleting the whole table

Deleting the schema deletes the whole table and all rows:

````
syn.delete(schema)
````

### Queries

The query language is quite similar to SQL select statements, except that joins are not supported. 
The documentation for the Synapse API has lots of [query examples](http://docs.synapse.org/rest/).

### Schema

*class* ```synapseclient.table.```**Schema**(*name=None, columns=None, parent=None, properties=None, annotations=None, local_state=None, **kwargs*)
A Schema is a ```synapse.entity.Entity``` that defines a set of columns in a table.

**Parameters:**	

- name – give the Table Schema object a name
- description –
- columns – a list of [Column](#column) objects or their IDs
- parent – the project (file a bug if you’d like folders supported) in Synapse to which this table belongs

````
cols = [Column(name='Isotope', columnType='STRING'),
        Column(name='Atomic Mass', columnType='INTEGER'),
        Column(name='Halflife', columnType='DOUBLE'),
        Column(name='Discovered', columnType='DATE')]

schema = syn.store(Schema(name='MyTable', columns=cols, parent=project))
````

<!--**addColumn**(*column*)-->

<!--&nbsp;&nbsp;&nbsp;**Parameters:	column** – a column object or its ID-->

<!--**addColumns**(*columns*)-->

<!--&nbsp;&nbsp;&nbsp;**Parameters:	columns** – a list of column objects or their ID-->

<!--**has_columns()**-->

<!--&nbsp;&nbsp;&nbsp;Does this schema have columns specified?-->

<!--**removeColumn**(*column*)-->

<!--&nbsp;&nbsp;&nbsp; **Parameters:	column** – a column object or its ID-->


<!--### Column-->
<!--*class* ```synapseclient.table.``` **Column** *(**kwargs)*-->

<!--Defines a column to be used in a table [synapseclient.table.Schema](#schema).-->

<!--**Variables:**	-->
<!--**id** – An immutable ID issued by the platform-->

<!--**Parameters:**	-->

<!--- **columnType** (*string*) – Can be any of: “STRING”, “DOUBLE”, “INTEGER”, “BOOLEAN”, “DATE”, “FILEHANDLEID”, “ENTITYID”-->
<!--- **maximumSize** (*integer*) – A parameter for columnTypes with a maximum size. For example, ColumnType.STRINGs have a default maximum size of 50 characters, but can be set to a maximumSize of 1 to 1000 characters.-->
<!--- **name** (*string*) – The display name of the column-->
<!--- **enumValues** (*array of strings*) – Columns type of STRING can be constrained to an enumeration values set on this list.-->
<!--- **defaultValue** (*string*) – The default value for this column. Columns of type FILEHANDLEID and ENTITYID are not allowed to have default values.-->


<!--### Row-->

<!--*class* ```synapseclient.table.``` **Row**(*values, rowId=None, versionNumber=None*)-->
<!--A [row](http://rest.synapse.org/org/sagebionetworks/repo/model/table/Row.html){:target="_blank"} in a Table.-->

<!--**Parameters:**	-->

<!--- **values** – A list of values-->
<!--- **rowId** – The immutable ID issued to a new row-->
<!--- **versionNumber** – The version number of this row. Each row version is immutable, so when a row is updated a new version is created.-->


<!--### Table-->

<!--*class* ```synapseclient.table.``` **TableAbstractBaseClass**(*schema, headers=None, etag=None*)-->
<!--Abstract base class for Tables based on different data containers.-->

<!--*class* ```synapseclient.table.``` **RowSetTable**(*schema, rowset*)-->
<!--A Table object that wraps a RowSet.-->

<!--*class* ```synapseclient.table.``` **TableQueryResult**(*synapse, query, limit=None, offset=None, isConsistent=True*)-->
<!--An object to wrap rows returned as a result of a table query.-->

<!--The TableQueryResult object can be used to iterate over results of a query:-->

<!--````-->
<!--results = syn.tableQuery(“select * from syn1234”) for row in results:-->
<!--print(row)-->
<!--````-->

<!--{:.markdown-table}-->
<!--| Function |  |-->
<!--| -- | -- |-->
<!--| **asDataFrame()** | Convert query result to a Pandas DataFrame. |-->
<!--| ----------------- | --- |-->
<!--| **next()**        | Python 2 iterator |-->

<!--<br>-->
<!--<br>-->

<!--*class* ```synapseclient.table.``` **CsvFileTable**(*schema, filepath, etag=None, quoteCharacter='"', escapeCharacter='\\', lineEnd='n', separator=', ', header=True, linesToSkip=0, includeRowIdAndRowVersion=None, headers=None*)-->

<!--&nbsp;&nbsp;&nbsp; An object to wrap a CSV file that may be stored into a Synapse table or returned as a result of a table query.-->

<!--&nbsp;&nbsp;&nbsp; ```classmethod``` **from_table_query**(*synapse, query, quoteCharacter='"', escapeCharacter='\\\\', lineEnd='\n', separator=', ', header=True, includeRowIdAndRowVersion=True*)-->

<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Create a Table object wrapping a CSV file resulting from querying a Synapse table. Mostly for internal use.-->

<!--&nbsp;&nbsp;&nbsp; **setColumnHeaders**(*headers*)-->

<!--&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set the list of ```synapseclient.table.SelectColumn``` objects that will be used to convert fields to the appropriate data types.-->

<!--Column headers are automatically set when querying.-->


## **Synapse REST API**

For an in-depth look with examples at querying using the Synapse REST API, please refer to the 
[REST API Docs](http://docs.synapse.com/rest).

### Basics Table Query

Select all columns from the table identified by 'syn123'.

````
select * from syn123
````


### Aggregation Functions

Count the number of rows in table 'syn123'.

````
select count(*) from syn123
````

### Set Selection

The DISTINCT keyword can be used to select all distinct value (the value set) from a column.

````
select distinct foo from syn123
````

### Filtering

Select all rows where column foo has a value equal to one.

````
select * from syn123 where foo =1
````

### Grouping

Select all rows grouping first by foo, then by bar.

````
select * from syn123 group by foo, bar
````


### Sorting

Select all columns from the table with the returned row order sorted by the values of the foo column in ascending order.

````
select * from syn123 order by foo asc
````

