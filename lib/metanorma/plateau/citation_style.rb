require "metanorma/jis/citation_style"

module Metanorma
  module Plateau
    #
    # The Plateau flavor's citation renderer: the JIS facade with this
    # flavor's style file. The 1.x stack's per-language citation
    # machinery (Relaton::Render::Plateau::General/Citations/I18n) has
    # no consumer on the render-v3 stack: isodoc renders the
    # bibliography once, in the document language.
    #
    class CitationStyle < ::Metanorma::Jis::CitationStyle
      STYLE_PATH = File.join(__dir__, "plateau-style.yml")

      def initialize(options = {})
        super(options.merge(style: STYLE_PATH))
      end
    end
  end
end
