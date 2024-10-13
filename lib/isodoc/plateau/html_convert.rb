require_relative "base_convert"

module IsoDoc
  module Plateau
    class HtmlConvert < IsoDoc::Jis::HtmlConvert
      def initialize(options)
        super
        @libdir = File.dirname(__FILE__)
      end

      include BaseConvert
      include Init
    end
  end
end
