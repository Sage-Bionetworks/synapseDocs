---
title: "Conditions for Use"
layout: article
excerpt: Conditions for Use determine how data in Synapse may be used by those who have been granted access.
category: governance
order: 2
---

Synapse has two ways to control who can access your content. Sharing Settings determine _who_ can access content, and is akin to individual or group (team) permissions. Conditions for Use determine _how_ data can be used by those users who have been granted access. All content in Synapse has Sharing Settings but not all content has Conditions for Use. See the [Sharing Settings](sharing_settings.md) article for information about those settings - this article covers conditions for use only.

<a name="conditions-for-use"></a>

# Conditions for Use

Some data requires data governance to appropriately manage its use. In Synapse this data is called Controlled Data and it is protected by Conditions for Use, typically applied in order to comply with the terms under which the data were collected or with other human subjects regulations. For example, human 'omic' data may have Conditions for Use imposed by informed consent requirements, legal contracts, or other privacy requirements. It is also appropriate to add Condition for Use to data collected from "vulnerable" populations and to content that could potentially harm individuals or groups if misused. If you have any questions about whether conditions for use should be applied to your data, please contact our [Access and Compliance Team (ACT)](mailto:act@sagebase.org).

<a name="require-conditions-for-use"></a>

## Examples of Conditions for Use

Conditions for Use vary broadly. Some examples include:

* Specification of what type of research or analysis can be conducted on the data, for example, a data set may only be able to be used for breast cancer research
* Specification of who can conduct research with the data set, for example, only researchers at non-profit institutions can use the data for research
* Specification that results be shared with the originating researcher/entity
* Requirement that the researcher submit an Intended Data Use statement prior to accessing the data. Note that Intended Data Use statements must be updated anytime the research plan changes.

{% include important.html content="Synapse users are responsible for determining the appropriate Conditions for Use for any data they upload into Synapse." %}

Additionally, use of certain data may require independent review and monitoring of research by an ethics committee (for example, an IRB). This ensures that use of the data meets all applicable human subjects research regulations.

<a name="controlled-data"></a>

## Controlled Data

Controlled Data requires appropriate Conditions for Use, can only be downloaded and used by authorized Synapse users, and is not transferable unless explicitly specified otherwise. In other words, you cannot share Controlled Data with collaborators; aach Synapse user wishing to access controlled data must individually agree to the conditions for use to access that data.

{% include important.html content="Controlled Data may not be redistributed." %}

It is important to note that Conditions for Use cannot be set for Synapse `Wikis` or `Discussion Forums`: they are not designed to house data and therefore do not have conditions for use as a feature.

Examples of Controlled Data include:

* Data whose nature confers more than minimal risks of re-identification to the research participant.
* Genetic sequence or genotype data from living individuals
* Data from “vulnerable” populations as defined using OHRP guidelines
* Data generated with restrictions or requirements for use as outlined in informed consents or legal agreements

<a name="open-data"></a>

## Open Data

Synapse Open Data is data that does not require Conditions for Use. Typically, open data is:

* Data from model organisms, species or strains
* Non-biological data, like that used for the calibration of instruments
* Human data that are:
  * Publicly available elsewhere
  * Anonymous
  * De-identified and non-sensitive, with no known sharing or use restrictions
  * Self-contributed and unambiguously consented for open data sharing and use

<a name="how-to-set-conditions-for-use "></a>

## How to Set Conditions for Use?

If you would like to set Conditions for Use for an entire `Project`, please contact the Synapse [Access and Compliance Team (ACT)](mailto:act@sagebase.org) directly for assistance.

By default, content within a `Folder` or Project inherit the Conditions for Use of the parent Folder or Project. As with sharing settings, you can set local conditions for use for individual Folders, `Files` and `Tables` but only **in addition to** the existing parent Project/Folder’s conditions for use. In other words, all content within a Folder or Project has, at a minimum, the Conditions for Use of its parent Folder or Project, and may have **additional** local conditions for use as needed. You cannot create a Folder, File, or Table that has fewer conditions for use than its parent or that has conditions for use that conflict with the conditions for use of the parent.

To set Conditions for Use for Folders, Files, and Tables in Synapse, nagivate to the content in question and use the popup Conditions for Use dialogue box. If you select that you would like to set conditions for use for your content, you are asked if the Folder, File or Table contains, “sensitive human data that must be protected.” If you answer “yes,” the ACT will reach out to you to assist in setting the appropriate Conditions for Use. If you answer “no,” but still feel that your Folder, File or Table requires Conditions for Use, contact the ACT for further discussion (<mailto:act@synapse.org>).
