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
            <title depth="1">Contents</title>
          </clause>
        </preface>
        <sections>
          <clause id="A" displayorder="2">
            <title>1</title>
            <table id="tableD-1" alt="tool tip" summary="long desc" width="70%" keep-with-next="true" keep-lines-together="true">
              <name>
                Table 1-1 — Repeatability and reproducibility of
                <em>husked</em>
                rice yield
                <fn reference="1">
                  <p>X</p>
                </fn>
              </name>
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
                    <fn reference="a">
                      <p id="_">Parboiled rice.</p>
                    </fn>
                  </td>
                  <td valign="bottom" align="center">
                    Balilla
                    <fn reference="a">
                      <p id="_">Parboiled rice.</p>
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
                    <stem type="AsciiMath">R</stem>
                    (= 2,83
                    <stem type="AsciiMath">s_R</stem>
                    )
                  </td>
                  <td align="center">2,89</td>
                  <td align="center">0,57</td>
                  <td align="center">2,26</td>
                  <td align="center">6,06</td>
                </tr>
              </tfoot>
              <p class="ListTitle">Key</p>
              <p class="dl">Drago: A type of rice</p>
              <source status="generalisation">
                SOURCE:
                <xref type="inline" target="ISO712">ISO 712, Section 1</xref>
                — with adjustments
              </source>
              <note>
                <name>NOTE</name>
                <p>This is a table about rice</p>
              </note>
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
            <title depth="1">
              2
              <tab/>
              Normative References
            </title>
            <bibitem id="ISO712" type="standard">
              <formattedref>
                <em>
                  <span class="stddocTitle">Cereals and cereal products</span>
                </em>
              </formattedref>
              <docidentifier type="ISO">ISO 712</docidentifier>
              <docidentifier scope="biblio-tag">ISO 712</docidentifier>
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
                        <a href="#tableD-11" class="TableFootnoteRef">1</a>
                        <aside class="footnote">
                          <div id="fn:tableD-11">
                            <span>
                              Footnote
                              <span id="tableD-11" class="TableFootnoteRef">1)</span>
                               
                            </span>
                            <p>X</p>
                          </div>
                        </aside>
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
                      <a href="#tableD-1a" class="TableFootnoteRef">a</a>
                      <aside class="footnote">
                        <div id="fn:tableD-1a">
                          <span>
                            Footnote
                            <span id="tableD-1a" class="TableFootnoteRef">a)</span>
                             
                          </span>
                          <p id="_">Parboiled rice.</p>
                        </div>
                      </aside>
                    </td>
                    <td style="text-align:center;vertical-align:bottom;border-top:none;border-bottom:solid windowtext 1.5pt;" scope="col">
                      Balilla
                      <a href="#tableD-1a" class="TableFootnoteRef">a</a>
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
                    <span class="note_label">NOTE</span>
                      This is a table about rice
                  </p>
                </div>
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
              <h1>
              2
               
              Normative References
            </h1>
              <p id="ISO712" class="NormRef">
                ISO 712,
                <i>
                  <span class="stddocTitle">Cereals and cereal products</span>
                </i>
              </p>
            </div>
          </div>
        </body>
      </html>
    OUTPUT

    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", presxml, true)))
      .to be_equivalent_to Xml::C14n.format(html)
  end
end
