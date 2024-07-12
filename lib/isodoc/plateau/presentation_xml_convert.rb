require_relative "init"

module IsoDoc
  module Plateau
    class PresentationXMLConvert < IsoDoc::JIS::PresentationXMLConvert
      def toc_title_insert_pt(docxml)
        ins = docxml.at(ns("//preface")) ||
          docxml.at(ns("//sections | //annex | //bibliography"))
            &.before("<preface> </preface>")
            &.previous_element or return nil
        ins.children.empty? and ins << " "
        a = ins.at(ns("./abstract[last()]")) and return a.after(" ").next
        ins.children.first
      end

      def middle_title(docxml); end

      include Init
    end
  end
end
