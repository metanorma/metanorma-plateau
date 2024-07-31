module IsoDoc
  module Plateau
    class Counter < IsoDoc::XrefGen::Counter
    end

    class Xref < IsoDoc::JIS::Xref
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

      def section_name_anchors(clause, num, level)
        super
        if level >= 4 && level <= 6
          label, xref = section_name_anchors_deep(num, level)
          @anchors[clause["id"]][:label] = label
          @anchors[clause["id"]][:xref] = l10n(xref)
        end
      end

      def section_name_anchors_deep(num, level)
        numparts = num.split(".")
        core = numparts[0..2].join(".")
        (4..level).each do |l|
          core += " #{section_name_label_deep(numparts[l - 1], l)}"
        end
        [section_name_label_deep(numparts[-1], level), l10n(core)]
      end

      def section_name_label_deep(num, level)
        case level
        when 4 then l10n("(#{num})")
        when 5 then l10n("#{num})")
        when 6
          ("" << (num.to_i + 0x245f))
        end
      end

      def annex_name_anchors1(clause, num, level)
        super
        if level >= 4 && level <= 6
          label, xref = section_name_anchors_deep(num, level)
          @anchors[clause["id"]][:label] = label
          @anchors[clause["id"]][:xref] = l10n(xref)
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

    end
  end
end
