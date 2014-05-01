require 'parchment/paragraph'
require_relative 'style'
require_relative 'text_run'

module Parchment
  module DOCX
    class Paragraph < Parchment::Paragraph

      def initialize(node, document)
        @node = node
        @style_id = nil
        @document = document
        set_style
        super()
      end

      private

        # Because OfficeOpen puts all formatting on the individual
        # elements rather than refer to a defined style, they need
        # to be created from the element itself.
        #
        def set_style
          @style = Style.new

          alignment_node = @node.xpath('.//w:jc').first
          alignment = alignment_node ? alignment_node.attributes['val'].value : nil
          @style.instance_variable_set('@text_align', alignment.to_sym) if alignment

          size_node = @node.xpath('w:pPr//w:sz').first
          font_size = size_node ? size_node.attributes['val'].value.to_i / 2 : nil
          @style.instance_variable_set('@font_size', font_size)

          bold_node = @node.xpath('w:pPr//w:b').first
          @style.instance_variable_set('@font_weight', 'bold') if bold_node

          italic_node = @node.xpath('w:pPr//w:i').first
          @style.instance_variable_set('@font_style', 'italic') if italic_node

          underline_node = @node.xpath('w:pPr//w:u').first
          @style.instance_variable_set('@text_underline_style', 'solid') if underline_node
        end

        def set_text_runs
          @text_runs = @node.xpath('.//w:r').map do |child|
            Parchment::DOCX::TextRun.new(child, self, @document)
          end
        end
    end
  end
end
