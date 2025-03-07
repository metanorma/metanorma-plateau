require_relative "init"

module IsoDoc
  module Plateau
    class PresentationXMLConvert < IsoDoc::Jis::PresentationXMLConvert
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

      # how many columns in the table?
      def table_col_count(table)
        cols = 0
        table&.at(ns(".//tr"))&.xpath(ns("./td | ./th"))&.each do |td|
          cols += (td["colspan"] ? td["colspan"].to_i : 1)
        end
        cols
      end

      # if there is already a full-row cell at the start of tfoot, use that to move content into
      # else create a full-row cell at the start of tfoot
      def initial_tfoot_cell(node)
        colspan = table_col_count(node)
        tfoot_start = node.at(ns("./tfoot/tr/td"))
        if !tfoot_start
          node.at(ns("./tbody")).after("<tfoot><tr><td colspan='#{colspan}'> </td></tr></tfoot>").first
          tfoot_start = node.at(ns("./tfoot/tr/td"))
        end
        if tfoot_start["colspan"] != colspan.to_s
          tfoot_start.parent.previous = "<tr><td colspan='#{colspan}'> </td></tr>"
          tfoot_start = node.at(ns("./tfoot/tr/td"))
        end
        tfoot_start
      end

      # if there is already a full-row cell at the end of tfoot, use that to move content into
      # else create a full-row cell at the end of tfoot
      def final_tfoot_cell(node)
        colspan = table_col_count(node)
        tfoot_start = node.at(ns("./tfoot/tr[last()]/td"))
        if !tfoot_start
          node.at(ns("./tbody")).after("<tfoot><tr><td colspan='#{colspan}'> </td></tr></tfoot>").first
          tfoot_start = node.at(ns("./tfoot/tr[last()]/td"))
        end
        if tfoot_start["colspan"] != colspan.to_s
          tfoot_start.parent.next = "<tr><td colspan='#{colspan}'> </td></tr>"
          tfoot_start = node.at(ns("./tfoot/tr[last()]/td"))
        end
        tfoot_start
      end

      def table1(node)
        super
        # move dl, notes, footnotes, source, fmt-footnote-container inside tfoot
        if node.at(ns("./dl"))
          tf = initial_tfoot_cell(node)
          node.xpath(ns("./dl")).reverse_each do |x|
            tf.children.first.previous = x.remove
          end
        end
        # TODO fmt-footnote-container moves inside tfoot
        if node.at(ns("./note | ./source"))
          tf = final_tfoot_cell(node)
          node.xpath(ns("./note")).each { |x| tf.children.last.next = x.remove }
          node.xpath(ns("./source")).each do |x|
            tf.children.last.next = x.remove
          end
        end
      end

      # Undo JIS encoding of figure and table dl as paragraphs
      def dl(docxml)
        docxml.xpath(ns("//dl")).each { |f| dl1(f) }
        docxml.xpath(ns("//table//dl | //figure//dl")).each do |l|
          l.at(ns("./dl")) || l.at("./ancestor::xmlns:dl") and next
          table_key(l)
        end
      end

      # Insert localised colon at start of dd in table and figure key,
      # replacing JIS Word <p class='dl' id='#{dt['id']}'>#{term}: #{bkmk}#{defn}</p>
      # with <dt>{term}</dt> <dd>: {defn}<dd>; the space should be stripped and
      # the colon double-width for Japanese text
      def table_key(node)
        node.xpath(ns(".//dd")).each do |dd|
          text_node = dd.xpath(".//text()[normalize-space()]").first or next
          text_content = text_node.content
          text_node.content = @i18n.l10n(": " + text_content)
        end
      end

      include Init
    end
  end
end
