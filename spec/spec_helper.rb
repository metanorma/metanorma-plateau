require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
end

require "bundler/setup"
require "asciidoctor"
require "metanorma-plateau"
require "rspec/matchers"
require "equivalent-xml"
require "metanorma"
require "metanorma/plateau"
require "canon"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def metadata(xml)
  xml.sort.to_h.delete_if do |_k, v|
    v.nil? || (v.respond_to?(:empty?) && v.empty?)
  end
end

def strip_guid(xml)
  xml.gsub(%r{ id="_[^"]+"}, ' id="_"')
    .gsub(%r{ semx-id="[^"]*"}, '')
    .gsub(%r{ original-id="_[^"]+"}, ' original-id="_"')
    .gsub(%r{ target="_[^"]+"}, ' target="_"')
    .gsub(%r{ target="_[^"]+"}, ' target="_"')
    .gsub(%r{ source="_[^"]+"}, ' source="_"')
    .gsub(%r{ name="_[^"]+"}, ' name="_"')
    .gsub(%r( href="#_?[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12,13}\)?"), ' href="#_"')
    .gsub(%r( href="#(fn:)_?[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12,13}\)?"), ' href="#fn:_"')
    .gsub(%r( id="[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{13}\)?"), ' id="_"')
    .gsub(%r( id="ftn[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{13}"), ' id="ftn_"')
    .gsub(%r( id="fn:_?[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12,13}\)?"), ' id="fn:_"')
    .gsub(%r[ src="([^/]+)/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\.], ' src="\\1/_.')
    .gsub(%r{<fetched>[^<]+</fetched>}, "<fetched/>")
    .gsub(%r{ schema-version="[^"]+"}, "")
end

ASCIIDOC_BLANK_HDR = <<~HDR.freeze
  = Document title
  Author
  :docfile: test.adoc
  :nodoc:
  :novalid:
  :no-isobib:
  :docnumber: 0

HDR

ISOBIB_BLANK_HDR = <<~HDR.freeze
  = Document title
  Author
  :docfile: test.adoc
  :nodoc:
  :novalid:
  :no-isobib-cache:
  :docnumber: 0

HDR

FLUSH_CACHE_ISOBIB_BLANK_HDR = <<~HDR.freeze
  = Document title
  Author
  :docfile: test.adoc
  :nodoc:
  :novalid:
  :flush-caches:
  :docnumber: 0

HDR

CACHED_ISOBIB_BLANK_HDR = <<~HDR.freeze
  = Document title
  Author
  :docfile: test.adoc
  :nodoc:
  :novalid:
  :docnumber: 0

HDR

LOCAL_CACHED_ISOBIB_BLANK_HDR = <<~HDR.freeze
  = Document title
  Author
  :docfile: test.adoc
  :nodoc:
  :novalid:
  :local-cache: spec/relatondb
  :docnumber: 0

HDR

VALIDATING_BLANK_HDR = <<~HDR.freeze
  = Document title
  Author
  :docfile: test.adoc
  :nodoc:
  :no-isobib:
  :docnumber: 0

HDR

def middle_title(word, number = "", year = "")
  yr = ""
  year and !year.blank? and yr = <<~YR
    :
      <span class="EffectiveYear">#{year}</span>
  YR
  <<~HDR
    <p class="JapaneseIndustrialStandard">
      日本工業規格#{word ? '<span style="mso-tab-count:1">  </span>' * 7 : '              '}<span class="JIS">JIS</span>
    </p>
    <p class="StandardNumber">
      #{word ? '<span style="mso-tab-count:1">  </span>' : ' '} #{number}#{yr}
    </p>
    <p class="IDT"/>
  HDR
end

TERMS_BOILERPLATE = "".freeze

def boilerplate_read(file)
  HTMLEntities.new.decode(
    Metanorma::Plateau::Converter
    .new(:plateau, {}).boilerplate_file_restructure(file)
    .to_xml.gsub(/<(\/)?sections>/, "<\\1boilerplate>")
      .gsub(/ id="_[^"]+"/, " id='_'"),
  )
end

ASCIIDOCTOR_ISO_DIR = Pathname
  .new(File.dirname(__FILE__)) / "../lib/metanorma/plateau"

BOILERPLATE = "".freeze

BLANK_HDR = <<~"HDR".freeze
  <?xml version="1.0" encoding="UTF-8"?>
  <metanorma xmlns="https://www.metanorma.org/ns/standoc" type="semantic" version="#{Metanorma::Plateau::VERSION}" flavor="plateau">
  <bibdata type="standard">
      <docidentifier primary="true" type="JIS">0:#{Date.today.year}</docidentifier>
    <docnumber>0</docnumber>
    <contributor>
      <role type="author"/>
      <organization>
        <name>
          <variant language="ja">日本工業規格</variant>
          <variant language="en">Japanese Industrial Standards</variant>
        </name>
        <abbreviation>JIS</abbreviation>
      </organization>
    </contributor>
    <contributor>
      <role type="publisher"/>
      <organization>
        <name>
          <variant language="ja">日本工業規格</variant>
          <variant language="en">Japanese Industrial Standards</variant>
        </name>
        <abbreviation>JIS</abbreviation>
      </organization>
    </contributor>
    <language>ja</language>
    <script>Jpan</script>
    <status>
    <stage>60</stage>
    <substage>60</substage>
    </status>
    <copyright>
      <from>#{Time.new.year}</from>
      <owner>
        <organization>
                  <name>
            <variant language="ja">日本工業規格</variant>
            <variant language="en">Japanese Industrial Standards</variant>
          </name>
          <abbreviation>JIS</abbreviation>
        </organization>
      </owner>
    </copyright>
    <ext>
      <doctype>japanese-industrial-standard</doctype>
    <editorialgroup>
      <agency>JIS</agency>
    </editorialgroup>
          <approvalgroup>
        <agency>JIS</agency>
      </approvalgroup>
           <structuredidentifier>
       <project-number>0</project-number>
     </structuredidentifier>
    </ext>
  </bibdata>
  <metanorma-extension>
      <presentation-metadata>
      <name>TOC Heading Levels</name>
      <value>2</value>
    </presentation-metadata>
    <presentation-metadata>
      <name>HTML TOC Heading Levels</name>
      <value>2</value>
    </presentation-metadata>
    <presentation-metadata>
      <name>DOC TOC Heading Levels</name>
      <value>3</value>
    </presentation-metadata>
    <presentation-metadata>
      <name>PDF TOC Heading Levels</name>
      <value>3</value>
    </presentation-metadata>
  </metanorma-extension>
HDR

def blank_hdr_gen
  <<~"HDR"
    #{BLANK_HDR}
    #{BOILERPLATE}
  HDR
end

HTML_HDR = <<~HDR.freeze
  <html xmlns:epub="http://www.idpf.org/2007/ops" lang="en">
    <head/>
    <body lang="en">
      <div class="title-section">
        <p>&#160;</p>
      </div>
      <br/>
      <div class="prefatory-section">
        <p>&#160;</p>
      </div>
      <br/>
      <div class="main-section">
HDR

OPTIONS = [backend: :plateau, header_footer: true].freeze

def presxml_options
  { semanticxmlinsert: "false" }
end

def mock_pdf
  allow(Mn2pdf).to receive(:convert) do |url, output, _c, _d|
    FileUtils.cp(url.gsub('"', ""), output.gsub('"', ""))
  end
end

private

def get_xml(search, code, opts)
  c = code.gsub(%r{[/\s:-]}, "_").sub(%r{_+$}, "").downcase
  o = opts.keys.join "_"
  file = "spec/examples/#{[c, o].join '_'}.xml"
  if File.exist? file
    File.read file
  else
    result = search.call(code)
    hit = result&.first&.first
    xml = hit.to_xml nil, opts
    File.write file, xml
    xml
  end
end
