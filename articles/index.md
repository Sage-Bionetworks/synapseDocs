---
title: User Guide
layout: index
---

{% assign doclist = site.pages | sort: 'order' %}


<div class="col-xs-12 col-md-12 col-lg-12" id="subjects">
    <ul class="nav nav-tabs" id="myTab" style="margin-top: -70px; border: 2px solid transparent;">
    <div class="col-xs-12 col-md-6 col-lg-4">
        <a href="#intro">
        <div class="subject-card">
            <i class="fa fa-power-off"></i>
            <h5>Getting Started</h5>
            <hr>
            <span>New to Synapse? Learn the basics with our introductory topics.</span>
        </div>
        </a>
    </div>
    <div class="col-xs-12 col-md-6 col-lg-4">
        <a href="#howto">
        <div class="subject-card">
            <i class="fa fa-book"></i>
            <h5>User Guide</h5>
            <hr>
            <span>Browse short "How To" articles on leveraging specific features in Synapse.</span>
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
   <div class="col-xs-12 col-md-6 col-lg-4">
        <a href="#governance">
        <div class="subject-card">
            <i class="fa fa-lock"></i>
            <h5>Governance</h5>
            <hr>
            <span>Learn about how Governance and Ethics policies and tools make Synapse safe.</span>
        </div>
        </a>
    </div>
    <div class="col-xs-12 col-md-6 col-lg-4">
        <a href="#admin">
        <div class="subject-card">
            <i class="fa fa-pencil"></i>
            <h5>Synapse in Practice</h5>
            <hr>
            <span>Get ideas for how to use Synapse in your own research with a series of case studies.</span>
        </div>
        </a>
    </div>
    </ul>

<div class="tab-content">
    <div class="tab-pane active" id="intro">
        <!--Start intro content-->
        <h3>Introduction</h3>
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
        <h3>How To Articles</h3>
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
        <h3>Governance and Security</h3>
        <div class="row">
            {% for page in doclist %} {% if page.category == 'governance' %}
                <ul>
                    <li><b><a href="{{ page.url | relative_url}}">{{ page.title }}</a></b>: {{page.excerpt}}</li>
                    </ul>
            {% endif %} {% endfor %}
        </div>

    </div>
    <!--end governance content-->

    <div class="tab-pane active" id="apiclient">
        <!--Start api-client content-->
        <h3>API Clients</h3>
        <div class="row">
            {% for page in doclist %} {% if page.category == 'apiclient' %}
                <ul>
                    <li><b><a href="{{ page.url | relative_url}}">{{ page.title }}</a></b>: {{page.excerpt}}</li>
                    </ul>
                {% endif %} {% endfor %}
        </div>

    </div>

    </div>
    <!--<end intro content>-->

    <div class="tab-pane active" id="admin">
        <h3>In Practice</h3>
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
