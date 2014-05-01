module Parchment
  module TXT
    class TextRun < Parchment::TextRun

      def initialize(line, paragraph, document)
        @content = @node = line # superclass expects @node, so we give it @node
        @style = paragraph.style
      end
    end
  end
end
