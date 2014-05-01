require 'parchment'

describe Parchment::Paragraph do
  before(:all) do
    @fixtures_path = 'spec/fixtures'
    @file_name = 'sample.odt'
    @file_path = File.join(@fixtures_path, @file_name)
    @document = Parchment.read(@file_path)
  end  

  describe 'outputting' do
    describe 'HTML' do
      before do
        @p_regex = /(^\<p).+((?<=\>)\w+)(\<\/p>$)/
        @span_regex = /(\<span).+((?<=\>)\w+)(<\/span>)/
        @em_regex = /(\<em).+((?<=\>)\w+)(\<\/em\>)/
        @strong_regex = /(\<strong).+((?<=\>)\w+)(\<\/strong\>)/
        @span_style_regex = /(\<span)[^\>]+style\=\"([^\"]+)[^\<]+(<\/span>)/
      end

      it 'should wrap pragraphs in a p tag' do
        scan = @document.paragraphs[1].to_html.scan(@p_regex).flatten
        scan.first.should eq '<p'
        scan.last.should eq '</p>'
        scan[1].should eq 'Normal'
      end

      it 'should strong bold text' do
        scan = @document.paragraphs[2].to_html.scan(@strong_regex).flatten
        scan.first.should eq '<strong'
        scan.last.should eq '</strong>'
        scan[1].should eq 'Bold'
      end

      it 'should emphasize italic text' do
        scan = @document.paragraphs[3].to_html.scan(@em_regex).flatten
        scan.first.should eq '<em'
        scan.last.should eq '</em>'
        scan[1].should eq 'Italic'
      end

      it 'should underline underlined text' do
        scan = @document.paragraphs[4].to_html.scan(/\<span\s+([^\>]+)/).flatten
        scan.first.should eq 'style="text-decoration:underline;"'
      end

      it 'should justify paragraphs' do
        regex = /^<p[^\"]+.(?<=\")([^\"]+)/
        @document.paragraphs[5].to_html.scan(regex).flatten.first.split(';').include?('text-align:center').should be_true
        @document.paragraphs[6].to_html.scan(regex).flatten.first.split(';').include?('text-align:right').should be_true
        @document.paragraphs[7].to_html.scan(regex).flatten.first.split(';').include?('text-align:left').should be_false
      end

      it 'should output styled html' do
        @document.paragraphs[8].to_html.scan('<span style="text-decoration:underline;"><strong><em>word</em></strong></span>').size.should eq 1
      end

      it 'should properly highlight different text in different places in a sentence' do
        paragraph = @document.paragraphs[9]
        scan = paragraph.to_html.scan(@span_regex).flatten
        scan.first.should eq '<span'
        scan.last.should eq '</span>'
        scan[1].should eq 'paragraph'
        scan = paragraph.to_html.scan(@em_regex).flatten
        scan.first.should eq '<em'
        scan.last.should eq '</em>'
        scan[1].should eq 'different'
        scan = paragraph.to_html.scan(@strong_regex).flatten
        scan.first.should eq '<strong'
        scan.last.should eq '</strong>'
        scan[1].should eq 'various'
        scan = paragraph.to_html.scan(/\<span\s+([^\>]+)/).flatten
        scan.first.should eq 'style="text-decoration:underline;"'
      end

      it "should set font size on styled paragraphs" do
        regex = /(\<p{1})[^\>]+style\=\"([^\"]+).+(<\/p>)/      
        scan = @document.paragraphs[10].to_html.scan(regex).flatten
        scan.first.should eq '<p'
        scan.last.should eq '</p>'
        scan[1].split(';').include?('font-size:24pt').should be_true
      end

      it "should not set font sizes on spans that are the same font size as the paragraph" do
        scan = @document.paragraphs[10].to_html.scan(@span_style_regex).flatten
        scan.size.should eq 0
      end

      it 'should set font size on styled text runs' do
        scan = @document.paragraphs[11].to_html.scan(@span_style_regex).flatten
        scan.first.should eq '<span'
        scan.last.should eq '</span>'
        scan[1].split(';').include?('font-size:18pt').should be_true
      end

    end
  end
end
