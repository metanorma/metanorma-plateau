require "metanorma-jis"

module Metanorma
  module Plateau
    class Converter < JIS::Converter
      register_for "plateau"

      def version
        flavour = "JIS"
        Metanorma.versioned(Metanorma, flavour)[-1]::VERSION
      end

      def schema_version
        f = File.read(File.join(File.dirname(__FILE__), "..", "jis", "isodoc.rng"))
        m = / VERSION (v\S+)/.match(f)
        m[1]
      end

      def html_converter(node)
        if node.nil?
          IsoDoc::Plateau::HtmlConvert.new({})
        else
          IsoDoc::Plateau::HtmlConvert.new(html_extract_attributes(node))
        end
      end

      def doc_converter(node)
        if node.nil?
          IsoDoc::Plateau::WordConvert.new({})
        else
          IsoDoc::Plateau::WordConvert.new(doc_extract_attributes(node))
        end
      end

      def pdf_converter(node)
        return if node.attr("no-pdf")

        if node.nil?
          IsoDoc::Plateau::PdfConvert.new({})
        else
          IsoDoc::Plateau::PdfConvert.new(pdf_extract_attributes(node))
        end
      end

      def presentation_xml_converter(node)
        if node.nil?
          IsoDoc::Plateau::PresentationXMLConvert.new({})
        else
          IsoDoc::Plateau::PresentationXMLConvert
            .new(doc_extract_attributes(node)
            .merge(output_formats: ::Metanorma::Plateau::Processor.new
            .output_formats))
        end
      end
    end
  end
end
