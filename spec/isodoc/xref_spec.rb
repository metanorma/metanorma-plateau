require "spec_helper"

RSpec.describe IsoDoc do
  it "cross-references figures" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
              <preface>
          <foreword id="fwd">
          <p>
          <xref target="N1"/>
          <xref target="N2"/>
          <xref target="N"/>
          <xref target="note1"/>
          <xref target="note3"/>
          <xref target="note4"/>
          <xref target="note2"/>
          <xref target="note51"/>
          <xref target="AN"/>
          <xref target="Anote1"/>
          <xref target="Anote2"/>
          <xref target="Anote3"/>
          <xref target="Anote4"/>
          </p>
          </foreword>
              <introduction id="intro">
              <figure id="N1">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
        <clause id="xyz"><title>Preparatory</title>
              <figure id="N2" unnumbered="true">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
      </clause>
          </introduction>
          </preface>
          <sections>
          <clause id="scope" type="scope"><title>Scope</title>
              <figure id="N">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
      <p><xref target="N"/></p>
          </clause>
          <terms id="terms"/>
          <clause id="widgets"><title>Widgets</title>
          <clause id="widgets1">
              <figure id="note1">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
        <figure id="note3" class="pseudocode">
        <p>pseudocode</p>
        </figure>
        <sourcecode id="note4"><name>Source! Code!</name>
        A B C
        </sourcecode>
        <example id="note5">
        <sourcecode id="note51">
        A B C
        </sourcecode>
        </example>
          <figure id="note2">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
        <p>    <xref target="note1"/> <xref target="note2"/> </p>
          </clause>
          </clause>
          </sections>
          <annex id="annex1">
          <clause id="annex1a">
              <figure id="AN">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
          </clause>
          <clause id="annex1b">
              <figure id="Anote1" unnumbered="true">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
          <figure id="Anote2">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
        <sourcecode id="Anote3"><name>Source! Code!</name>
        A B C
        </sourcecode>
          </clause>
          </annex>
          <bibliography><references normative="false" id="biblio"><title>Bibliographical Section</title>
          <figure id="Anote4">
        <name>Split-it-right sample divider</name>
        <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
        </figure>
          </references></bibliography>
          </iso-standard>
    INPUT
    output = <<~OUTPUT
      <foreword id="fwd" displayorder="2"><title>Foreword</title>
         <p>
           <xref target="N1">
             <span class="citefig">Figure 1</span>
           </xref>
           <xref target="N2">
             <span class="citefig">Figure (??)</span>
           </xref>
           <xref target="N">
             <span class="citefig">Figure 1-1</span>
           </xref>
           <xref target="note1">
             <span class="citefig">Figure 3-1</span>
           </xref>
           <xref target="note3">
             <span class="citefig">Figure 3-2</span>
           </xref>
           <xref target="note4">
             <span class="citefig">Figure 3-3</span>
           </xref>
           <xref target="note2">
             <span class="citefig">Figure 3-4</span>
           </xref>
           <xref target="note51">[note51]</xref>
           <xref target="AN">
             <span class="citefig">Figure A-1</span>
           </xref>
           <xref target="Anote1">
             <span class="citefig">Figure (??)</span>
           </xref>
           <xref target="Anote2">
             <span class="citefig">Figure A-2</span>
           </xref>
           <xref target="Anote3">
             <span class="citefig">Figure A-3</span>
           </xref>
           <xref target="Anote4">
             <span class="citefig">Bibliographical Section, Figure 1</span>
           </xref>
         </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end

  it "cross-references subfigures" do
    input = <<~INPUT
            <iso-standard xmlns="http://riboseinc.com/isoxml">
            <preface>
        <foreword id="fwd">
        <p>
        <xref target="N"/>
        <xref target="note1"/>
        <xref target="note2"/>
        <xref target="AN"/>
        <xref target="Anote1"/>
        <xref target="Anote2"/>
        <xref target="AN1"/>
        <xref target="Anote11"/>
        <xref target="Anote21"/>
        </p>
        </foreword>
        </preface>
        <sections>
        <clause id="scope" type="scope"><title>Scope</title>
        </clause>
        <terms id="terms"/>
        <clause id="widgets"><title>Widgets</title>
        <clause id="widgets1">
        <figure id="N">
            <figure id="note1">
      <name>Split-it-right sample divider</name>
      <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
      </figure>
        <figure id="note2">
      <name>Split-it-right sample divider</name>
      <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
      </figure>
      </figure>
      <p>    <xref target="note1"/> <xref target="note2"/> </p>
        </clause>
        </clause>
        </sections>
        <annex id="annex1">
        <clause id="annex1a">
        </clause>
        <clause id="annex1b">
        <figure id="AN">
            <figure id="Anote1">
      <name>Split-it-right sample divider</name>
      <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
      </figure>
        <figure id="Anote2">
      <name>Split-it-right sample divider</name>
      <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
      </figure>
      </figure>
        </clause>
        </annex>
                  <bibliography><references normative="false" id="biblio"><title>Bibliographical Section</title>
                  <figure id="AN1">
            <figure id="Anote11">
      <name>Split-it-right sample divider</name>
      <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
      </figure>
        <figure id="Anote21">
      <name>Split-it-right sample divider</name>
      <image src="rice_images/rice_image1.png" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png"/>
      </figure>
      </figure>
          </references></bibliography>
        </iso-standard>
    INPUT
    output = <<~OUTPUT
      <foreword id="fwd" displayorder="2"><title>Foreword</title>
         <p>
           <xref target="N">
             <span class="citefig">Figure 3-1</span>
           </xref>
           <xref target="note1">
             <span class="citefig">Figure 3-1 a)</span>
           </xref>
           <xref target="note2">
             <span class="citefig">Figure 3-1 b)</span>
           </xref>
           <xref target="AN">
             <span class="citefig">Figure A-1</span>
           </xref>
           <xref target="Anote1">
             <span class="citefig">Figure A-1 a)</span>
           </xref>
           <xref target="Anote2">
             <span class="citefig">Figure A-1 b)</span>
           </xref>
           <xref target="AN1">
             <span class="citefig">Bibliographical Section, Figure 1</span>
           </xref>
           <xref target="Anote11">
             <span class="citefig">Bibliographical Section, Figure 1 a)</span>
           </xref>
           <xref target="Anote21">
             <span class="citefig">Bibliographical Section, Figure 1 b)</span>
           </xref>
         </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end

  it "cross-references tables" do
    input = <<~INPUT
              <iso-standard xmlns="http://riboseinc.com/isoxml">
              <preface>
          <foreword>
          <p>
          <xref target="N1"/>
          <xref target="N2"/>
          <xref target="N"/>
          <xref target="note1"/>
          <xref target="note2"/>
          <xref target="AN"/>
          <xref target="Anote1"/>
          <xref target="Anote2"/>
          <xref target="Anote3"/>
          </p>
          </foreword>
          <introduction id="intro">
          <table id="N1">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
        <clause id="xyz"><title>Preparatory</title>
          <table id="N2" unnumbered="true">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
      </clause>
          </introduction>
          </preface>
          <sections>
          <clause id="scope" type="scope"><title>Scope</title>
              <table id="N">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
          <p><xref target="N"/></p>
          </clause>
          <terms id="terms"/>
          <clause id="widgets"><title>Widgets</title>
          <clause id="widgets1">
              <table id="note1">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
              <table id="note2">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
          <p>    <xref target="note1"/> <xref target="note2"/> </p>
          </clause>
          </clause>
          </sections>
          <annex id="annex1">
          <clause id="annex1a">
              <table id="AN">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
          </clause>
          <clause id="annex1b">
              <table id="Anote1" unnumbered="true">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
              <table id="Anote2">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
          </clause>
          </annex>
                    <bibliography><references normative="false" id="biblio"><title>Bibliographical Section</title>
          <table id="Anote3">
          <name>Repeatability and reproducibility of husked rice yield</name>
          <tbody>
          <tr>
            <td align="left">Number of laboratories retained after eliminating outliers</td>
            <td align="center">13</td>
            <td align="center">11</td>
          </tr>
          </tbody>
          </table>
          </references></bibliography>
          </iso-standard>
    INPUT
    output = <<~OUTPUT
      <foreword displayorder="2"><title>Foreword</title>
         <p>
           <xref target="N1">
             <span class="citetbl">Table 1</span>
           </xref>
           <xref target="N2">
             <span class="citetbl">Table (??)</span>
           </xref>
           <xref target="N">
             <span class="citetbl">Table 1-1</span>
           </xref>
           <xref target="note1">
             <span class="citetbl">Table 3-1</span>
           </xref>
           <xref target="note2">
             <span class="citetbl">Table 3-2</span>
           </xref>
           <xref target="AN">
             <span class="citetbl">Table A-1</span>
           </xref>
           <xref target="Anote1">
             <span class="citetbl">Table (??)</span>
           </xref>
           <xref target="Anote2">
             <span class="citetbl">Table A-2</span>
           </xref>
           <xref target="Anote3">
             <span class="citetbl">Bibliographical Section, Table 1</span>
           </xref>
         </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end

  it "cross-references sections" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
      <preface>
      <foreword obligation="informative">
         <title>Foreword</title>
         <p id="A">This is a preamble
         <xref target="C"/>
         <xref target="C1"/>
         <xref target="D"/>
         <xref target="H"/>
         <xref target="I"/>
         <xref target="J"/>
         <xref target="K"/>
         <xref target="L"/>
         <xref target="M"/>
         <xref target="N"/>
         <xref target="O"/>
         <xref target="P"/>
         <xref target="Q"/>
         <xref target="Q1"/>
         <xref target="QQ"/>
         <xref target="QQ1"/>
         <xref target="QQ2"/>
         <xref target="R"/>
         <xref target="S"/>
         </p>
       </foreword>
        <introduction id="B" obligation="informative"><title>Introduction</title><clause id="C" inline-header="false" obligation="informative">
         <title>Introduction Subsection</title>
       </clause>
       <clause id="C1" inline-header="false" obligation="informative">Text</clause>
       </introduction></preface><sections>
       <clause id="D" obligation="normative" type="scope">
         <title>Scope</title>
         <p id="E">Text</p>
       </clause>

       <terms id="H" obligation="normative"><title>Terms, definitions, symbols and abbreviated terms</title><terms id="I" obligation="normative">
         <title>Normal Terms</title>
         <term id="J">
         <preferred><expression><name>Term2</name></expression></preferred>
       </term>
       </terms>
       <definitions id="K">
         <dl>
         <dt>Symbol</dt>
         <dd>Definition</dd>
         </dl>
       </definitions>
       </terms>
       <definitions id="L">
         <dl>
         <dt>Symbol</dt>
         <dd>Definition</dd>
         </dl>
       </definitions>
       <clause id="M" inline-header="false" obligation="normative"><title>Clause 4</title><clause id="N" inline-header="false" obligation="normative">
         <title>Introduction</title>
       </clause>
       <clause id="O" inline-header="false" obligation="normative">
         <title>Clause 4.2</title>
       </clause></clause>
       </sections><annex id="P" inline-header="false" obligation="normative">
         <title>Annex</title>
         <clause id="Q" inline-header="false" obligation="normative">
         <title>Annex A.1</title>
         <clause id="Q1" inline-header="false" obligation="normative">
         <title>Annex A.1a</title>
         </clause>
       </clause>
       </annex>
       <annex id="QQ">
       <terms id="QQ1">
       <term id="QQ2"/>
       </terms>
      </annex>
        <bibliography><references normative="false" id="R" obligation="informative" normative="true">
         <title>Normative References</title>
       </references><clause id="S" obligation="informative">
         <title>Bibliography</title>
         <references normative="false" id="T" obligation="informative" normative="false">
         <title>Bibliography Subsection</title>
       </references>
       </clause>
       </bibliography>
       </iso-standard>
    INPUT
    output = <<~OUTPUT
       <foreword obligation="informative" displayorder="2">
        <title>Foreword</title>
        <p id="A">
          This is a preamble
          <xref target="C">
            <span class="citesec">0.1</span>
          </xref>
          <xref target="C1">
            <span class="citesec">0.2</span>
          </xref>
          <xref target="D">
            <span class="citesec">Clause 1</span>
          </xref>
          <xref target="H">
            <span class="citesec">Clause 2</span>
          </xref>
          <xref target="I">
            <span class="citesec">2.1</span>
          </xref>
          <xref target="J">
            <span class="citesec">2.1.1</span>
          </xref>
          <xref target="K">
            <span class="citesec">2.2</span>
          </xref>
          <xref target="L">
            <span class="citesec">Clause 3</span>
          </xref>
          <xref target="M">
            <span class="citesec">Clause 4</span>
          </xref>
          <xref target="N">
            <span class="citesec">4.1</span>
          </xref>
          <xref target="O">
            <span class="citesec">4.2</span>
          </xref>
          <xref target="P">
            <span class="citeapp">Annex A</span>
          </xref>
          <xref target="Q">
            <span class="citeapp">A.1</span>
          </xref>
          <xref target="Q1">
            <span class="citeapp">A.1.1</span>
          </xref>
          <xref target="QQ">
            <span class="citeapp">Annex B</span>
          </xref>
          <xref target="QQ1">
            <span class="citeapp">B</span>
          </xref>
          <xref target="QQ2">
            <span class="citeapp">B.1</span>
          </xref>
          <xref target="R">
            <span class="citesec">Clause 5</span>
          </xref>
          <xref target="S">
            <span class="citesec">Bibliography</span>
          </xref>
        </p>
      </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end

  it "cross-references deep-nested sections" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
      <preface>
      <foreword obligation="informative">
         <title>Foreword</title>
         <p id="A">This is a preamble
         <xref target="S1"/>
         <xref target="S2"/>
         <xref target="S3"/>
         <xref target="S4"/>
         <xref target="S5"/>
         <xref target="S6"/>
         <xref target="S7"/>
         <xref target="A1"/>
         <xref target="A2"/>
         <xref target="A3"/>
         <xref target="A4"/>
         <xref target="A5"/>
         <xref target="A6"/>
         </p>
       </foreword>
       </preface><sections>
       <clause id="S1" obligation="normative">
         <title>Scope</title>
       <clause id="S2" obligation="normative">
         <title>Scope</title>
       <clause id="S3" obligation="normative">
         <title>Scope</title>
       <clause id="S4" obligation="normative">
         <title>Scope</title>
       <clause id="S5" obligation="normative">
         <title>Scope</title>
       <clause id="S6" obligation="normative">
         <title>Scope</title>
       <clause id="S7" obligation="normative">
         <title>Scope</title>
       </clause>
       </clause>
       </clause>
       </clause>
       </clause>
       </clause>
       </clause>
       </sections>
        <annex id="P" inline-header="false" obligation="normative">
         <title>Annex</title>
       <clause id="A1" obligation="normative">
         <title>Scope</title>
       <clause id="A2" obligation="normative">
         <title>Scope</title>
       <clause id="A3" obligation="normative">
         <title>Scope</title>
       <clause id="A4" obligation="normative">
         <title>Scope</title>
       <clause id="A5" obligation="normative">
         <title>Scope</title>
       <clause id="A6" obligation="normative">
         <title>Scope</title>
       </clause>
       </clause>
       </clause>
       </clause>
       </clause>
       </clause>
       </annex>
       </iso-standard>
    INPUT
    output = <<~OUTPUT
      <foreword obligation="informative" displayorder="2">
          <title>Foreword</title>
          <p id="A">
             This is a preamble
             <xref target="S1">
                <span class="citesec">Clause 1</span>
             </xref>
             <xref target="S2">
                <span class="citesec">1.1</span>
             </xref>
             <xref target="S3">
                <span class="citesec">1.1.1</span>
             </xref>
             <xref target="S4">
                <span class="citesec">1.1.1.1</span>
             </xref>
             <xref target="S5">
                <span class="citesec">1.1.1.1.1</span>
             </xref>
             <xref target="S6">
                <span class="citesec">1.1.1.1.1.1</span>
             </xref>
             <xref target="S7">
                <span class="citesec">1.1.1.1.1.1.1</span>
             </xref>
             <xref target="A1">
                <span class="citeapp">A.1</span>
             </xref>
             <xref target="A2">
                <span class="citeapp">A.1.1</span>
             </xref>
             <xref target="A3">
                <span class="citeapp">A.1.1.1</span>
             </xref>
             <xref target="A4">
                <span class="citeapp">A.1.1.1.1</span>
             </xref>
             <xref target="A5">
                <span class="citeapp">A.1.1.1.1.1</span>
             </xref>
             <xref target="A6">
                <span class="citeapp">A.1.1.1.1.1.1</span>
             </xref>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end

  it "cross-references lists" do
    input = <<~INPUT
          <iso-standard xmlns="http://riboseinc.com/isoxml">
          <preface>
          <foreword>
          <p>
          <xref target="N1"/>
          <xref target="N2"/>
          <xref target="N"/>
          <xref target="note1"/>
          <xref target="note2"/>
          <xref target="AN"/>
          <xref target="Anote1"/>
          <xref target="Anote2"/>
          <xref target="Anote3"/>
          </p>
          </foreword>
          <acknowledgements id="intro">
           <ol id="N1">
        <li><p>A</p></li>
      </ol>
        <clause id="xyz"><title>Preparatory</title>
           <ol id="N2">
        <li><p>A</p></li>
      </ol>
      </clause>
          </acknowledgements>
          </preface>
          <sections>
          <clause id="scope" type="scope"><title>Scope</title>
          <ol id="N">
        <li><p>A</p></li>
      </ol>
          </clause>
          <terms id="terms"/>
          <clause id="widgets"><title>Widgets</title>
          <clause id="widgets1">
          <ol id="note1">
        <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83f">These results are based on a study carried out on three different types of kernel.</p>
      </ol>
          <ol id="note2">
        <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83a">These results are based on a study carried out on three different types of kernel.</p>
      </ol>
          </clause>
          </clause>
          </sections>
          <annex id="annex1">
          <clause id="annex1a">
          <ol id="AN">
        <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83f">These results are based on a study carried out on three different types of kernel.</p>
      </ol>
          </clause>
          <clause id="annex1b">
          <ol id="Anote1">
        <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83f">These results are based on a study carried out on three different types of kernel.</p>
      </ol>
          <ol id="Anote2">
        <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83a">These results are based on a study carried out on three different types of kernel.</p>
      </ol>
          </clause>
          </annex>
          <bibliography><references normative="false" id="biblio"><title>Bibliographical Section</title>
          <ol id="Anote3">
        <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83a">These results are based on a study carried out on three different types of kernel.</p>
      </ol>
          </references></bibliography>
          </iso-standard>
    INPUT
    output = <<~OUTPUT
      <foreword displayorder="2"><title>Foreword</title>
          <p>
             <xref target="N1">Acknowledgements, List</xref>
             <xref target="N2">Preparatory, List</xref>
             <xref target="N">Clause 1, List</xref>
             <xref target="note1">3.1, List  1</xref>
             <xref target="note2">3.1, List  2</xref>
             <xref target="AN">A.1, List</xref>
             <xref target="Anote1">A.2, List  1</xref>
             <xref target="Anote2">A.2, List  2</xref>
             <xref target="Anote3">Bibliographical Section, List</xref>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end

  it "cross-references list items in English and Japanese" do
    input = <<~INPUT
          <iso-standard xmlns="http://riboseinc.com/isoxml">
          <bibdata><language>en</language></bibdata>
          <preface>
          <foreword>
          <p>
          <xref target="N1"/>
          <xref target="N11"/>
          <xref target="N12"/>
          <xref target="N2"/>
          <xref target="N"/>
          <xref target="note1"/>
          <xref target="note2"/>
          <xref target="AN"/>
          <xref target="Anote1"/>
          <xref target="Anote2"/>
          <xref target="Anote3"/>
          </p>
          </foreword>
          <acknowledgements id="intro">
          <ol id="N01">
        <li id="N1"><p>A</p>
          <ol id="N011">
        <li id="N11"><p>A</p>
          <ol id="N012">
        <li id="N12"><p>A</p>
         </li>
      </ol></li></ol></li></ol>
        <clause id="xyz"><title>Preparatory</title>
           <ol id="N02" type="arabic">
        <li id="N2"><p>A</p></li>
      </ol>
      </clause>
          </acknowledgements>
          </preface>
          <sections>
          <clause id="scope" type="scope"><title>Scope</title>
          <ol id="N0" type="roman">
        <li id="N"><p>A</p></li>
      </ol>
          </clause>
          <terms id="terms"/>
          <clause id="widgets"><title>Widgets</title>
          <clause id="widgets1">
          <ol id="note1l" type="alphabet">
        <li id="note1"><p>A</p></li>
      </ol>
          <ol id="note2l" type="roman_upper">
        <li id="note2"><p>A</p></li>
      </ol>
          </clause>
          </clause>
          </sections>
          <annex id="annex1">
          <clause id="annex1a">
          <ol id="ANl" type="alphabet_upper">
        <li id="AN"><p>A</p></li>
      </ol>
          </clause>
          <clause id="annex1b">
          <ol id="Anote1l" type="roman" start="4">
        <li id="Anote1"><p>A</p></li>
      </ol>
          <ol id="Anote2l">
        <li id="Anote2"><p>A</p></li>
      </ol>
          </clause>
          </annex>
          <bibliography><references normative="false" id="biblio"><title>Bibliographical Section</title>
          <ol id="Anote31">
        <li id="Anote3"><p>A</p></li>
      </ol>
          </references></bibliography>
          </iso-standard>
    INPUT
    output = <<~OUTPUT
      <foreword displayorder="2"><title>Foreword</title>
          <p>
             <xref target="N1">Acknowledgements a)</xref>
             <xref target="N11">Acknowledgements a) 1)</xref>
             <xref target="N12">Acknowledgements a) 1) i)</xref>
             <xref target="N2">Preparatory 1)</xref>
             <xref target="N">Clause 1 i)</xref>
             <xref target="note1">3.1, List  1 a)</xref>
             <xref target="note2">3.1, List  2 I)</xref>
             <xref target="AN">A.1 A)</xref>
             <xref target="Anote1">A.2, List  1 iv)</xref>
             <xref target="Anote2">A.2, List  2 a)</xref>
             <xref target="Anote3">Bibliographical Section a)</xref>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
    input1 = input.sub(%r{<language>en</language>}, "<language>ja</language>")
    output = <<~OUTPUT
      <foreword displayorder="2"><title>まえがき</title>
          <p>
             <xref target="N1">謝辞 a)</xref>
             <xref target="N11">謝辞 a)の1)</xref>
             <xref target="N12">謝辞 a)の1)のi)</xref>
             <xref target="N2">Preparatory 1)</xref>
             <xref target="N">箇条1 i)</xref>
             <xref target="note1">3.1のリスト  1のa)</xref>
             <xref target="note2">3.1のリスト  2のI)</xref>
             <xref target="AN">A.1 A)</xref>
             <xref target="Anote1">A.2のリスト  1のiv)</xref>
             <xref target="Anote2">A.2のリスト  2のa)</xref>
             <xref target="Anote3">Bibliographical Section a)</xref>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input1, true))
      .at("//xmlns:foreword").to_xml))
      .to be_equivalent_to Xml::C14n.format(output)
  end
end
