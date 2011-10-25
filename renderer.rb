require 'rubygems'
require 'cgi'

cgi = CGI.new

begin
  
  require "common.rb"
  require "helpers.rb"

  File.open('renderer.access.log', 'a') do |file|
    file.puts cgi.params.inspect
  end
  
  cgi.out { template_render(cgi.params['file'].first) }

rescue => e
  
  File.open('renderer.error.log', 'a') do |file|
    file.puts e.message
    file.puts e.backtrace
    file.puts "\n\n"
  end
  
  cgi.out { "<pre>#{e.message}\n#{e.backtrace.join("\n")}</pre>" }

end
