# frozen_string_literal: true

require "metanorma/standoc"
require "metanorma/iso/document/models"
require "metanorma/jis/document/models"
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

module Metanorma
  existing = defined?(Metanorma::PlateauDocument) && Metanorma::PlateauDocument
  if !existing.equal?(Metanorma::Plateau::Document)
    Metanorma.send(:remove_const, :PlateauDocument) if existing
    PlateauDocument = Metanorma::Plateau::Document
  end
end

require "metanorma/plateau/registers"
Metanorma::Plateau::Registers.setup

# OCP adoption: ONE registration in the metanorma-core flavor table
require "metanorma-core"

Metanorma::Core::Flavors.register(Metanorma::Core::Flavor.new(
  name: :plateau,
  gem: "metanorma-plateau",
  model_root: Metanorma::Plateau::Document::Root,
  pubid_module: nil,
  renderers: { html: lambda do |_document, **_options|
    Metanorma::Html::StandardRenderer
  end },
))
