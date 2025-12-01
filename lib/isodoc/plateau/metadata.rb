module IsoDoc
  module Plateau
    class Metadata < IsoDoc::Jis::Metadata
      def docid(xml, _out)
        id = xml.at(ns("//bibdata/docidentifier[@type = 'PLATEAU']"))&.text or
          return
        set(:docnumber, id)
        set(:docnumber_undated, id.sub(/:\d{4}$/, ""))
      end

      def bibdate(xml, _out)
        require "debug"; binding.b
        super
        d = get[:publisheddate] or return
        require "debug"; binding.b
        lbl = @i18n.l10n(@i18n.published_date_labelled.sub("%", d))
        set(:published_date_labelled, lbl)
      end
    end
  end
end
