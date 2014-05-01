module Parchment
  class Style

    AVAILABLE_FORMATTING = %w(
      bold
      italic
      underline
      aligned_left
      aligned_right
      aligned_center
    )

    attr_reader :id,
                :name,
                :family,
                :parent_style_name,
                :text_align,
                :font_size,
                :font_weight,
                :font_style,
                :text_underline_style

    # This needs to be defined in each format's subclass.
    #
    def initialize(node)
      raise MissingFormatterMethodError
    end

    def paragraph?
      @family == 'paragraph'
    end

    def text?
      @family == 'text'
    end

    def bold?
      @font_weight == 'bold'
    end

    def italic?
      @font_style == 'italic'
    end

    def underline?
      !@text_underline_style.nil?
    end

    def aligned_left?
      [:left, nil].include?(@text_align)
    end

    def aligned_right?
      @text_align == :right
    end

    def aligned_center?
      @text_align == :center
    end
  end
end
