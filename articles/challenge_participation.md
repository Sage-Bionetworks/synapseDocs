---
title: Participating in a Challenge
layout: article
excerpt: Learn how to participate in challenges.
category: howto
---

<style>
#image {
    width: 100%;
}
#toobig {
    width: 45%;
}
</style>

## Overview
This tutorial will teach you the steps of participating in a challenge.

## Challenge Registration
If you do not have a Synapse account, please go to our [getting started guide](http://docs.synapse.org/articles/getting_started.html#becoming-a-certified-user) to become a certified Synapse user.
Participants **must** be registered for the challenge if they want to submit and participate. The registration button can be found on the home page or `How to Participate` page for every challenge. In order to be fully registered for any challenge, you must have a Synapse account. In addition, DREAM Challenges require that you:

(1) become a [certified user](http://docs.synapse.org/articles/getting_started.html#becoming-a-certified-user);
<br/>
(2) agree to the DREAM Rules of participation, and
<br/>
(3) agree to the Terms of Use to work with the Challenge data.


## Join or Create a Team
We encourage you to form a team with other participants for the challenge. You can either join a team or create your own team of collaborators. See instructions on how to form a team [here](http://docs.synapse.org/articles/teams.html). It is important to note that you **cannot** be on more than one team. Once you have submitted as a team or individual, you will not be able to submit as another team. If you decide to be part of a team, please register your team to the challenge - there will be a place to do this in every challenge wiki.

## Accessing Challenge Data
The data stored on the challenge Synapse site can be accessed using the Synapse website or programmatically using the Synapse R or Python clients. Instructions on using Synapse are provided in the [Synapse User Guide](http://docs.synapse.org/). File descriptions are provided on the Data Description page in each challenge wiki.

## Run your Algorithms and Submit to the Challenge

You can submit to a challenge queue by using the R, Python or web client. In many cases, submitting through the web is easiest. All submissions must be first uploaded into Synapse. Follow instructions [here](http://docs.synapse.org/articles/getting_started.html#project-and-data-management-on-synapse) on how to upload to a project. Most challenge queues will be labeled by `challengename-subchallenge#` as a challenge may have different questions that it may want you to answer.

In the R and Python examples, you need to know the evaluation ID of the subchallenge to which you you are submitting. The ID of the evaluation queue should be specified in the submission instructions specific to the challenge, but often times the queue you should submit to will also be labeled with the name of its relevant subchallenge in the _Challenge_s tab within the challenge project, under the _Evaluation Queues_ section.
The submission function takes **two optional parameters**: `name` and `team`.  Name can be provided to serve as a custom name of the submission. If a name is not provided, the name of the entity being submitted will be used. Teams can optionally be provided to give credit to members of the team that contributed to the submission. 

The examples below will show you the process of uploading a file to a project and then submitting that file to the challenge evaluation queue.

{% tabs %}

{% tab Web %}
Navigate to an uploaded file in Synapse and click on `Tools` on the upper right hand corner.
Select `Submit To Challenge`.

<img id="image" src="/assets/images/howtosubmit.png">
After doing so, pick the challenge you want to submit to, in this case (My Example Challenge). Click Next and follow the steps to complete your submission.

<img id="toobig" src="/assets/images/submitToChallenge.png">
{% endtab %}

	{% tab Python %}
		{% highlight python %}
import synapseclient
syn = synapseclient.login()

parentId = "syn12345" # folder/project to upload your file to
my_submission_file = File("/path/to/file.csv", parent=parentId)
my_submission_file = syn.store(my_submission_file)

# if you're submitting as a team, get team entity
team_entity = syn.getTeam("NameOfYourTeam")
# submit to the challenge evaluation queue
my_submission = syn.submit(evaluation=evaluationId, entity=my_submission_file, name="Blue Team", team=team_entity)
		{% endhighlight %}
	{% endtab %}

	{% tab R %}
		{% highlight r %}
library(synapser)
synLogin()
my_submission_file <- File("/path/to/submission.csv", parentId="syn12345")
my_submission_file <- synStore(my_submission_file)
#The evaluationId must be a string here or there will be an error
submission <- synSubmit(evaluationId, my_submission_file, name="Our Final Answer", team="Blue Team") 
{%endhighlight %}
	{% endtab %}

{% endtabs %}

The submission function takes two optional parameters: `name` and `team` in Python, `submissionName` and `teamName` in R. The name can be provided to serve as a custom name of the submission. If a name is not not provided, the name of the entity being submitted will be used. A team name can be provided to give credit to members of the team that contributed to the submission.

## Share Ideas and Ask Questions

Every challenge has a discussion forum for participants (the `Discussion` tab on the Challenge Project page). The forum is a space for participants to ask any questions and raise ideas.

Instructions on how to use the discussion forum can be found [here](http://docs.synapse.org/articles/discussion.html)
