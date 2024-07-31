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

      def pub_class(bib)
        return 1 if bib.at("#{PUBLISHER}[name = '#{pub_hash['en']}']") ||
          bib.at("#{PUBLISHER}[abbreviation = 'MLIT']")
        return 2 if bib["type"] == "standard"

        3
      end
    end
  end
end
