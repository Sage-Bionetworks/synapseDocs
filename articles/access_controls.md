---
title: "Sharing Settings and Conditions for Use"
layout: article
excerpt: Synapse has two content controls -- the Sharing setting and Conditions for Use. Learn how to set Sharing settings and Conditions for Use.
category: governance
order: 2
---

<style>
#image {
    width: 100%;
    }
</style>

# Sharing Settings and Conditions for Use
Synapse has two ways to control who can access your content. `Sharing Settings` determine _who_ can access content, and is akin to individual or group (team) permissions. `Conditions for Use` determine _how_ data can be used by those users who have been granted access. All content in Synapse has `Sharing Settings` but not all content has `Conditions for Use`. 

<a name="sharing-setting"></a>

# Sharing Settings
You can use the `Sharing Settings` to grant different levels of access to individuals or `Teams`. Often, users leverage these features to invite people to view or collaborate on a Synapse `Project`. Here are the kinds of access currently supported: 

* Can view
* Can download
* Can edit
* Can edit & delete
* Administrator

`Sharing Settings` can be set for an entire project or for individual files or folders within a project. 

There are two primary `Sharing settings`: **Public** and **Private**. The `Public` sharing setting means that any user on the web can view the content and any registered, logged-in Synapse user can view and download the content. The `Private` sharing setting limits access and means that only the named users or teams in the sharing setting window can access the content with the access level granted to them. By default, new projects are `Private`. 
 
{% include important.html content="Synapse users are responsible for determining the appropriate Sharing Setting for any content they upload into Synapse." %}

<a name="how-to-share-content"></a>
## How to Share Projects
To adjust the sharing settings on a project, click the `Project Settings` button. This will open a window listing the Synapse users who have access to the `Project` and their roles. When you create a new `Project` you are the only Synapse user listed in this window, because projects are private by default, and your access level will be `Administrator`. 

Use the `Add People` feature to add collaborators individually or to add a [team of collaborators](/articles/teams.html).

<a name="share-files-folders-and-tables"></a>
## Sharing Files, Folders, and Tables

You can also adjust the sharing settings for `Folders`, `Files`, and `Tables` separately from their parent project. For example, you may wish to keep a particular folder private while you make the project more broadly available, or share drafts of individual files to collaborators privately prior to releasing publicly. 

By default, all of the content residing within a project inherits the project sharing settings. However, you can override this inheritance by defining a `Local Sharing Setting` for that specific content. To do so, visit the content in question (Folder, File, or Table) and click on the `Tools` menu and then click on the `Sharing Setting` option for that content (the menu option will be labeled with the type of content, e.g. `Folder Sharing Settings` or `File Sharing Settings`, etc.). 

When you click on the sharing settings for that content, you'll see the current (inherited) sharing settings, as well as the option to `Create Local Sharing Settings`. Once you create the local sharing settings, you'll be able to change them to be different than the parent project. 

## Sharing Wikis and Discussion Forums

It is important to note that you **cannot** set local sharing settings for `Wikis` and `Discussion Forums` as these can only inherit the sharing settings from their parent project.

<a name="conditions-for-use"></a>
# Conditions for Use
Some data requires data governance to appropriately manage its use. In Synapse this data is called `Controlled Data` and it is protected by `Conditions for Use`, typically applied in order to comply with the terms under which the data were collected or with other human subjects regulations. For example, human 'omic' data may have `Conditions for Use` imposed by informed consent requirements, legal contracts, or other privacy requirements. It is also appropriate to add `Condition for Use` to data collected from "vulnerable" populations and to content that could potentially harm individuals or groups if misused. If you have any questions about whether conditions for use should be applied to your data, please contact our <a href="mailto:act@sagebase.org">Access and Compliance Team (ACT)</a>.

<a name="require-conditions-for-use"></a>
## Examples of Conditions for Use
`Conditions for Use` vary broadly. Some examples include:

* Specification of what type of research or analysis can be conducted on the data, for example, a data set may only be able to be used for breast cancer research
* Specification of who can conduct research with the data set, for example, only researchers at non-profit institutions can use the data for research
* Specification that results be shared with the originating researcher/entity
* Requirement that the researcher submit an Intended Data Use statement prior to accessing the data. Note that Intended Data Use statements must be updated anytime the research plan changes.

{% include important.html content="Synapse users are responsible for determining the appropriate Conditions for Use for any data they upload into Synapse." %}

Additionally, use of certain data may require independent review and monitoring of research by an ethics committee (for example, an IRB). This ensures that use of the data meets all applicable human subjects research regulations. 

<a name="controlled-data"></a>
## Controlled Data
`Controlled Data` requires appropriate `Conditions for Use`, can only be downloaded and used by authorized Synapse users, and is not transferable unless explicitly specified otherwise. In other words, you cannot share `Controlled Data` with collaborators; aach Synapse user wishing to access controlled data must individually agree to the conditions for use to access that data.

{% include important.html content="Controlled Data may not be redistributed." %}

It is important to note that `Conditions for Use` cannot be set for Synapse `Wikis` or `Discussion Forums`: they are not designed to house data and therefore do not have conditions for use as a feature. 

Examples of `Controlled Data` include:

* Data whose nature confers more than minimal risks of re-identification to the research participant.
* Genetic sequence or genotype data from living individuals
* Data from “vulnerable” populations as defined using OHRP guidelines
* Data generated with restrictions or requirements for use as outlined in informed consents or legal agreements

<a name="open-data"></a>
## Open Data
Synapse `Open Data` is data that does not require `Conditions for Use`. Typically, open data is:

* Data from model organisms, species or strains
* Non-biological data, like that used for the calibration of instruments 
* Human data that are:
    * Publicly available elsewhere
    * Anonymous
    * De-identified and non-sensitive, with no known sharing or use restrictions
    * Self-contributed and unambiguously consented for open data sharing and use

<a name="how-to-set-conditions-for-use "></a>
## How to Set Conditions for Use?
If you would like to set `Conditions for Use` for an entire `Project`, please contact the Synapse <a href="mailto:act@sagebase.org">Access and Compliance Team (ACT)</a> directly for assistance. 

By default, content within a `Folder` or `Project` inherit the `Conditions for Use` of the parent `Folder` or `Project`. As with sharing settings, you can set local conditions for use for individual `Folders`, `Files` and `Tables` but only **in addition to** the existing parent `Project`/`Folder’s` conditions for use. In other words, all content within a Folder or Project has, at a minimum, the `Conditions for Use` of its parent Folder or Project, and may have **additional** local conditions for use as needed. You cannot create a Folder, File, or Table that has fewer conditions for use than its parent or that has conditions for use that conflict with the conditions for use of the parent.

To set `Conditions for Use` for Folders, Files, and Tables in Synapse, nagivate to the content in question and use the popup `Conditions for Use` dialogue box. If you select that you would like to set conditions for use for your content, you are asked if the `Folder`, `File` or `Table` contains, “sensitive human data that must be protected.” If you answer “yes,” the ACT will reach out to you to assist in setting the appropriate `Conditions for Use`. If you answer “no,” but still feel that your `Folder`, `File` or `Table` requires `Conditions for Use`, contact the ACT for further discussion (<mailto:act@synapse.org>).
