require 'parchment'
require_relative 'sample_document_shared'

describe Parchment::ODT::Document do
  before(:all) do
    @fixtures_path = 'spec/fixtures'
    @file_name = 'sample.odt'
    @file_path = File.join(@fixtures_path, @file_name)
    @document = Parchment.read(@file_path)
    @sample_line_count = 12
    @sample_style_count = 14
    @sample_default_font_size = 12
  end

  describe 'reading' do
    it_behaves_like 'sample document'

    it 'styles should have formatting attributes' do
      @styles = @document.styles
      @styles[0].paragraph?.should be_true
      @styles[0].text?.should be_false
      @styles[0].aligned_left?.should be_true
      @styles[1].aligned_center?.should be_true
      @styles[2].aligned_right?.should be_true
      @styles[3].bold?.should be_true
      @styles[4].italic?.should be_true
      @styles[5].underline?.should be_true
      @styles[7].font_size.should eq 24
      @styles[9].paragraph?.should be_false
      @styles[9].text?.should be_true
      @styles[9].bold?.should be_true
      @styles[9].italic?.should be_false
      @styles[10].bold?.should be_false
      @styles[10].italic?.should be_true
      @styles[11].bold?.should be_true
      @styles[11].italic?.should be_true
      @styles[11].underline?.should be_true
      @styles[13].font_size.should eq 18
    end
  end
end
