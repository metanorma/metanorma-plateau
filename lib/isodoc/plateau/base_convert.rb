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

      include Init
    end
  end
end
