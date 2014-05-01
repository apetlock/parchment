require 'zip'
require_relative 'document'

module Parchment

  # = Parchment OpenOffice (.odt) format parser
  #
  module ODT

    def self.read(path)
      zip = Zip::File.open(path)
      document_file = zip.read('content.xml')
      styles_file = zip.read('styles.xml')
      Parchment::ODT::Document.new(document_file, styles_file)
    end
  end
end
