require 'parchment'
require_relative 'sample_document_shared'

describe Parchment::DOCX::Document do
  before(:all) do
    @fixtures_path = 'spec/fixtures'
    @file_name = 'sample.docx'
    @file_path = File.join(@fixtures_path, @file_name)
    @document = Parchment.read(@file_path)
    @sample_line_count = 12
    @sample_style_count = 4
    @sample_default_font_size = 11
  end

  describe 'reading' do
    it_behaves_like 'sample document reading'
    it_behaves_like 'sample document formatting'
  end
end
