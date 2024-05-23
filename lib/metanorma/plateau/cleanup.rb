module Metanorma
  module Plateau
    class Converter < JIS::Converter
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
    end
  end
end
