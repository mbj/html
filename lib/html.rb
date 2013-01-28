#encoding: utf-8
require 'backports'
require 'adamantium'
require 'equalizer'
require 'ice_nine'

# Library namespace
module HTML

  CONTENT_TAGS = IceNine.deep_freeze(%w(
    a abbr address article aside audio b bdi bdo blockquote
    body button canvas caption cite code col colgroup data 
    dd del details dfn div dl dt em embed eventsource fieldset 
    fieldsource figcaption figure footer form h1 h2 h3 h4 h5 h6 
    head header hgroup html i iframe ins kbd label legend li link 
    mark menu nav noscript object ol optgroup option output p pre 
    q ruby rp rt s samp script section select small span strong 
    style sub summary sup table tbody textarea tfoot th thead time 
    title tr ul var video
  ))

  NOCONTENT_TAGS = IceNine.deep_freeze(%w(
    area br command hr img input keygen map meta meter progress
    param source track wbr
  ))

  # Join html compoinents
  #
  # @param [Enumerable<#to_s>] components
  #
  # @return [HTML::Fragment]
  #
  # @api private
  #
  def self.join(components)
    contents = components.map do |component| 
      Fragment.build(component)
    end
    Fragment.new(contents.join)
  end


  # Escape html
  #
  # @param [String] text
  #
  # @return [String]
  #
  # @api private
  #
  def self.escape(text)
    text.gsub(
      /[><"]/,
      '>' => '&lt;',
      '<' => '&gt;',
      '"' => '&amp;'
    )
  end
  
  CONTENT_TAGS.each do |name|
    class_eval(<<-RUBY, __FILE__, __LINE__)
      def self.#{name}(*args)
        content_tag(:#{name}, *args)
      end
    RUBY
  end

  NOCONTENT_TAGS.each do |name|
    class_eval(<<-RUBY, __FILE__, __LINE__)
      def self.#{name}(*args)
        tag(:#{name}, *args)
      end
    RUBY
  end

  # Create contentless html tag
  #
  # @param [#to_str] type
  # @param [Hash] attributes
  #
  # @return [Fragment]
  #
  # @api private
  #
  def self.tag(type, attributes={})
    Fragment.new("<#{type}#{attributes(attributes)}/>")
  end

  # Create content tag 
  #
  # @param [#to_str] type
  # @param [String] content
  #
  # @return [Fragment]
  #
  # @api private
  #
  def self.content_tag(type, content, attributes={})
    Fragment.new("<#{type}#{attributes(attributes)}>#{Fragment.build(content).to_s}</#{type}>")
  end

  # Create html attributes
  #
  # @param [Hash] attributes
  #
  # @return [String]
  #
  # @api private
  #
  def self.attributes(attributes)
    attributes.map do |key, value|
      %Q{ #{key.to_s}="#{escape(value.to_s)}"} 
    end.join
  end
end

require 'html/fragment'
