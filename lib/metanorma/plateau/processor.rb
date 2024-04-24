require "metanorma/processor"

module Metanorma
  module Plateau
    class Processor < Metanorma::JIS::Processor
      def initialize # rubocop:disable Lint/MissingSuper
        @short = :plateau
        @input_format = :asciidoc
        @asciidoctor_backend = :plateau
      end

      def output_formats
        super.merge(
          html: "html",
          pdf: "pdf",
          doc: "doc",
        )
      end

      def fonts_manifest
        {
          "STIX Two Math" => nil,
          "IPAexGothic" => nil,
          "IPAexMincho" => nil,
          "Courier New" => nil,
          "Cambria Math" => nil,
          "Times New Roman" => nil,
          "Arial" => nil,
        }
      end

      def version
        "Metanorma::JIS #{Metanorma::JIS::VERSION}"
      end

      def output(xml, inname, outname, format, options = {})
        options_preprocess(options)
        case format
        when :html
          IsoDoc::Plateau::HtmlConvert.new(options).convert(inname, xml, nil,
                                                            outname)
        when :doc
          IsoDoc::Plateau::WordConvert.new(options).convert(inname, xml, nil,
                                                            outname)
        when :pdf
          IsoDoc::Plateau::PdfConvert.new(options).convert(inname, xml, nil,
                                                           outname)
        when :presentation
          IsoDoc::Plateau::PresentationXMLConvert.new(options).convert(inname, xml,
                                                                       nil, outname)
        else
          super
        end
      end
    end
  end
end
