require 'parchment/style'

module Parchment
  module DOCX
    class Style < Parchment::Style

      #--
      # I don't like particularly how this is set up, but the OfficeOpen
      # format has styles split up between a global docDefaults and separate
      # styles which relate to the ones set up in word. Unlike ODT, all
      # the styles are set on paragraphs and runs individually, rather than
      # referring to an embedded style. But, we still want a style Object,
      # so there's two creation methods here.
      #++
      def initialize
      end

      # Creates a new Style from the XML w:style element passed in.
      #
      def self.new_from_node(node)
        style = self.new
        @node = node
        instance_variable_set('@family',@node.attributes['type'].value)
        instance_variable_set('@id', @node.attributes['styleId'].value)
        return style
      end

      # The OfficeOpen format has a spcific docDefaults block which
      # describes the globals for the document. This creates a Style
      # Object from that element.
      #
      def self.new_default_style(node)
        style = self.new

        # Right now, only concerned about document global font size.
        #
        # OfficeOpen specifications store the font size as half-points. Meaning if
        # something is at 12 points, it will be 24. We want actual full-point size.
        #
        font_size_tag = node.xpath('//w:docDefaults//w:rPrDefault//w:rPr//w:sz').first
        font_size = font_size_tag ? font_size_tag.attributes['val'].value.to_i / 2 : nil

        style.instance_variable_set('@font_size', font_size)
        return style
      end
    end
  end
end
