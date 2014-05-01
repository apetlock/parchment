require 'nokogiri'
require 'parchment/paragraph'
require 'parchment/style'

module Parchment

  # = Primary Document class.
  #
  # A Document is the primary "container" for everything necessary to format
  # and display its contents. Holds Paragraph and Style objects.
  #
  class Document

    # (Array) All the Styles that belong to the Document that other objects
    # (i.e. Paragraphs, TextRuns) can reference and apply.
    attr_reader :styles

    # (Array) Paragraph objects that belong to the Document.
    attr_reader :paragraphs

    # (Style) A Style referenced when style attributes on the child are
    # not available.
    attr_reader :default_paragraph_style

    # content_file:: (File) The primary content file of the document.
    # styles_file:: (File) The styles file from the document.
    #
    def initialize(content_file, styles_file)
      @content_xml = Nokogiri::XML(content_file)
      @styles_xml = Nokogiri::XML(styles_file)
      set_styles
      set_paragraphs
    end

    # Returns the Style based on the +id+ given.
    #
    # The XML document formats in particular store their styles in elements
    # with unique identifiers. OpenOffice uses these extensively, relying
    # on them to specify formatting for the text. DOCX, not so much, but
    # it does have user-defined styles.
    #
    #--
    # DOCX styles are not implemented yet.
    #++
    #
    # id:: (String) The unique identifier of the Style.
    #
    def get_style_by_id(id)
      styles.select { |style| id == style.id }.first
    end

    # Output entire document as a HTML fragment String.
    #
    def to_html
      paragraphs.map(&:to_html).join("\n")
    end

    private

      # These methods add the Document's children and default settings.
      #
      # These methods should be defined in the appropriate class in the
      # formatter module. i.e. Parchment::ODT::Document will have these.
      #
      def set_paragraphs
        raise MissingFormatterMethodError
      end

      def set_styles
        raise MissingFormatterMethodError
      end

      def set_default_paragraph_style
        raise MissingFormatterMethodError
      end
  end
end
