#! /bin/bash

# I'm sure there is a way to do this in Rake-land, but it isn't obvious to me.
# This gets the job so I can move on.  Maybe I'll come back to this someday...

coffee -b -c coffee/link_to.coffee 

cp coffee/link_to.js lib/js-rails-routes/js/
