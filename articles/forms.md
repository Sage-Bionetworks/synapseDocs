---
title: "Forms"
layout: article
excerpt: Embedding Synapse Forms to Collect Data into Tables 
category: howto
---

# Forms

`Forms` are a way to collect data _into_ a Synapse `Table`. Forms are currently available only under the _alpha_ configuration as they are not yet ready for full release; please use Forms only with this caveat in mind. This document will evolve as additional functionality is added. 

With Forms, you can: 

* Create surveys to collect feedback
* Crowdsource data collection
* Allow others to contribute data through a user-friendly UI


## Creating a Table

In order to use Forms, you'll need to first create a `Table`. Read more about creating tables here: [Tables](/articles/tables.html)

## Activating and Deactivating 'Alpha' Mode

In the Synapse footer, on the right side, is a little "@" symbol. Clicking this symbol will bring you a pop-up that asks if you want to enter into "alpha mode". Doing so enables a small number of new, under development features related to new "widgets" in our `Wiki` pages, all available under under the "Insert" menu when you are editing a wiki page. Once alpha mode has been activated, you'll see a little bit of text in the Synapse header that says "Alpha features on / off" with "ON" in bold. 

You can also deactivate alpha mode at any time; the deactivation button is the word "off" the Synapse header and clicking it turns it off and removes the text from the header. 

## Creating a Form

Once alpha mode has been activated, visit the wiki page where you'd like to insert the Form. Click on "Edit Project Wiki" and select the "@ Insert" menu. Select "Synapse Form" from the menu. The widget will insert (currently; this may change in the future) a line of markdown that says:

```
${synapseForm?tableId=syn123&successMessage=Your response has been recorded}
```

You will need to insert the proper Synapse ID for the Table you created above, and optionally, you can customize the "Success" message for users. When a `Form` is submitted, it will create a new row in a Synapse Table.

* The question UI is built from the Synapse Table column schema.
* Column names are used as question prompts.
* The possible values for an enum column type, for example, will be a represented by a multiple choice question.


The form is also responsive, so it will render on both large and small screens. 

## Allowing Others to Contribute

Entering data into a `Form` is equivalent to editing the data in a `Table`, so users who wish to add data using the form will need to have "Edit" permissions on the Table. See [Sharing Settings](/articles/access_controls.html) for more information on controlling who can edit your Table. 

## See Also
[Tables](/articles/tables.html), [Wikis](/articles/wikis.html), [Sharing Settings](/articles/access_controls.html)
