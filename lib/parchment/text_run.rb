require 'parchment/helpers'

module Parchment

  # A "run" of text within a Paragraph. Each run may have its own style
  # attributes different from that of the Paragraph. These are iterated
  # through to generate a line of formatted output.
  #
  class TextRun
    include Parchment::Helpers

    # (Style) The primary Style for the TextRun.
    attr_reader :style

    def initialize(paragraph, document)
      raise MissingFormatterMethodError unless @node
      @content = @node.content
      @default_font_size = paragraph.font_size
    end

    # The font size of the TextRun. Will return the Paragraph's default
    # font size if not defined.
    #
    def font_size
      @style.font_size || @default_font_size
    end

    # This is a method constructor which creates Boolean methods (e.g. bold?,
    # italic?) based on the available formatting options defined in Style.
    #
    Parchment::Style::AVAILABLE_FORMATTING.each do |styling|
      define_method("#{styling}?") { style.public_send("#{styling}?") }
    end

    # Output the unformatted TextRun's content as a String.
    #
    def to_s
      @content
    end
    alias :text :to_s

    # Return a HTML element String with formatting based on the TextRun's
    # properties.
    #
    def to_html
      html = @content
      html = html_tag(:em, content: html) if italic?
      html = html_tag(:strong, content: html) if bold?
      styles = {}
      styles['text-decoration'] = 'underline' if underline?
      # No need to be granular with font size down to the span level if it doesn't vary.
      styles['font-size'] = "#{font_size}pt" if font_size != @default_font_size
      html = html_tag(:span, content: html, styles: styles) unless styles.empty?
      return html
    end
  end
end
