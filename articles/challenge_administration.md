---
title: Challenge Infrastructure
layout: article
excerpt: Learn how to set-up the wireframe of a challenge. 
category: admin
---

## Challenge Guide Overview
This guide is meant to help challenge organizers create a space within Synapse to host the challenge, giving participants a place to learn about the challenge, join the challenge community, submit entries, track progress and view results.


## A - Setting up Challenge infrastructure

This [createChallenge.py](https://github.com/Sage-Bionetworks/DREAM-Utilities/blob/master/createChallenge.py) script sets up the challenge infrastructure (steps A1-5).  

**For all DREAM challenges, please contact the Synapse Access and Compliance Team (act@sagebase.org) for step A4!**

### 1 - Creating Teams

In Synapse, Teams are publicly viewable groups of users.  Teams may be given access to projects, data files, and Evaluation submission queues as a group.  Using a Team for a challenge allows you to see who is participating and to conveniently control access to challenge resources.  **All challenges require a challenge participant, challenge pre-registrant, and administrator team.**

From the Synapse [home page](https://www.synapse.org) enter a unique Team name to the left of the "Create Team" button, then click the button to create a new Team.  On the page for your Team you can configure whether approval is required by a Team administrator (you) to join the Team.  On this page you can also share administrative rights with other team members of your choice.

Please visit this [page](/articles/teams.html) to learn more about teams.


### 2 - Creating DREAM Challenge Projects

Each Project, Folder and File may have an associated wiki page describing it.  The project wiki is a good place for an overview of the challenge and instructions for participating.  For background on how to create and share Projects, Files and Folders, please see our [making a project guide](/articles/making_a_project.html).  

All DREAM challenges should have a live and staging site.  The two projects should be named something like this:  "Your DREAM challenge" and "Your DREAM challenge staging site".  It is important to note that the live site will act as a splash site as the DREAM challenge is in development.  The main challenge project can serve as a 'landing page' for visitors wishing to learn about the challenge, as well as a repository for data files and other resources related to the challenge.  

{% include important.html content="All edits and changes even after the challenge has launched should be made on the staging site." %}

The comprehensive [DREAM Challenge Wiki Template](https://www.synapse.org/#!Synapse:syn2769515/wiki/) is a great starting point for your challenge's wiki pages.  It also helps to have a look at [some examples from previous challenges](https://www.synapse.org/#!Challenges:DREAM).  **This page will act as the staging site until the challenge is ready to be launched.  Then all the pages on the staging site will be copied onto the main site.** To copy the Challenge Wiki Template to your new project:  Say your private project is "syn0123456".   First, ensure your project has no wiki page (deleting the current one if necessary).  Here are the ways to copy a wiki from one project to another.

{% tabs %}
	{% tab Python %}
		{% highlight python %}
import synapseclient
import synapseutils
syn = synapseclient.login()
source_project_id = "syn2769515" # This is the ID of the template project
target_project_id = "syn0123456"
synapseutils.copyWiki(syn, source_project_id, target_project_id)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
library(synapser)
library(synapserutils)
synLogin()
source_project_id = "syn2769515"
target_project_id = "syn0123456"
copyWiki(source_project_id, target_project_id)
		{%endhighlight %}
	{% endtab %}

{% endtabs %}


### 3 - Connect the Sign-up Team to the Challenge Project 

The challenge team you created needs to be connected to the to the challenge.

{% tabs %}
	{% tab Python %}
		{% highlight python %}
import synapseclient
import json
syn = synapseclient.login()
challenge_object = {'id': u'1000',
	'participantTeamId': u'1111', #replace with the actual Team ID
	'projectId': u'syn12345'} #replace with the MAIN project Synapse ID (not staging)
challenge = syn.restPOST('/challenge', json.dumps(challenge_object))
# retain the challenge ID (distinct from 'projectId', above) for use in several wiki widgets described below)
challenge_id = challenge['id']
#You will be able to access the challenge Id by doing
challenge = syn.restGET('/entity/syn12345/challenge')
challenge.id
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
library(rjson)
library(synapser)
synLogin()
projectId <- "syn123456" # replace with the actual project Synapse ID
participantTeamId <- "987654" # replace with the actual Team ID
challenge <- list(projectId=projectId, participantTeamId=participantTeamId)
challenge <- synRestPOST("/challenge", toJSON(challenge))
# retain the challenge ID (distinct from 'projectId', above) for use in several wiki widgets described below)
challengeId<-challenge$id
		{%endhighlight %}
	{% endtab %}
	{% tab Web %}

Navigate to your challenge site (E.g. www.synapse.org/#!Synapse:syn12345) and click on Tools, Run Challenge and insert your challenge team name.

<img src="/assets/images/attachTeamToChallenge.png">


	{% endtab %}
{% endtabs %}

### 4 - Add a Sign-up button

You can add a "Join" button on a wiki page to allow people to join your challenge.  Edit a wiki page, and click Insert > "Join Team Button".  A 'widget' will be added to your wiki page like this:

```
${jointeam?teamId=42&showProfileForm=true&isMemberMessage=You have successfully registered for the challenge&
text=Register for the Challenge&successMessage=Registration Request Accepted&
requestOpenText=Registration Request Accepted&isSimpleRequestButton=true&isChallenge=true}
```

You fill in the challenge Team ID and other parameters.  You can configure challenge registration to require that registrants agree to 'terms of use' (ToU) before they are allowed to join the challenge.   Further, mutiple terms of use can be associated with a single team.  For example, it is common to have participants agree both to the DREAM rules and also to terms that are specific to the particular challenge.  Adding these terms is the function of the Synapse Access and Compliance Team.  Please
contact them (act@sagebase.org) and provide the text of the the ToU and the name and/or ID of the team.

{% include note.html content="Please contact the Synapse Access and Compliance Team with the Terms of Use and ID of your team prior to launching the challenge." %}

### 5 - Configure Team Registration widgets

The challenge wiki template has placeholders for widgets which (1) register teams with the challenge, (2) list registered teams, and (3) list participants who have not joined any registered team.  At the time of this writing the templates appear in Sect. "3.2 - Forming a Team".  Edit the markdown to see the widget definitions:

```
Register a Team for the challenge:
${registerChallengeTeam?challengeId=1234&buttonText=Register a Team} 

List the registered Teams:
${challengeTeams?challengeId=1234}

List registered participants who have not joined a registered Team:
${challengeParticipants?challengeId=1234&isInTeam=false}
```

In the template the challenge ID is the placeholder '1234'.  Replace this with the challenge ID for your challenge.  This ID was retained in the Python/R script in the section 'Connect the Sign-up Team to the Challenge Project', above.  If you did not retain this ID, you may look it up from the Challenge project ID.


{% tabs %}
	{% tab Python %}
		{% highlight python %}
challenge = syn.restGET("/entity/%s/challenge" % project_id) # project_id is defined above
challenge['id']
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
projectId <- "syn123456" # replace with the actual challenge project ID
challenge <- synRestGET(sprintf("/entity/%s/challenge", projectId))
challenge$id
		{%endhighlight %}
	{% endtab %}
	{% tab Web %}

Click on the Challenge Tab:

<img src="/assets/images/challengeId.png">


	{% endtab %}
{% endtabs %}


## B - Configuring a Challenge

### 1 - Edit Challenge Wiki Privately

Challenge organizers have found it convenient to author wiki pages privately, then publish the result when ready for public view.  Please review [step A2](/articles/2---creating-dream-challenge-projects) for more information, and to learn how make the initial copy of the wiki from the staging site to the public site. 

If significant modifications to the public wiki are required, you can first edit the staging project wiki to test your edits. Once you are satisfied with your wiki edits, you can use the [mirrorWiki script](https://github.com/Sage-Bionetworks/DREAM-Utilities/blob/master/mirrorWiki.py) to mirror the staging site changes to the live site so that only changes are made on the staging site. As mentioned above, for the initial copying of staging wiki content to the live site, please follow the instructions in [step A2](/articles/2---creating-dream-challenge-projects)

{% include note.html content="The wiki titles are matched between the staging and live site, so if you don't want a page to be mirrored over, change the name of the wikipage." %}

```
#Usage of mirrowWiki script
python mirrorWiki.py stagingSiteSynId liveSiteSynId
```

### 2 - Upload Challenge Data

As mentioned earlier, Synapse can serve both as a place for challenge administrators to share 'secret' scoring data files and for challenge participants to access training data used in the challenge.  You may share training data with participants by sharing with the challenge Team you created.  

#### 2.1 - Add access restrictions

Please view the [Sharing Settings and Conditions for Use](/articles/access_controls.html) to learn how to add access restrictions to the data.

Synapse has the ability to apply access restrictions to sensitive, human data, so that legal requirements are met before participants access such data.  If human are being used in the challenge, or if you have any question about sensitivity of the challenge data, you must contact the Synapse Access and Compliance Team (act@sagebase.org) who will help put in place the necessary data access approval procedure.  

There are cases in which there are no human data concerns but for which a pop-up agreement needs to be presented before download data for the first time.  Contact the Access and Compliance Team to set up this agreement. 

### 3 - Create an Evaluation Queue for Submissions

Challenge participants submit their entries as Synapse Files to an Evaluation queue ("Evaluation" for short) which you manage.  You may create multiple Evaluation queues to support sub-challenges having different types and rounds of submissions.

Please visit the [Evaluation Queue article](/articles/evaluation_queues.html) to learn about queues.

#### 3.2 - Enable Challenge Statistics

Share your Evaluations with the service account 'evaluationstatistics', giving 'Can Score' access.  This will result in a statistical summary of your challenge appearing on this [page](https://www.synapse.org/#!Synapse:syn2504723). The specific steps are:
- Navigate to your Challenge project in Synapse
- Click on the `Challenge` tab
- Next to each Evaluation submission queue click `Share`
- In the `name` field type `evaluationstatistics`.  The new entry will appear in the list of accessors above.
- Next to the new entry use the pull down menu to change `Can View` to `Can Score.`
- Click Save.


#### 3.3 - Add a Submit button to your wiki (Optional)

You can add a "Submit" button on a wiki page to allow people to submit entries to the Evaluation you set up.  Edit a wiki page, and click Insert > "Submit to Evaluation Button".  A 'widget' will be added to your wiki page like this:

```
${evalsubmit?subchallengeIdList=evalId1,evalId2&unavailableMessage=Join the team to submit to the challenge}
```

You customize the subchallengeIdList and other parameters.  The IDs in the subchallengeIdList are those shown in the Challenge Admin project tab. 

#### 3.4 - Large email volumes

Synapse has a limit on the volume of email messages sent out.  Currently accounts may not send more than ten messages per minute.  If you feel your scoring application needs to send larger volumes, please contact Synapse administration.

## C - Scoring Submissions

### 1 - Creating a Scoring Application

As submissions arrive from participants, you may need to run a custom scoring script.  Synapse provides APIs for retrieving and scoring submissions.  A runnable scoring template (versions in Java, R and Python) is available in the [Synapse Challenge Agent GitHub repository](https://github.com/Sage-Bionetworks/SynapseChallengeAgents)
After customizing the application for your scoring needs, create a periodically running job on a server owned by your organization.  A convenient, free web interface for periodically running jobs is [Jenkins](http://jenkins-ci.org/).  Note:  In the Challenge Admin tab mentioned above you must share the Evaluation with the user under whose credentials the Scoring Application is run, providing "Can score" access to this user.

Submission scores and other computational results may be attached to the Submissions themselves.  The sample code shows how to do this.  The results may be retrieved and displayed in a leaderboard, as described below.


#### Python Scoring Application

```
git clone https://github.com/Sage-Bionetworks/SynapseChallengeAgents.git
```


For those writing Synapse challenge scoring applications in Python, these scripts should serve as a starting point giving working examples of many of the tasks typical to running a challenge on Synapse.  Challenges can be set up by creating a **challenge_config.py** with **challenge_config.template.py** and editting **messages.py**. You'll need to add an evaluation queue for each question in your challenge and write appropriate validation and scoring functions. Then, customize the messages with challenge specific help for your solvers.

In the **challenge_config.template.py**, you can add in separate `validate_func`, `score1`, `score2`, and `score...` functions for each question in your challenge.  You can name these functions anything you want as long as you set up a evaluation queue and function or file mapping. 

```
evaluation_queues = [
    {
        'id':1,
        'scoring_func':score1
        'validation_func':validate_func
        'goldstandard':'path/to/sc1gold.txt'
    },
    {
        'id':2,
        'scoring_func':score2
        'validation_func':validate_func
        'goldstandard':'path/to/sc2gold.txt'

    }
]
evaluation_queue_by_id = {q['id']:q for q in evaluation_queues}
```

Make sure the id's are your actual evaluation queue ids, so that the right functions are used when the submissions are being validated and scored.   

All validation functions **MUST** use assertions to catch the participant errors.  Only assertion errors are emailed to the participants.  All other errors are emailed to the challenge admins.  Example validation function:

```
import pandas as pd
import os
def validate_func(submission, goldstandard_path):
    ##Read in submission (submission.filePath)
    ## MUST USE ASSERTION ERRORS!!! 
    assert os.path.basename(submission.filePath) == "prediction.tsv", "Submission file must be named prediction.tsv"
    pred = pd.read_csv(submission.filePath, sep="\t")
    gold = pd.read_csv(goldstandard_path, sep="\t")
    REQUIRED_HEADERS = ["sampleId","values"]
    assert all([i in pred.columns for i in REQUIRED_HEADERS]), "predictions.tsv must have headers: sampleId, values"
    assert sum(pred['sampleId'].duplicated()) ==0, "No duplicated sampleIds allowed"
    return(True,"Passed Validation")
```

All successfully validated submissions will have submission status as VALIDATED.  The scoring harness will then look for all VALIDATED submissions and score them.  Example scoring function:

```
import pandas as pd
import numpy
print numpy.corrcoef(a,b)
def score1(submission, goldstandard_path):
    pred = pd.read_csv(submission.filePath, sep="\t")
    gold = pd.read_csv(goldstandard_path, sep="\t")
    combined = gold.merge(pred, on="sampleId", how="outer")
    correlation = numpy.corrcoef(combined['truth'],combined['values'])
    return(correlation[0,1])
```

To attach the scores to the submission object, you must set up the `score_submission` function to return a dictionary of values.

```
def score_submission(evaluation, submission):
    """
    Find the right scoring function and score the submission

    :returns: (score, message) where score is a dict of stats and message
              is text for display to user
    """
    config = evaluation_queue_by_id[int(evaluation.id)]
    score = config['scoring_func'](submission, config['goldstandard_path'])
    #Make sure to round results to 3 or 4 digits
    return (dict(corr=round(score[0],4)), "You did fine!")
```


In **messages.py**, please edit the dictionary on line 18:

```
defaults = dict(
    challenge_instructions_url = "https://www.synapse.org/",
    support_forum_url = "https://www.synapse.org/#!Synapse:{synIdhere}/discussion/default",
    scoring_script = "the scoring script")
```

Point to the correct **How to submit** page on the challenge site and the challenge's discussion forum.


##### Validation and Scoring

Let's validate the submission we just reset, with the full suite of messages enabled:

```
python challenge.py --send-messages --notifications --acknowledge-receipt validate [evaluation ID]
```

The script also takes a --dry-run parameter for testing. Let's see if scoring seems to work:

```
python challenge.py --send-messages --notifications --dry-run score [evaluation ID]
```

OK, assuming that went well, now let's score for real:

```
python challenge.py --send-messages --notifications score [evaluation ID]
```

Go to the challenge project in Synapse and take a look around. You will find a leaderboard in the wikis and also a Synapse table that mirrors the contents of the leaderboard. The script can output the leaderboard in .csv format:

```
python challenge.py leaderboard [evaluation ID]
```

##### RPy2
Often it's more convenient to write statistical code in R. We've successfully used the [Rpy2](http://rpy.sourceforge.net/) library to pass file paths to scoring functions written in R and get back a named list of scoring statistics. Alternatively, there's R code included in the R folder of this repo to fully run a challenge in R.

##### Setting Up Automatic Validation and Scoring on an EC2

Make sure challenge_config.py is set up properly and all the files in this repository are in one directory on the EC2.  Crontab is used to help run the validation and scoring command automatically.  To set up crontab, first open the crontab configuration file:

```
crontab -e
```

Paste this into the file:

```
# minute (m), hour (h), day of month (dom), month (mon)                      
*/10 * * * * sh challenge_eval.sh>>~/challenge_runtimes.log
5 5 * * * sh scorelog_update.sh>>~/change_score.log
```

Note: the first 5 * stand for minute (m), hour (h), day of month (dom), and month (mon). The configuration to have a job be done every ten minutes would look something like `*/10 * * * *`


#### Java Scoring Application

**More info coming soon**

#### R Scoring Application

**More info coming soon**


### 2 - Share Scoring Code with Participants

Although validation/test data is typically kept secret during a challenge, you should make the scoring algorithm itself available to participants.  A straightforward way to do this is to push the code to your GitHub fork, then link to a Synapse entity or wiki using its GitHub URL.

## D - Share the Challenge!

Now that you have successfully configured the challenge. Please view the [Access Controls article](/articles/access_controls.html) to learn how to share the challenge and apply conditions for use on the data.

A common pattern is to make the challenge project publicly viewable so all Synapse users can read about the challenge.  Participant data sets are organized in the project, but are limited in access so only challenge participants may see them.  Data used for testing/scoring submissions may
also be placed with the project but with even tighter access restrictions, so that only challenge organizers may see the data files. 


## E - Revealing Submissions and Scores

### 1 - Create a Leaderboard

Leaderboards are sorted, paginated, tabular forms that display submission annotations (such as scores from your scoring application and other metadata). Leaderboards are dynamic and update as annotations/scores change, so can provide real-time insight into how your Challenge is going. The scoring application templates mentioned above print out valid sample widget text suitable for pasting into the wiki editor.  In the "Challenge Admin" control, described above, you provide "Can View" access to whomever you wish to be able to see the leaderboard. 

To add a leaderboard to your Challenge Wiki,
* First go to the Challenge Project and get the ID of the Evaluation of interest; Challenges can have multiple evaluations so it's important to identify which evaluation you want to summarize.
* Next, edit the wiki page where you want to add your leaderboard and choose "Insert" and then "Leaderboard". 
* Finally, you'll configure your leaderboard by entering a query of the form "Select * from Evaluation_12345" where 12345 is the ID from the first step. 

<br>If you have some annotations already then you can click "Refresh Columns" to add display columns for the existing annotations. Otherwise you have to add the columns manually. You can reorder the columns and choose what to sort by. Keep in mind that "private" annotations will not be visible to participants (only to challenge administrators). 

**Test everything on some dry run users**

**DON'T SKIP THIS STEP!!!**  Really.  Get some friends to try to go through the whole process of signing up and submitting to the challenge, starting with just a link to synapse.org.  Do this 2 weeks before you intend to launch publicly so you can actually do the little bug fixing needed to smooth things out for the larger launch.

### 2 - Link results to participants' project spaces

If using a "live leaderboard", add a column whose value is "entityId".  This will add a column to the table containing hyperlinks to the submitter's home project.  There they can add a wiki describing their algorithm.  If using a static leaderboard (wiki table), you may retrieve the entity IDs from the submissions and add them in the wiki editor.  To get the link for each submission, you may use this R script:

```
library(synapseClient)
synapseLogin()
# give a list of submission IDs, for example
sids<-c(
"2703876",
"2700048",
"2700357",
"2700006",
"2701077",
"2699014")
# Now find the parent entity ID for each submitted file.
# Usually this will be the project containing the write-up.
# If not, it's just one click to go from the folder to the wiki.
# If the submitted file is erased, just link to the user himself.
for (sid in sids) {
        subm<-synGetSubmission(sid, downloadFile=F)
            reference<-sprintf("https://www.synapse.org/#!Profile:%s", subm$userId)
                try({
                            file<-synGet(subm"ntityId, downloadFile=F)
                        reference<-propertyValue(file, "parentId")
                            })
                    cat(subm$id, "\t", reference, "\n")
}
```

## F - Challenge Tips & Tricks

Here are some helpful functions that could help with running a challenge.  Every submission has a unique submission id, this should not be confused with synapse ids which start with `syn`.  A submission can also contain annotations that can be used to display on live leaderboards.  It is good to note that these added annotations can be set to either public or private.  Private annotations cannot be read by people on the live leaderboard unless the READ_PRIVATE_SUBMISSIONS ACL is set on the evaluation queue.

{% tabs %}
	{% tab Python %}
		{% highlight python %}
#Get submission / annotations
sub = syn.getSubmission(submissionId)
annotations = syn.getSubmissionStatus(submissionId)
#Get all scored submissions in an evaluation queue
e = syn.getEvaluation(e)
bundles = syn.getSubmissionBundles(e, status = "SCORED")
for sub, status in bundles:
	print(sub)
	print(status)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
# Get submission / annotations
sub <- synGetSubmission(submissionId)
annotations <- synGetSubmissionStatus(submissionId)
# Get all scored submissions in an evaluation queue
bundles <- as.list(synGetSubmissionBundles(evaluation, status="SCORED"))
		{%endhighlight %}
	{% endtab %}
{% endtabs %}
