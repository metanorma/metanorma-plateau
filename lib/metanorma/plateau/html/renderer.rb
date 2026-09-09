# frozen_string_literal: true

module Metanorma
  module Plateau
    module Html
      # Plateau documents render iso-style (JIS-shaped): the Plateau
      # root and the JIS annex register alongside the ISO classes the
      # parent renderer covers (exact-class dispatch, OGC pattern).
      class Renderer < Metanorma::Iso::Html::Renderer
        register_render "Metanorma::Plateau::Document::Root", :render_document
        register_render "Metanorma::Jis::Document::Sections::JisAnnexSection",
                        :render_annex
      end
    end
  end
end
