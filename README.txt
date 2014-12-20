= js-rails-routes

https://github.com/kirkbowers/js-rails-routes

== Description

+js-rails-routes+ is a utility for generating javascript equivalents to the +[route]_path+
functions provided by {Ruby on Rails}(https://github.com/rails/rails).  This allows you
to do very similar things in your +ejs+ javascript templates as you would in your +erb+
ruby templates.  You can move html rendering to the client and keep it looking very 
similar to how it would look on the server.

For example, if you have a model +Item+ and a simple route to list all the items, a link
to that items page (using an explicit +a+ anchor tag instead of the Rails +link_to+)
would look the same in either a +erb+ file or a +ejs+ file:

    <a href="<%= index_path() %>">List all Items</a>


== Usage

To use +js-rails-routes+, first install it:

    [sudo] gem install js-rails-routes
    
=== Command Line
    
Most likely you will want to run it on the command line, like so:

    js-rails-routes
  
which will dump the generated javascript to stdout.  Or, if you are in the base directory
of a Ruby on Rails project that already has a directory +app/assets/javascripts+ 
defined, you can run:

    js-rails-routes --output
    
This will produce (*clobber*) the file +app/assets/javascripts/routes.js+.
    
You will then want to make sure the asset pipeline picks up the routes file.  Inside 
your +application.js+:

    //= require routes
    
    
=== Inside of Ruby
    
You can use it inside of a Ruby program by passing a +String+ to the initializer of the 
+js-rails-routes::Routes+ object and calling +create_javascript+:

    require 'js-rails-routes'

    result = js-rails-routes::Routes.new(text).create_javascript
    
== Using the Resulting JavaScript

In all the examples below, I assume using the client-side framework 
MVCoffee(https://github.com/kirkbowers/mvcoffee).  For one, it provides client-side
models that closely mirror Rails models.  For two, it provides the Rails-style 
+link_to+ helper function for creating anchor links.

=== Simple Routes with no Parameters

The simplest case is a route that does not depend on a parameter.  Suppose we have this
simple route:

    items              /items
    
In your javascript +ejs+ template, you can do this:

    <%= link_to("Show all items", items_path()) %>
    
=== Route with one Parameter

Frequently a route depends on the id of a model, either to display that one entity or to
edit it.  For example, given this route:

    edit_item          /item/
    
== Dependencies

+js-rails-routes+ depends on {Ruby on Rails}[https://github.com/rails/rails].

It also depends on by hoe[https://github.com/seattlerb/hoe] and
shoulda[https://github.com/thoughtbot/shoulda] for development and testing.

== Developers/Contributing

After checking out the source, run:

    rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

This first pass is very ad-hoc.  I make no claims that it exhaustively covers all 
possible Rails route formats.  If you 
find a shortcoming, by all means, feel free to upgrade it.  I welcome all contributions.

I do prefer that such shortcomings be documented first in the Issues.  I may be working on a fix already.  No sense in two people fixing the same thing....

== License

+js-rails-routes+ is released under the MIT license.  
