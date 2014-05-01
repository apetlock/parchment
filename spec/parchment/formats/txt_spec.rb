require 'parchment'
require_relative 'sample_document_shared'

describe Parchment::TXT::Document do
  before(:all) do
    @fixtures_path = 'spec/fixtures'
    @file_name = 'sample.txt'
    @file_path = File.join(@fixtures_path, @file_name)
    @document = Parchment.read(@file_path)
    @sample_line_count = 12
    @sample_style_count = 0
    @sample_default_font_size = nil
  end

  describe 'reading' do
    it_behaves_like 'sample document reading'
  end

  describe 'outputting' do
    describe 'HTML' do
      before do
        @p_regex = /(^\<p).+((?<=\>)\w+)(\<\/p>$)/
      end

      it 'should wrap pragraphs in a p tag' do
        scan = @document.paragraphs[1].to_html.scan(@p_regex).flatten
        scan.first.should eq '<p'
        scan.last.should eq '</p>'
        scan[1].should eq 'Normal'
      end
    end
  end
end
