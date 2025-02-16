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
       <foreword id="fwd" displayorder="2">
          <title id="_">Foreword</title>
          <fmt-title depth="1">
             <semx element="title" source="_">Foreword</semx>
          </fmt-title>
          <p>
             <xref target="N1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N1">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="N1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="N2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N2">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="N2">(??)</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="N" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="scope">1</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="N">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note1">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="note1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note3">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="note3">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note4" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note4">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="note4">3</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note2">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="note2">4</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note51" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note51">[note51]</fmt-xref>
             </semx>
             <xref target="AN" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="AN">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="AN">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote1">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="Anote1">(??)</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote2">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="Anote2">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote3">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="Anote3">3</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote4" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote4">
                   <span class="citefig">
                      <span class="fmt-xref-container">
                         <semx element="references" source="biblio">Bibliographical Section</semx>
                      </span>
                      <span class="fmt-comma">,</span>
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="Anote4">1</semx>
                   </span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
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
       <foreword id="fwd" displayorder="2">
          <title id="_">Foreword</title>
          <fmt-title depth="1">
             <semx element="title" source="_">Foreword</semx>
          </fmt-title>
          <p>
             <xref target="N" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="N">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note1">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="N">1</semx>
                      <span class="fmt-autonum-delim"> </span>
                      <semx element="autonum" source="note1">a</semx>
                      <span class="fmt-autonum-delim">)</span>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note2">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="N">1</semx>
                      <span class="fmt-autonum-delim"> </span>
                      <semx element="autonum" source="note2">b</semx>
                      <span class="fmt-autonum-delim">)</span>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="AN" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="AN">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="AN">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote1">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="AN">1</semx>
                      <span class="fmt-autonum-delim"> </span>
                      <semx element="autonum" source="Anote1">a</semx>
                      <span class="fmt-autonum-delim">)</span>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote2">
                   <span class="citefig">
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="AN">1</semx>
                      <span class="fmt-autonum-delim"> </span>
                      <semx element="autonum" source="Anote2">b</semx>
                      <span class="fmt-autonum-delim">)</span>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="AN1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="AN1">
                   <span class="citefig">
                      <span class="fmt-xref-container">
                         <semx element="references" source="biblio">Bibliographical Section</semx>
                      </span>
                      <span class="fmt-comma">,</span>
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="AN1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote11" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote11">
                   <span class="citefig">
                      <span class="fmt-xref-container">
                         <semx element="references" source="biblio">Bibliographical Section</semx>
                      </span>
                      <span class="fmt-comma">,</span>
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="AN1">1</semx>
                      <span class="fmt-autonum-delim"> </span>
                      <semx element="autonum" source="Anote11">a</semx>
                      <span class="fmt-autonum-delim">)</span>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote21" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote21">
                   <span class="citefig">
                      <span class="fmt-xref-container">
                         <semx element="references" source="biblio">Bibliographical Section</semx>
                      </span>
                      <span class="fmt-comma">,</span>
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="AN1">1</semx>
                      <span class="fmt-autonum-delim"> </span>
                      <semx element="autonum" source="Anote21">b</semx>
                      <span class="fmt-autonum-delim">)</span>
                   </span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
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
       <foreword id="_" displayorder="2">
          <title id="_">Foreword</title>
          <fmt-title depth="1">
             <semx element="title" source="_">Foreword</semx>
          </fmt-title>
          <p>
             <xref target="N1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N1">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="N1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="N2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N2">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="N2">(??)</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="N" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="scope">1</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="N">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note1">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="note1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="note2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note2">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="note2">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="AN" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="AN">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="AN">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote1">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="Anote1">(??)</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote2">
                   <span class="citetbl">
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="Anote2">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Anote3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote3">
                   <span class="citetbl">
                      <span class="fmt-xref-container">
                         <semx element="references" source="biblio">Bibliographical Section</semx>
                      </span>
                      <span class="fmt-comma">,</span>
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="Anote3">1</semx>
                   </span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
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
       <foreword obligation="informative" id="_" displayorder="2">
          <title id="_">Foreword</title>
          <fmt-title depth="1">
             <semx element="title" source="_">Foreword</semx>
          </fmt-title>
          <p id="A">
             This is a preamble
             <xref target="C" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="C">
                   <span class="citesec">
                      <semx element="autonum" source="B">0</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="C">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="C1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="C1">
                   <span class="citesec">
                      <semx element="autonum" source="B">0</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="C1">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="D" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="D">
                   <span class="citesec">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="D">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="H" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="H">
                   <span class="citesec">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="H">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="I" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="I">
                   <span class="citesec">
                      <semx element="autonum" source="H">2</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="I">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="J" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="J">
                   <span class="citesec">
                      <semx element="autonum" source="H">2</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="I">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="J">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="K" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="K">
                   <span class="citesec">
                      <semx element="autonum" source="H">2</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="K">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="L" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="L">
                   <span class="citesec">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="L">3</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="M" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="M">
                   <span class="citesec">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="M">4</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="N" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N">
                   <span class="citesec">
                      <semx element="autonum" source="M">4</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="N">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="O" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="O">
                   <span class="citesec">
                      <semx element="autonum" source="M">4</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="O">2</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="P" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="P">
                   <span class="citeapp">
                      <span class="fmt-element-name">Annex</span>
                      <semx element="autonum" source="P">A</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Q" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Q">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="Q">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="Q1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Q1">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="Q">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="Q1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="QQ" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="QQ">
                   <span class="citeapp">
                      <span class="fmt-element-name">Annex</span>
                      <semx element="autonum" source="QQ">B</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="QQ1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="QQ1">
                   <span class="citeapp">
                      <span class="fmt-element-name">Annex</span>
                      <semx element="autonum" source="QQ1">B</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="QQ2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="QQ2">
                   <span class="citeapp">
                      <semx element="autonum" source="QQ1">B</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="QQ2">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="R" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="R">
                   <span class="citesec">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="R">5</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S">
                   <span class="citesec">
                      <semx element="clause" source="S">Bibliography</semx>
                   </span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
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
      <foreword obligation="informative" id="_" displayorder="2">
          <title id="_">Foreword</title>
          <fmt-title depth="1">
             <semx element="title" source="_">Foreword</semx>
          </fmt-title>
          <p id="A">
             This is a preamble
             <xref target="S1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S1">
                   <span class="citesec">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="S1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S2">
                   <span class="citesec">
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S3">
                   <span class="citesec">
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S3">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S4" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S4">
                   <span class="citesec">
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S4">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S5" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S5">
                   <span class="citesec">
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S4">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S5">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S6" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S6">
                   <span class="citesec">
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S4">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S5">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S6">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="S7" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="S7">
                   <span class="citesec">
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S4">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S5">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S6">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S7">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="A1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="A1">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="A2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="A2">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A2">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="A3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="A3">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A3">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="A4" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="A4">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A4">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="A5" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="A5">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A4">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A5">1</semx>
                   </span>
                </fmt-xref>
             </semx>
             <xref target="A6" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="A6">
                   <span class="citeapp">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A2">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A3">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A4">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A5">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A6">1</semx>
                   </span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
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
      <foreword id="_" displayorder="2">
          <title id="_">Foreword</title>
          <fmt-title depth="1">
             <semx element="title" source="_">Foreword</semx>
          </fmt-title>
          <p>
             <xref target="N1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N1">
                   <span class="fmt-xref-container">
                      <semx element="acknowledgements" source="intro">Acknowledgements</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                </fmt-xref>
             </semx>
             <xref target="N2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N2">
                   <span class="fmt-xref-container">
                      <semx element="clause" source="xyz">Preparatory</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                </fmt-xref>
             </semx>
             <xref target="N" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N">
                   <span class="fmt-xref-container">
                      <span class="fmt-element-name">Clause</span>
                      <semx element="autonum" source="scope">1</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                </fmt-xref>
             </semx>
             <xref target="note1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note1">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="widgets1">1</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                   <semx element="autonum" source="note1">1</semx>
                </fmt-xref>
             </semx>
             <xref target="note2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note2">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="widgets1">1</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                   <semx element="autonum" source="note2">2</semx>
                </fmt-xref>
             </semx>
             <xref target="AN" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="AN">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="annex1a">1</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                </fmt-xref>
             </semx>
             <xref target="Anote1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote1">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="annex1b">2</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                   <semx element="autonum" source="Anote1">1</semx>
                </fmt-xref>
             </semx>
             <xref target="Anote2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote2">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="annex1b">2</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                   <semx element="autonum" source="Anote2">2</semx>
                </fmt-xref>
             </semx>
             <xref target="Anote3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote3">
                   <span class="fmt-xref-container">
                      <semx element="references" source="biblio">Bibliographical Section</semx>
                   </span>
                   <span class="fmt-comma">,</span>
                   <span class="fmt-element-name">List</span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
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
       <foreword id="_" displayorder="2">
           <title id="_">Foreword</title>
           <fmt-title depth="1">
              <semx element="title" source="_">Foreword</semx>
           </fmt-title>
           <p>
              <xref target="N1" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="N1">
                    <span class="fmt-xref-container">
                       <semx element="acknowledgements" source="intro">Acknowledgements</semx>
                    </span>
                    <semx element="autonum" source="N1">a</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="N11" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="N11">
                    <span class="fmt-xref-container">
                       <semx element="acknowledgements" source="intro">Acknowledgements</semx>
                    </span>
                    <semx element="autonum" source="N1">a</semx>
                    <span class="fmt-autonum-delim">)</span>
                    <semx element="autonum" source="N11">1</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="N12" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="N12">
                    <span class="fmt-xref-container">
                       <semx element="acknowledgements" source="intro">Acknowledgements</semx>
                    </span>
                    <semx element="autonum" source="N1">a</semx>
                    <span class="fmt-autonum-delim">)</span>
                    <semx element="autonum" source="N11">1</semx>
                    <span class="fmt-autonum-delim">)</span>
                    <semx element="autonum" source="N12">i</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="N2" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="N2">
                    <span class="fmt-xref-container">
                       <semx element="clause" source="xyz">Preparatory</semx>
                    </span>
                    <semx element="autonum" source="N2">1</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="N" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="N">
                    <span class="fmt-xref-container">
                       <span class="fmt-element-name">Clause</span>
                       <semx element="autonum" source="scope">1</semx>
                    </span>
                    <semx element="autonum" source="N">i</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="note1" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="note1">
                    <span class="fmt-xref-container">
                       <semx element="autonum" source="widgets">3</semx>
                       <span class="fmt-autonum-delim">.</span>
                       <semx element="autonum" source="widgets1">1</semx>
                    </span>
                    <span class="fmt-comma">,</span>
                    <span class="fmt-element-name">List</span>
                    <semx element="autonum" source="note1l">1</semx>
                    <semx element="autonum" source="note1">a</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="note2" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="note2">
                    <span class="fmt-xref-container">
                       <semx element="autonum" source="widgets">3</semx>
                       <span class="fmt-autonum-delim">.</span>
                       <semx element="autonum" source="widgets1">1</semx>
                    </span>
                    <span class="fmt-comma">,</span>
                    <span class="fmt-element-name">List</span>
                    <semx element="autonum" source="note2l">2</semx>
                    <semx element="autonum" source="note2">I</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="AN" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="AN">
                    <span class="fmt-xref-container">
                       <semx element="autonum" source="annex1">A</semx>
                       <span class="fmt-autonum-delim">.</span>
                       <semx element="autonum" source="annex1a">1</semx>
                    </span>
                    <semx element="autonum" source="AN">A</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="Anote1" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="Anote1">
                    <span class="fmt-xref-container">
                       <semx element="autonum" source="annex1">A</semx>
                       <span class="fmt-autonum-delim">.</span>
                       <semx element="autonum" source="annex1b">2</semx>
                    </span>
                    <span class="fmt-comma">,</span>
                    <span class="fmt-element-name">List</span>
                    <semx element="autonum" source="Anote1l">1</semx>
                    <semx element="autonum" source="Anote1">iv</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="Anote2" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="Anote2">
                    <span class="fmt-xref-container">
                       <semx element="autonum" source="annex1">A</semx>
                       <span class="fmt-autonum-delim">.</span>
                       <semx element="autonum" source="annex1b">2</semx>
                    </span>
                    <span class="fmt-comma">,</span>
                    <span class="fmt-element-name">List</span>
                    <semx element="autonum" source="Anote2l">2</semx>
                    <semx element="autonum" source="Anote2">a</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
              <xref target="Anote3" id="_"/>
              <semx element="xref" source="_">
                 <fmt-xref target="Anote3">
                    <span class="fmt-xref-container">
                       <semx element="references" source="biblio">Bibliographical Section</semx>
                    </span>
                    <semx element="autonum" source="Anote3">a</semx>
                    <span class="fmt-autonum-delim">)</span>
                 </fmt-xref>
              </semx>
           </p>
        </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .at("//xmlns:foreword").to_xml)))
      .to be_equivalent_to Xml::C14n.format(output)
    input1 = input.sub(%r{<language>en</language>}, "<language>ja</language>")
    output = <<~OUTPUT
       <foreword id="_" displayorder="2">
          <title id="_">まえがき</title>
          <fmt-title depth="1">
             <semx element="title" source="_">まえがき</semx>
          </fmt-title>
          <p>
             <xref target="N1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N1">
                   <span class="fmt-xref-container">
                      <semx element="acknowledgements" source="intro">謝辞</semx>
                   </span>
                   <semx element="autonum" source="N1">a</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="N11" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N11">
                   <span class="fmt-xref-container">
                      <semx element="acknowledgements" source="intro">謝辞</semx>
                   </span>
                   <semx element="autonum" source="N1">a</semx>
                   <span class="fmt-autonum-delim">)</span>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="N11">1</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="N12" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N12">
                   <span class="fmt-xref-container">
                      <semx element="acknowledgements" source="intro">謝辞</semx>
                   </span>
                   <semx element="autonum" source="N1">a</semx>
                   <span class="fmt-autonum-delim">)</span>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="N11">1</semx>
                   <span class="fmt-autonum-delim">)</span>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="N12">i</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="N2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N2">
                   <span class="fmt-xref-container">
                      <semx element="clause" source="xyz">Preparatory</semx>
                   </span>
                   <semx element="autonum" source="N2">1</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="N" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="N">
                   <span class="fmt-xref-container">
                      <span class="fmt-element-name">箇条</span>
                      <semx element="autonum" source="scope">1</semx>
                   </span>
                   <semx element="autonum" source="N">i</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="note1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note1">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="widgets1">1</semx>
                   </span>
                   <span class="fmt-conn">の</span>
                   <span class="fmt-element-name">リスト</span>
                   <semx element="autonum" source="note1l">1</semx>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="note1">a</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="note2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="note2">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="widgets">3</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="widgets1">1</semx>
                   </span>
                   <span class="fmt-conn">の</span>
                   <span class="fmt-element-name">リスト</span>
                   <semx element="autonum" source="note2l">2</semx>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="note2">I</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="AN" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="AN">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="annex1a">1</semx>
                   </span>
                   <semx element="autonum" source="AN">A</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="Anote1" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote1">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="annex1b">2</semx>
                   </span>
                   <span class="fmt-conn">の</span>
                   <span class="fmt-element-name">リスト</span>
                   <semx element="autonum" source="Anote1l">1</semx>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="Anote1">iv</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="Anote2" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote2">
                   <span class="fmt-xref-container">
                      <semx element="autonum" source="annex1">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="annex1b">2</semx>
                   </span>
                   <span class="fmt-conn">の</span>
                   <span class="fmt-element-name">リスト</span>
                   <semx element="autonum" source="Anote2l">2</semx>
                   <span class="fmt-conn">の</span>
                   <semx element="autonum" source="Anote2">a</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
             <xref target="Anote3" id="_"/>
             <semx element="xref" source="_">
                <fmt-xref target="Anote3">
                   <span class="fmt-xref-container">
                      <semx element="references" source="biblio">Bibliographical Section</semx>
                   </span>
                   <semx element="autonum" source="Anote3">a</semx>
                   <span class="fmt-autonum-delim">)</span>
                </fmt-xref>
             </semx>
          </p>
       </foreword>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(Nokogiri.XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input1, true))
      .at("//xmlns:foreword").to_xml)))
      .to be_equivalent_to Xml::C14n.format(output)
  end
end
