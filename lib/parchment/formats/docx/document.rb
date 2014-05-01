require 'parchment/document'
require_relative 'paragraph'
require_relative 'style'

module Parchment
  module DOCX
    class Document < Parchment::Document

      private

        # These methods parse and add the Document's children and defaults.
        #
        def set_paragraphs
          set_default_paragraph_style
          paragraph_nodes = @content_xml.xpath('.//w:document//w:body//w:p')
          @paragraphs = paragraph_nodes.map { |node| Parchment::DOCX::Paragraph.new(node, self) }
        end

        def set_styles
          style_nodes = @styles_xml.xpath('.//w:style')
          @styles = style_nodes.map { |node| Parchment::DOCX::Style.new_from_node(node) }
        end

        def set_default_paragraph_style
          doc_style_node = @styles_xml.xpath('.//w:docDefaults').first
          @default_paragraph_style = Parchment::DOCX::Style.new_default_style(doc_style_node)
        end
    end
  end
end
