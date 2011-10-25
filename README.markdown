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

You can obtain a list of available templates in your browser by navigating to
http://localhost/! when the server is running. This invokes `list.rb`.

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

### Helpers

Various helper methods have been added to `helpers.rb`. This should be more of 
an ad-hoc file, modified to suit each project.

### Exporting HTML

The `export.rb` script will create a HTML version of the site and save it in the
`.export` directory, as follows: for each HAML file that is not a partial and is
not a layout, an HTML file is generated. Every other non-HAML file is copied as 
is.


Known shortcomings
------------------

TODO:

* Create one or more branches for bootstraps
* The server should return a 404 when the target HAML file does not exist
* Have the `!` at the end of a directory URL work for subdirectories as well 
* Have `export.rb` take a command line `--zip` to generate a zip file.
* Have `export.rb` also parse and convert LESS files. (This feature is currently
  broken because gem `therubyracer` doesn't compile on Windows.)
* Add examples of using the included helpers.

README TODO:

* Add information about obtaining Lighttpd
* Add information about obtaining Ruby
* List required and recommended gems
