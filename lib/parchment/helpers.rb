module Parchment

  # Helper methods useful to multiple classes.
  #
  module Helpers

    # Wraps content in an HTML tag, returning the element.
    # Currently used in Paragraph and TextRun for the to_html methods
    #
    # name:: (String) The name of the HTML tag. (e.g. 'p', 'span')
    # options:: (Hash) Options that describe the element.
    #
    # ==== Options
    # +content:+ (String) The base text content for the tag.
    # 
    # +styles:+ (Hash) CSS styles and values to be applied. e.g.
    # { 'font-size' => '12pt', 'text-decoration' => 'underline' }
    #
    def html_tag(name, options = {})
      content = options[:content]
      styles = options[:styles]

      html = "<#{name.to_s}"
      unless styles.nil? || styles.empty?
        styles_array = []
        styles.each do |property, value|
          styles_array << "#{property.to_s}:#{value};"
        end
        html << " style=\"#{styles_array.join('')}\""
      end
      html << ">"
      html << content if content
      html << "</#{name.to_s}>"
    end
  end
end
