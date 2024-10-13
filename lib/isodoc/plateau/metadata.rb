module IsoDoc
  module Plateau
    class Metadata < IsoDoc::Jis::Metadata
      def docid(xml, _out)
        id = xml.at(ns("//bibdata/docidentifier[@type = 'PLATEAU']"))&.text or
          return
        set(:docnumber, id)
        set(:docnumber_undated, id.sub(/:\d{4}$/, ""))
      end
    end
  end
end
