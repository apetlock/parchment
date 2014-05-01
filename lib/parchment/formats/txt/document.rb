require 'parchment/document'
require_relative 'paragraph'
require_relative 'style'

module Parchment
  module TXT
    class Document < Parchment::Document

      def initialize(file)
        @text = file
        @styles = []
        set_paragraphs
      end

      private

        # These methods parse and add the Document's children and defaults.
        #
        def set_paragraphs
          set_default_paragraph_style
          # double quotes matter here
          @paragraphs = @text.gsub("\r", '').split("\n").map { |line| Parchment::TXT::Paragraph.new(line, self) }
        end

        def set_default_paragraph_style
          @default_paragraph_style = Parchment::TXT::Style.new
        end
    end
  end
end
