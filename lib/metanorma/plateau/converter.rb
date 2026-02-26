require "metanorma-jis"
require_relative "cleanup"

module Metanorma
  module Plateau
    class Converter < Jis::Converter
      register_for "plateau"

      def default_requirement_model
        "ogc"
      end

      def org_abbrev
        super.merge(pub_hash["en"] => "MLIT")
      end

      def default_publisher
        "MLIT"
      end

      def init_misc(node)
        super
        @default_doctype = "technical-report"
      end

      # Plateau reuse of the JIS publisher default setting
      def pub_hash
        { "ja" => "国土交通省",
          "en" => "Ministry of Land, Infrastructure, Transport and Tourism" }
      end

      def doctype_validate(_xmldoc)
        %w(handbook technical-report annex).include? @doctype or
          @log.add("PLATEAU_1", nil, params: [@doctype])
      end

      def metadata_id_docidentifier(node, xml)
        id = node.attr("docidentifier")
        add_noko_elem(xml, "docidentifier", "PLATEAU #{id.sub(/^PLATEAU /, '')}",
                      primary: "true",
                      boilerplate: true,
                      type: metadata_id_primary_type(node))
      end

      def metadata_id_primary_type(_node)
        "PLATEAU"
      end

      # do not use pubid
      def metadata_id_primary(node, xml)
        id = node.attr("docnumber") or return
        add_noko_elem(xml, "docidentifier",
                      "PLATEAU #{id.sub(/^PLATEAU /, '')}", type: "PLATEAU",
                                                            primary: "true")
      end

      # do not use pubid
      def metadata_status(node, xml)
        stage = get_stage(node)
        xml.status do |s|
          add_noko_elem(s, "stage", stage,
                        abbreviation: node.attr("docstage-abbrev"))
          add_noko_elem(s, "iteration", node.attr("iteration"))
        end
      end

      def metadata_stage(node, xml); end

      def html_converter(node)
        if node.nil?
          IsoDoc::Plateau::HtmlConvert.new({})
        else
          IsoDoc::Plateau::HtmlConvert.new(html_extract_attributes(node))
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

require_relative "log"
