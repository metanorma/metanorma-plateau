require "spec_helper"
require "relaton_iso"

RSpec.describe Metanorma::Plateau do
  it "processes default metadata" do
    input = <<~INPUT
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
      :docnumber: PLATEAU 1000
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
      :sponsor: Flintstone Enterprises
    INPUT
    output = <<~OUTPUT
      <metanorma type="semantic" version="#{Metanorma::Plateau::VERSION}" xmlns="https://www.metanorma.org/ns/standoc" flavor="plateau">
               <bibdata type="standard">
           <title language="en" type="main">Introduction — Main Title — Title — Title Part</title>
           <title language="en" type="title-intro">Introduction</title>
           <title language="en" type="title-main">Main Title — Title</title>
           <title language="en" type="title-part">Title Part</title>
           <title language="en" type="title-part-prefix">Part 1</title>
           <title language="ja" type="main">Introduction Française — Titre Principal — Part du Titre</title>
           <title language="ja" type="title-intro">Introduction Française</title>
           <title language="ja" type="title-main">Titre Principal</title>
           <title language="ja" type="title-part">Part du Titre</title>
           <title language="ja" type="title-part-prefix">その 1</title>
           <docidentifier type="PLATEAU" primary="true">PLATEAU 1000</docidentifier>
           <docnumber>PLATEAU 1000</docnumber>
           <date type="announced">
              <on>2000-02-01</on>
           </date>
             <contributor>
                <role type="author"/>
                <organization>
                   <name language="ja">国土交通省</name>
                   <name language="en">Ministry of Land, Infrastructure, Transport and Tourism</name>
                   <abbreviation>MLIT</abbreviation>
                </organization>
             </contributor>
      <contributor>
         <role type="author">
            <description>secretariat</description>
         </role>
         <organization>
            <name>SECRETARIAT</name>
         </organization>
      </contributor>
             <contributor>
                <role type="publisher"/>
                <organization>
                   <name language="ja">国土交通省</name>
                   <name language="en">Ministry of Land, Infrastructure, Transport and Tourism</name>
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
                <organization>
                   <name>日本産業標準調査会 標準第一部会</name>
                </organization>
             </contributor>
                   <contributor>
         <role type="enabler"/>
         <organization>
            <name>Flintstone Enterprises</name>
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
             <iteration>3</iteration>
           </status>
           <copyright>
             <from>2000</from>
             <owner>
               <organization>
                   <name language="ja">国土交通省</name>
                   <name language="en">Ministry of Land, Infrastructure, Transport and Tourism</name>
               <abbreviation>MLIT</abbreviation>
               </organization>
             </owner>
           </copyright>
           <ext>
             <doctype>technical-report</doctype>
             <flavor>plateau</flavor>
             <horizontal>true</horizontal>
             <structuredidentifier>
               <project-number part="1">PLATEAU 1000</project-number>
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
         <colophon>
         <clause id="_" inline-header="false" obligation="normative">
            <p id="_" anchor="_colophon_title">
               Titre Principal　<span class="colophon_edition">第2版</span>
            </p>
            <p id="_" anchor="_colophon_author">国土交通省</p>
            <p id="_" anchor="_colophon_sponsor">Flintstone Enterprises</p>
         </clause>
        </colophon>
       </metanorma>
    OUTPUT
    xml = Nokogiri::XML(Asciidoctor.convert(input, *OPTIONS))
    xml.at("//xmlns:metanorma-extension")&.remove
    expect(Canon.format_xml(strip_guid(xml.to_xml)))
      .to be_equivalent_to Canon.format_xml(output)
    xml = Nokogiri::XML(Asciidoctor.convert(
                          input.sub(":docfile: test.adoc",
                                    ":docfile: test.adoc\n:language: en"),
                          *OPTIONS,
                        ))
    xml.at("//xmlns:metanorma-extension")&.remove
    output = <<~OUTPUT
      <metanorma type="semantic" version="#{Metanorma::Plateau::VERSION}" xmlns="https://www.metanorma.org/ns/standoc" flavor="plateau">
               <bibdata type="standard">
           <title language="en" type="main">Introduction — Main Title — Title — Title Part</title>
           <title language="en" type="title-intro">Introduction</title>
           <title language="en" type="title-main">Main Title — Title</title>
           <title language="en" type="title-part">Title Part</title>
           <title language="en" type="title-part-prefix">Part 1</title>
           <title language="ja" type="main">Introduction Française — Titre Principal — Part du Titre</title>
           <title language="ja" type="title-intro">Introduction Française</title>
           <title language="ja" type="title-main">Titre Principal</title>
           <title language="ja" type="title-part">Part du Titre</title>
           <title language="ja" type="title-part-prefix">その 1</title>
           <docidentifier type="PLATEAU" primary="true">PLATEAU 1000</docidentifier>
           <docnumber>PLATEAU 1000</docnumber>
           <date type="announced">
              <on>2000-02-01</on>
           </date>
             <contributor>
                <role type="author"/>
                <organization>
                   <name language="ja">国土交通省</name>
                   <name language="en">Ministry of Land, Infrastructure, Transport and Tourism</name>
                   <abbreviation>MLIT</abbreviation>
                </organization>
             </contributor>
      <contributor>
         <role type="author">
            <description>secretariat</description>
         </role>
         <organization>
            <name>SECRETARIAT</name>
         </organization>
      </contributor>
             <contributor>
                <role type="publisher"/>
                <organization>
                   <name language="ja">国土交通省</name>
                   <name language="en">Ministry of Land, Infrastructure, Transport and Tourism</name>
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
                <organization>
                   <name>日本産業標準調査会 標準第一部会</name>
                </organization>
             </contributor>
                   <contributor>
            <role type="enabler"/>
            <organization>
                <name>Flintstone Enterprises</name>
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
             <iteration>3</iteration>
           </status>
           <copyright>
             <from>2000</from>
             <owner>
               <organization>
                   <name language="ja">国土交通省</name>
                   <name language="en">Ministry of Land, Infrastructure, Transport and Tourism</name>
               <abbreviation>MLIT</abbreviation>
               </organization>
             </owner>
           </copyright>
           <ext>
             <doctype>technical-report</doctype>
             <flavor>plateau</flavor>
             <horizontal>true</horizontal>
             <structuredidentifier>
               <project-number part="1">PLATEAU 1000</project-number>
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
            <colophon>
       <clause id="_" inline-header="false" obligation="normative">
         <p id="_" anchor="_colophon_title">
            Main Title — Title
            <span class="colophon_edition">second edition</span>
         </p>
         <p id="_" anchor="_colophon_author">Ministry of Land, Infrastructure, Transport and Tourism</p>
         <p id="_" anchor="_colophon_sponsor">Flintstone Enterprises</p>
      </clause>
      </colophon>
       </metanorma>
    OUTPUT
    expect(Canon.format_xml(strip_guid(xml.to_xml)))
      .to be_equivalent_to Canon.format_xml(output)
  end

  it "populates cover images" do
    input = <<~INPUT
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
      :docnumber: 1000
      :coverpage-image: images/image1.gif,images/image2.gif
    INPUT
    output = <<~OUTPUT
       <metanorma-extension>
          <semantic-metadata>
             <stage-published>true</stage-published>
          </semantic-metadata>
          <presentation-metadata>
             <coverpage-image>
                <image src="images/image1.gif"/>
                <image src="images/image2.gif"/>
             </coverpage-image>
             <toc-heading-levels>2</toc-heading-levels>
             <html-toc-heading-levels>2</html-toc-heading-levels>
             <doc-toc-heading-levels>3</doc-toc-heading-levels>
             <pdf-toc-heading-levels>3</pdf-toc-heading-levels>
          </presentation-metadata>
       </metanorma-extension>
    OUTPUT
    expect(Canon.format_xml(strip_guid(Nokogiri::XML(Asciidoctor.convert(input,
                                                                         *OPTIONS))
      .at("//xmlns:metanorma-extension").to_xml)))
      .to be_equivalent_to Canon.format_xml(output)
  end

  it "populates sources on paragraphs and lists" do
    input = <<~INPUT
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
      :docnumber: 1000

      [[x]]
      == Clause

      Paragraph

      [.source]
      <<x,1>>

      [.source]
      <<x,2>>

      * List

      [.source]
      <<x,3>>

      [.source]
      <<x,4>>

      . List

      [.source]
      <<x,5>>

      [.source]
      <<x,6>>

      List:: Entry

      [.source]
      <<x,7>>

      [.source]
      <<x,8>>
    INPUT
    output = <<~OUTPUT
      <sections>
          <clause id="_" anchor="x" inline-header="false" obligation="normative">
            <title id="_">Clause</title>
            <p id="_">
              Paragraph
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>1</display-text></origin>
              </source>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>2</display-text></origin>
              </source>
            </p>
            <ul id="_">
              <li>
                <p id="_">List</p>
              </li>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>3</display-text></origin>
              </source>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>4</display-text></origin>
              </source>
            </ul>
            <ol id="_">
              <li>
                <p id="_">List</p>
              </li>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>5</display-text></origin>
              </source>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>6</display-text></origin>
              </source>
            </ol>
            <dl id="_">
              <dt>List</dt>
              <dd id="_">
                <p id="_">Entry</p>
              </dd>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>7</display-text></origin>
              </source>
              <source status="identical">
                <origin bibitemid="x" type="inline" citeas=""><display-text>8</display-text></origin>
              </source>
            </dl>
          </clause>
        </sections>
    OUTPUT
    expect(Canon.format_xml(strip_guid(Nokogiri::XML(Asciidoctor
      .convert(input, *OPTIONS))
      .at("//xmlns:sections").to_xml)))
      .to be_equivalent_to Canon.format_xml(output)
  end

  it "does not include termdefs in nesting of sources" do
    input = <<~INPUT
      = Document title
      Author
      :docfile: test.adoc
      :nodoc:
      :novalid:
      :no-isobib:
      :docnumber: 1000

      [[toc1_05]]
      [heading=terms and definitions]
      [source="jpgis_2014"]
      === 用語と定義

      // TODO: use "SOURCE" to generate

      標準製品仕様書で使用する用語を示す。以下に記載のない用語とその定義については、 +
      JPGIS 2014付属書5（規定）定義に従う。 +

      // NOTE: 標準製品仕様書は、i-UR及びCityGMLから3D都市モデルとして必要な地物型等をi-UR及びCityGMLと矛盾なく抽出した、i-UR及びCityGMLのプロファイルである。
      また、各都市で作成される拡張製品仕様書も、i-UR及びCityGMLのプロファイルでなくてはならない。

      ==== BIM（Building Information Modeling）

      コンピュータ上に作成した主に三次元の形状情報に加え、室等の名称・⾯積、材料・部材の仕様・性能、仕上げ等、建築物の属性情報を併せ持つ建築物情報モデルを構築
      するもの。

      [.source]
      <<plateau_003_annex>>
      // ［出典　3D都市モデル整備のためのBIM活⽤マニュアル第3.0版］

      [bibliography]
      == Bibliography
      * [[[plateau_003_annex,PLATEAU Handbook #03-1]]],
      span:title[3D都市モデル整備のためのBIM活用マニュアル（第3.0版）（別冊）3D都市モデルとの連携のためのBIMモデルIDM・MVD].
      span:organization[国土交通省 都市局].
      span:docid.PLATEAU[PLATEAU Handbook #03-1].
      span:edition[第2.0版].
      span:date[2023-03-27].
      span:uri.citation[https://www.mlit.go.jp/plateau/libraries/handbooks/].
    INPUT
    output = <<~OUTPUT
      <sections>
         <terms id="_" anchor="toc1_05" obligation="normative">
            <title id="_">用語及び定義</title>
            <p id="_">
               この規格で用いる主な用語及び定義は，次によるほか，
               <xref target="jpgis_2014"/>
               による。
            </p>
            <p id="_">
               標準製品仕様書で使用する用語を示す。以下に記載のない用語とその定義については、
               <br/>
               JPGIS 2014付属書5（規定）定義に従う。
               <br/>
            </p>
            <p id="_">また、各都市で作成される拡張製品仕様書も、i-UR及びCityGMLのプロファイルでなくてはならない。</p>
            <term id="_" anchor="term-BIM_Building-Information-Modeling_">
               <preferred>
                  <expression>
                     <name>BIM（Building Information Modeling）</name>
                  </expression>
               </preferred>
               <definition id="_">
                  <verbal-definition id="_">
                     <p id="_">コンピュータ上に作成した主に三次元の形状情報に加え、室等の名称・⾯積、材料・部材の仕様・性能、仕上げ等、建築物の属性情報を併せ持つ建築物情報モデルを構築するもの。</p>
                  </verbal-definition>
               </definition>
               <source status="identical" type="authoritative">
                  <origin bibitemid="plateau_003_annex" type="inline" citeas="PLATEAU Handbook #03-1"/>
               </source>
            </term>
         </terms>
      </sections>
    OUTPUT
    expect(Canon.format_xml(strip_guid(Nokogiri::XML(Asciidoctor
          .convert(input, *OPTIONS))
          .at("//xmlns:sections").to_xml)))
      .to be_equivalent_to Canon.format_xml(output)
  end

  it "applies default requirement model" do
    input = <<~"INPUT"
      #{ASCIIDOC_BLANK_HDR}

      [[A]]
      [.permission]
      ====
      I permit this


      [[B]]
      [.permission]
      =====
      I also permit this

      . List
      . List
      =====
      ====
    INPUT

    xml = Nokogiri::XML(Asciidoctor.convert(input, *OPTIONS))
    expect(xml.at("//xmlns:permission[@anchor = 'A']/@model").text).to eq("ogc")
    expect(xml.at("//xmlns:permission/xmlns:permission/@model").text)
      .to eq("ogc")
  end
end
