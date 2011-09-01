require 'rubygems'
require 'cgi'
require 'haml'
require 'tilt'

cgi = CGI.new

# Helpers
def render(options)
  template = Tilt.new(options[:partial].gsub(/([^\/]+)$/, "_\\1.haml"))
  template.render(self, options[:locals])
end


# Probe for custom layout request
template_filename = cgi.params['file'].first
layout_filename = 'layouts/default.haml'
File.open(template_filename, 'r') do |file|
  layout_filename = $1 if file.readline.match /^-### (.+)$/
end


# Actual rendering
template = Tilt.new(template_filename)
output = nil

if template_filename.match(/\.haml$/) && !template_filename.match(/(\/|^)_(.+).haml$/)
  begin
    layout = Tilt.new(layout_filename)
    output = layout.render(self) { template.render }
  rescue
  end
end

if output.nil?
  output = template.render(self)
end

cgi.out { output }
