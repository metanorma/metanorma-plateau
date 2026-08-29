# frozen_string_literal: true

module Metanorma
  module Plateau::Document
    class Root < Lutaml::Model::Serializable
      include Metanorma::Standoc::Document::RootAttributes

      def self.lutaml_default_register
        :plateau_document
      end

      attribute :bibdata, Metadata::PlateauBibliographicItem
      attribute :preface,
                Metanorma::IsoDocument::Sections::IsoPreface
      attribute :sections,
                Metanorma::IsoDocument::Sections::IsoSections
      attribute :annex,
                Metanorma::JisDocument::Sections::JisAnnexSection,
                collection: true

      xml do
        element "metanorma"
        namespace Metanorma::Standoc::Document::Namespace

        Metanorma::Standoc::Document::RootXmlMapping.apply(self)
      end
    end
  end
end