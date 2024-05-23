require "metanorma-jis"
require_relative "cleanup"

module Metanorma
  module Plateau
    class Converter < JIS::Converter
      register_for "plateau"

      XML_ROOT_TAG = "plateau-standard".freeze
      XML_NAMESPACE = "https://www.metanorma.org/ns/plateau".freeze

      def schema_version
        f = File.read(File.join(File.dirname(__FILE__), "..", "plateau", "isodoc.rng"))
        m = / VERSION (v\S+)/.match(f)
        m[1]
      end

      def validate(doc)
        content_validate(doc)
        schema_validate(formattedstr_strip(doc.dup),
                        File.join(File.dirname(__FILE__), "plateau.rng"))
      end

      def metadata_ext(node, xml)
        super
        metadata_coverpage_images(node, xml)
      end

      def metadata_coverpage_images(node, xml)
        %w(coverpage-image).each do |n|
          if a = node.attr(n)
            xml.send n do |c|
              a.split(",").each do |x|
                c.image src: x
              end
            end
          end
        end
      end

      def sectiontype(node, level = true)
        ret = sectiontype1(node)
        ret1 = preface_main_filter(sectiontype_streamline(ret), node)
        ret1 == "symbols and abbreviated terms" and return ret1
        #!level || node.attr("heading") or return nil
        !level || node.level == 1 || node.attr("heading") or return nil
        @seen_headers.include? ret and return nil
        @seen_headers << ret unless ret1.nil?
        @seen_headers_canonical << ret1 unless ret1.nil?
        ret1
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
