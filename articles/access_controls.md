---
title: "Sharing Settings and Conditions for Use"
layout: article
excerpt: Synapse has two content controls -- the Sharing setting and Conditions for Use. Learn how to set Sharing settings and Conditions for Use.
---

## Overview
Synapse has two content controls: the `Sharing setting` and `Conditions for Use.` The `Sharing setting` is an access control. It determines _who_ has access to Synapse content. `Conditions for Use` are for data governance. They determine _how_ data can be used. 

<a name="sharing-setting"></a>

## Sharing setting
You can use the `Sharing setting` to invite people to view or collaborate on a Synapse `Project`. There are two `Sharing settings`: **Public** and **Private**. Synapse content with the **Public** `Sharing setting` is visible to all Synapse users. By contrast, the **Private** `Sharing setting` limits who can see content. **By default, new `Projects` are Private.** 
{% include important.html content="Synapse users are responsible for determining the appropriate `Sharing Setting` for any content they upload into Synapse." %}

<a name="how-to-share-content"></a>

### How to share content
To adjust the `Sharing setting`, click the `Share` button at the upper right hand side of the `Project's` header. This will open a window listing the Synapse users who have access to the `Project` and their roles. A globe icon means the `Project` is **Public**. A lock icon means the `Project` is **Private**. When you create a new `Project` you are the only Synapse user listed in this window. Use the `Add People` feature to add collaborators individually or to add a [team of collaborators](/articles/teams.html).


![sharing button examples]({{site.url}}/assets/images/sharing_buttons_examples.png)

<a name="share-content"></a>

### Sharing content within a Project 
You can also adjust the `Sharing setting` for `Folders`, `Files`, and `Tables`. By default, all of the content residing within a `Folder` or `Project` inherits the `Sharing setting` of its parent `Folder` or `Project`. To create a local `Sharing setting` specific only to a particular `Folder`, `File` or `Table`, open the `Folder`, `File` or `Table` and click on its `Share` button and adjust the `Sharing setting` just like you would for a `Project`. It is important to note that you **cannot** set local sharing settings for `Wikis` and `Discussion Forums`. `Wikis` and `Discussion Forums` inherit the `Sharing setting` of their parent `Project`.

Local `Sharing settings` are illustrated in the diagram below. `Projects` A and B have a **Public** `Sharing setting` (notice the globe icon on the `Share` button). `Folders` 1 and 2 and `Table` 3 in `Project` A _do not_ have a local `Sharing setting` specified. Because they do not have a local `Sharing setting` specified, they inherit the **Public** `Sharing setting` of `Project` A. By contrast, in `Project` B the `Folder` 4 and `Table` 6 _do_ have local `Sharing settings`. Unlike their parent `Project` B, `Folder` 4 and `Table` 6 have the **Private** `Sharing setting` (notice the lock icon on the `Share` buttons). However, `File` 5 has no local `Sharing setting`; it inherits the **Public** `Sharing setting` of `Project` B. But, if you move `File` 5 into `Folder` 4, then its **Public** `Sharing setting` will be reset to the `Sharing setting` of `Folder` 4: **Private**.

<img src= "/assets/images/synapse_sharingsetting.jpg">

<a name="conditions-for-use"></a>

## Conditions for Use
Some data requires data governance to appropriately manage its use. In Synapse this data is called `Controlled Data` and it is protected by `Conditions for Use`. `Conditions for Use` are typically applied in order to comply with the terms under which the data were collected or with other human subjects regulations. For example, human 'omic' data may have `Conditions for Use` imposed by informed consent requirements, legal contracts, or other privacy requirements. It is also appropriate to add `Condition for Use` to data collected from "vulnerable" populations and to content that could potentially harm individuals or groups if misused. 

{% include important.html content="Controlled Data may not be redistributed." %}
`Controlled Data` can only be downloaded and used by authorized Synapse users. `Controlled Data` is not transferable unless explicitly specified otherwise. In other words, you cannot share `Controlled Data` with collaborators. Each Synapse user wishing to access `Controlled Data` must individually agree to the `Conditions for Use` to access that data.

{% include important.html content="Synapse users are responsible for determining the appropriate Conditions for Use for any data they upload into Synapse." %}

It is important to note that `Conditions for Use` cannot be set for Synapse `Wikis` or `Discussion Forums`: they are not designed to house data and therefore do not have local `Conditions for Use` as a feature. 

<a name="open-data"></a>

### Data that does not require Conditions for Use
Synapse `Open Data` is data that does not require `Conditions for Use`. Any registered Synapse user included in the `Project`, `Folder`, `File` or `Table` (based on the `Sharing setting`) can immediately access `Open Data`. Typically, `Open Data` is:

* Data from model organisms, species or strains
* Non-biological data, like that used for the calibration of instruments 

<br>
Human data that are:

* Publicly available elsewhere
* Anonymous
* De-identified and non-sensitive, with no known sharing or use restrictions
* Self-contributed and unambiguously consented for open data sharing and use

<a name="require-conditions-for-use"></a>

### Data that does require Conditions for Use
`Conditions for Use` regulate who can access `Controlled Data` and how it can be used. This means that any Synapse user included in a `Project`, `Folder`, `File` or `Table` (based on the `Sharing setting`) must fulfill the `Conditions for Use` **before** he/she can access that `Controlled Use` data. Examples of `Controlled Data` include:

* Data whose nature confers more than minimal risks of re-identification to the research participant.
* Genetic sequence or genotype data from living individuals
* Data from “vulnerable” populations as defined using OHRP guidelines
* Data generated with restrictions or requirements for use as outlined in informed consents or legal agreements

<a name="controlled-data"></a>

### Examples of Conditions for Use
`Conditions for Use` vary broadly. Some examples include:

* Specification of what type of research or analysis can be conducted on the data, for example, a data set may only be able to be used for breast cancer research
* Specification of who can conduct research with the data set, for example, only researchers at non-profit institutions can use the data for research
* Specification that results be shared with the originating researcher/entity
* Requirement that the researcher submit an Intended Data Use statement prior to accessing the data. Note that Intended Data Use statements must be updated anytime the research plan changes.

<br>
Additionally, use of certain data may require independent review and monitoring of research by an ethics committee (for example, an IRB). This ensures that use of the data meets all applicable human subjects research regulations. 

<a name="how-to-set-conditions-for-use "></a>

### How to set Conditions for Use?
If you would like to set `Conditions for Use` for an entire `Project`, please contact the Synapse Access and Compliance Team (ACT) directly for assistance (<mailto:act@synapse.org>). 

By default, the `Folders`, `Files` and `Tables` residing within a `Folder` or `Project` inherit the `Conditions for Use` of the parent `Folder` or `Project`. As with `Sharing settings`, you can set local `Conditions for Use` for individual `Folders`, `Files` and `Tables` but only **in addition to** the existing parent `Project`/`Folder’s` `Conditions for Use`. In other words, every `Folder`, `File` or `Table` has the `Conditions for Use` of its parent `Project`/`Folder`, and may have **additional** local `Conditions for Use` as needed. You cannot create `Folder`, `File` or `Table` that has fewer `Conditions for Use` than its parent `Project`/`Folder` or that has `Conditions for Use` that conflict with the `Conditions for Use` of the parent `Project`/`Folder`.

To set `Conditions for Use` for a  specific `Folder`, `File` or `Table`, use the popup `Conditions for Use` dialogue box. If you select that you would like to set `Conditions for Use` for your content, you are asked if the `Folder`, `File` or `Table` contains, “sensitive human data that must be protected.” If you answer “yes,” the ACT will reach out to you to assist in setting the appropriate `Conditions for Use`. If you answer “no,” but still feel that your `Folder`, `File` or `Table` requires `Conditions for Use`, contact the ACT for further discussion (<mailto:act@synapse.org>).
