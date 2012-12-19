#encoding: utf-8
require 'adamantium'
require 'equalizer'
require 'ice_nine'
require 'ice_nine/core_ext/object'

# Library namespace
module HTML

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
    # @param [String,Fragment] 
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

  CONTENT_TAGS = %w(
    a ul ol form fieldset table tr td tbody li div label 
    select option textarea
  ).deep_freeze
  
  CONTENT_TAGS.each do |name|
    class_eval(<<-RUBY, __FILE__, __LINE__)
      def self.#{name}(*args)
        content_tag(:#{name}, *args)
      end
    RUBY
  end

  %w(input img).each do |name|
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
