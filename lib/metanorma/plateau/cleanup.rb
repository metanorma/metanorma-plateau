module Metanorma
  module Plateau
    class Converter < JIS::Converter
      def cleanup(xmldoc)
        #require "debug"; binding.b
        super
      end

      def bibdata_cleanup(xmldoc)
        super
        coverpage_images(xmldoc)
      end

      def coverpage_images(xmldoc)
        %w(coverpage-image).each do |n|
          xmldoc.xpath("//bibdata/ext/#{n}").each do |x|
            ins = add_misc_container(xmldoc)
            ins << "<presentation-metadata><name>#{n}</name>" \
                   "<value>#{x.remove.children.to_xml}</value>" \
                   "</presentation-metadata>"
          end
        end
      end

      def blocksource_cleanup(xmldoc)
        xmldoc.xpath("//termsource").each do |s|
          p = s.previous_element or next
          %w[p ol ul dl].include? p.name or next
          s.name = "source"
          s.delete("type")
          s.parent = p
        end
        super
      end
    end
  end
end
