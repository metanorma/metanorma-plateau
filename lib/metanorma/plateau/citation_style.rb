# frozen_string_literal: true

require "metanorma/jis"

module Metanorma
  module Plateau
    #
    # The PLATEAU flavor's citation renderer: the JIS facade carrying
    # this gem's CitationStyle instances. The language pack and name
    # form follow the document language; a Japanese document renders
    # the plateau bilingual forms - the fullwidth space as the field
    # separator, 『』 for component titles, 「」 for series titles -
    # in each item's own language punctuation; an English document
    # takes the plain JIS forms.
    #
    class CitationStyle < ::Metanorma::Jis::CitationStyle
      STYLE_EN_JA = File.join(__dir__, "plateau-style-en-ja.yml")
      STYLE_JA_EN = File.join(__dir__, "plateau-style-ja-en.yml")
      STYLE_JA_JA = File.join(__dir__, "plateau-style-ja-ja.yml")

      # The language pack and name form follow the document language;
      # the punctuation (field separator, title marks, list joins)
      # follows the item's own language
      def style_path(lang)
        if @lang.to_s.start_with?("ja")
          lang.to_s == "ja" || lang.nil? ? STYLE_JA_JA : STYLE_JA_EN
        else
          lang.to_s == "ja" ? STYLE_EN_JA : super
        end
      end

      # The ja-document rendering of a Latin item closes an ASCII
      # separator up to a CJK run on the four-per-em space
      # ("2022,\u2005巻1")
      FOUR_PER_EM = "\u2005".freeze

      def cjk_spacing(text)
        super
          # the colon-terminated production yields its field separator
          .gsub(/：\s*\./, "：")
          .gsub(/： /, "：")
          .gsub(/([.,]) (?=第|一-鿿|\p{Han}|\p{Hiragana}|\p{Katakana})/) do
          "#{Regexp.last_match(1)}#{FOUR_PER_EM}"
        end
      end

      # The per-item renderer carries the document's language pack, not
      # the item's (the 1.x i18n_multi merge)
      def renderer_for(lang)
        return @renderer if lang.nil? || lang == @lang

        @renderers_by_lang[lang] ||= ::Metanorma::Jis::JisElements::JisRenderer.new(
          lang: @lang,
          script: @renderer_opts[:script],
          labels: @renderer_opts[:labels],
          style: style_path(lang),
          elements: ::Metanorma::Jis::JisElements::ELEMENTS,
        )
      end
    end
  end
end
