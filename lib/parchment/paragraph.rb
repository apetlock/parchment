require 'parchment/style'
require 'parchment/text_run'
require 'parchment/helpers'

module Parchment

  # A Paragraph holds several TextRun objects and default formatting for them.
  #
  class Paragraph
    include Parchment::Helpers

    # (Style) The primary Style for the Paragraph.
    attr_reader :style

    # (Array) All the TextRun children that the Paragraph has.
    attr_reader :text_runs

    # (Integer) It's what it sounds like.
    attr_reader :default_font_size

    # This does not accept any arguments because the primary work
    # for this is done in the formatter's subclass.
    #
    def initialize
      raise MissingFormatterMethodError unless @node
      @default_font_size = @document.default_paragraph_style.font_size
      set_text_runs
    end

    # The font size of the Paragraph. Will return the Document's default
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

    # Output the unformatted Paragraph's content as a String.
    #
    def to_s
      @node.content
    end
    alias :text :to_s

    # Return a HTML element String with formatting based on the Paragraph's
    # properties.
    #
    def to_html
      html = ''
      text_runs.each { |text_run| html << text_run.to_html }
      styles = { 'font-size' => "#{font_size}pt" }
      styles['text-align'] = @style.text_align unless @style.aligned_left?
      html_tag(:p, content: html, styles: styles)
    end

    private

      # Parses and creates the TextRun objects that belong to the Paragraph.
      #
      # *This needs to be defined in the formatter's Paragraph class.*
      #
      def set_text_runs
        raise MissingFormatterMethodError
      end
  end
end
