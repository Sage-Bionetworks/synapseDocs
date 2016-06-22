---
title: "Access and Content Restrictions"
layout: article
excerpt: Learn how to share and restrict content on Synapse using the sharing settings and conditions for use. 
---

## Access and Content Restrictions
Synapse content is subject to two control settings: the `Sharing setting` and `Conditions for Use.` The `Sharing setting` determines _with whom_ content is shared. `Conditions for Use` govern _how_ content can be used. 

## Sharing setting
`Sharing setting` determines with whom content (projects, wikis, folders, files, and tables) is shared. Content can be shared (1) **broadly**, with all registered Synapse users, (2) **sparsely,** with a limited set of users (e.g., a team) or (3) can be **private** (i.e., only the creator has access). 

**Users are responsible for determining the appropriate `Sharing setting` for any content they upload into Synapse. **

### How to share a project
The `Sharing setting` enables you to invite others to view/collaborate on a project you have created. **By default, your newly created project is private**; you are the only person that can assess it or any content included in it. To give others access to your project, click on the Share icon in the upper right hand corner of the screen. You can share your project broadly, opening it to the public or you may share your project sparsely, with a limited set of Synapse users, like a team. 

The `Sharing setting` is shown on the upper right hand side of the project’s header, visible from the `Wiki, Files`, and `Tables` tabs. One of two icons will be displayed: either a globe, meaning the project is shared broadly (public), or a lock, meaning that the project is either shared sparsely or is private. Clicking on the lock will open a window listing the users who have access to the restricted project and their roles/privileges.

![sharing button examples]({{site.url}}/assets/images/sharing_buttons_examples.png)

#### Creating a team
If you want to share a project with a specific group of people, you can create a team. Any Synapse user can create a team and invite other Synapse users to join their team. Only after the invited user accepts this invitation is he/she added to the team. Similarly, any Synapse user can request to be added to a team.

### Sharing content within a project 
By default, all content residing within a project **inherits** the project `Sharing settings` that you specify for the project. You may change this by creating a local `Sharing setting` on any `folder, file` or `table.` If you change the `Sharing setting` on a folder all content within that folder will inherit that change. Just as your are able to control who can access your project, you can also restrict or open portions of your project using the `Sharing setting` for a folder or subfolder.

Inheritance is illustrated in the example below. In the diagram, the project carries the “share broadly” (public) `Sharing setting` designated by the globe icon. Folder A does not have a `Sharing setting` specified, so it inherits the `sharing setting` of the project: “share broadly.” Files 1, 2, and 3 also share this setting. By contrast, Folder B has a restricted `Sharing setting,` designated with the lock icon. Files 4, 5, and 6 are also restricted as a result of their location within Folder B. It is important to note that if you were to move `File 4 `out of the restricted Folder B and place it in Folder A, File 4’s `Sharing setting` will be reset to the `Sharing setting`of Folder A: “share broadly” unless you apply a restricted `Sharing setting` specifically to that file.


## Conditions for Use
`Conditions for Use` determine how data can be used. `Conditions for Use` are determined based on nature of the data within a particular `file` or `table`. For example, a `file` or `table` may have `Conditions for Use` due to informed consent requirements, legal contracts, or other privacy requirements based on the source, collection method, and/or type of data in the file or table. It is important to note that `Conditions for Use` cannot be set for Synapse wiki; wiki are not designed to house data and therefore do not have `Conditions for Use` as a feature.

**Users are responsible for determining the appropriate `Conditions for Use` for any data they upload into Synapse. **

### Data that does not require Conditions for Use

Open Data in Synapse are data without `Conditions for Use.` They can be used by any registered Synapse users authorized to view the project/folder/file/table (based on sharing setting) for research purpose. Typically Open Data are:
* Data from model organism, species or strain
* Non-biological data such as presentations, results or images

### Data that does require Conditions for Use (“Controlled Use” data)
`Conditions for Use` are typically applied in order to comply with the terms under which the data in the `files/tables` were collected or with other human subjects regulations. In Synapse, data that carries `Conditions for Use` is labeled as **Controlled Use**. Examples of Controlled Use data include:
* Data whose nature confers more than minimal risks of re-identification to the research participant. 
* Genetic sequence or genotype data from living individuals
* Data from “vulnerable” populations as defined using [OHRP guidelines](http://www.hhs.gov/ohrp/policy/populations/index.html)
* Bridge data (generated from ResearchKit apps)
* Data generated with `Conditions for Use` as outlined in informed consents or legal agreements

### Examples of Conditions for Use
`Conditions for Use` vary broadly. Some examples include: 
* Specification of what type of research or analysis can be conducted on the data, for example, a data set may only be able to be used for breast cancer research
* Specification of who can conduct research with the data set, for example, only researchers at non-profit institutions can use the data for research
* Specification that results be shared with the originating researcher/entity
* Requirement that the researcher submit an Intended Use statement prior to accessing the data
* Specification of attribution or publication requirements (e.g., only as open access articles)

Additionally, use of certain data may require independent review and monitoring of research by an IRB/Ethics committee. This ensures that use of data meets all applicable human subjects research regulations. 
 
