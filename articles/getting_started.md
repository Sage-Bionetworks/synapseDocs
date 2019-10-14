---
title: "Getting Started with Synapse"
layout: article
excerpt: A getting started guide for new users who are interested in learning about Synapse.
category: intro
order: 1
---

This guide is for new users who are interested in learning about Synapse. You will learn fundamental Synapse features by performing some common tasks:

* Create your own project and add content to Synapse
* Provide a project description alongside your materials via the Synapse `Wiki` tools
* Share your work with other Synapse users, teams of users, or the public

## What is Synapse?

Synapse is an open source collaborative platform. It can store data, code, results, and descriptions research work. Synapse hosts many [research projects](https://www.synapse.org/#!StandaloneWiki:ResearchCommunities) and [resources](https://www.synapse.org/#!StandaloneWiki:OpenResearchProjects). It also hosts crowdsourced competitions, including [DREAM Challenges](http://dreamchallenges.org/). [Sage Bionetworks](http://www.sagebionetworks.org) provides Synapse services free of charge to the scientific community through generous support from various [funding sources](faq.md#how-is-synapse-funded).

Synapse operates under a thorough [governance process](governance.md). This includes [Terms and Conditions of Use](https://s3.amazonaws.com/static.synapse.org/governance/SageBionetworksSynapseTermsandConditionsofUse.pdf?v=4), guidelines, and operating procedures.

## Register for a Synapse Account

Anyone can browse public content on the Synapse web site, but to download and create content you will need to register for an account using an email address. You will receive an email message for verification to complete the registration process.

<a href="https://www.synapse.org/register" class="btn btn-primary">Register</a>

Synapse can store human subject data with sharing and use restrictions. Before you can upload files, you must demonstrate you understand what you can share in Synape. To start this process:

<a href="https://www.synapse.org/#!Quiz:Certification" class="btn btn-primary">Become a Certified User</a>

Read the [accounts, certification, and profile validation](accounts_certified_users_and_profile_validation.md) page to learn more about the different levels of users.

## Project and Data Management on Synapse

Synapse content is organized in `Projects`. In a project you can upload files and write descriptions (Wikis). Each Project also contains a discussion forum.

To create a `Project`:

1. Go to your [projects list](https://www.synapse.org/#!Profile:v/projects) on your dashboard.
1. Click the **Create Project** button.
1. Decide on a unique name for your `Project` and click Save.

By default, your newly created `Project` is private. You are the only person who can access it, including any content in it. In another tutorial you will learn how to share your project with other users.

Synapse projects are assigned a Synapse ID, unique identifiers used for reference with the format `syn12345678`.

To find your project at any time, you can see your projects on your [dashboard](https://www.synapse.org/#!Profile:v/projects).

## Organizing Data: creating Files and Folders

You can use the `Files` tab to upload data, code, results, and other information to your project. Synapse Folders are used to organize content and can contain other Folders and Files. Synapse `Folders` and `Files` are also assigned a unique identifier (Synapse ID).

To add a `Folder`:

1. Click on the Files tab.
1. Use the Tools menu and select **Add New Folder**.
1. Decide on a Folder name and click 'Save'.

To upload a file into that folder:

1. Use the Tools menu and select **Upload or Link to File**.
1. Use the Browse button to select the file, or drag and drop it to upload and click Save.

To explore other features available for files and folders, read about [annotating files](annotation_and_query.md), [assigning DOIs](doi.md), [versioning](files_and_versioning.md), [provenance](provenance.md),and [sharing settings](access_controls.md).

## Adding a Wiki to your Project

A Wiki is a document that can be edited by multiple people on the web. The Wiki tab in a project provides a space to write a description. This Wiki can be organized with subpages and a table of contents. Folders and files in your project can also have a wiki. You can use the wiki to document the contents of the folder or file, similar to a README.

Wiki pages are written with [Markdown](https://www.markdownguide.org/), a lightweight syntax for styling text on the web. In addition to standard Markdown, `Wiki` pages can contain customized content, including images, tables, code blocks, LaTeX formatted equations, and scholarly references. Synapse Wiki widgets also allow you to embed content based on other resources stored in Synapse.

See the [Wiki](wikis.md) user guide for more information and examples.

Create a Project wiki:

1. From the project page, click the **Tools button** and choose **Edit Project Wiki**.
1. Add some text describing your project, and then click Save.

To add a wiki to a folder or file:

1. Click on the Files tab and navigate to the Folder or File.
1. Use the Tools menu and select **Edit Folder Wiki** or **Edit File Wiki**.
1. Add some text describing the folder or file, and then click Save.

## Local Folder and File Sharing Settings

By default, access to folders and files is controlled by the same **sharing settings** as the project. You may set different sharing settings for specific folders and files in a project.

You may share a `Project` with specific people or make it public.

1. Click on the **Project Settings** menu and select **Project Sharing Settings**.
1. Add individuals or teams with different permissions.

For more details, read the [How to Share Projects](access_controls.md#how-to-share-projects) section of the Sharing Settings and Conditions for Use instructions.

For instructions on changing sharing settings for `Folders` and `Files`, read the [Sharing Other Content](access_controls.md#sharing-other-content) section of the Sharing Settings and Conditions for Use instructions.

## More Guides

Find additional information in our [User Guide](./).

For information on using Synapse programmatically, see the documentation for the [Python client](https://python-docs.synapse.org/build/html/index.html), [command line client](https://python-docs.synapse.org/build/html/CommandLineClient.html), and [R client](https://r-docs.synapse.org/)
