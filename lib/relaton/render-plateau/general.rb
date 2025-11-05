require "relaton-render"
require "metanorma-jis"
require_relative "citations"
require_relative "i18n"
require "isodoc-i18n"
require_relative "../../isodoc/plateau/i18n"

module Relaton
  module Render
    module Plateau
      class General < ::Relaton::Render::Jis::General
        def initialize(opt = {})
          i18n = opt[:i18n] ||
            i18n_klass(language: opt[:language], script: opt[:script],
                       locale: opt[:locale], i18nhash: opt[:i18nhash])
          opt["i18n_multi"] = {
            en: i18n_config("en", i18n),
            ja: i18n_config("ja", i18n),
          }
          super
        end

        def klass_initialize(_options)
          super
          @i18nklass = Relaton::Render::Plateau::I18n
          @citeklass = Relaton::Render::Plateau::Citations
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
             biblio-field-delimiter comma).freeze

        # cit_i18n is citation lang i18n
        # @i18n is document lang i18n
        # return merger of the two
        # KILL
        def bibrenderer_lang_config(lang)
          script = lang == "ja" ? "Jpan" : "Latn"
          cit_i18n = ::IsoDoc::Plateau::I18n.new(lang, script).get
          i18n = deep_clone(@i18n.get)
          SWITCH_PUNCT_KEYS.each { |k| i18n["punct"][k] = cit_i18n["punct"][k] }
          # keep Latin punct half-width in Japanese context
          lang == "en" and
            i18n["punct"]["biblio-field-delimiter"] = "<esc>.</esc> "
          i18n
        end

        # cit_i18n is citation lang i18n
        # i18n is document lang i18n
        # return customised merger of the two
        def i18n_config(lang, i18n)
          script = lang == "ja" ? "Jpan" : "Latn"
          cit_i18n = ::IsoDoc::Plateau::I18n.new(lang, script)
          i18n = deep_clone(i18n)
          punct = i18n.get["punct"]
          SWITCH_PUNCT_KEYS.each { |k| punct[k] = cit_i18n.get["punct"][k] }
          # keep Latin punct half-width in Japanese context
          lang == "en" and
            punct["biblio-field-delimiter"] = "<esc>.</esc> "
          i18n.set("punct", punct)
          i18n.set("author_and", cit_i18n.get["author_and"])
          i18n
        end

        def bibrenderer_lang(lang, options)
          yaml, script = bibrenderer_lang_prep(lang)
          # i18n = bibrenderer_lang_config(lang)
          i18n = i18n_config(lang, @i18n.config[@lang]).get
          ::Relaton::Render::Plateau::General.new(options
            .deep_merge(yaml)
            .merge(language: lang, script: script, i18nhash: i18n))
        end

        def bibrenderer_lang_prep(lang)
          yaml = YAML.load_file(File.join(File.dirname(__FILE__),
                                          "config-#{lang}.yml"))
          script = lang == "ja" ? "Jpan" : "Latn"
          [yaml, script]
        end
      end
    end
  end
end
