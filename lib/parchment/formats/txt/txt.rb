require 'zip'
require_relative 'document'

module Parchment

  # = Parchment plain text format parser
  #
  module TXT
    def self.read(path)
      Parchment::TXT::Document.new(File.read(path))
    end
  end
end
