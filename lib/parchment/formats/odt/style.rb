require 'parchment/style'

module Parchment
  module ODT
    class Style < Parchment::Style

      # Because the OpenOffice standard uses 'start', 'end', etc.
      ALIGNMENT_CONVERSION = {
        start: :left,
        end: :right,
        center: :center
      }

      TEXT_PROPERTIES = [
        'font-size',
        'font-weight',
        'font-style',
        'text-underline-style'
      ]

      def initialize(node)
        @node = node
        @node.attributes.map { |k, v| [k, v.value] }.each do |prop|
          prop_name = prop[0].gsub('-', '_')
          instance_variable_set("@#{prop_name}", prop[1])
        end
        instance_variable_set("@id", @name)
        @node.children.each do |style_child|
          case style_child.name
          when 'paragraph-properties'
            if style_child.attributes['text-align']
              @text_align = ALIGNMENT_CONVERSION[style_child.attributes['text-align'].value.to_sym]
            end
          when 'text-properties'
            TEXT_PROPERTIES.each do |prop|
              style_attr = style_child.attributes[prop]
              if style_attr
                value = style_attr.value
                value = value.to_i if prop == 'font-size'
                instance_variable_set("@#{prop.gsub('-', '_')}", value)
              end
            end
          end
        end
      end

    end
  end
end
