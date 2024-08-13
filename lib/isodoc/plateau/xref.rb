module IsoDoc
  module Plateau
    class Counter < IsoDoc::XrefGen::Counter
    end

    class Xref < IsoDoc::JIS::Xref
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

      def hierarchical_figure_names(clause, num)
        c = IsoDoc::XrefGen::Counter.new
        j = 0
        clause.xpath(ns(FIGURE_NO_CLASS)).noblank.each do |t|
          labelled_ancestor(t, %w(figure)) and next # do not label nested figure
          j = subfigure_increment(j, c, t)
          label = "#{num}#{hiersep}#{c.print}"
          sublabel = subfigure_label(j)
          figure_anchor(t, sublabel, label, "figure")
        end
        hierarchical_figure_class_names(clause, num)
      end

      def hierarchical_figure_class_names(clause, num)
        c = {}
        j = 0
        clause.xpath(ns(".//figure[@class][not(@class = 'pseudocode')]"))
          .noblank.each do |t|
          c[t["class"]] ||= IsoDoc::XrefGen::Counter.new
          labelled_ancestor(t, %w(figure)) and next
          j = subfigure_increment(j, c[t["class"]], t)
          label = "#{num}#{hiersep}#{c.print}"
          sublabel = j.zero? ? nil : "#{(j + 96).chr})"
          figure_anchor(t, sublabel, label, t["class"])
        end
      end

      def list_item_anchor_names(list, list_anchor, depth, prev_label,
refer_list)
        @iso.list_item_anchor_names(list, list_anchor, depth, prev_label, refer_list)
      end

      def list_item_value(entry, counter, depth, opts)
        @iso.list_item_value(entry, counter, depth, opts)
      end
    end
  end
end
