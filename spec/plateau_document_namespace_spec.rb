# frozen_string_literal: true

# Self-contained: avoids pulling in the gem's full spec_helper (which
# may load unrelated code with pre-existing pubid-* dependency issues).
require "bundler/setup"
require "metanorma/plateau/document"

RSpec.describe "Metanorma::Plateau::Document namespace" do
  describe "canonical namespace" do
    it "exposes Metanorma::Plateau::Document as a Module" do
      expect(Metanorma::Plateau::Document).to be_a(Module)
    end

    it "exposes Root with the canonical name" do
      expect(Metanorma::Plateau::Document::Root.name)
        .to eq("Metanorma::Plateau::Document::Root")
    end

    it "Root is a lutaml Serializable" do
      expect(Metanorma::Plateau::Document::Root < Lutaml::Model::Serializable).to be(true)
    end
  end

  describe "backwards-compat alias" do
    it "Metanorma::PlateauDocument aliases to the new namespace" do
      expect(Metanorma::PlateauDocument).to eq(Metanorma::Plateau::Document)
    end

    it "the alias preserves class identity" do
      expect(Metanorma::PlateauDocument::Root.equal?(
               Metanorma::Plateau::Document::Root)).to be(true)
    end
  end

  describe "parent namespace" do
    it "Metanorma::Standoc::Document is available" do
      expect(Metanorma::Standoc::Document).to be_a(Module)
    end

    it "Metanorma::StandardDocument alias is available" do
      expect(Metanorma::StandardDocument).to eq(Metanorma::Standoc::Document)
    end
  end
end
