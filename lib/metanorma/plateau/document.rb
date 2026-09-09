# frozen_string_literal: true

require "metanorma/standoc"
require "metanorma/iso/document"
require "metanorma/jis/document"
# Forward-declare parent namespace so this file is safe to require
# directly (without first requiring metanorma/plateau.rb).
module Metanorma
  module Plateau
  end
end


module Metanorma
  module Plateau::Document
    autoload :Metadata, "metanorma/plateau/document/metadata"
    autoload :Root, "metanorma/plateau/document/root"
  end
end


# Backwards-compat alias so external consumers that reference
# Metanorma::PlateauDocument keep resolving during the transition.
module Metanorma
  existing = defined?(Metanorma::PlateauDocument) && Metanorma::PlateauDocument
  if !existing.equal?(Metanorma::Plateau::Document)
    Metanorma.send(:remove_const, :PlateauDocument) if existing
    PlateauDocument = Metanorma::Plateau::Document
  end
end

if defined?(Metanorma::Registers::Setup.setup_plateau_register)
  Metanorma::Registers::Setup.setup_plateau_register
end

module Metanorma
  deprecate_constant :PlateauDocument
end

require "metanorma-core"

# OCP adoption: ONE registration in the metanorma-core flavor table
# (metanorma-core#18). Lazy: the table exists only on the flavor-table
# line of metanorma-core; skip silently on resolutions without it.
if defined?(Metanorma::Core::Flavors)
  Metanorma::Core::Flavors.register(Metanorma::Core::Flavor.new(
                                      name: :plateau,
                                      gem: "metanorma-plateau",
                                      model_root: Metanorma::Plateau::Document::Root,
                                      pubid_module: nil,
                                      renderers: { html: lambda do |_document, **_options|
                                        require "metanorma/plateau/html"
                                        Metanorma::Plateau::Html::Renderer
                                      end },
                                    ))
end
