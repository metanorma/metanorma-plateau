# frozen_string_literal: true

require "bundler/setup"
require "rspec/matchers"
require "metanorma/plateau/document"

RSpec.describe "Plateau synthetic round-trip" do
  def round_trip(root_class, xml)
    doc = root_class.from_xml(xml)
    output = doc.to_xml
    reparsed = root_class.from_xml(output)
    [doc, reparsed, output]
  end

describe "Plateau" do
  let(:xml) do
    <<~XML
      <metanorma type="semantic" version="1.0">
        <bibdata type="standard"><title>Plateau Doc</title></bibdata>
        <sections>
          <clause id="_c1"><title>Scope</title><p>Text</p></clause>
        </sections>
        <annex id="_a1" obligation="informative" commentary="true">
          <title>Commentary</title>
          <clause id="_ac1"><title>Notes</title><p>Text</p></clause>
        </annex>
      </metanorma>
    XML
  end

  it "parses the flavor root through the JIS fallback chain" do
    doc = Metanorma::Plateau::Document::Root.from_xml(xml)
    register = Lutaml::Model::GlobalRegister.lookup(:plateau_document)
    expect(register.fallback).to include(:jis_document)
    expect(doc.sections).to be_a(Metanorma::IsoDocument::Sections::IsoSections)
    expect(doc.annex.first)
      .to be_a(Metanorma::JisDocument::Sections::JisAnnexSection)
    expect(doc.annex.first.commentary).to be(true)
  end

  it "round-trips the flavor-specific structures" do
    _, reparsed, output = round_trip(Metanorma::Plateau::Document::Root, xml)
    expect(output).to include('commentary="true"')
    expect(output).to include('<clause id="_c1"')
    expect(reparsed.annex.first.commentary).to be(true)
    expect(reparsed.sections.clause.length).to eq(1)
  end
end
end
