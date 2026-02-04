require "isodoc"
require "metanorma-jis"
require_relative "init"

module IsoDoc
  module Plateau
    module BaseConvert
      def para_prefix(_node, out)
        @lang == "ja" and out << "&#x3000;"
      end

      def clause_etc1(clause, out, num)
        out.div **attr_code(
          id: clause["id"],
          class: clause.name == "definitions" ? "Symbols" : nil,
        ) do |div|
          num = num + 1
          clause_name(clause, clause&.at(ns("./fmt-title")), div, nil)
          clause.elements.each do |e|
            parse(e, div) unless %w{fmt-title}.include? e.name
          end
        end
      end

      def colophon(node, out)
        @seen_colophon or page_break(out)
        @seen_colophon = true
        out.div class: "colophon", id: node["id"] do |div|
          clause_name(node, node.at(ns("./fmt-title")), div,
                      { class: "IntroTitle" })
          node.elements.each do |e|
            parse(e, div) unless e.name == "fmt-title"
          end
        end
      end

      include Init
    end
  end
end
