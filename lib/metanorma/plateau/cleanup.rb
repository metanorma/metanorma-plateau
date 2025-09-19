module Metanorma
  module Plateau
    # after term def processed, process source after paragraphs so that
    # the moving of paragraphs there does not nclude termdef
    class Converter < Jis::Converter
      def termdef_cleanup(xmldoc)
        super
        xmldoc.xpath("//source").each do |s|
          p = s.previous_element or next
          %w[p ol ul dl].include? p.name or next
          s.delete("type")
          s.parent = p
        end
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
