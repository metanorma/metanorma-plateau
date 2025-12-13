require_relative "init"
require_relative "../../relaton/render-plateau/general"

module IsoDoc
  module Plateau
    class PresentationXMLConvert < IsoDoc::Jis::PresentationXMLConvert
      def initialize(options)
        @iso = ::IsoDoc::Iso::PresentationXMLConvert.new(options)
        super
      end

      def i18n_init(lang, script, locale, i18nyaml = nil)
        @i18n = super
        alt_i18n_init(i18nyaml)
        @i18n
      end

      def alt_i18n_init(i18nyaml)
        @i18n_lg = {}
        en = I18n.new("en", "Latn", i18nyaml: i18nyaml || @i18nyaml)
        ja = I18n.new("ja", "Jpan", i18nyaml: i18nyaml || @i18nyaml)
        @i18n_lg["default"] = { i18n: @i18n, lang: @lang, script: @script }
        @i18n_lg["alt"] = if @lang == "ja"
                            { i18n: en, lang: "en", script: "Latn" }
                          else
                            { i18n: ja, lang: "ja", script: "Jpan" }
                          end
      end

      def alt_i18n
        @i18n = @i18n_lg["alt"][:i18n]
        @lang = @i18n_lg["alt"][:lang]
        @script = @i18n_lg["alt"][:script]
      end

      def revert_i18n
        @i18n = @i18n_lg["default"][:i18n]
        @lang = @i18n_lg["default"][:lang]
        @script = @i18n_lg["default"][:script]
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
        elem.parent.next = elem.remove
      end

      def listsource(elem, ancestor)
        source1(elem, ancestor)
        elem.parent or return
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

      # Undo JIS encoding of figure and table dl as paragraphs
      def dl(docxml)
        docxml.xpath(ns("//dl")).each { |f| dl1(f) }
        docxml.xpath(ns("//table//dl | //figure//dl")).each do |l|
          l.at(ns("./dl")) || l.at("./ancestor::xmlns:dl") and next
          table_key(l)
        end
      end

      # Insert localised colon at start of dd in table and figure key,
      # replacing JIS Word
      #    <p class='dl' id='#{dt['id']}'>#{term}: #{bkmk}#{defn}</p>
      # with
      #   <dt>{term}</dt> <dd>: {defn}<dd>
      # Space should be stripped and the colon double-width for Japanese text
      def table_key(node)
        node.xpath(ns(".//dd")).each do |dd|
          text_node = dd.xpath(".//text()[normalize-space()]").first or next
          colon = %w(zh ja ko).include?(@lang) ? "：" : ": "
          text_node.previous = "<span class='fmt-dt-delim'>#{colon}</span>"
        end
      end

      def anchor_linkend(node, linkend)
        title_fallback_docid?(node) and
          node["style"] ||= "title"
        super
      end

      # if we are falling back to a title identifier for citation,
      # cite title-style, which gives us title marks
      def title_fallback_docid?(elem)
        sem_xml_descendant?(elem) and return
        id = elem["bibitemid"] or return
        b = @bibitem_lookup[id] or return
        x = <<~XPATH
          ./docidentifier[not(#{SERIAL_NUM_DOCID} or @scope = 'biblio-tag' or @type = 'metanorma' or @type = 'metanorma-ordinal' or @type='title')]
        XPATH
        !b.at(ns(x)) && b.at(ns("./docidentifier[@type='title']"))
      end

      def termsource_join_delim(_elem)
        @lang == "ja" ? "／" : "/"
      end

      def source_join_delim(_elem)
        @lang == "ja" ? "／" : "/"
      end

      def termsource_mod_text_delim(_elem)
        @lang == "ja" ? "、" : ", "
      end

      def short_style_origin(docxml)
        docxml.xpath(ns("//fmt-origin")).each do |o|
          xref_empty?(o) or next
          fmt_origin_cite_full?(o) and o["style"] ||= "reference-tag"
        end
      end

      def fmt_origin_cite_full?(elem)
        sem_xml_descendant?(elem) and return
        id = elem["bibitemid"] or return
        @bibitem_lookup[id] or return
        true
      end

      def bibdata_i18n(bib)
        alt_i18n
        super
        revert_i18n
        super
      end

      def date_translate(bibdata)
        bibdata.xpath(ns("./date[not(@language)]")).each do |d|
          d.next = d.dup
          newdate = date_translate1(d.text)
          d.next.children = newdate
          d.next["language"] = @lang
          @lang == @i18n_lg["default"][:lang] and d.children = newdate
        end
      end

      def date_translate1(date)
        if @lang == "en" then date
        else super
        end
      end

      include Init
    end
  end
end
