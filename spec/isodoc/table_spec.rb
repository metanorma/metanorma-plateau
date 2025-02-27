require "spec_helper"

RSpec.describe IsoDoc do
  it "processes IsoXML tables" do
    input = <<~INPUT
            <iso-standard xmlns="http://riboseinc.com/isoxml">
            <sections>
            <clause id="A">
              <table id="tableD-1" alt="tool tip" summary="long desc" width="70%" keep-with-next="true" keep-lines-together="true">
          <name>Repeatability and reproducibility of <em>husked</em> rice yield<fn reference="1"><p>X</p></fn></name>
          <colgroup>
          <col width="30%"/>
          <col width="20%"/>
          <col width="20%"/>
          <col width="20%"/>
          <col width="10%"/>
          </colgroup>
          <thead>
            <tr>
              <td rowspan="2" align="left">Description</td>
              <td colspan="4" align="center">Rice sample</td>
            </tr>
            <tr>
              <td valign="top" align="left">Arborio</td>
              <td valign="middle" align="center">Drago<fn reference="a">
          <p id="_0fe65e9a-5531-408e-8295-eeff35f41a55">Parboiled rice.</p>
        </fn></td>
              <td valign="bottom" align="center">Balilla<fn reference="a">
          <p id="_0fe65e9a-5531-408e-8295-eeff35f41a55">Parboiled rice.</p>
        </fn></td>
              <td align="center">Thaibonnet</td>
            </tr>
            </thead>
            <tbody>
            <tr>
              <th align="left">Number of laboratories retained after eliminating outliers</th>
              <td align="center">13</td>
              <td align="center">11</td>
              <td align="center">13</td>
              <td align="center">13</td>
            </tr>
            <tr>
              <td align="left">Mean value, g/100 g</td>
              <td align="center">81,2</td>
              <td align="center">82,0</td>
              <td align="center">81,8</td>
              <td align="center">77,7</td>
            </tr>
            </tbody>
            <tfoot>
            <tr>
              <td align="left">Reproducibility limit, <stem type="AsciiMath">R</stem> (= 2,83 <stem type="AsciiMath">s_R</stem>)</td>
              <td align="center">2,89</td>
              <td align="center">0,57</td>
              <td align="center">2,26</td>
              <td align="center">6,06</td>
            </tr>
          </tfoot>
          <dl key="true">
          <name>Key</name>
          <dt>Drago</dt>
        <dd>A type of rice</dd>
        </dl>
              <source status="generalisation">
          <origin bibitemid="ISO712" type="inline" citeas="">
            <localityStack>
              <locality type="section">
                <referenceFrom>1</referenceFrom>
              </locality>
            </localityStack>
          </origin>
          <modification>
            <p id="_">with adjustments</p>
          </modification>
        </source>
        <note><p>This is a table about rice</p></note>
        </table>
        <table id="tableD-2" unnumbered="true">
        <tbody><tr><td>A</td></tr></tbody>
        </table>
        </clause>
        </sections>
        <bibliography><references id="_normative_references" obligation="informative" normative="true"><title>Normative References</title>
        <bibitem id="ISO712" type="standard">
          <title format="text/plain">Cereals or cereal products</title>
          <title type="main" format="text/plain">Cereals and cereal products</title>
          <docidentifier type="ISO">ISO 712</docidentifier>
          <contributor>
            <role type="publisher"/>
            <organization>
              <name>International Organization for Standardization</name>
            </organization>
          </contributor>
        </bibitem>
      </bibliography>
        </iso-standard>
    INPUT

    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <preface>
             <clause type="toc" id="_" displayorder="1">
                <fmt-title depth="1">Contents</fmt-title>
             </clause>
          </preface>
          <sections>
             <clause id="A" displayorder="2">
                <fmt-title depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="A">1</semx>
                   </span>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="A">1</semx>
                </fmt-xref-label>
                <table id="tableD-1" alt="tool tip" summary="long desc" width="70%" keep-with-next="true" keep-lines-together="true" autonum="1-1">
                   <name id="_">
                      Repeatability and reproducibility of
                      <em>husked</em>
                      rice yield
                      <fn reference="1" target="_" original-id="_">
                         <p>X</p>
                         <fmt-fn-label>
                            <sup>
                               <semx element="autonum" source="_">1</semx>
                               <span class="fmt-label-delim">)</span>
                            </sup>
                         </fmt-fn-label>
                      </fn>
                   </name>
                   <fmt-name>
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">Table</span>
                         <semx element="autonum" source="A">1</semx>
                         <span class="fmt-autonum-delim">-</span>
                         <semx element="autonum" source="tableD-1">1</semx>
                      </span>
                      <span class="fmt-caption-delim"> — </span>
                      <semx element="name" source="_">
                         Repeatability and reproducibility of
                         <em>husked</em>
                         rice yield
                         <fn reference="1" id="_" target="_">
                            <p>X</p>
                            <fmt-fn-label>
                               <sup>
                                  <semx element="autonum" source="_">1</semx>
                                  <span class="fmt-label-delim">)</span>
                               </sup>
                            </fmt-fn-label>
                         </fn>
                      </semx>
                   </fmt-name>
                   <fmt-xref-label>
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="A">1</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="tableD-1">1</semx>
                   </fmt-xref-label>
                   <colgroup>
                      <col width="30%"/>
                      <col width="20%"/>
                      <col width="20%"/>
                      <col width="20%"/>
                      <col width="10%"/>
                   </colgroup>
                   <thead>
                      <tr>
                         <td rowspan="2" align="left">Description</td>
                         <td colspan="4" align="center">Rice sample</td>
                      </tr>
                      <tr>
                         <td valign="top" align="left">Arborio</td>
                         <td valign="middle" align="center">
                            Drago
                            <fn reference="a" id="_" target="_">
                               <p original-id="_">Parboiled rice.</p>
                               <fmt-fn-label>
                                  <sup>
                                     <semx element="autonum" source="_">a</semx>
                                     <span class="fmt-label-delim">)</span>
                                  </sup>
                               </fmt-fn-label>
                            </fn>
                         </td>
                         <td valign="bottom" align="center">
                            Balilla
                            <fn reference="a" id="_" target="_">
                               <p id="_">Parboiled rice.</p>
                               <fmt-fn-label>
                                  <sup>
                                     <semx element="autonum" source="_">a</semx>
                                     <span class="fmt-label-delim">)</span>
                                  </sup>
                               </fmt-fn-label>
                            </fn>
                         </td>
                         <td align="center">Thaibonnet</td>
                      </tr>
                   </thead>
                   <tbody>
                      <tr>
                         <th align="left">Number of laboratories retained after eliminating outliers</th>
                         <td align="center">13</td>
                         <td align="center">11</td>
                         <td align="center">13</td>
                         <td align="center">13</td>
                      </tr>
                      <tr>
                         <td align="left">Mean value, g/100 g</td>
                         <td align="center">81,2</td>
                         <td align="center">82,0</td>
                         <td align="center">81,8</td>
                         <td align="center">77,7</td>
                      </tr>
                   </tbody>
                   <tfoot>
                      <tr>
                         <td align="left">
                            Reproducibility limit,
                            <stem type="AsciiMath" id="_">R</stem>
                            <fmt-stem type="AsciiMath">
                               <semx element="stem" source="_">R</semx>
                            </fmt-stem>
                            (= 2,83
                            <stem type="AsciiMath" id="_">s_R</stem>
                            <fmt-stem type="AsciiMath">
                               <semx element="stem" source="_">s_R</semx>
                            </fmt-stem>
                            )
                         </td>
                         <td align="center">2,89</td>
                         <td align="center">0,57</td>
                         <td align="center">2,26</td>
                         <td align="center">6,06</td>
                      </tr>
                   </tfoot>
                   <p class="ListTitle">
                      <semx element="name" source="_">Key</semx>
                   </p>
                   <p class="dl">Drago: A type of rice</p>
                   <source status="generalisation" id="_">
                      SOURCE:
                      <semx element="source" source="_">
                         <origin bibitemid="ISO712" type="inline" citeas="" id="_">
                            <localityStack>
                               <locality type="section">
                                  <referenceFrom>1</referenceFrom>
                               </locality>
                            </localityStack>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-xref type="inline" target="ISO712">ISO 712, Section 1</fmt-xref>
                         </semx>
                         —
                         <semx element="modification" source="_">with adjustments</semx>
                      </semx>
                   </source>
                   <note>
                      <fmt-name>
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">NOTE</span>
                         </span>
                         <span class="fmt-label-delim">
                            <tab/>
                         </span>
                      </fmt-name>
                      <p>This is a table about rice</p>
                   </note>
                   <fmt-footnote-container>
                      <fmt-fn-body id="_" target="_" reference="1">
                         <semx element="fn" source="_">
                            <p>
                               <fmt-fn-label>
                                  <sup>
                                     Footnote
                                     <semx element="autonum" source="_">1</semx>
                                     <span class="fmt-label-delim">)</span>
                                  </sup>
                                  <span class="fmt-caption-delim">
                                     <tab/>
                                  </span>
                               </fmt-fn-label>
                               X
                            </p>
                         </semx>
                      </fmt-fn-body>
                      <fmt-fn-body id="_" target="_" reference="a">
                         <semx element="fn" source="_">
                            <p id="_">
                               <fmt-fn-label>
                                  <sup>
                                     Footnote
                                     <semx element="autonum" source="_">a</semx>
                                     <span class="fmt-label-delim">)</span>
                                  </sup>
                                  <span class="fmt-caption-delim">
                                     <tab/>
                                  </span>
                               </fmt-fn-label>
                               Parboiled rice.
                            </p>
                         </semx>
                      </fmt-fn-body>
                   </fmt-footnote-container>
                </table>
                <table id="tableD-2" unnumbered="true">
                   <thead> </thead>
                   <tbody>
                      <tr>
                         <td>A</td>
                      </tr>
                   </tbody>
                </table>
             </clause>
             <references id="_" obligation="informative" normative="true" displayorder="3">
                <title id="_">Normative References</title>
                <fmt-title depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="_">2</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Normative References</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="_">2</semx>
                </fmt-xref-label>
                <bibitem id="ISO712" type="standard">
                   <formattedref>
                      <span class="stddocTitle">Cereals and cereal products</span>
                   </formattedref>
                   <title format="text/plain">Cereals or cereal products</title>
                   <title type="main" format="text/plain">Cereals and cereal products</title>
                   <docidentifier type="ISO">ISO 712</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 712</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Organization for Standardization</name>
                      </organization>
                   </contributor>
                   <biblio-tag>ISO 712, </biblio-tag>
                </bibitem>
             </references>
          </sections>
          <bibliography>
         </bibliography>
       </iso-standard>
    OUTPUT

    html = <<~OUTPUT
           #{HTML_HDR}
           <br/>
                        <div id="_" class="TOC">
              <h1 class="IntroTitle">Contents</h1>
            </div>
                <div id="A">
                   <h1>1</h1>
                   <table id="tableD-1" class="MsoISOTable" style="border-width:1px;border-spacing:0;width:70%;page-break-after: avoid;page-break-inside: avoid;table-layout:fixed;" title="tool tip">
                      <caption>
                         <span style="display:none">long desc</span>
                      </caption>
                      <colgroup>
                         <col style="width: 30%;"/>
                         <col style="width: 20%;"/>
                         <col style="width: 20%;"/>
                         <col style="width: 20%;"/>
                         <col style="width: 10%;"/>
                      </colgroup>
                      <thead>
                         <tr>
                            <td colspan="5" style="" scope="colgroup">
                               <p class="TableTitle" style="text-align:center;;">
                                  Table 1-1 — Repeatability and reproducibility of
                                  <i>husked</i>
                                  rice yield
                                  <a href="#tableD-11" class="TableFootnoteRef">1)</a>
                               </p>
                            </td>
                         </tr>
                         <tr>
                            <td rowspan="2" style="text-align:left;border-top:none;border-bottom:solid windowtext 1.5pt;" scope="col">Description</td>
                            <td colspan="4" style="text-align:center;border-top:none;border-bottom:solid windowtext 1.0pt;" scope="colgroup">Rice sample</td>
                         </tr>
                         <tr>
                            <td style="text-align:left;vertical-align:top;border-top:none;border-bottom:solid windowtext 1.5pt;" scope="col">Arborio</td>
                            <td style="text-align:center;vertical-align:middle;border-top:none;border-bottom:solid windowtext 1.5pt;" scope="col">
                               Drago
                               <a href="#tableD-1a" class="TableFootnoteRef">a)</a>
                            </td>
                            <td style="text-align:center;vertical-align:bottom;border-top:none;border-bottom:solid windowtext 1.5pt;" scope="col">
                               Balilla
                               <a href="#tableD-1a" class="TableFootnoteRef">a)</a>
                            </td>
                            <td style="text-align:center;border-top:none;border-bottom:solid windowtext 1.5pt;" scope="col">Thaibonnet</td>
                         </tr>
                      </thead>
                      <tbody>
                         <tr>
                            <th style="font-weight:bold;text-align:left;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;" scope="row">Number of laboratories retained after eliminating outliers</th>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;">13</td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;">11</td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;">13</td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.0pt;">13</td>
                         </tr>
                         <tr>
                            <td style="text-align:left;border-top:none;border-bottom:solid windowtext 1.5pt;">Mean value, g/100 g</td>
                            <td style="text-align:center;border-top:none;border-bottom:solid windowtext 1.5pt;">81,2</td>
                            <td style="text-align:center;border-top:none;border-bottom:solid windowtext 1.5pt;">82,0</td>
                            <td style="text-align:center;border-top:none;border-bottom:solid windowtext 1.5pt;">81,8</td>
                            <td style="text-align:center;border-top:none;border-bottom:solid windowtext 1.5pt;">77,7</td>
                         </tr>
                      </tbody>
                      <tfoot>
                         <tr>
                            <td style="text-align:left;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;">
                               Reproducibility limit,
                               <span class="stem">(#(R)#)</span>
                               (= 2,83
                               <span class="stem">(#(s_R)#)</span>
                               )
                            </td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;">2,89</td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;">0,57</td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;">2,26</td>
                            <td style="text-align:center;border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;">6,06</td>
                         </tr>
                      </tfoot>
                      <p class="ListTitle">Key</p>
                      <p class="dl">Drago: A type of rice</p>
                      <div class="BlockSource">
                         <p>
                            SOURCE:
                            <a href="#ISO712">ISO 712, Section 1</a>
                            — with adjustments
                         </p>
                      </div>
                      <div class="Note">
                         <p>
                            <span class="note_label">NOTE  </span>
                            This is a table about rice
                         </p>
                      </div>
                      <aside id="fn:tableD-11" class="footnote">
                         <p>
                            <span class="TableFootnoteRef">Footnote 1)</span>
                              X
                         </p>
                      </aside>
                      <aside id="fn:tableD-1a" class="footnote">
                         <p id="_">
                            <span class="TableFootnoteRef">Footnote a)</span>
                              Parboiled rice.
                         </p>
                      </aside>
                   </table>
                   <table id="tableD-2" class="MsoISOTable" style="border-width:1px;border-spacing:0;">
                      <thead/>
                      <tbody>
                         <tr>
                            <td style="border-top:solid windowtext 1.5pt;border-bottom:solid windowtext 1.5pt;">A</td>
                         </tr>
                      </tbody>
                   </table>
                </div>
                <div>
                   <h1>2  Normative References</h1>
                   <p id="ISO712" class="NormRef">
                      ISO 712,
                      <span class="stddocTitle">Cereals and cereal products</span>
                   </p>
                </div>
             </div>
          </body>
       </html>
    OUTPUT
    pres_output = IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)
    expect(Xml::C14n.format(strip_guid(pres_output
      .gsub(/&lt;/, "&#x3c;"))))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", pres_output, true))))
      .to be_equivalent_to Xml::C14n.format(html)
  end
end
