require 'rubygems'
require 'cgi'

cgi = CGI.new

begin

  s = ""
  
  Dir.glob("**/*").each do |filename|
    if !filename.match(/^layouts\//) && filename.match(/(?:^|\/)([^_].*?)\.haml$/)
      url = filename.sub(/(?:^|\/)index.haml$/, '/').sub(/\.haml$/, '')
      s << "<a href='#{url}'>#{filename}</a><br />"
    end
  end
  
  cgi.out { s }

rescue => e
  
  cgi.out { "<pre>#{e.message}\n#{e.backtrace.join("\n")}</pre>" }

end
