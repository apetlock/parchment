require 'zip'
require_relative 'document'

module Parchment

  # = Parchment OfficeOpen (.docx) format parser
  #
  module DOCX

    def self.read(path)
      zip = Zip::File.open(path)
      document_file = zip.read('word/document.xml')
      styles_file = zip.read('word/styles.xml')
      Parchment::DOCX::Document.new(document_file, styles_file)
    end
  end
end
