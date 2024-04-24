module IsoDoc
  module Plateau
    class HtmlConvert < IsoDoc::JIS::HtmlConvert
      def initialize(options)
        super
        @libdir = File.dirname(__FILE__)
      end
    end
  end
end
