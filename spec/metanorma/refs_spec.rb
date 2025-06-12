require "spec_helper"
require "relaton_iso"

RSpec.describe Metanorma::Plateau do
  it "sorts bibliography" do
    input = <<~INPUT
      #{LOCAL_CACHED_ISOBIB_BLANK_HDR}

      [bibliography]
      == Bibliography

      * [[[ref1,PLATEAU Technical Report #00]]]
      * [[[ref2,RFC 7749]]]
      * [[[ref4,PLATEAU Handbook #11 第1.0版（民間活用編）]]]
      * [[[ref5,ISO 639]]]

      [[ref3]]
      [%bibitem]
      === Indiana Jones and the Last Crusade
      type:: book
      title::
        type::: main
        content::: Indiana Jones and the Last Crusade

      ==== Contributor
      organization::
        name::: International Organization for Standardization
        abbreviation::: ISO
      role::
        type::: publisher

      ==== Contributor
      person::
        name:::
          surname:::: Jones
          forename:::: Indiana

      [[ref6]]
      [%bibitem]
      === “Indiana Jones and your Last Crusade”
      type:: book
      title::
        type::: main
        content::: Indiana Jones and your Last Crusade

      ==== Contributor
      organization::
        name::: International Organization for Standardization
        abbreviation::: ISO
      role::
        type::: publisher

      ==== Contributor
      person::
        name:::
          surname:::: Jones
          forename:::: Indiana


    INPUT
      out = Nokogiri::XML(Asciidoctor.convert(input, *OPTIONS))
      expect(out.xpath("//xmlns:references/xmlns:bibitem/@anchor")
        .map(&:value))
        .to be_equivalent_to ["ref1", "ref3", "ref6", "ref5", "ref2", "ref4"]

      out = Nokogiri::XML(Asciidoctor.convert(input
        .sub("== Bibliography", "== Normative References"), *OPTIONS))
      expect(out.xpath("//xmlns:references/xmlns:bibitem/@anchor")
        .map(&:value))
        .to be_equivalent_to ["ref1", "ref3", "ref6", "ref5", "ref2", "ref4"]
  end
end
