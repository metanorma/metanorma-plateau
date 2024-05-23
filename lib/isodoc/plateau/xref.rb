module IsoDoc
  module Plateau
    class Xref < IsoDoc::JIS::Xref
      def clause_order_main(_docxml)
        [
          {
            path: "//sections/introduction | //sections/clause | " \
                  "//sections/terms | //sections/references", multi: true
          },
        ]
      end

      def middle_section_asset_names(doc)
        middle_sections =
          "//clause[@type = 'scope'] | #{@klass.norm_ref_xpath} | " \
          "//sections/terms | //preface/* | " \
          "//sections/definitions | //clause[parent::sections]"
        #sequential_asset_names(doc.xpath(ns(middle_sections)))
        middle_asset_names(doc.xpath(ns(middle_sections)))
      end

      # container makes numbering be prefixed with the parent clause reference
      def middle_asset_names(clause, container: false)
        sequential_table_names(clause, container: true)
        sequential_figure_names(clause, container: true)
        sequential_formula_names(clause, container: container)
        sequential_permission_names(clause, container: container)
      end
    end
  end
end
