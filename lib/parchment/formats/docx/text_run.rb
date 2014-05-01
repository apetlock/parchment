module Parchment
  module DOCX
    class TextRun < Parchment::TextRun

      def initialize(node, paragraph, document)
        @node = node
        set_style
        super(paragraph, document)
      end

      private

        # Because OfficeOpen puts all formatting on the individual
        # elements rather than refer to a defined style, they need
        # to be created from the element itself.
        #
        def set_style
          @style = Style.new

          size_node = @node.xpath('.//w:sz').first
          font_size = size_node ? size_node.attributes['val'].value.to_i / 2 : nil
          @style.instance_variable_set('@font_size', font_size)

          font_weight = @node.xpath('.//w:b').empty? ? 'normal' : 'bold'
          @style.instance_variable_set('@font_weight', font_weight)

          font_style = @node.xpath('.//w:i').empty? ? 'normal' : 'italic'
          @style.instance_variable_set('@font_style', font_style)

          underline_style = @node.xpath('.//w:u').empty? ? nil : 'solid'
          @style.instance_variable_set('@text_underline_style', underline_style)
        end
    end
  end
end
