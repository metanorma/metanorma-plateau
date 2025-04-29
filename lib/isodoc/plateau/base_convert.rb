require "isodoc"
require "metanorma-jis"
require_relative "init"

module IsoDoc
  module Plateau
    module BaseConvert

      def para_parse(node, out)
        out.p **attr_code(para_attrs(node)) do |p|
          @lang == "ja" and p << "&#x3000;"
          node.children.each { |n| parse(n, p) }
        end
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

      include Init
    end
  end
end
