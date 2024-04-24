module IsoDoc
  module Plateau
    class WordConvert < IsoDoc::JIS::WordConvert
      def initialize(options)
        @libdir = File.dirname(__FILE__)
        super
        @libdir = File.dirname(__FILE__)
      end
    end
  end
end
