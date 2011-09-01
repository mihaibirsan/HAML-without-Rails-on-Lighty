This is the basic setup to start developing front-end templates using HAML. 
This setup is designed for a Windows machine with Ruby and Lighttpd binaries 
installed, plus a bunch of Ruby gems.


Getting started
---------------

First off, make sure that development.bat points to where you've installed 
Lighty and adjust accordingly. Then run development.bat, start your browser and 
point it to http://localhost/.


Features
--------

The whole idea behind this setup is to keep things simple so as to get 
development started without too much hassle. You can use any of the HAML 
features, provided you have the necessary gems. For example, if you want to use 
the `:textile` feature, you need the gem RedCloth.

### Accessing templates

The web server is configured to try and parse which ever URL that does not 
resolve to a file on the disk. The root URL tries to render `index.haml`. Any 
other URL of the form `path/to/foo` will try to render `path/to/foo.haml`. The 
server is not configured to handle any other types of requests.

### Rendering partials

You can render partials using a Rails-like method: 
`= render :partial => 'path/to/file', :locals => { :foo => "value" }`
and that will render the file `path/to/_file.haml` with the local variable `foo`.

### Layouts

By default, the script will try to use a Rails-like layout system and render
the file `layouts/default.haml`. If that file does not exist, the script will 
render no layout.

You can override the default layout using a HAML comment on the first line of
the template you're rendering, as follows: `-### layouts/other.haml`. The syntax
is `-###` followed by a space and the path to the other layout.


Known shortcomings
------------------

TODO:

* Create one or more branches for bootstraps
* When accessing `/path/to/` the file `/path/to/index.haml` should be tried
* The server should return a 404 when the target HAML file does not exist
* The current partials method requires passing the :locals option, which should 
be optional instead

README TODO:

* Add information about obtaining Lighttpd
* Add information about obtaining Ruby
* List required and recommended gems
