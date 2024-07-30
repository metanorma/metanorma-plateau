require "spec_helper"

RSpec.describe Metanorma::Plateau do
  before do
    allow_any_instance_of(Relaton::Index::FileIO)
      .to receive(:check_file).and_return(nil)
  end

  it "sorts normative references" do
    VCR.use_cassette "sortrefs" do
      input = <<~INPUT
        = Document title
        Author
        :docfile: test.adoc
        :nodoc:
        :no-isobib-cache:

        [bibliography]
        == Normative References

        * [[[ref1,PLATEAU Handbook #00]]]
        * [[[ref2,RFC 7749]]]
        * [[[ref3,REF4]]]
        * [[[ref4,PLATEAU Handbook #01]]]
        * [[[ref5,ISO 639]]]
        * [[[ref6,REF5]]]

        [[ref4]]
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

        [[ref5]]
        [%bibitem]
        === “Indiana Jones and your Last Crusade”
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


      INPUT
      out = Nokogiri::XML(Asciidoctor.convert(input, *OPTIONS))
      expect(out.xpath("//xmlns:references/xmlns:bibitem/@id")
        .map(&:value)).to be_equivalent_to ["ref2", "ref1", "ref4", "ref5",
                                            "ref3"]
    end
  end
end
