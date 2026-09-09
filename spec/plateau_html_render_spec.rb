# frozen_string_literal: true

# Self-contained: avoids the gem spec_helper's heavier requires.
require "bundler/setup"
require "metanorma/plateau/document"
require "metanorma/plateau/html"
require "metanorma/html/generator"

# The renderer registration contract: the Plateau root and the JIS
# annex must dispatch — an unregistered root renders reader chrome
# with no document body. (No compiled presentation fixture exists in
# the sample corpus.)
RSpec.describe "Metanorma::Plateau::Html::Renderer" do
  let(:xml) do
    <<~XML
      <metanorma xmlns="https://www.metanorma.org/ns/standoc" \
type="presentation" flavor="plateau">
        <bibdata type="standard"><title>Plateau Test</title></bibdata>
        <sections><clause id="_c1" obligation="normative">
          <title>Scope</title><p id="_p1">The scope.</p>
        </clause></sections>
      </metanorma>
    XML
  end

  it "renders the Plateau root to a document body, not an empty shell" do
    model = Metanorma::Plateau::Document::Root.from_xml(xml)
    html = Metanorma::Html::Generator.generate(model)
    page = Nokogiri::HTML(html)
    page.css("header, nav, .header-actions, button, kbd").remove

    expect(page.css("p").size).to be >= 1,
                                  "document body rendered no content (root dispatch missing)"
    expect(page.at("body").text).to include("The scope.")
  end

  it "is the renderer the flavor registry resolves" do
    entry = Metanorma::Core::Flavors.find(:plateau)
    expect(entry.renderers[:html].call(nil)).to eq(Metanorma::Plateau::Html::Renderer)
  end
end
