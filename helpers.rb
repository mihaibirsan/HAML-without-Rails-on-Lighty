# render
def render(options)
  options = { :locals => {} }.merge(options)
  template = nil
  if !options[:partial].nil?
    template = Tilt.new(options[:partial].gsub(/([^\/]+)$/, "_\\1.haml"))
  else
    template = Tilt.new(options[:action].gsub(/([^\/]+)$/, "\\1.haml"))
  end
  template.render(self, options[:locals])
end

# nav_menu
def nav_menu(array, options = {})
  options = {
    :ul_class => 'menu',
    :sub_menu_ul_class => 'sub-menu',
    :li_class => 'menu-item',
    :li_selected_class => 'current-menu-item'
  }.merge(options)
  haml_tag :ul, :class => options[:ul_class] do
    array.each do |item|
      klass_attr = [ options[:li_class] ]
      klass_attr << options[:li_selected_class] if item[:current] === true
      klass_attr << item[:li_class] unless item[:li_class].nil?
      haml_tag :li, :class => klass_attr.join(' ')  do
        haml_tag :a, item[:title], :href => item[:href]
        haml_concat item[:after_a] if item[:after_a]
        unless item[:sub].nil?
          nav_menu(item[:sub], options.merge({ :ul_class => options[:sub_menu_ul_class] }))
        end
      end
    end
  end
end

# Custom form helpers
def basic_help
  haml_concat '<div class="help-message">Nunc luctus auctor odio, quis vulputate nisi tincidunt et. Morbi urna massa, sollicitudin hendrerit tristique quis, sollicitudin ut augue. Integer vestibulum congue mattis. Cras molestie elit eget justo auctor lobortis.</div>'
end

def text_field(id, label, options = {})
  capture_haml do
    haml_tag 'div.input', :class => options[:class] do
      haml_tag :label, label, :for => id unless label == ''
      haml_tag :input, :id => id, :type => 'text', :value => options[:value]
      basic_help if options[:default_help]
      yield if block_given?
    end
  end
end

def select_field(id, label, options = {})
  options = { 
    :choices => [ ['-select one', ''], 'Foo', 'Bar', 'Baz' ] 
  }.merge(options)
  
  capture_haml do
    haml_tag 'div.input', :class => options[:class] do
      haml_tag :label, label, :for => id unless label == ''
      haml_tag 'select', :id => id do
        options[:choices].each do |choice|
          if choice.is_a? Array
            haml_tag 'option', choice[0], :value => choice[1]
          else
            haml_tag 'option', choice.to_s
          end
        end
      end
      basic_help if options[:default_help]
      yield if block_given?
    end
  end
end

def radio_buttons(id, choices, options = {})
  capture_haml do
    haml_tag 'div.radio_buttons', :class => options[:class] do
      i = 0
      choices.each do |choice|
        haml_tag :label do
          haml_tag 'input', :type => 'radio', :name => id, :value => i.to_s, :checked => (i == options[:checked])
          haml_concat choice
        end
        i += 1
      end
      basic_help if options[:default_help]
      yield if block_given?
    end
  end
end

def check_box(id, label, options = {})
  capture_haml do
    haml_tag 'div.check_box', :class => options[:class] do
      haml_tag :label do
        haml_tag 'input', :type => 'checkbox', :name => id, :value => id, :checked => options[:checked]
        haml_concat label
      end
      basic_help if options[:default_help]
      yield if block_given?
    end
  end
end
