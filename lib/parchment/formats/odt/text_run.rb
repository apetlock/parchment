module Parchment
  module ODT
    class TextRun < Parchment::TextRun

      def initialize(node, paragraph, document)
        @node = node
        if @node.attributes.empty?
          @style = paragraph.style
        else
          @style_id = @node.attributes['style-name'].value
          @style = document.get_style_by_id(@style_id)
        end
        super(paragraph, document)
      end

    end
  end
end
