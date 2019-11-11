---
title: Synapse in Practice
layout: default
---

<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">

<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.matchHeight/0.7.0/jquery.matchHeight-min.js"></script>

<script>
    $(function() {
        $('.thumbnail').matchHeight();
    });

    $(function() {
        $('a[title]').tooltip();
    });
</script>

<style>
    .glyphicon {
        line-height: 1.6;
    }
</style>

<div class="container">
<div class="row">
    <h1 style="text-align: center">Synapse In Practice</h1>
    <hr>
    {% assign sorted_pages = site.pages | sort:"order" %}
    {% for page in sorted_pages %}
    {% if page.category == 'inpractice' %}
    <div class="col-xs-12 col-sm-6 col-md-6">
        <div class="thumbnail"
             style="border-left: 5px solid #B1C6FA;
                                     border-right: 1px solid #B1C6FA; border-bottom: 1px solid #B1C6FA;">
            <div class="card-header" style="height: 15px; background-color: #3F5EAB">
            </div>
            <div class="caption">
                <h5><b>{{ page.title }}</b></h5>
                <p>{{page.excerpt}}</p>
                <a href="{{ page.url | relative_url }}" class="btn btn-default btn-sm" role="button">Learn More</a>
            </div>

        </div>
    </div>

    {% endif %}
    {% endfor %}
</div>
</div>