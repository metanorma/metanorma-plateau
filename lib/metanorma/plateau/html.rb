# frozen_string_literal: true

require "metanorma/iso/html"

module Metanorma
  module Plateau
    # HTML format slice for the flavor: the renderer, registered with
    # the harness from plateau/document.rb. Renders iso-style; the
    # Plateau root uses the ISO section classes plus the JIS annex.
    module Html
      autoload :Renderer, "#{__dir__}/html/renderer"
    end
  end
end
