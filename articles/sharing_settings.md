---
title: "Sharing Settings"
layout: article
excerpt: Sharing settings determine who can access content in Synapse.
category: governance
order: 2
---

## Access Control

Synapse has two ways to control who can access your content. `Sharing Settings`, or permissions, determine _who_ can access content and at what level. `Conditions for Use` define _how_ users with access may use the data. All content in Synapse has `Sharing Settings` but not all content has `Conditions for Use`. See the [Conditions for Use](/articles/access_control.html) article for information about those settings. This article covers sharing settings only.

<a name="sharing-setting"></a>

## Sharing Settings

You can use the `Sharing Settings` to grant different levels of access to individuals or `Teams`. Often, users leverage these features to invite people to view or collaborate on a Synapse `Project`. Here are the kinds of access currently supported:

* Can view
* Can download
* Can edit
* Can edit & delete
* Administrator

`Sharing Settings` can apply to an entire project or for individual files or folders within a project.

`Sharing Settings` have two primary groups: **Public** and **Private**. The `Private` sharing setting limits access to only specified users and  teams. By default, new projects are `Private`. The `Public` sharing setting applies to users on the web and any registered, logged-in Synapse user.

{% include important.html content="Synapse users are responsible for determining the appropriate Sharing Setting for any content they upload into Synapse." %}

<a name="how-to-share-content"></a>

## How to Share Projects

To adjust the sharing settings on a project, click the `Project Settings` button. This will open a window listing the Synapse users who have access to the `Project` and their roles. When you create a new `Project` you are the only Synapse user listed in this window, because projects are private by default, and your access level will be `Administrator`.

Use the `Add People` feature to add collaborators individually or to add a [team of collaborators](teams.md).

<a name="share-files-folders-and-tables"></a>

## Sharing Files, Folders, and Tables

You can adjust the sharing settings for `Folders`, `Files`, and `Tables` separately from their parent project. For example, you may wish to keep a particular folder private while you make the project public. Or you may want to share drafts of individual files to collaborators first prior to sharing them publicly.

By default, all of the content residing within a project inherits the project sharing settings. You can override this inheritance by defining a `Local Sharing Setting` for that specific content. To do so, visit the content in question (Folder, File, or Table). Click on the `Tools` menu, and then click on the `Sharing Setting` option for that content. The menu option will show the type of content, e.g. `Folder Sharing Settings` or `File Sharing Settings`, etc.).

When you click on the sharing settings for that content, you'll see the current (inherited) sharing settings. You will also see the option to `Create Local Sharing Settings`. Once you create the local sharing settings, you'll be able to change them to be different than the parent project.

## Sharing Wikis and Discussion Forums

Note you **cannot** set local sharing settings for `Wikis` and `Discussion Forums`. These areas can only inherit the sharing settings from their parent project.
