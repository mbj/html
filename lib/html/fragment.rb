module HTML

  # An html fragment
  class Fragment
    include Adamantium, Equalizer.new(:content)

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
      @content = string
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
      if input.kind_of?(self)
        input
      else
        new(HTML.escape(input))
      end
    end

    EMPTY = new('')
  end

end
