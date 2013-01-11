#encoding: utf-8
require 'adamantium'
require 'equalizer'
require 'ice_nine'

# Library namespace
module HTML

  CONTENT_TAGS = IceNine.deep_freeze(%w(
    a abbr address article aside audio b bdi bdo blockquote
    body button canvas caption cite code col colgroup data 
    dd del details dfn dov dl dt em embed eventsource fieldset 
    fieldsource figcaption figure footer form h1 h2 h3 h4 h5 h6 
    head header hgroup html i iframe ins kbd label legend li link 
    mark menu nav noscript object ol optgroup option output p pre 
    q ruby rp rt s samp script section select small span strong 
    style sub summary sup table tbody textarea tfoot th thead time 
    title tr var video
  ))

  NOCONTENT_TAGS = IceNine.deep_freeze(%w(
    area br command hr img input keygen map meta meter progress
    param source track wbr
  ))

  # An html fragment
  class Fragment
    include Adamantium::Flat, Equalizer.new(:content)

    # Return contents of fragment
    #
    # @return [String]
    #
    # @api private
    #
    attr_reader :content

    # Initialize object
    #
    # @param [String] string
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(string)
      @content = self.class.freezer.call(string)
    end

    # Return string 
    #
    # FIXME: This will be removed once I have my own templating language.
    #
    # @return [String]
    #
    alias_method :to_s, :content

    # Create new fragment
    #
    # @param [String,Fragment] input
    #  
    # @return [Fragment]
    #
    # @api private
    #   
    def self.build(input)
      unless input.kind_of?(self)
        new(HTML.escape(input))
      else
        input
      end
    end
  end

  # Join html compoinents
  #
  # @param [Enumerable<#to_s>] components
  #
  # @return [HTML::Fragment]
  #
  # @api private
  #
  def self.join(components)
    contents = components.map { |component| Fragment.build(component).to_s }
    Fragment.new(contents.join(''))
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
    text.to_s.gsub(
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
    return '' if attributes.empty?

    contents = attributes.map do |key, value|
      %Q{ #{key}="#{escape(value)}"} 
    end.join('')
  end
end
