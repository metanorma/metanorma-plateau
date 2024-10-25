module Metanorma
  module Plateau
    class Converter < Jis::Converter
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

      # Abandoned in favour of JIS ordering
      #       def pub_class(bib)
      #         return 1 if bib.at("#{PUBLISHER}[name = '#{pub_hash['en']}']") ||
      #           bib.at("#{PUBLISHER}[name = '#{pub_hash['ja']}']") ||
      #           bib.at("#{PUBLISHER}[abbreviation = 'MLIT']")
      #         return 2 if bib["type"] == "standard"
      #
      #         3
      #       end

      def biblio_reorder(xmldoc)
        xmldoc.xpath("//references").each do |r|
          biblio_reorder1(r)
        end
      end
    end
  end
end
