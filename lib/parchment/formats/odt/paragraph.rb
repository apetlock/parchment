require 'parchment/paragraph'
require_relative 'style'
require_relative 'text_run'

module Parchment
  module ODT
    class Paragraph < Parchment::Paragraph

      def initialize(node, document)
        @node = node
        @style_id = @node.attributes['style-name'].value
        @document = document
        @style = @document.get_style_by_id(@style_id)
        super()
      end

      private

        def set_text_runs
          @text_runs = @node.children.map do |child|
            Parchment::ODT::TextRun.new(child, self, @document)
          end
        end
    end
  end
end
