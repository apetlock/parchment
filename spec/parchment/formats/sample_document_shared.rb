# All document formatss must pass these tests.
# See spec/fixtures for sample templates.
#
shared_examples 'sample document' do

  it 'should read the file' do
    @document = Parchment.read(@file_path)
  end

  it 'should have paragraphs' do
    @paragraphs = @document.paragraphs
    @paragraphs.size.should eq @sample_line_count
    @paragraphs[1].to_s.should eq 'Normal'
    @paragraphs[2].to_s.should eq 'Bold'
    @paragraphs[3].to_s.should eq 'Italic'
    @paragraphs[4].to_s.should eq 'Underline'
    @paragraphs[5].to_s.should eq 'This paragraph is centered.'
    @paragraphs[6].to_s.should eq 'This paragraph is right justified.'
    @paragraphs[7].to_s.should eq 'This paragraph is left justified.'
    @paragraphs[8].to_s.should eq 'This paragraph has a word with all the basic formatting.'
    @paragraphs[9].to_s.should eq 'This paragraph has different words with various styles.'
    @paragraphs[10].to_s.should eq 'This paragraph is at 24 points.'
    @paragraphs[11].to_s.should eq 'This paragraph has a word at 18 points.'
  end

  it 'should have styles' do
    @document.styles.size.should eq @sample_style_count
  end

  describe 'formatting' do
    before do
      @paragraphs = @document.paragraphs
    end

    describe 'in a paragraph' do
      it 'should recognize absence of formatting' do
        @paragraphs[1].bold?.should be_false
        @paragraphs[1].italic?.should be_false
        @paragraphs[1].underline?.should be_false
      end

      it 'should recongize bold text weight' do
        @paragraphs[2].bold?.should be_true
      end

      it 'should recongize italic text style' do
        @paragraphs[3].italic?.should be_true
      end

      it 'should recongize underlined text style' do
        @paragraphs[4].underline?.should be_true
      end

      it 'should recognize center justified text' do
        @paragraphs[5].aligned_center?.should be_true
      end

      it 'should recognize right justified text' do
        @paragraphs[6].aligned_right?.should be_true
      end

      it 'should recognize left justified text' do
        @paragraphs[7].aligned_left?.should be_true
        @paragraphs[1].aligned_left?.should be_true
        @paragraphs[8].aligned_left?.should be_true
      end

      it 'should recognize font size' do
        @paragraphs[9].font_size.should eq @sample_default_font_size
        @paragraphs[10].font_size.should eq 24
        @paragraphs[11].font_size.should eq @sample_default_font_size
      end
    end

    describe 'in a text run' do
      it 'should recognize absence of formatting' do
        @text = @paragraphs[1].text_runs[0]
        @text.bold?.should be_false
        @text.italic?.should be_false
        @text.underline?.should be_false
      end

      it 'should recognize bold text weight' do
        @text = @paragraphs[2].text_runs[0]
        @text.bold?.should be_true
        @text.italic?.should be_false
        @text.underline?.should be_false
      end

      it 'should recognize italic text style' do
        @text = @paragraphs[3].text_runs[0]
        @text.bold?.should be_false
        @text.italic?.should be_true
        @text.underline?.should be_false
      end

      it 'should recognize underlined text style' do
        @text = @paragraphs[4].text_runs[0]
        @text.bold?.should be_false
        @text.italic?.should be_false
        @text.underline?.should be_true
      end

      it 'should recognize all styles in the middle of a sentence' do
        @text_runs = @paragraphs[8].text_runs
        @text_runs[0].bold?.should be_false
        @text_runs[0].italic?.should be_false
        @text_runs[0].underline?.should be_false
        @text_runs[1].bold?.should be_true
        @text_runs[1].italic?.should be_true
        @text_runs[1].underline?.should be_true
        @text_runs[2].bold?.should be_false
        @text_runs[2].italic?.should be_false
        @text_runs[0].underline?.should be_false
      end

      it 'should recognize all styles throughout a sentence' do
        @text_runs = @paragraphs[9].text_runs
        @text_runs[0].bold?.should be_false
        @text_runs[0].italic?.should be_false
        @text_runs[0].underline?.should be_false
        @text_runs[1].bold?.should be_false
        @text_runs[1].italic?.should be_false
        @text_runs[1].underline?.should be_true
        @text_runs[2].bold?.should be_false
        @text_runs[2].italic?.should be_false
        @text_runs[2].underline?.should be_false
        @text_runs[3].bold?.should be_false
        @text_runs[3].italic?.should be_true
        @text_runs[3].underline?.should be_false
        @text_runs[4].bold?.should be_false
        @text_runs[4].italic?.should be_false
        @text_runs[4].underline?.should be_false
        @text_runs[5].bold?.should be_true
        @text_runs[5].italic?.should be_false
        @text_runs[5].underline?.should be_false
        @text_runs[6].bold?.should be_false
        @text_runs[6].italic?.should be_false
        @text_runs[6].underline?.should be_false
      end

      it 'should recognize font size' do
        @paragraphs[1].text_runs[0].font_size.should eq @sample_default_font_size
        @paragraphs[10].text_runs[0].font_size.should eq 24
        @paragraphs[11].text_runs[0].font_size.should eq @sample_default_font_size
        @paragraphs[11].text_runs[1].font_size.should eq 18
        @paragraphs[11].text_runs[2].font_size.should eq @sample_default_font_size
      end
    end
  end
end
