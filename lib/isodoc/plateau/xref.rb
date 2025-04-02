module IsoDoc
  module XrefGen
    module OlTypeProvider
      # revert to ISO default
      def ol_type(list, depth)
        return list["type"].to_sym if list["type"]
        return :arabic if [2, 7].include? depth
        return :alphabet if [1, 6].include? depth
        return :alphabet_upper if [4, 9].include? depth
        return :roman if [3, 8].include? depth
        return :roman_upper if [5, 10].include? depth

        :arabic
      end
    end
  end

  module Plateau
    class Counter < IsoDoc::XrefGen::Counter
    end

    class Xref < IsoDoc::Jis::Xref
      def initialize(lang, script, klass, i18n, options)
        @iso = ::IsoDoc::Iso::Xref.new(lang, script, klass, i18n, options)
        super
      end

      def clause_order_main(_docxml)
        [
          {
            path: "//sections/introduction | //sections/clause | " \
                  "//sections/terms | //sections/definitions | " \
                  "//sections/references", multi: true
          },
        ]
      end

      def middle_section_asset_names(doc)
        middle_sections =
          "//clause[@type = 'scope'] | #{@klass.norm_ref_xpath} | " \
          "//sections/terms | //preface/* | " \
          "//sections/definitions | //clause[parent::sections]"
        # sequential_asset_names(doc.xpath(ns(middle_sections)))
        middle_asset_names(doc.xpath(ns(middle_sections)))
      end

      def hiersep
        "-"
      end

      # container makes numbering be prefixed with the parent clause reference
      def middle_asset_names(clause, container: false)
        sequential_formula_names(clause, container:)
        sequential_permission_names(clause, container:)
        clause.each do |c|
          num = @anchors.dig(c["id"], :label) || @anchors.dig(c["id"], :xref) ||
            c.at(ns("./title"))&.text
          hierarchical_table_names(c, num)
          hierarchical_figure_names(c, num)
        end
      end

      def hierarchical_figure_names(clauses, num)
        c = IsoDoc::XrefGen::Counter.new
        j = 0
        nodeSet(clauses).each do |clause|
          clause.xpath(ns(FIGURE_NO_CLASS)).noblank.each do |t|
            labelled_ancestor(t, %w(figure)) and next # do not label nested figure
            j = subfigure_increment(j, c, t)
            sublabel = subfigure_label(j)
            figure_anchor(t, sublabel, hiersemx(clause, num, c, t), "figure")
          end
          hierarchical_figure_class_names(clause, num)
        end
      end

      def hierarchical_figure_class_names(clause, num)
        c = {}
        j = 0
        clause.xpath(ns(".//figure[@class][not(@class = 'pseudocode')]"))
          .noblank.each do |t|
          c[t["class"]] ||= IsoDoc::XrefGen::Counter.new
          labelled_ancestor(t, %w(figure)) and next
          j = subfigure_increment(j, c[t["class"]], t)
          sublabel = j.zero? ? nil : "#{(j + 96).chr})"
          figure_anchor(t, sublabel, hiersemx(clause, num, c[t["class"]], t),
                        t["class"])
        end
      end

      def list_item_anchor_names(list, list_anchor, depth, prev_label,
refer_list)
        @iso.anchors.merge!(@anchors)
        @iso.list_item_anchor_names(list, list_anchor, depth, prev_label,
                                    refer_list)
        @anchors.merge!(@iso.anchors)
      end

      def list_item_value(entry, counter, depth, opts)
        @iso.anchors.merge!(@anchors)
        @iso.list_item_value(entry, counter, depth, opts)
        @anchors.merge!(@iso.anchors)
      end
    end
  end
end
