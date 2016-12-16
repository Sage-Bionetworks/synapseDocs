---
title: "Wikis"
layout: article
 excerpt: Create wikis to provide narrative content for your research. 
category: howto
---

<style>
#image {
    width: 35%;
}
#tableImage {
    width: 65%;
}
#tableImage:hover {
    transform: scale(3.0);
    outline: 1px solid #1e7098;
}
#image:hover {
    transform: scale(3.0);
    outline: 1px solid #1e7098;
}
</style>

## Overview

`Wikis` are available in Synapse both on the `Project` level and on `Files/Folders` to provide a space to build narrative content to describe the research. 
Every project has a Wiki tab where you can build pages and a hierarchy of subpages as you would with any website. These pages can be reordered through the Edit Order button below the Wiki pages. `Wikis` can also be added to `Folders` and `Files` allowing additional content documentation. `Wikis`, whether they are under the Wiki tab or on a folder, are built in the same way and enables incorporation of highly customized content including, but not limited to: images, tables, code blocks, LaTeX formatted equations, and scholarly references. In addition, Synapse-specific widgets lets you embed dynamic content based on other resources stored in Synapse. 

## Starting, editing and deleting a Wiki


### Using the Synapse web portal
After creating a new project select the Wiki tab. Start a `Wiki` through the Tools menu by selecting the 'Edit Project Wiki' function. Content in this first `Wiki` becomes your `Project`'s home page. Go to the Tools menu to add subpages to your `Wiki`. These will appear as links on the left side of your home page. Adding a `Wiki` to a `Folder` or `File` is done in a similar manner by selecting 'Edit Folder/File Wiki'. Content added to a `Wiki` can be Previewed before Saving. Each version of a saved `Wiki` is visible under Wiki History where older versions can be restored. To delete a `Wiki` select 'Delete Wiki Page' under Tools.  

### Using R/Python
{% tabs %} 
{% tab Command %}
{% highlight bash %} 
The command line client does not support the creation of Wiki content. We suggest using (to get to the webpage of the project) `synapse onweb syn###` where `syn###` is the Synapse Id of your created project. Then editing the Wiki using the web client. 
{% endhighlight %} 
{% endtab %}

{% tab Python %} 
{% highlight python %}
projWiki = Wiki(title='Data Summary', owner = myProj) 
markdown = '''* Cell growth look normally distributed. There is evidence of inverse growth between these two cell lines ''' 
projWiki['markdown'] = markdown 
projWiki = syn.store(projWiki) 
{% endhighlight %} 
{% endtab %}

{% tab R %} 
{% highlight r %} 
library(synapseClient); 
placeholderText <- "* Cell growth look normally distributed\n* There is evidence of inverse growth between these two cell lines." 
wiki <- WikiPage(owner=myProject, title="Analysis summary", markdown=placeholderText) 
wiki <- synStore(wiki) 
{%endhighlight %} 
{% endtab %}

{% tab Web %} 
Select **Tools** then select **Edit Project/Folder/File wiki** 

<img src="/assets/images/wiki_editprojectwiki.png">
{% endtab %}

{% endtabs %}

## Governance
`Wiki` pages do not have `Conditions for Use` as a feature. Therefore, **do not** put any protected human data (`Controlled Data`) in Synapse `Wikis`. See the Synapse Data Use Procedure document for [details](https://s3.amazonaws.com/static.synapse.org/governance/SageBionetworksSynapseTermsandConditionsofUse.pdf?v=4){:target="_blank"}.

## Wiki Features

### Markdown language
The layout and text of a `Wiki` can be customized using Wiki markdown language. A Formatting Guide is available within the Wiki editing window. For additional markdown functions see [Markdown in Synapse](https://www.synapse.org/#!Wiki:syn2467792/ENTITY/64247){:target="_blank"}. Useful markdown shortcuts are available as separate tools, including: heading, bold, italic, strike-through, code block, sub and superscript. 

### Tables in Markdown

{% include tip.html content="Add this Markdown below the header to enable sort on the header columns." %}

    ````
     Header 1 | Header 2 | Header 3
    --- | --- | ---
    ````



### Attachments, links and tagging
Files, images and videos can be attached to a `Wiki`. This may be content on from the web, your desktop, or `Files` already uploaded to Synapse. Links can be added to content available from any source with a url or to a Synapse users profile through the Tag someone widget, or by typing @ - just enter the Synapse username in the dialog that appears.

### Additional Widgets

On the project Wiki page, go to 'Tools' and click on 'Edit Project Wiki'

See the 'Insert' list for the following widgets to customize your Wiki design. 
<img src="/assets/images/wiki_insertwidget.png">

{% include tip.html content="To edit widgets after they have been added to the wiki, see the widget edit button in the upper left hand corner of the Wiki editing window." %}

{:.markdown-table}
| Widget | Hover over the image to see what the widget will look like when embedded in your project |
| -- | :--: | 
| **References** <br/> Create a reference list by linking to papers using the References widget | <img id="image" src="/assets/images/wiki_reference.png"> |
| **File Preview** <br/> Embeds a preview window for csv, txt and image files||
| **Provenance** <br/> Embeds the provenance graph created for a file |  <img id="image" src="/assets/images/wiki_provenance.png"> |
| **Table of Contents** <br/> Creates a content list that links to sections of the wiki based on headers and subheaders |  <img id="image" src="/assets/images/wiki_tableofcontents.png"> |
| **Entity List** <br/> A list of Synapse `Folders`, `Files` or `Tables` can be easily created by browsing to the Synapse location or searching by entity name or Synapse ID. The table lists entity name, date entity was created, who created it, and for `Files` and `Tables` - version and version notes|  <img id="tableImage" src="/assets/images/wiki_entitylist.png"> |
| **Table: Paste tabular data** <br/> A table can be created of any data by pasting tab delimited content into this widget window.  |  <img id="image" src="/assets/images/wiki_tablepastetabular.png"> |
| **Table: Query on a Synapse `Table`** <br/> Provides a Query for any Synapse `Table` and displays the information in the`Wiki`. |  <img id="tableImage" src="/assets/images/wiki_queryonsyntable.png"> |
| **Query on `Files`/`Folders`** <br/> Provides a Query based an annotations (need link) added to `Files` and `Folders`. Columns in the Query table can be renamed and ordered through the 'Add Column Renderer' | <img id="tableImage" src="/assets/images/wiki_tablequeryonfiles.png"> |
| **Button Link** <br/> Insert a button that links to content within Synapse or elsewhere. **Tip:** buttons can be colored purple by adding `'&highlight=true'` to the end of the widget markdown |<img id="image" src="/assets/images/wiki_insertbutton.png">|
| **Join Team Button** <br/> Provide a button for people to join Synapse [Teams](/articles/teams.html) | <img id="image" src="/assets/images/wiki_jointeambutton.png"> |
| **Team Badge** <br/> Creates a link to the `Team` profile | <img id="image" src="/assets/images/wiki_teambadge.png"> |
| **Genome Browser** <br/> You can add a [Biodalliance genome browser](http://www.biodalliance.org) using tracks from files uploaded to Synapse or from external sources. Choose between Human or Mouse and adjust your tracks for height and color. See the Biodalliance Setup page for [more information](https://www.synapse.org/#!StandaloneWiki:GenomeBrowser) | <img id="image" src="/assets/images/wiki_genomebrowser.png"> |
| **Video** <br/> Video, Vimeo Video, and YouTube Video insert a video from various sources. | <img id="image" src="/assets/images/wiki_video.png"> | 

<br> 

