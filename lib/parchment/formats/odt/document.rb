require 'parchment/document'
require_relative 'paragraph'
require_relative 'style'

module Parchment
  module ODT
    class Document < Parchment::Document

      private

        # These methods parse and add the Document's children and defaults.
        #
        def set_paragraphs
          set_default_paragraph_style
          paragraph_nodes = @content_xml.xpath('.//office:body/office:text/text:p')
          @paragraphs = paragraph_nodes.map { |node| Parchment::ODT::Paragraph.new(node, self) }
        end

        def set_styles
          style_nodes = @content_xml.xpath('.//office:automatic-styles/style:style')
          @styles = style_nodes.map { |node| Parchment::ODT::Style.new(node) }
        end

        def set_default_paragraph_style
          style_nodes = @styles_xml.xpath('.//office:styles/style:default-style').select do |style|
            style.attributes['family'].value == 'paragraph'
          end
          @default_paragraph_style = Parchment::ODT::Style.new(style_nodes.first)
        end
    end
  end
end
