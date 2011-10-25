require 'haml'
require 'tilt'

def template_render(template_filename, layout_filename = 'layouts/default.haml')
  
  # Probe for custom layout request
  File.open(template_filename, 'r') do |file|
    layout_filename = $1 if file.readline.match /^-### (.+)$/
  end
  
  
  # Actual rendering
  template = Tilt.new(template_filename)
  output = nil
  
  if template_filename.match(/\.haml$/) && !template_filename.match(/(\/|^)_(.+).haml$/)
    if File.exists? layout_filename
      layout = Tilt.new(layout_filename)
      output = layout.render(self) { template.render }
    end
  end
  
  if output.nil?
    output = template.render(self)
  end
  
  output
end
