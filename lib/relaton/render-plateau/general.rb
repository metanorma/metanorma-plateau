require "relaton-render"
require "metanorma-jis"
require_relative "citations"
require "isodoc-i18n"
require_relative "../../isodoc/plateau/i18n"

module Relaton
  module Render
    module Plateau
      class General < ::Relaton::Render::Jis::General
        def initialize(opt = {})
          super
          # @jis = ::Relaton::Render::Jis::General
          # .new(language: @lang, script: @script, i18nhash: @i18n.get)
        end

        def deep_clone(obj)
          Marshal.load(Marshal.dump(obj))
        end

        def citation_renderers
          { en: bibrenderer_lang("en", deep_clone(@config)),
            ja: bibrenderer_lang("ja", deep_clone(@config)) }
        end

        SWITCH_PUNCT_KEYS =
          %w(open-title close-title open-secondary-title close-secondary-title
             biblio-field-delimiter).freeze

        def bibrenderer_lang_config(lang, i18n, cit_i18n)
          SWITCH_PUNCT_KEYS.each { |k| i18n["punct"][k] = cit_i18n["punct"][k] }
          # keep Latin punct half-width in Japanese context
          lang == "en" and
            i18n["punct"]["biblio-field-delimiter"] = "<esc>.</esc> "
          i18n
        end

        def bibrenderer_lang(lang, options)
          yaml, script, cit_i18n = bibrenderer_lang_prep(lang)
          i18n = deep_clone(@i18n.get)
          i18n = bibrenderer_lang_config(lang, i18n, cit_i18n)
          ::Relaton::Render::Plateau::General.new(options
            .deep_merge(yaml)
            .merge(language: lang, script: script, i18nhash: i18n))
        end

        def bibrenderer_lang_prep(lang)
          yaml = YAML.load_file(File.join(File.dirname(__FILE__),
                                          "config-#{lang}.yml"))
          script = lang == "ja" ? "Jpan" : "Latn"
          cit_i18n = ::IsoDoc::Plateau::I18n.new(lang, script).get
          [yaml, script, cit_i18n]
        end
      end
    end
  end
end
