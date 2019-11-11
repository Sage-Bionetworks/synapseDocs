---
title: "Getting Started with Synapse"
layout: article
excerpt: A getting started guide for new users who are interested in learning about Synapse.
category: intro
order: 1
---

This guide is for new users who are interested in learning about Synapse. You will learn fundamental Synapse features by performing some common tasks:

* Create your own `Project` and add content to Synapse
* Provide a Project description alongside your materials via the Synapse `Wiki` tools
* Share your work with other Synapse users, `Teams` of users, or the public

## What is Synapse?


Synapse is a collaborative research platform that allows individuals and teams to share, track, and discuss their data and analysis in projects. Synapse is built to work on the web. We provide access to Synapse features and services for programmers through a REST API, [Python client](https://python-docs.synapse.org/build/html/index.html), [command line client](https://python-docs.synapse.org/build/html/CommandLineClient.html), and [R client](https://r-docs.synapse.org/). 

Synapse hosts many [research projects](https://www.synapse.org/#!StandaloneWiki:ResearchCommunities) and [resources](https://www.synapse.org/#!StandaloneWiki:OpenResearchProjects). It also hosts crowdsourced competitions, including [DREAM Challenges](http://dreamchallenges.org/). [Sage Bionetworks](http://www.sagebionetworks.org) provides Synapse services free of charge to the scientific community through generous support from various [funding sources](/articles/faq.html#how-is-synapse-funded).

## Create Your Account

Anyone can browse public content on the Synapse web site. To download and create content, you will need to [register for an account](https://www.synapse.org/register) using an email address. You will receive an email message for verification to complete the registration process.

## Getting Certified

Synapse is a data sharing platform approved for storing data from human subjects research. This requires special care and thought. To upload files, Sage Bionetworks requires you demonstrate awareness of privacy and security issues. 

You can complete this by taking a [Certification Quiz](https://www.synapse.org/#!Quiz:Certification).

## Making and Managing Projects in Synapse

Synapse Projects are online workspaces where researchers can collaborate and organize their work. Synapse supports all kinds of working groups: individuals, small teams, and large consortia.

To create a new Project:

1. Navigate to the User Menu and click on [**Projects**](https://www.synapse.org/#!Profile:v/projects).
2. Click the **Create a New Project** button.
3. Decide on a unique name for your Project and click **Save**.

Your Projects [dashboard](https://www.synapse.org/#!Profile:v/projects) stores your collection of Projects.

Read about [Projects](making_a_project.md) in the User Guide.

## Synapse IDs

Synapse Projects are assigned a Synapse ID, a globally unique identifier used for reference with the format `syn12345678`. Often abbreviated to "synID", the ID of an object never changes, even if the name does. The Synapse ID is always accessible in the URL and visible on the webpage. 

## Organizing Content in `Files` and `Folders`

Projects contain Files, which can be organized into Folders. Folders and Files also have their own unique Synapse IDs and can be moved within or between Projects. Uploaded files are stored within Synapse storage.

Use the **Tools Menu** to upload a file: 

1. Navigate to the Files tab.
2. Use the **Files Tools** menu to select **Add New Folder**.
3. Decide on a Folder name and click **Save**.
4. Navigate into your new Folder and use the **Folder Tools** menu to select **Upload or Link to a File**.
5. Use the **Browse** button to select the file, or drag and drop it to upload, and click **Save**.

To explore other features available for Files and Folders, read about [annotating Files](/articles/annotation_and_query.html), [assigning DOIs](/articles/doi.html), [versioning](/articles/files_and_versioning.html), [`Provenance`](/articles/provenance.html), and [sharing settings](/articles/access_controls.html).

## Adding a Wiki to your Project

A Wiki is a document that can be edited by multiple people on the web. Synapse uses Wikis to provide descriptions of your Project and data.

Wiki pages can be written using text, [Markdown](https://www.markdownguide.org/), or basic HTML. Content can include images, tables, code blocks, LaTeX formatted equations, scholarly references, and references to other things in Synapse.

Use the **Tools** menu to see available Wiki options on Projects, Folders and Files: 

1. Click the **Tools** button and choose **Edit Wiki**.
	- During editing, you have the option to "Preview" your edits.
2. Add relevant text, and click **Save**.

See the [Wiki](/articles/wikis.html) User Guide for more information and examples.

## Sharing and Teams

The default setting for new Projects in Synapse is **private**. As a project owner, you choose who to share with, and how. You can find Project sharing settings under the **Project Settings** menu. Permissions or sharing settings at the Project level are automatically inherited by all Files and Folders within the Project. If needed, you can **Create Local Sharing Settings** to make certain Files or Folders have permissions that differ from the parent Project.

Groups of users can form Teams for collaboration. Teams can be used for permissions and for communication. Sharing things with teams instead of individual users can provide simiplicity for administrators.


For more details, visit the [Sharing Settings](/articles/access_controls.html) and [Teams](/articles/teams.html) User Guide.

## More Guides

Find additional information in our [User Guide](/articles).

Read about Synapse [governance](/articles/governance.html) and [Terms and Conditions of Use](https://s3.amazonaws.com/static.synapse.org/governance/SageBionetworksSynapseTermsandConditionsofUse.pdf?v=4).

For information on using Synapse programmatically, see the documentation for the [Python client](https://python-docs.synapse.org/build/html/index.html), [command line client](https://python-docs.synapse.org/build/html/CommandLineClient.html), and [R client](https://r-docs.synapse.org/)
