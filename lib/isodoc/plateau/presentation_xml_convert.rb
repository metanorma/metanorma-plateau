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

      def source_types(docxml)
        super
        docxml.xpath(ns("//p/fmt-source")).each { |f| parasource(f) }
        docxml.xpath(ns("//ul/fmt-source")).each { |f| listsource(f, :ul) }
        docxml.xpath(ns("//ol/fmt-source")).each { |f| listsource(f, :ol) }
        docxml.xpath(ns("//dl/fmt-source")).each { |f| listsource(f, :dl) }
      end

      def parasource(elem)
        source1(elem, :para)
        # if we haven't already removed it...
        elem.parent or return
        # elem.parent.next = "<p>#{to_xml(elem.remove)}</p>"
        elem.parent.next = elem.remove
      end

      def listsource(elem, ancestor)
        source1(elem, ancestor)
        elem.parent or return
        # elem.parent.next = "<p>#{to_xml(elem.remove)}</p>"
        elem.parent.next = elem.remove
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

      # revert to iso
      def ol_depth(node)
        depth = node.ancestors("ul, ol").size + 1
        @counter.ol_type(node, depth) # defined in Xref::Counter
      end

      # how many columns in the table?
      def table_col_count(table)
        cols = 0
        table&.at(ns(".//tr"))&.xpath(ns("./td | ./th"))&.each do |td|
          cols += (td["colspan"] ? td["colspan"].to_i : 1)
        end
        cols
      end

      # if there is already a full-row cell at the start of tfoot,
      # use that to move content into
      # else create a full-row cell at the start of tfoot
      def initial_tfoot_cell(node)
        colspan = table_col_count(node)
        tfoot_start = node.at(ns("./tfoot/tr/td"))
        if !tfoot_start
          node.at(ns("./tbody")).after("<tfoot><tr #{add_id_text}><td #{add_id_text} colspan='#{colspan}'> </td></tr></tfoot>").first
          tfoot_start = node.at(ns("./tfoot/tr/td"))
        end
        if tfoot_start["colspan"] != colspan.to_s
          tfoot_start.parent.previous = "<tr #{add_id_text}><td #{add_id_text} colspan='#{colspan}'> </td></tr>"
          tfoot_start = node.at(ns("./tfoot/tr/td"))
        end
        tfoot_start
      end

      # if there is already a full-row cell at the end of tfoot,
      # use that to move content into
      # else create a full-row cell at the end of tfoot
      def final_tfoot_cell(node)
        colspan = table_col_count(node)
        tfoot_start = node.at(ns("./tfoot/tr[last()]/td"))
        if !tfoot_start
          node.at(ns("./tbody")).after("<tfoot><tr #{add_id_text}><td #{add_id_text} colspan='#{colspan}'> </td></tr></tfoot>").first
          tfoot_start = node.at(ns("./tfoot/tr[last()]/td"))
        end
        if tfoot_start["colspan"] != colspan.to_s
          tfoot_start.parent.next = "<tr #{add_id_text}><td #{add_id_text} colspan='#{colspan}'> </td></tr>"
          tfoot_start = node.at(ns("./tfoot/tr[last()]/td"))
        end
        tfoot_start
      end

      def table1(node)
        super
        # move dl, notes, footnotes, fmt-source,
        # fmt-footnote-container inside tfoot
        table_dl_to_tfoot(node)
        table_content_to_tfoot(node)
      end

      def table_dl_to_tfoot(node)
        node.at(ns("./dl")) or return
        tf = initial_tfoot_cell(node)
        node.xpath(ns("./dl")).reverse_each do |x|
          tf.children.first.previous = x.remove
        end
      end

      def table_content_to_tfoot(node)
        node.at(ns("./note | ./fmt-source | ./example | " \
          "./fmt-footnote-container")) or return
        tf = final_tfoot_cell(node)
        %w(example note fmt-footnote-container
           fmt-source).each do |n|
          node.xpath(ns("./#{n}")).each do |x|
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
          colon = %w(zh ja ko).include?(@lang) ? "：" : ": "
          text_node.previous = "<span class='fmt-dt-delim'>#{colon}</span>"
        end
      end

      include Init
    end
  end
end
