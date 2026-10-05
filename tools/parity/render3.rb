# 3.x-line rendering: relaton-bib model -> facade -> Iso690::Renderer
require "relaton-bib"
require "relaton-render"

xml = File.read("refs.xml")
doc = Nokogiri::XML(xml).root
doc.xpath("./bibitem").each do |b|
  model = Relaton::BibliographicItem.from_xml(b.to_xml)
  general = Relaton::Render::General.new(
    language: model.language&.first || "en",
  )
  puts "#{model.docidentifier.first.id}: #{general.render(model, embedded: true)}"
end
