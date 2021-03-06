MetaOnRails
===========
MetaOnRails DRYs up your page meta tags.  
It is a very simple Rails plugin to help you customize your pages' meta tags a little bit easier.

Install
=======
    script/plugin install git://github.com/ashchan/meta_on_rails.git

Example
=======
Add the following code to the layout (e.g. `app/views/layout/application.html.erb`), be sure to put it in the head tag:

    <head>
      <%= display_meta(:keywords => "default,keywords", :description => "default description") %>
    </head>

Default meta values can be set. In the above example, these two meta tags will be generated if they're not overridden on the views:

    <meta name="description" content="default description" />
    <meta name="keywords" content="default,keywords" />

Then add this code to the view to set meta tags on that page:

    <% set_meta(:keywords => 'my,keyword', :generator => 'a bad <script /> generator') %>

The output html will be like this:

    <meta name="generator" content="a bad  generator" />
    <meta name="description" content="default description" />
    <meta name="keywords" content="my,keyword" />

Bugs?
=====
[Lighthouse](http://ashchan.lighthouseapp.com/projects/13347-meta-on-rails/overview)

Author
======
Copyright (c) 2008 James Chan (ashchan), released under the MIT license