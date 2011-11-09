require 'haml'
require 'yaml'
require 'tilt'

class Data
  def self.method_missing(sym, *args, &block)
    return Data.parse(sym) if Data.exists?(sym)
    super(sym, *args, &block)
  end
  
private
  def self.exists?(sym)
    Data.class_variable_defined?("@@#{sym}".to_sym) || File.exists?("data/#{sym}.yml")
  end
  def self.parse(sym)
    return Data.class_eval("@@#{sym}") if Data.class_variable_defined?("@@#{sym}".to_sym)
    data = YAML.load_file("data/#{sym}.yml")
    Data.class_eval("@@#{sym} = #{data.inspect}")
    data
  end
end

$context = nil

def section(name = nil, &block)
  if $context == name
    yield
  end
end

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
      output = layout.render(self) { |*args| $context = args[0]; template.render }
    end
  end
  
  if output.nil?
    output = template.render(self)
  end
  
  output
end
