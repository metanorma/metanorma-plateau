require "spec_helper"
require "relaton_iso"

RSpec.describe Metanorma::Plateau do
  it "Warns of illegal doctype" do
    Asciidoctor.convert(<<~INPUT, *OPTIONS)
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :no-isobib:
      :doctype: standard

      text
    INPUT
    expect(File.read("test.err.html"))
      .to include("standard is not a recognised document type")
  end 

  it "validates document against Metanorma XML schema" do
    Asciidoctor.convert(<<~"INPUT", *OPTIONS)
      = A
      X
      :docfile: test.adoc
      :no-pdf:

      [align=mid-air]
      Para
    INPUT
    expect(File.read("test.err.html"))
      .to include('value of attribute "align" is invalid; must be equal to')
  end
end
