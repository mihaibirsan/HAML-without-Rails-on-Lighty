require 'rubygems'
require 'fileutils'
require "common.rb"
require "helpers.rb"

EXPORT_DIR = ".export"

FileUtils.rm_rf EXPORT_DIR

Dir.glob("**/*").each do |filename|
  
  # Skipping some files
  next if filename.match(/^layouts\//)                # Skipping the layouts directory
  next if filename.match(/\.(rb|log)$/)               # Skipping script files and logs
  next if filename.match(/development\.(bat|conf)$/)  # Skipping configuration files
  
  # Making the required directories, if they don't exist
  FileUtils.makedirs "#{EXPORT_DIR}/#{File.dirname(filename)}"
  
  # Parsing all HAML files
  if filename.match(/(?:^|\/)([^_].*?)\.haml$/)
    File.open("#{EXPORT_DIR}/#{filename.sub(/\.haml$/, '.html')}", 'w') do |file|
      file.write(template_render(filename))
    end
    
  # Skip HAML partials
  elsif filename.match(/\.haml$/)
    
  # Copy all other files
  else
    FileUtils.copy(filename, "#{EXPORT_DIR}/#{filename}") unless File.directory? filename
    
  end
end
