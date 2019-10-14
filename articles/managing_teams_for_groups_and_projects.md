---
title: "Managing Teams for Groups and Projects"
layout: article
excerpt: Using Synapse teams for group permissions in projects.
category: inpractice
---

## Creating Permissions Models for Synapse Projects

Synapse supports several different kinds of project permissions. These are described in more detail as "sharing settings" in the article on [access controls](access_controls.md#sharing-settings). Additionally, Synapse supports setting "local sharing settings" that allow you to make your project public while keeping some folders, files, or tables private. To do this, you would use local sharing settings. Permissions and sharing settings within Synapse are otherwise hierarchical; that is, if you set permissions on a project, everything within that project inherits those permissions until local sharing settings have been created.

When thinking through the process of creating a permissions model for your project, consider the following questions:

* Who needs to be able to view this project?
* Who needs to be able to edit or add content to this project?
* Who should be in charge of changing permissions on this project, to modify either of the above?
* Does any content in this project need different permissions than the whole project? For example:
  * Raw vs. processed data folders with different permissions
  * Internal meeting notes in a private folder vs. methodolodgy and SOP documents shared publicly

## Using Teams for Permissions

Teams are groups of Synapse users; learn more about [managing teams here](teams.md). If you are working with a group of users, and you want to allow some users to view or download data, while other users should be in charge of managing the project or adding new data, you should consider using teams to grant users permission. For example, you can create a "project administrators" group and grant that team permission to administer the project. Then, when you need to modify permissions on the project, you can add or remove people from the team rather than modifying the sharing settings on the project. This is especially useful if you have more than one project that the same group of people will be working across; using teams for permissions can help prevent administrative errors like forgetting to remove someone from a project if they leave your collaboration.

## Recommended Team Types

For many collaborations, there is a small group who will administer the project, a slightly larger group who will contribute data or content, and an even larger group who may have permission to view the project or contents. In these cases, we recommend creating groups for each of these permission types: an admin team with "administer" permissions, a data curation or content creation team with "can edit" permissions, and a viewing team with "can view/download" permissions. If you intend to make your content publicly viewable, this third team is not necessary; you can click on "Make Public" to share your project more broadly.

Because permissions are additive, a user who is in all three teams will have the highest permissions granted; that is, if you add a single user to three different teams and grant those teams "admin", "edit", and "view" permissions, the user in question will have "admin" permissions.

## Local Sharing Settings

Sometimes, users wish to retain private spaces within public projects, or otherwise create sharing settings on project components (folders, tables, etc.) that are different from the overall project permissions. This is possible using Local Sharing Settings. You can use teams for group permissions even with local sharing settings, which can help streamline administration even more.

For example, to create a private folder within a public project, you would make the entire project public using the "Make Public" button. Then, create a new folder, click on "Create Local Sharing Settings", and click the "Make Private" button. Confirm that this removes the "All registered Synapse users - Can Download" and "Anyone on the web - Can View" from the list.

The folder with then be shared only with the specific user groups that the entire project is shared with, and not the general public. Note that creating local sharing settings can sometimes alter the permissions model unintentionally; see below for how to triage your sharing settings.

# Triaging Project Permissions Using Views

Sometimes local sharing settings are accidentally created, and once created, they can be somewhat tricky to detect. One quick way to triage your project permissions is by using a [view](views.md) with a scope set to a single project, or across multiple projects with similar permissions models. The field that you will be using below is called
"benefactorId" -- this is the unique set of permissions assigned to groups of things. When you first create a project, the project itself is the "benefactor" of permissions, and there is only one benefactor ID for all the things in the project.

As soon as you create your first set of local sharing settings, there are now two benefactors; the project is still providing the permissions for most the content, but whatever you have set local sharing settings on (say, a folder) now is the benefactor for anything inside it; it's the new benefactor of permissions for that sub-hierarchy, and everything inside will share the same, new benefactorId.

This is useful as a query because you can set up a file/folder "view" of your entire project and look at all of the system metadata, including benefactor ID, and use it as a permissions audit. It will help you find places where local sharing settings are set (causing new benefactor IDs to appear) and can help you clean them up, as views automatically update to re-query across your project each time the data changes (this can take a few moments if the update is quite large, so it is not precisely real-time, but it is automatic). You can find and remove local sharing settings entirely, which will cause permissions to then be inherited "up the chain", so to speak.

The query that will help identify things that have different permissions than the project compares the benefactor ID of each thing to the project ID. If they are different, this means that object has different sharing settings than that of the project, and might be something you want to check. This example query focuses on folders, as that is the most common thing that have different sharing settings. The query can be modified to look at files, tables, or all content as well:

{% highlight sql %}
SELECT id,parentId,type FROM syn12162270 WHERE type = 'folder' AND  benefactorId <> projectId
{% endhighlight %}
