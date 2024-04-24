require "spec_helper"
RSpec.describe Metanorma::Plateau do
  before do
    # Force to download Relaton index file
    allow_any_instance_of(Relaton::Index::Type).to receive(:actual?)
      .and_return(false)
    allow_any_instance_of(Relaton::Index::FileIO).to receive(:check_file)
      .and_return(nil)
  end

  it "processes default metadata" do
    input = <<~INPUT
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
      :docnumber: 1000
      :docseries: Z
      :partnumber: 1
      :edition: 2
      :revdate: 2000-01-01
      :draft: 0.3.4
      :announced-date: 2000-02-01
      :technical-committee: TC
      :technical-committee-number: 1
      :technical-committee-type: A
      :subcommittee: SC
      :subcommittee-number: 2
      :subcommittee-type: B
      :workgroup: WG
      :workgroup-number: 3
      :workgroup-type: C
      :technical-committee_2: TC1
      :technical-committee-number_2: 11
      :technical-committee-type_2: A1
      :subcommittee_2: SC1
      :subcommittee-number_2: 21
      :subcommittee-type_2: B1
      :workgroup_2: WG1
      :workgroup-number_2: 31
      :workgroup-type_2: C1
      :secretariat: SECRETARIAT
      :approval-technical-committee: TCa
      :approval-technical-committee-number: 1a
      :approval-technical-committee-type: Aa
      :approval-subcommittee: SCa
      :approval-subcommittee-number: 2a
      :approval-subcommittee-type: Ba
      :approval-workgroup: WGa
      :approval-workgroup-number: 3a
      :approval-workgroup-type: Ca
      :approval-technical-committee_2: TC1a
      :approval-technical-committee-number_2: 11a
      :approval-technical-committee-type_2: A1a
      :approval-subcommittee_2: SC1a
      :approval-subcommittee-number_2: 21a
      :approval-subcommittee-type_2: B1a
      :approval-workgroup_2: WG1a
      :approval-workgroup-number_2: 31a
      :approval-workgroup-type_2: C1a
      :approval-agency: ISO/IEC
      :docstage: 20
      :docsubstage: 20
      :iteration: 3
      :title-intro-en: Introduction
      :title-main-en: Main Title -- Title
      :title-part-en: Title Part
      :title-intro-ja: Introduction Française
      :title-main-ja: Titre Principal
      :title-part-ja: Part du Titre
      :copyright-year: 2000
      :horizontal: true
      :investigative-organization-ja: 日本産業標準調査会
      :investigative-organization-en: Japanese Industrial Standards Committee
      :investigative-committee: 日本産業標準調査会 標準第一部会
    INPUT
    output = <<~OUTPUT
      <jis-standard type="semantic" version="#{Metanorma::JIS::VERSION}" xmlns="https://www.metanorma.org/ns/jis">
               <bibdata type="standard">
           <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
           <title language="en" format="text/plain" type="title-intro">Introduction</title>
           <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
           <title language="en" format="text/plain" type="title-part">Title Part</title>
           <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
           <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
           <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
           <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
           <docidentifier primary="true" type="JIS">Z 1000-1:2000</docidentifier>
           <docnumber>1000</docnumber>
           <date type="announced">
              <on>2000-02-01</on>
           </date>
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
                      <contributor>
             <role type="authorizer">
               <description>Investigative organization</description>
             </role>
             <organization>
               <name>
                 <variant language="ja">日本産業標準調査会</variant>
                 <variant language="en">Japanese Industrial Standards Committee</variant>
               </name>
             </organization>
           </contributor>
           <contributor>
             <role type="authorizer">
               <description>Investigative committee</description>
             </role>
             <organization>
               <name>日本産業標準調査会 標準第一部会</name>
             </organization>
           </contributor>
           <edition>2</edition>
           <version>
             <revision-date>2000-01-01</revision-date>
             <draft>0.3.4</draft>
           </version>
           <language>ja</language>
           <script>Jpan</script>
           <status>
             <stage>20</stage>
             <substage>20</substage>
             <iteration>3</iteration>
           </status>
           <copyright>
             <from>2000</from>
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
             <horizontal>true</horizontal>
             <editorialgroup>
               <agency>JIS</agency>
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
               <project-number part="1">1000</project-number>
             </structuredidentifier>
           </ext>
         </bibdata>
         <!--
         <boilerplate>
           <copyright-statement>
             <p id="_">主 務 大 臣:経済産業大臣 制定:昭和 26.10.31 改正:平成十二年1月1日</p>
             <p id="_">官 報 掲 載 日:平成十二年2月1日</p>
             <p id="_">原 案 作 成 者:一般財団法人日本規格協会</p>
             <p id="_">(〒108-0073 東京都港区三田 3-13-12 三田 MT ビル TEL 03-4231-8530)</p>
             <p id="_">審 議 部 会:日本工業規格</p>
           </copyright-statement>
           <feedback-statement>
             <p id="_">この規格についての意見又は質問は，上記原案作成者又は経済産業省産業技術環境局 国際標準課(〒100-8901 東京 都千代田区霞が関 1-3-1)にご連絡ください。</p>
             <p id="_">なお，日本産業規格は，産業標準化法の規定によって，少なくとも 5 年を経過する日までに日本産業標準調査会の審 議に付され，速やかに，確認，改正又は廃止されます。</p>
           </feedback-statement>
         </boilerplate>
         -->
         <sections> </sections>
       </jis-standard>
    OUTPUT
    xml = Nokogiri::XML(Asciidoctor.convert(input, *PLATEAU_OPTIONS))
    xml.at("//xmlns:metanorma-extension")&.remove
    expect(xmlpp(strip_guid(xml.to_xml)))
      .to be_equivalent_to xmlpp(output)
    xml = Nokogiri::XML(Asciidoctor.convert(
                          input.sub(":docfile: test.adoc",
                                    ":docfile: test.adoc\n:language: en"),
                          *PLATEAU_OPTIONS,
                        ))
    xml.at("//xmlns:metanorma-extension")&.remove
    output = <<~OUTPUT
      <jis-standard type="semantic" version="#{Metanorma::JIS::VERSION}" xmlns="https://www.metanorma.org/ns/jis">
               <bibdata type="standard">
           <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
           <title language="en" format="text/plain" type="title-intro">Introduction</title>
           <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
           <title language="en" format="text/plain" type="title-part">Title Part</title>
           <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
           <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
           <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
           <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
           <docidentifier primary="true" type="JIS">Z 1000-1:2000(E)</docidentifier>
           <docnumber>1000</docnumber>
           <date type="announced">
              <on>2000-02-01</on>
           </date>
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
                      <contributor>
             <role type="authorizer">
               <description>Investigative organization</description>
             </role>
             <organization>
               <name>
                 <variant language="ja">日本産業標準調査会</variant>
                 <variant language="en">Japanese Industrial Standards Committee</variant>
               </name>
             </organization>
           </contributor>
           <contributor>
             <role type="authorizer">
               <description>Investigative committee</description>
             </role>
             <organization>
               <name>日本産業標準調査会 標準第一部会</name>
             </organization>
           </contributor>
           <edition>2</edition>
           <version>
             <revision-date>2000-01-01</revision-date>
             <draft>0.3.4</draft>
           </version>
           <language>en</language>
           <script>Latn</script>
           <status>
             <stage>20</stage>
             <substage>20</substage>
             <iteration>3</iteration>
           </status>
           <copyright>
             <from>2000</from>
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
             <horizontal>true</horizontal>
             <editorialgroup>
               <agency>JIS</agency>
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
               <project-number part="1">1000</project-number>
             </structuredidentifier>
           </ext>
         </bibdata>
         <!--
                  <boilerplate>
           <copyright-statement>
             <p id="_">Competent Minister: Minister of Economy, Trade and Industry Established: October 31, 1951 Revised: 2000-01-01
       Date of publication in the Official Gazette: 2000-02-01
       Draft creator: Japanese Standards Association
       (Mita MT Building, 3-13-12 Mita, Minato-ku, Tokyo 108-0073 Tel: 03-4231-8530)
       Investigative Working Group: Japanese Industrial Standards </p>
           </copyright-statement>
           <feedback-statement>
             <p id="_">Any comments or questions regarding this standard should be directed to the above drafter or the International Standardization Division, Industrial Science and Technology Policy and Environment Bureau, Ministry of Economy, Trade and Industry (Tokyo 100-8901 Tokyo, Japan). Please contact 1-3-1 Kasumigaseki, Chiyoda-ku, Tokyo. In accordance with the provisions of the Industrial Standardization Law, Japanese Industrial Standards shall be reviewed by the Japan Industrial Standards Committee by the date when at least five years have passed. It will be put up for discussion and promptly confirmed, amended or repealed.</p>
           </feedback-statement>
         </boilerplate>
         -->
         <sections> </sections>
       </jis-standard>
    OUTPUT
    expect(xmlpp(strip_guid(xml.to_xml)))
      .to be_equivalent_to xmlpp(output)
  end
end
