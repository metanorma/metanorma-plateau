module IsoDoc
  module Plateau
    class PdfConvert < IsoDoc::JIS::PdfConvert
      def initialize(options)
        @libdir = File.dirname(__FILE__)
        super
      end

      def pdf_stylesheet(_docxml)
        "jis.international-standard.xsl"
      end
    end
  end
end
