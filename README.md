# Synapse Documentation

This is a documentation site for [Synapse](https://www.synapse.org). Synapse is an open source software platform that data
scientists use to carry out, track, and communicate their research in real time.

## How to contribute

Synapse Docs is generated using [Jekyll](https://jekyllrb.com/) and uses redcarpet to render Markdown. Various page layouts can be found under the _layouts folder in the home directory. Most everything can be written using standard [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet). 

### Creating a page

To create a page using the article layout, start by specifying at the very beginning the title, layout, and excerpt in the YAML front matter. Note that the front matter needs to be enclosed between three dashed lines to work properly.:

```
---
title: Name of page here
layout: article
excerpt: A blurb about this page that will show up as a description in the user guide.
---
```

### Content
Article content should begin with a short summary describing what the page is about. Each header on the page will be rendered on the sidebar menu as well for easier navigation.

### Code blocks with multiple languages

You can use Liquid tags to show a code example in multiple languages. Follow the format below for as many languages as you'd like, ensuring that the languages are in alphabetical order.
```
{% tabs %}

  {% tab Command %}
    {% highlight bash %}
    some code here
    {% endhighlight %}
  {% endtab %}


  {% tab Python %}
    {% highlight python %}
    more code here
    {% endhighlight %}
  {% endtab %}

  {% tab R %}
    {% highlight r %}
    add code here
    {% endhighlight %}
  {% endtab %}

  {% tab Web %}
    Instructions for Web + screenshots
  {% endtab %}

{% endtabs %}
```

### Using alert tags

There are four types of alert highlighting to inform users: note, tip, warning, and important. You can insert an alert by using any of the following code in a markdown file. 
```
{% include note.html content="This is a note." %}

{% include tip.html content="This is a tip." %}
```
To include new paragraphs, just add the `<br/>` tag within the content, like this:
```
{% include warning.html content="This is a warning. `<br/>` This is the second line of the warning." %}

{% include important.html content="This is for an important message." %}
```

### Adding a table
To add a table, use Liquid to call on the markdown-table css class. Then use the standard markdown table format.
```
{:.markdown-table}
| Header 1 | Header 2 | 
| --- | --- |
| content | content |
| content | content |
```

### Inserting an image
Images can be inserted using either Markdown or HTML, it all depends on your preference. The examples below will display the same thing:
```
![alt text](/assets/images/image1.jpg)
<img src="/assets/images/image1.jpg" alt="alt text">
```
### To commit changes 

To avoid a lint error when committing, use:

    git commit --no-verify -m "some message here"

## Install Dependencies

With Bundler:

    bundle install 
    npm install

### How to run a development server

    bundle exec jekyll serve

then navigate to [localhost:4000](http://localhost:4000)

### How to regenerate the site

    ./bin/jekyll build

## License 

Distributed under the Eclipse Public License, the same as Clojure.

