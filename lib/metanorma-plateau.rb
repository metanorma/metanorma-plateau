require "asciidoctor" unless defined? Asciidoctor::Converter
require_relative "metanorma/plateau/converter"
require_relative "metanorma/plateau/version"
require "isodoc/plateau/html_convert"
require "isodoc/plateau/pdf_convert"
require "isodoc/plateau/presentation_xml_convert"
require "isodoc/plateau/metadata"
require "isodoc/plateau/xref"
require "metanorma"

if defined? Metanorma::Registry
  require_relative "metanorma/plateau"
  Metanorma::Registry.instance.register(Metanorma::Plateau::Processor)
end

