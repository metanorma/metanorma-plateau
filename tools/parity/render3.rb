# frozen_string_literal: true

require "nokogiri"
require "relaton/bib"
require "relaton-render"

doc = Nokogiri::XML(File.read("refs.xml")).root
doc.xpath("./bibitem").each do |b|
  model = Relaton::Bib::Item.from_xml(b.to_xml)
  label = b.at("docidentifier")&.text
  general = Relaton::Render::General.new(
    language: model.language&.first || "en",
  )
  rendered = general.render(model, embedded: true)
  puts "#{label}: #{rendered}"
end
