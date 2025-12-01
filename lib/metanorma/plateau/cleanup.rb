module Metanorma
  module Plateau
    # after term def processed, process source after paragraphs so that
    # the moving of paragraphs there does not include termdef
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

      def biblio_reorder(xmldoc)
        xmldoc.xpath("//references").each do |r|
          biblio_reorder1(r)
        end
      end

      def boilerplate_cleanup(xmldoc)
        super
        conv = boilerplate_isodoc(xmldoc) or return
        c = process_boilerplate_file(File.join(@libdir, "colophon.adoc"), conv)
        xmldoc.root << "<colophon>#{c.children.first.to_xml}</colophon>"
      end
    end
  end
end
