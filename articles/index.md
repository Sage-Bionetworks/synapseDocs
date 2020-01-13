---
title: Before You Start
layout: index
---

{% assign doclist = site.pages | sort: 'order' %}


<div class="col-xs-12 col-lg-12" id="subjects">
    <ul class="nav nav-tabs" id="myTab" style="margin-top: -70px; border: 2px solid transparent;">
    <div class="col-xs-12 col-lg-4">
        <a href="#intro">
        <div class="subject-card">
            <i class="fa fa-power-off"></i>
            <h5>Get Started</h5>
            <hr>
            <span>New to Synapse? Read this 10-minute guide that explains what it is, why you should use it and how to get started!</span>
        </div>
        </a>
    </div>
    <div class="col-xs-12 col-lg-4">
        <a href="#howto">
        <div class="subject-card">
            <i class="fa fa-book"></i>
            <h5>Onboarding</h5>
            <hr>
            <span>Learn how to set up your Synapse account for the first time. Register, become a certified user and set up your profile.</span>
        </div>
        </a>
    </div>
   <!-- <div class="col-xs-12 col-sm-3">
        <a href="/articles/api_documentation.html">
        <div class="subject-card">
            <i class="fa fa-cog"></i>
            <h5>API Docs</h5>
            <hr>
            <span>Technical documentation for using the R/Python clients and RESTful APIs.</span>
        </div>
        </a>
    </div> -->
   <div class="col-xs-12 col-lg-4">
        <a href="#governance">
        <div class="subject-card">
            <i class="fa fa-lock"></i>
            <h5>Governance</h5>
            <hr>
            <span>Requirements and best practices for using Synapse in a compliant, ethical and considerate manner.</span>
        </div>
        </a>
    </div>
    </ul>

<div class="tab-content">
    <div class="tab-pane active" id="intro">
        <!--Start intro content-->
        <h3>Before You Start</h3>
        <div class="row">
            {% for page in doclist %} {% if page.category == 'intro' %}
                <ul>
                    <li><b><a href="{{ page.url | relative_url}}">{{ page.title }}</a></b>: {{page.excerpt}}</li>
                    </ul>
                {% endif %} {% endfor %}
        </div>
    </div>
    <!-- <end intro content> -->
    <div class="tab-pane active" id="howto">
        <!--Start how to content-->
        <h3>Core Components of Synapse</h3>
        <div class="row">
            {% for page in doclist %} {% if page.category == 'howto' %}
                <ul>
                    <li><b><a href="{{ page.url | relative_url}}">{{ page.title }}</a></b>: {{page.excerpt}}</li>
                    </ul>
            {% endif %} {% endfor %}
        </div>

    </div>
    <!--end how to content-->

    <div class="tab-pane active" id="governance">
        <!--Start governance content-->
        <h3>Additional Components</h3>
        <div class="row">
            {% for page in doclist %} {% if page.category == 'governance' %}
                <ul>
                    <li><b><a href="{{ page.url | relative_url}}">{{ page.title }}</a></b>: {{page.excerpt}}</li>
                    </ul>
            {% endif %} {% endfor %}
        </div>

    </div>
    <!--end governance content-->

    </div>
    <!--<end intro content>-->

    <div class="tab-pane active" id="admin">
        <h3>Vignettes</h3>
    <!-- start synapse in practice content -->
        <div class="row">
            {% for page in doclist %} {% if page.category == 'inpractice' %}
                <ul>
                    <li><b><a href="{{ page.url | relative_url}}">{{ page.title }}</a></b>: {{page.excerpt}}</li>
                    </ul>
            {% endif %} {% endfor %}
        </div>

    </div>
    <!--End synapse in practice content-->


    <div class="clearfix"></div>
</div>
