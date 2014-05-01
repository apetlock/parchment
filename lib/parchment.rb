require 'parchment/document'
require 'parchment/formats/odt/odt'
require 'parchment/formats/docx/docx'

module Parchment

  # Reads +path+ and determines which format module to use for reading
  # the file.
  #
  def self.read(path)
    extension = path.split('.').last
    case extension
    when 'odt'
      Parchment::ODT.read(path)
    when 'docx'
      Parchment::DOCX.read(path)
    else
      raise UnsupportedFileFormatError, 'File format is not supported.'
    end
  end

  class UnsupportedFileFormatError < LoadError
  end

  class MissingFormatterMethodError < NotImplementedError
  end
end
