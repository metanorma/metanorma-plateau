require "isodoc"
require_relative "metadata"
require_relative "i18n"
require_relative "xref"

module IsoDoc
  module Plateau
    module Init
      def metadata_init(lang, script, locale, labels)
        @meta = Metadata.new(lang, script, locale, labels)
      end

      def xref_init(lang, script, _klass, labels, options)
        p = PresentationXMLConvert.new(language: lang, script:)
        @xrefs = Xref.new(lang, script, p, labels, options)
      end

      def i18n_init(lang, script, locale, i18nyaml = nil)
        @i18n = I18n.new(lang, script, locale:,
                                       i18nyaml: i18nyaml || @i18nyaml)
      end

      def bibrenderer(options = {})
        ::Relaton::Render::Jis::General.new(options.merge(language: @lang,
                                                          i18nhash: @i18n.get))
      end
    end
  end
end
