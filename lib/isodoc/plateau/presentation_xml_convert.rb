require_relative "init"

module IsoDoc
  module Plateau
    class PresentationXMLConvert < IsoDoc::JIS::PresentationXMLConvert
      def toc_title_insert_pt(docxml)
        ins = docxml.at(ns("//preface")) ||
          docxml.at(ns("//sections | //annex | //bibliography"))
            &.before("<preface> </preface>")
            &.previous_element or return nil
        ins.children.empty? and ins << " "
        a = ins.at(ns("./abstract[last()]")) and return a.after(" ").next
        ins.children.first
      end

      def source(docxml)
        super
        docxml.xpath(ns("//p/source")).each { |f| parasource(f) }
        docxml.xpath(ns("//ul/source")).each { |f| listsource(f) }
        docxml.xpath(ns("//ol/source")).each { |f| listsource(f) }
        docxml.xpath(ns("//dl/source")).each { |f| listsource(f) }
      end

      def parasource(elem)
        source1(elem)
        # if we haven't already removed it...
        elem.parent or return
        elem.name = "p"
        elem.delete("status")
        elem.parent.next = elem
      end

      def listsource(elem)
        source1(elem)
        elem.parent or return
        elem.name = "p"
        elem.delete("status")
        elem.parent.next = elem
      end

      def middle_title(docxml); end

      def rearrange_clauses(docxml)
        super
        revhistory(docxml)
      end

      def revhistory(doc)
        a = doc.at(ns("//annex[@type = 'revhistory']")) or return
        ins = doc.at(ns("//bibliography")) ||
          doc.at(ns("//annex[not(@type = 'revhistory')]")) ||
          doc.at(ns("//sections"))
        ins.next = a
        a["unnumbered"] = "true"
      end

      include Init
    end
  end
end
