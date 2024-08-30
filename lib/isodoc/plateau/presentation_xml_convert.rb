require_relative "init"

module IsoDoc
  module Plateau
    class PresentationXMLConvert < IsoDoc::JIS::PresentationXMLConvert
      def initialize(options)
        @iso = ::IsoDoc::Iso::PresentationXMLConvert.new(options)
        super
      end

      def toc_title_insert_pt(docxml)
        i = preface_init_insert_pt(docxml) or return nil
        a = i.at(ns("./abstract[last()] | ./clause[@type = 'revhistory']")) and
          return a.after(" ").next
        i.children.first
      end

      def preface_init_insert_pt(docxml)
        ret = docxml.at(ns("//preface")) ||
          docxml.at(ns("//sections | //annex | //bibliography"))
            &.add_previous_sibling("<preface> </preface>")&.first
        ret.nil? and return nil
        ret.children.empty? and ret << " "
        ret
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

      def revhistory(docxml)
        a = docxml.at(ns("//clause[@type = 'revhistory']"))&.remove or return
        pref = preface_init_insert_pt(docxml) or return nil
        ins = if b = pref.at(ns("./abstract[last()]"))
                b.after(" ").next
              else pref.children.first
              end
        ins.previous = a
      end

      def commentary_title_hdr(elem)
        ret = <<~COMMENTARY
          <p class="CommentaryStandardNumber">#{@meta.get[:docnumber_undated]}
        COMMENTARY
        yr = @meta.get[:docyear] and
          ret += ": <span class='CommentaryEffectiveYear'>#{yr}</span>"
        elem.previous = ret
      end

      def ol_depth(node)
        @iso.ol_depth(node)
      end

      include Init
    end
  end
end
