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
        @xrefs = Xref.new(lang, script,
                          HtmlConvert.new(language: lang, script: script),
                          labels, options)
      end

      def i18n_init(lang, script, locale, i18nyaml = nil)
        @i18n = I18n.new(lang, script, locale: locale,
                                       i18nyaml: i18nyaml || @i18nyaml)
      end
    end
  end
end
