require_relative "init"

module IsoDoc
  module Plateau
    class PresentationXMLConvert < IsoDoc::JIS::PresentationXMLConvert
      def convert(input_filename, file = nil, debug = false,
                     output_filename = nil)
        super
      end

      def middle_title(docxml); end

      include Init
    end
  end
end
