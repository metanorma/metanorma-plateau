require "isodoc"
require_relative "metadata"
require_relative "i18n"
require_relative "xref"
require "metanorma-utils"

module IsoDoc
  module Plateau
    module Init
      Hash.include Metanorma::Utils::Hash

      def metadata_init(lang, script, locale, labels)
        @meta = Metadata.new(lang, script, locale, labels)
      end

      def xref_init(lang, script, _klass, labels, options)
        p = HtmlConvert.new(language: lang, script:)
        @xrefs = Xref.new(lang, script, p, labels, options)
      end

      def i18n_init(lang, script, locale, i18nyaml = nil)
        @i18n = I18n.new(lang, script, locale:,
                                       i18nyaml: i18nyaml || @i18nyaml)
      end

      def bibrenderer(options = {})
        ret = ::Relaton::Render::Plateau::General.new(options
          .merge(language: @lang, script: @script, i18nhash: @i18n.get))
        options = options.merge(ret.config)
        en = bibrenderer_lang("en", options)
        ja = bibrenderer_lang("ja", options)
        ret
      end

      def bibrenderer_lang(lang, options)
        yaml = YAML.load_file(File.join(File.dirname(__FILE__),
                                        "..", "..", "relaton", "render-plateau",
                                        "config-#{lang}.yml"))
        script = lang == "ja" ? "Jpan" : "Latn"
        citation_i18n = I18n.new(lang, script).get
        i18n = Marshal.load(Marshal.dump(@i18n.get))
        %w(open-title close-title open-secondary-title close-secondary-title).each do |k|
        i18n["punct"][k] = citation_i18n["punct"][k]
        end
        ::Relaton::Render::Plateau::General.new(options
          .deep_merge(yaml)
          .merge(language: lang, script: script, i18nhash: i18n))
      end
    end
  end
end
