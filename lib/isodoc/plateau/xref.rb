module IsoDoc
  module Plateau
    class Xref < IsoDoc::JIS::Xref
      def clause_order_main(docxml)
        [
          { path: "//sections/introduction | //sections/clause | //sections/terms | //sections/references", multi: true }
        ]
      end
    end
  end
end
