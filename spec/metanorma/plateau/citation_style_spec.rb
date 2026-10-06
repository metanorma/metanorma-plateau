require "spec_helper"
require "metanorma/plateau/citation_style"
require "relaton/bib"

RSpec.describe Metanorma::Plateau::CitationStyle do
  let(:home_jis) do
    <<~XML
      <bibitem type="standard" id="h">
        <title type="main" language="ja">電気及び関連分野―信号指定及び接続指定</title>
        <docidentifier type="JIS">JIS C 0450</docidentifier>
        <date type="published"><on>2004</on></date>
        <language>ja</language>
        <script>Jpan</script>
      </bibitem>
    XML
  end

  let(:iso_ref) do
    <<~XML
      <bibitem type="standard" id="i">
        <title type="main">Geographic information — Metadata</title>
        <docidentifier type="ISO">ISO 19115-1:2014</docidentifier>
        <contributor>
          <role type="publisher"/>
          <organization><name>International Organization for Standardization</name></organization>
        </contributor>
        <date type="published"><on>2014</on></date>
        <language>en</language>
      </bibitem>
    XML
  end

  describe "#render" do
    it "renders a home JIS standard title-first in the stddocTitle span" do
      expect(style("ja").render(Relaton::Bib::Item.from_xml(home_jis), embedded: true))
        .to eq("<span class='stddocTitle'>電気及び関連分野―信号指定及び接続指定</span>")
    end

    it "renders a home ISO standard the same way" do
      expect(style("ja").render(Relaton::Bib::Item.from_xml(iso_ref), embedded: true))
        .to eq("<span class='stddocTitle'>Geographic information — Metadata</span>")
    end
  end

  private

  def style(lang)
    described_class.new(language: lang)
  end
end
