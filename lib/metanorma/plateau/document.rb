# frozen_string_literal: true

require "metanorma/standoc"
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
