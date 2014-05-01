require 'parchment/paragraph'
require_relative 'style'
require_relative 'text_run'

module Parchment
  module TXT
    class Paragraph < Parchment::Paragraph

      def initialize(line, document)
        @node = line # superlass is expecting @node, so we give it @node
        @document = document
        @style = @document.default_paragraph_style
        super()
      end

      private

        def set_text_runs
          @text_runs = [Parchment::TXT::TextRun.new(@node, self, @document)]
        end
    end
  end
end
