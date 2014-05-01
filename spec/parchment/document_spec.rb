require 'parchment'

describe Parchment::Document do
  before(:all) do
    @fixtures_path = 'spec/fixtures'
    @file_name = 'sample.odt'
    @file_path = File.join(@fixtures_path, @file_name)
    @sample_odt_line_count = 12
  end  

  describe "outputting" do
    before do
      @document = Parchment.read(@file_path)
    end

    describe "to html" do
      it 'should output an entire document as html fragment' do
        @document.to_html.scan(/(\<p)/).flatten.size.should eq @sample_odt_line_count
      end
    end
  end
end