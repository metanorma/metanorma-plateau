require "spec_helper"
require "nokogiri"

RSpec.describe IsoDoc::Plateau::Metadata do
  let (:input) { <<~INPUT }
       <jis-standard type="semantic" version="#{Metanorma::Plateau::VERSION}" xmlns="https://www.metanorma.org/ns/plateau">
            <bibdata type="standard">
        <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
        <title language="en" format="text/plain" type="title-intro">Introduction</title>
        <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
        <title language="en" format="text/plain" type="title-part">Title Part</title>
        <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
        <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
        <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
        <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
        <title language="en" type="title-part-prefix">Part 1</title>
          <title language="ja" type="title-part-prefix">その 1</title>
        <docidentifier type="PLATEAU">1000-1.3:2000</docidentifier>
        <docnumber>1000</docnumber>
        <date type="published">2020-10-11</date>
        <contributor>
          <role type="author"/>
          <organization>
            <name>Japanese Industrial Standards</name>
            <abbreviation>MLIT</abbreviation>
          </organization>
        </contributor>
        <contributor>
          <role type="publisher"/>
          <organization>
            <name>Japanese Industrial Standards</name>
            <abbreviation>MLIT</abbreviation>
          </organization>
        </contributor>
        <contributor>
           <role type="authorizer">
             <description>Investigative organization</description>
           </role>
           <organization>
               <name language="ja">日本産業標準調査会</name>
               <name language="en">Japanese Industrial Standards Committee</name>
           </organization>
         </contributor>
                    <contributor>
           <role type="authorizer">
             <description>Investigative committee</description>
           </role>
           <person>
             <name>
               <completename>KUROSAWA Akira</completename>
             </name>
             <affiliation>
               <organization>
                 <name>Committee 123</name>
               </organization>
             </affiliation>
           </person>
         </contributor>
         <contributor>
           <role type="authorizer">
             <description>Investigative committee</description>
           </role>
           <person>
             <name>
               <completename>MIFUNE Toshiro</completename>
             </name>
             <affiliation>
               <name>委員会長</name>
               <name>lead actor</name>
               <organization>
                 <name>Committee 123</name>
               </organization>
             </affiliation>
           </person>
         </contributor>
        <edition>2</edition>
        <version>
          <revision-date>2000-01-01</revision-date>
          <draft>0.3.4</draft>
        </version>
        <language>ja</language>
        <script>Jpan</script>
        <status>
          <stage abbreviation="WD">20</stage>
          <substage>20</substage>
          <iteration>3</iteration>
        </status>
        <copyright>
          <from>2000</from>
          <owner>
            <organization>
              <name>Japanese Industrial Standards</name>
              <abbreviation>JIS</abbreviation>
            </organization>
          </owner>
        </copyright>
        <ext>
          <doctype>standard</doctype>
          <horizontal>true</horizontal>
          <editorialgroup>
            <agency>MLIT</agency>
            <technical-committee number="1" type="A">TC</technical-committee>
            <technical-committee number="11" type="A1">TC1</technical-committee>
            <subcommittee number="2" type="B">SC</subcommittee>
            <subcommittee number="21" type="B1">SC1</subcommittee>
            <workgroup number="3" type="C">WG</workgroup>
            <workgroup number="31" type="C1">WG1</workgroup>
            <secretariat>SECRETARIAT</secretariat>
          </editorialgroup>
          <approvalgroup>
            <agency>ISO</agency>
            <agency>IEC</agency>
            <technical-committee number="1a" type="Aa">TCa</technical-committee>
            <technical-committee number="11a" type="A1a">TC1a</technical-committee>
            <subcommittee number="2a" type="Ba">SCa</subcommittee>
            <subcommittee number="21a" type="B1a">SC1a</subcommittee>
            <workgroup number="3a" type="Ca">WGa</workgroup>
            <workgroup number="31a" type="C1a">WG1a</workgroup>
          </approvalgroup>
          <structuredidentifier>
            <project-number part="1">JIS 1000</project-number>
          </structuredidentifier>
          <stagename abbreviation="WD">Working Draft International Standard</stagename>
        </ext>
      </bibdata>
      <metanorma-extension>
      <semantic-metadata>
      <stage-published>false</stage-published>
      </semantic-metadata>
      </metanorma-extension>
      <sections> </sections>
    </jis-standard>
  INPUT

  it "processes IsoXML metadata" do
    c = IsoDoc::Plateau::HtmlConvert.new({})
    _ = c.convert_init(<<~"INPUT", "test", false)
      <iso-standard xmlns="http://riboseinc.com/isoxml">
    INPUT
    output =
      { agency: "MLIT",
        authorizer: ["Japanese Industrial Standards Committee"],
        docnumber: "1000-1.3:2000",
        docnumber_undated: "1000-1.3",
        docnumeric: "1000",
        docsubtitle: "Introduction Française&#xa0;&#x2014; Titre Principal&#xa0;&#x2014; その 1： Part du Titre",
        docsubtitleintro: "Introduction Fran&#xe7;aise",
        docsubtitlemain: "Titre Principal",
        docsubtitlepart: "Part du Titre",
        docsubtitlepartlabel: "その&#xa0;1",
        doctitle: "Introduction&#xa0;&#x2014; Main Title — Title&#xa0;&#x2014; Part 1: Title Part",
        doctitleintro: "Introduction",
        doctitlemain: "Main Title&#x2009;&#x2014;&#x2009;Title",
        doctitlepart: "Title Part",
        doctitlepartlabel: "Part&#xa0;1",
        doctype: "Standard",
        doctype_display: "Standard",
        docyear: "2000",
        draft: "0.3.4",
        draftinfo: " (draft 0.3.4, 2000-01-01)",
        edition: "2",
        horizontal: "true",
        "investigative-committee": "Committee 123",
        "investigative-committee-representative-name": "KUROSAWA Akira",
        "investigative-committee-representative-role": "chairperson",
        "investigative-organization": "Japanese Industrial Standards Committee",
        lang: "en",
        published_date_labelled: "Published: 2020-10-11",
        publisheddate: "2020-10-11",
        publisher: "Japanese Industrial Standards",
        revdate: "2000-01-01",
        revdate_monthyear: "January 2000",
        script: "Latn",
        stage: "20",
        stage_int: 20,
        stageabbr: "WD",
        statusabbr: "PreWD3",
        substage_int: "20",
        unpublished: true }
    expect(metadata(c.info(Nokogiri::XML(input),
                           nil))).to be_equivalent_to output

    c = IsoDoc::Plateau::HtmlConvert.new({})
    _ = c.convert_init(<<~"INPUT", "test", false)
      <iso-standard xmlns="http://riboseinc.com/isoxml">
       <bibdata>
          <language>ja</language>
        </bibdata>
      </iso-standard>
    INPUT
    output =
      { agency: "MLIT",
        authorizer: ["日本産業標準調査会"],
        docnumber: "1000-1.3:2000",
        docnumber_undated: "1000-1.3",
        docnumeric: "1000",
        docsubtitle: "Introduction&#xa0;&#x2014; Main Title — Title&#xa0;&#x2014; Part 1: Title Part",
        docsubtitleintro: "Introduction",
        docsubtitlemain: "Main Title&#x2009;&#x2014;&#x2009;Title",
        docsubtitlepart: "Title Part",
        docsubtitlepartlabel: "Part&#xa0;1",
        doctitle: "Introduction Française&#xa0;&#x2014; Titre Principal&#xa0;&#x2014; その 1： Part du Titre",
        doctitleintro: "Introduction Fran&#xE7;aise",
        doctitlemain: "Titre Principal",
        doctitlepart: "Part du Titre",
        doctitlepartlabel: "その&#xa0;1",
        doctype: "Standard",
        doctype_display: "Standard",
        docyear: "2000",
        draft: "0.3.4",
        draftinfo: " （案 0.3.4、平成12年1月1日）",
        edition: "2",
        horizontal: "true",
        "investigative-committee": "Committee 123",
        "investigative-committee-representative-name": "KUROSAWA Akira",
        "investigative-committee-representative-role": "&#x59d4;&#x54e1;&#x4f1a;&#x9577;",
        "investigative-organization": "&#x65e5;&#x672c;&#x7523;&#x696d;&#x6a19;&#x6e96;&#x8abf;&#x67fb;&#x4f1a;",
        lang: "ja",
        published_date_labelled: "令和2年10月11日　発行",
        publisheddate: "令和2年10月11日",
        publisher: "Japanese Industrial Standards",
        revdate: "平成12年1月1日",
        revdate_monthyear: "1月 2000",
        script: "Jpan",
        stage: "20",
        stage_int: 20,
        stageabbr: "WD",
        statusabbr: "PreWD3",
        substage_int: "20",
        unpublished: true }
    expect(metadata(c.info(Nokogiri::XML(input),
                           nil))).to be_equivalent_to output
  end

  it "internationalises IsoXML metadata" do
    output = <<~OUTPUT
      <jis-standard xmlns="https://www.metanorma.org/ns/plateau" type="presentation" version="#{Metanorma::Plateau::VERSION}">
         <bibdata type="standard">
            <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
            <title language="en" format="text/plain" type="title-intro">Introduction</title>
            <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
            <title language="en" format="text/plain" type="title-part">Title Part</title>
            <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
            <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
            <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
            <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
            <title language="en" type="title-part-prefix">Part 1</title>
            <title language="ja" type="title-part-prefix">その 1</title>
            <docidentifier type="PLATEAU">1000-1.3:2000</docidentifier>
            <docnumber>1000</docnumber>
            <date type="published">令和2年10月11日</date>
            <date type="published" language="ja">令和2年10月11日</date>
            <date type="published" language="en">2020-10-11</date>
            <contributor>
               <role type="author"/>
               <organization>
                  <name>Japanese Industrial Standards</name>
                  <abbreviation>MLIT</abbreviation>
               </organization>
            </contributor>
            <contributor>
               <role type="publisher"/>
               <organization>
                  <name>Japanese Industrial Standards</name>
                  <abbreviation>MLIT</abbreviation>
               </organization>
            </contributor>
            <contributor>
               <role type="authorizer">
                  <description>Investigative organization</description>
               </role>
               <organization>
                  <name language="ja">日本産業標準調査会</name>
                  <name language="en">Japanese Industrial Standards Committee</name>
               </organization>
            </contributor>
            <contributor>
               <role type="authorizer">
                  <description>Investigative committee</description>
               </role>
               <person>
                  <name>
                     <completename>KUROSAWA Akira</completename>
                  </name>
                  <affiliation>
                     <organization>
                        <name>Committee 123</name>
                     </organization>
                  </affiliation>
               </person>
            </contributor>
            <contributor>
               <role type="authorizer">
                  <description>Investigative committee</description>
               </role>
               <person>
                  <name>
                     <completename>MIFUNE Toshiro</completename>
                  </name>
                  <affiliation>
                     <name>委員会長</name>
                     <name>lead actor</name>
                     <organization>
                        <name>Committee 123</name>
                     </organization>
                  </affiliation>
               </person>
            </contributor>
            <edition language="">2</edition>
            <edition language="ja">第2版</edition>
            <edition language="ja" numberonly="true">2</edition>
            <edition language="en">second edition</edition>
            <edition language="en" numberonly="true">2</edition>
            <version>
               <revision-date>2000-01-01</revision-date>
               <draft>0.3.4</draft>
            </version>
            <language current="true">ja</language>
            <script current="true">Jpan</script>
            <status>
               <stage abbreviation="WD" language="">20</stage>
               <stage abbreviation="WD" language="ja">Working draft</stage>
               <stage abbreviation="WD" language="en">Working draft</stage>
               <substage>20</substage>
               <iteration>3</iteration>
            </status>
            <copyright>
               <from>2000</from>
               <owner>
                  <organization>
                     <name>Japanese Industrial Standards</name>
                     <abbreviation>JIS</abbreviation>
                  </organization>
               </owner>
            </copyright>
            <ext>
               <doctype>standard</doctype>
               <horizontal>true</horizontal>
               <editorialgroup>
                  <agency>MLIT</agency>
                  <technical-committee number="1" type="A">TC</technical-committee>
                  <technical-committee number="11" type="A1">TC1</technical-committee>
                  <subcommittee number="2" type="B">SC</subcommittee>
                  <subcommittee number="21" type="B1">SC1</subcommittee>
                  <workgroup number="3" type="C">WG</workgroup>
                  <workgroup number="31" type="C1">WG1</workgroup>
                  <secretariat>SECRETARIAT</secretariat>
               </editorialgroup>
               <approvalgroup>
                  <agency>ISO</agency>
                  <agency>IEC</agency>
                  <technical-committee number="1a" type="Aa">TCa</technical-committee>
                  <technical-committee number="11a" type="A1a">TC1a</technical-committee>
                  <subcommittee number="2a" type="Ba">SCa</subcommittee>
                  <subcommittee number="21a" type="B1a">SC1a</subcommittee>
                  <workgroup number="3a" type="Ca">WGa</workgroup>
                  <workgroup number="31a" type="C1a">WG1a</workgroup>
               </approvalgroup>
               <structuredidentifier>
                  <project-number part="1">JIS 1000</project-number>
               </structuredidentifier>
               <stagename abbreviation="WD">Working Draft International Standard</stagename>
            </ext>
         </bibdata>

         <metanorma-extension>
            <semantic-metadata>
               <stage-published>false</stage-published>
            </semantic-metadata>
         </metanorma-extension>
         <preface>
            <clause type="toc" id="_" displayorder="1">
               <fmt-title depth="1" id="_">目　次</fmt-title>
            </clause>
         </preface>
         <sections> </sections>
      </jis-standard>
    OUTPUT
    expect(Canon.format_xml(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
  .new(presxml_options)
  .convert("test", input, true)))
  .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to Canon.format_xml(output)

    output = <<~OUTPUT
      <jis-standard xmlns="https://www.metanorma.org/ns/plateau" type="presentation" version="1.2.3">
         <bibdata type="standard">
            <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
            <title language="en" format="text/plain" type="title-intro">Introduction</title>
            <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
            <title language="en" format="text/plain" type="title-part">Title Part</title>
            <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
            <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
            <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
            <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
            <title language="en" type="title-part-prefix">Part 1</title>
            <title language="ja" type="title-part-prefix">その 1</title>
            <docidentifier type="PLATEAU">1000-1.3:2000</docidentifier>
            <docnumber>1000</docnumber>
            <date type="published">令和2年10月11日</date>
            <date type="published" language="ja">令和2年10月11日</date>
            <date type="published" language="en">2020-10-11</date>
            <contributor>
               <role type="author"/>
               <organization>
                  <name>Japanese Industrial Standards</name>
                  <abbreviation>MLIT</abbreviation>
               </organization>
            </contributor>
            <contributor>
               <role type="publisher"/>
               <organization>
                  <name>Japanese Industrial Standards</name>
                  <abbreviation>MLIT</abbreviation>
               </organization>
            </contributor>
            <contributor>
               <role type="authorizer">
                  <description>Investigative organization</description>
               </role>
               <organization>
                  <name language="ja">日本産業標準調査会</name>
                  <name language="en">Japanese Industrial Standards Committee</name>
               </organization>
            </contributor>
            <contributor>
               <role type="authorizer">
                  <description>Investigative committee</description>
               </role>
               <person>
                  <name>
                     <completename>KUROSAWA Akira</completename>
                  </name>
                  <affiliation>
                     <organization>
                        <name>Committee 123</name>
                     </organization>
                  </affiliation>
               </person>
            </contributor>
            <contributor>
               <role type="authorizer">
                  <description>Investigative committee</description>
               </role>
               <person>
                  <name>
                     <completename>MIFUNE Toshiro</completename>
                  </name>
                  <affiliation>
                     <name>委員会長</name>
                     <name>lead actor</name>
                     <organization>
                        <name>Committee 123</name>
                     </organization>
                  </affiliation>
               </person>
            </contributor>
            <edition language="">2</edition>
            <edition language="ja">第2版</edition>
            <edition language="ja" numberonly="true">2</edition>
            <edition language="en">second edition</edition>
            <edition language="en" numberonly="true">2</edition>
            <version>
               <revision-date>2000-01-01</revision-date>
               <draft>0.3.4</draft>
            </version>
            <language current="true">ja</language>
            <script current="true">Jpan</script>
            <status>
               <stage abbreviation="WD" language="">20</stage>
               <stage abbreviation="WD" language="ja">Working draft</stage>
               <stage abbreviation="WD" language="en">Working draft</stage>
               <substage>20</substage>
               <iteration>3</iteration>
            </status>
            <copyright>
               <from>2000</from>
               <owner>
                  <organization>
                     <name>Japanese Industrial Standards</name>
                     <abbreviation>JIS</abbreviation>
                  </organization>
               </owner>
            </copyright>
            <ext>
               <doctype>standard</doctype>
               <horizontal>true</horizontal>
               <editorialgroup>
                  <agency>MLIT</agency>
                  <technical-committee number="1" type="A">TC</technical-committee>
                  <technical-committee number="11" type="A1">TC1</technical-committee>
                  <subcommittee number="2" type="B">SC</subcommittee>
                  <subcommittee number="21" type="B1">SC1</subcommittee>
                  <workgroup number="3" type="C">WG</workgroup>
                  <workgroup number="31" type="C1">WG1</workgroup>
                  <secretariat>SECRETARIAT</secretariat>
               </editorialgroup>
               <approvalgroup>
                  <agency>ISO</agency>
                  <agency>IEC</agency>
                  <technical-committee number="1a" type="Aa">TCa</technical-committee>
                  <technical-committee number="11a" type="A1a">TC1a</technical-committee>
                  <subcommittee number="2a" type="Ba">SCa</subcommittee>
                  <subcommittee number="21a" type="B1a">SC1a</subcommittee>
                  <workgroup number="3a" type="Ca">WGa</workgroup>
                  <workgroup number="31a" type="C1a">WG1a</workgroup>
               </approvalgroup>
               <structuredidentifier>
                  <project-number part="1">JIS 1000</project-number>
               </structuredidentifier>
               <stagename abbreviation="WD">Working Draft International Standard</stagename>
            </ext>
         </bibdata>

         <metanorma-extension>
            <semantic-metadata>
               <stage-published>false</stage-published>
            </semantic-metadata>
         </metanorma-extension>
         <preface>
            <clause type="toc" id="_" displayorder="1">
               <fmt-title depth="1" id="_">目　次</fmt-title>
            </clause>
         </preface>
         <sections> </sections>
      </jis-standard>
    OUTPUT
    expect(Canon.format_xml(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
    .new(presxml_options)
    .convert("test", input.sub("<language>en</language>",
                               "<language>ja</language"), true)))
    .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to Canon.format_xml(output)
  end

  it "internationalises dates in bibdata" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
        <bibdata>
        <language>en</language>
          <date type="created">2020-10-11</date>
          <date type="issued">2020-10</date>
          <date type="published">2020</date>
        </bibdata>
      </iso-standard>
    INPUT
    output = <<~OUTPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <bibdata>
             <language current="true">en</language>
             <date type="created">2020-10-11</date>
             <date type="created" language="en">2020-10-11</date>
             <date type="created" language="ja">令和2年10月11日</date>
             <date type="issued">2020-10</date>
             <date type="issued" language="en">2020-10</date>
             <date type="issued" language="ja">令和2年10月</date>
             <date type="published">2020</date>
             <date type="published" language="en">2020</date>
             <date type="published" language="ja">令和2年</date>
          </bibdata>
       </iso-standard>
    OUTPUT
    expect(Canon.format_xml(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)))
      .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to Canon.format_xml(output)
    output = <<~OUTPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <bibdata>
             <language current="true">ja</language>
             <date type="created">令和2年10月11日</date>
             <date type="created" language="ja">令和2年10月11日</date>
             <date type="created" language="en">2020-10-11</date>
             <date type="issued">令和2年10月</date>
             <date type="issued" language="ja">令和2年10月</date>
             <date type="issued" language="en">2020-10</date>
             <date type="published">令和2年</date>
             <date type="published" language="ja">令和2年</date>
             <date type="published" language="en">2020</date>
          </bibdata>
       </iso-standard>
    OUTPUT
    expect(Canon.format_xml(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input.sub!("<language>en</language>",
                                  "<language>ja</language"), true)))
      .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to Canon.format_xml(output)

    input.sub!("</bibdata>", <<~SUB
      </bibdata><metanorma-extension>
      <presentation-metadata><autonumbering-style>japanese</autonumbering-style></presentation-metadata>
      </metanorma-extension>
    SUB
    )
    output = <<~OUTPUT
          <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
         <bibdata>
            <language current="true">ja</language>
            <date type="created">令和二年十月十一日</date>
            <date type="created" language="ja">令和二年十月十一日</date>
            <date type="created" language="en">2020-10-11</date>
            <date type="issued">令和二年十月</date>
            <date type="issued" language="ja">令和二年十月</date>
            <date type="issued" language="en">2020-10</date>
            <date type="published">令和二年</date>
            <date type="published" language="ja">令和二年</date>
            <date type="published" language="en">2020</date>
         </bibdata>
      </iso-standard>
    OUTPUT
    expect(Canon.format_xml(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .sub(%r{<metanorma-extension>.*</metanorma-extension>}m, "")
      .sub(%r{<localized-strings>.*</localized-strings>}m, "")))
      .to be_equivalent_to Canon.format(output)
  end
end
