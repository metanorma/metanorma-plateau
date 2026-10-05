require "nokogiri"
require "relaton-render"
general = Relaton::Render::General.new(language: "ja")
xml = File.read("refs.xml")
out = general.render_all(xml)
out.each { |k, v| puts "#{k}: #{v.is_a?(Hash) ? v.values.join(' | ') : v}" }
