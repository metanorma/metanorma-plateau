require "spec_helper"
require "fileutils"

RSpec.describe IsoDoc do
  it "processes figures" do
    input = <<~INPUT
            <iso-standard xmlns="http://riboseinc.com/isoxml">
            <sections><clause id="A">
            <figure id="figureA-1" keep-with-next="true" keep-lines-together="true">
          <name>Split-it-right <em>sample</em> divider<fn reference="1"><p>X</p></fn></name>
          <image src="rice_images/rice_image1.png" height="20" width="30" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png" alt="alttext" title="titletxt"/>
          <image src="rice_images/rice_image1.png" height="20" width="auto" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f1" mimetype="image/png"/>
          <image src="data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSKudfOulrSOp3WOyDZu6QdvCchPGolfO0o/XBs/fNwfjZ0frl3/zy7////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAABAALAAAAAAQABAAAAVVICSOZGlCQAosJ6mu7fiyZeKqNKToQGDsM8hBADgUXoGAiqhSvp5QAnQKGIgUhwFUYLCVDFCrKUE1lBavAViFIDlTImbKC5Gm2hB0SlBCBMQiB0UjIQA7" height="20" width="auto" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f2" mimetype="image/png"/>
          <image src="data:application/xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjw/eG1sLXN0eWxlc2hlZXQgdHlwZT0idGV4dC94c2wiIGhyZWY9Ii4uLy4uLy4uL3hzbC9yZXNfZG9jL2ltZ2ZpbGUueHNsIj8+CjwhRE9DVFlQRSBpbWdmaWxlLmNvbnRlbnQgU1lTVEVNICIuLi8uLi8uLi9kdGQvdGV4dC5lbnQiPgo8aW1nZmlsZS5jb250ZW50IG1vZHVsZT0iZnVuZGFtZW50YWxzX29mX3Byb2R1Y3RfZGVzY3JpcHRpb25fYW5kX3N1cHBvcnQiIGZpbGU9ImFjdGlvbl9zY2hlbWFleHBnMS54bWwiPgo8aW1nIHNyYz0iYWN0aW9uX3NjaGVtYWV4cGcxLmdpZiI+CjxpbWcuYXJlYSBzaGFwZT0icmVjdCIgY29vcmRzPSIyMTAsMTg2LDM0MywyMjciIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9iYXNpY19hdHRyaWJ1dGVfc2NoZW1hL2Jhc2ljX2F0dHJpYnV0ZV9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMTAsMTAsOTYsNTEiIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9hY3Rpb25fc2NoZW1hL2FjdGlvbl9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMjEwLDI2NCwzNTgsMzA1IiBocmVmPSIuLi8uLi9yZXNvdXJjZXMvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEueG1sIiAvPgo8L2ltZz4KPC9pbWdmaWxlLmNvbnRlbnQ+Cg==" height="20" width="auto" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f2" mimetype="application/xml"/>
          <fn reference="a">
          <p id="_ef2c85b8-5a5a-4ecd-a1e6-92acefaaa852">The time <stem type="AsciiMath">t_90</stem> was estimated to be 18,2 min for this example.</p>
        </fn>
          <dl>
          <dt>A</dt>
          <dd><p>B</p></dd>
          </dl>
                <source status="generalisation">
          <origin bibitemid="ISO712" type="inline" citeas="ISO 712">
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
        </figure>
        <figure id="figure-B">
        <pre alt="A B">A &#x3c;
        B</pre>
        </figure>
        <figure id="figure-C" unnumbered="true">
        <pre>A &#x3c;
        B</pre>
        </figure>
            </clause></sections>
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
          <figure id="figureA-1" keep-with-next="true" keep-lines-together="true" autonum="1-1">
             <name id="_">
                Split-it-right
                <em>sample</em>
                divider
                <fn reference="1" original-reference="1" target="_" original-id="_">
                   <p>X</p>
                   <fmt-fn-label>
                      <sup>
                         <semx element="autonum" source="_">1</semx>
                      </sup>
                   </fmt-fn-label>
                </fn>
             </name>
             <fmt-name>
                <span class="fmt-caption-label">
                   <span class="fmt-element-name">Figure</span>
                   <semx element="autonum" source="A">1</semx>
                   <span class="fmt-autonum-delim">-</span>
                   <semx element="autonum" source="figureA-1">1</semx>
                </span>
                <span class="fmt-caption-delim"> — </span>
                <semx element="name" source="_">
                   Split-it-right
                   <em>sample</em>
                   divider
                   <fn reference="1" original-reference="1" id="_" target="_">
                      <p>X</p>
                      <fmt-fn-label>
                         <sup>
                            <semx element="autonum" source="_">1</semx>
                         </sup>
                      </fmt-fn-label>
                   </fn>
                </semx>
             </fmt-name>
             <fmt-xref-label>
                <span class="fmt-element-name">Figure</span>
                <semx element="autonum" source="A">1</semx>
                <span class="fmt-autonum-delim">-</span>
                <semx element="autonum" source="figureA-1">1</semx>
             </fmt-xref-label>
             <image src="rice_images/rice_image1.png" height="20" width="30" id="_" mimetype="image/png" alt="alttext" title="titletxt"/>
             <image src="rice_images/rice_image1.png" height="20" width="auto" id="_" mimetype="image/png"/>
             <image src="data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSKudfOulrSOp3WOyDZu6QdvCchPGolfO0o/XBs/fNwfjZ0frl3/zy7////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAABAALAAAAAAQABAAAAVVICSOZGlCQAosJ6mu7fiyZeKqNKToQGDsM8hBADgUXoGAiqhSvp5QAnQKGIgUhwFUYLCVDFCrKUE1lBavAViFIDlTImbKC5Gm2hB0SlBCBMQiB0UjIQA7" height="20" width="auto" id="_" mimetype="image/png"/>
             <image src="data:application/xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjw/eG1sLXN0eWxlc2hlZXQgdHlwZT0idGV4dC94c2wiIGhyZWY9Ii4uLy4uLy4uL3hzbC9yZXNfZG9jL2ltZ2ZpbGUueHNsIj8+CjwhRE9DVFlQRSBpbWdmaWxlLmNvbnRlbnQgU1lTVEVNICIuLi8uLi8uLi9kdGQvdGV4dC5lbnQiPgo8aW1nZmlsZS5jb250ZW50IG1vZHVsZT0iZnVuZGFtZW50YWxzX29mX3Byb2R1Y3RfZGVzY3JpcHRpb25fYW5kX3N1cHBvcnQiIGZpbGU9ImFjdGlvbl9zY2hlbWFleHBnMS54bWwiPgo8aW1nIHNyYz0iYWN0aW9uX3NjaGVtYWV4cGcxLmdpZiI+CjxpbWcuYXJlYSBzaGFwZT0icmVjdCIgY29vcmRzPSIyMTAsMTg2LDM0MywyMjciIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9iYXNpY19hdHRyaWJ1dGVfc2NoZW1hL2Jhc2ljX2F0dHJpYnV0ZV9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMTAsMTAsOTYsNTEiIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9hY3Rpb25fc2NoZW1hL2FjdGlvbl9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMjEwLDI2NCwzNTgsMzA1IiBocmVmPSIuLi8uLi9yZXNvdXJjZXMvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEueG1sIiAvPgo8L2ltZz4KPC9pbWdmaWxlLmNvbnRlbnQ+Cg==" height="20" width="auto" id="_" mimetype="application/xml"/>
             <fn reference="a" id="_" target="_">
                <p original-id="_">
                   The time
                   <stem type="AsciiMath" id="_">t_90</stem>
                   <fmt-stem type="AsciiMath">
                      <semx element="stem" source="_">t_90</semx>
                   </fmt-stem>
                   was estimated to be 18,2 min for this example.
                </p>
                <fmt-fn-label>
                   <sup>
                      <semx element="autonum" source="_">a</semx>
                      <span class="fmt-label-delim">)</span>
                   </sup>
                </fmt-fn-label>
             </fn>
             <p keep-with-next="true">
                <strong>Key</strong>
             </p>
                   <dl class="formula_dl">
         <dt>A</dt>
         <dd>
            <p>
               <span class="fmt-dt-delim">: </span>
               B
            </p>
         </dd>
      </dl>
             <source status="generalisation">
                [SOURCE:
                <origin bibitemid="ISO712" type="inline" citeas="ISO 712" id="_">
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
                ]
             </source>
             <fmt-footnote-container>
                <fmt-fn-body id="_" target="_" reference="a">
                   <semx element="fn" source="_">
                      <p id="_">
                         <fmt-fn-label>
                               Footnote
                            <sup>
                               <semx element="autonum" source="_">a</semx>
                               <span class="fmt-label-delim">)</span>
                            </sup>
                            <span class="fmt-caption-delim">
                               <tab/>
                            </span>
                         </fmt-fn-label>
                         The time
                         <stem type="AsciiMath" id="_">t_90</stem>
                         <fmt-stem type="AsciiMath">
                            <semx element="stem" source="_">t_90</semx>
                         </fmt-stem>
                         was estimated to be 18,2 min for this example.
                      </p>
                   </semx>
                </fmt-fn-body>
             </fmt-footnote-container>
          </figure>
          <figure id="figure-B" autonum="1-2">
             <fmt-name>
                <span class="fmt-caption-label">
                   <span class="fmt-element-name">Figure</span>
                   <semx element="autonum" source="A">1</semx>
                   <span class="fmt-autonum-delim">-</span>
                   <semx element="autonum" source="figure-B">2</semx>
                </span>
             </fmt-name>
             <fmt-xref-label>
                <span class="fmt-element-name">Figure</span>
                <semx element="autonum" source="A">1</semx>
                <span class="fmt-autonum-delim">-</span>
                <semx element="autonum" source="figure-B">2</semx>
             </fmt-xref-label>
             <pre alt="A B">A &lt;
         B</pre>
          </figure>
          <figure id="figure-C" unnumbered="true">
             <pre>A &lt;
         B</pre>
          </figure>
       </clause>
    OUTPUT

    html = <<~OUTPUT
       <div id="A">
          <h1>1</h1>
          <div id="figureA-1" class="figure" style="page-break-after: avoid;page-break-inside: avoid;">
             <img src="rice_images/rice_image1.png" height="20" width="30" title="titletxt" alt="alttext"/>
             <img src="rice_images/rice_image1.png" height="20" width="auto"/>
             <img src="data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSKudfOulrSOp3WOyDZu6QdvCchPGolfO0o/XBs/fNwfjZ0frl3/zy7////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAABAALAAAAAAQABAAAAVVICSOZGlCQAosJ6mu7fiyZeKqNKToQGDsM8hBADgUXoGAiqhSvp5QAnQKGIgUhwFUYLCVDFCrKUE1lBavAViFIDlTImbKC5Gm2hB0SlBCBMQiB0UjIQA7" height="20" width="auto"/>
             <img src="data:application/xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjw/eG1sLXN0eWxlc2hlZXQgdHlwZT0idGV4dC94c2wiIGhyZWY9Ii4uLy4uLy4uL3hzbC9yZXNfZG9jL2ltZ2ZpbGUueHNsIj8+CjwhRE9DVFlQRSBpbWdmaWxlLmNvbnRlbnQgU1lTVEVNICIuLi8uLi8uLi9kdGQvdGV4dC5lbnQiPgo8aW1nZmlsZS5jb250ZW50IG1vZHVsZT0iZnVuZGFtZW50YWxzX29mX3Byb2R1Y3RfZGVzY3JpcHRpb25fYW5kX3N1cHBvcnQiIGZpbGU9ImFjdGlvbl9zY2hlbWFleHBnMS54bWwiPgo8aW1nIHNyYz0iYWN0aW9uX3NjaGVtYWV4cGcxLmdpZiI+CjxpbWcuYXJlYSBzaGFwZT0icmVjdCIgY29vcmRzPSIyMTAsMTg2LDM0MywyMjciIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9iYXNpY19hdHRyaWJ1dGVfc2NoZW1hL2Jhc2ljX2F0dHJpYnV0ZV9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMTAsMTAsOTYsNTEiIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9hY3Rpb25fc2NoZW1hL2FjdGlvbl9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMjEwLDI2NCwzNTgsMzA1IiBocmVmPSIuLi8uLi9yZXNvdXJjZXMvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEueG1sIiAvPgo8L2ltZz4KPC9pbWdmaWxlLmNvbnRlbnQ+Cg==" height="20" width="auto"/>
             <a href="#figureA-1a" class="TableFootnoteRef">a)</a>
             <p style="page-break-after: avoid;">
                <b>Key</b>
             </p>
                   <div class="figdl">
         <dl class="formula_dl">
            <dt>
               <p>A</p>
            </dt>
            <dd>
               <p>
                  <span class="fmt-dt-delim">: </span>
                  B
               </p>
            </dd>
         </dl>
      </div>
             <div class="BlockSource">
                <p>
                   [SOURCE:
                   <a href="#ISO712">ISO 712, Section 1</a>
                   — with adjustments]
                </p>
             </div>
             <aside id="fn:figureA-1a" class="footnote">
                <p id="_">
                   <span class="TableFootnoteRef">Footnote a)</span>
                     The time
                   <span class="stem">(#(t_90)#)</span>
                   was estimated to be 18,2 min for this example.
                </p>
             </aside>
             <p class="FigureTitle" style="text-align:center;">
                Figure 1-1 — Split-it-right
                <i>sample</i>
                divider
                <a class="FootnoteRef" href="#fn:_">
                   <sup>1</sup>
                </a>
             </p>
          </div>
          <div id="figure-B" class="figure">
             <pre>A &lt;
         B</pre>
             <p class="FigureTitle" style="text-align:center;">Figure 1-2</p>
          </div>
          <div id="figure-C" class="figure">
             <pre>A &lt;
         B</pre>
          </div>
       </div>
    OUTPUT

    pres_output = IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)
    expect(Xml::C14n.format(strip_guid(Nokogiri::XML(pres_output)
      .at("//xmlns:clause[@id = 'A']").to_xml)
      .gsub(/&lt;/, "&#x3c;")))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(strip_guid(Nokogiri::XML(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", pres_output, true))
      .at("//div[@id = 'A']").to_xml)))
      .to be_equivalent_to Xml::C14n.format(html)
  end

  it "processes subfigures" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
           <sections><clause id="A">
           <figure id="figureA-1" keep-with-next="true" keep-lines-together="true">
         <name>Overall title</name>
         <figure id="note1">
       <name>Subfigure 1</name>
         <image src="rice_images/rice_image1.png" height="20" width="30" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f0" mimetype="image/png" alt="alttext" title="titletxt"/>
         </figure>
         <figure id="note2">
       <name>Subfigure 2</name>
         <image src="rice_images/rice_image1.png" height="20" width="auto" id="_8357ede4-6d44-4672-bac4-9a85e82ab7f1" mimetype="image/png"/>
         </figure>
       </figure>
           </clause></sections>
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
                <figure id="figureA-1" keep-with-next="true" keep-lines-together="true" autonum="1-1">
                   <name id="_">Overall title</name>
                   <fmt-name>
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">Figure</span>
                         <semx element="autonum" source="A">1</semx>
                         <span class="fmt-autonum-delim">-</span>
                         <semx element="autonum" source="figureA-1">1</semx>
                      </span>
                      <span class="fmt-caption-delim"> — </span>
                      <semx element="name" source="_">Overall title</semx>
                   </fmt-name>
                   <fmt-xref-label>
                      <span class="fmt-element-name">Figure</span>
                      <semx element="autonum" source="A">1</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="figureA-1">1</semx>
                   </fmt-xref-label>
                   <figure id="note1" autonum="1-1 a">
                      <name id="_">Subfigure 1</name>
                      <fmt-name>
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="note1">a</semx>
                            <span class="fmt-label-delim">)</span>
                         </span>
                         <span class="fmt-caption-delim">  </span>
                         <semx element="name" source="_">Subfigure 1</semx>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Figure</span>
                         <semx element="autonum" source="A">1</semx>
                         <span class="fmt-autonum-delim">-</span>
                         <semx element="autonum" source="figureA-1">1</semx>
                         <span class="fmt-autonum-delim"> </span>
                         <semx element="autonum" source="note1">a</semx>
                         <span class="fmt-autonum-delim">)</span>
                      </fmt-xref-label>
                      <image src="rice_images/rice_image1.png" height="20" width="30" id="_" mimetype="image/png" alt="alttext" title="titletxt"/>
                   </figure>
                   <figure id="note2" autonum="1-1 b">
                      <name id="_">Subfigure 2</name>
                      <fmt-name>
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="note2">b</semx>
                            <span class="fmt-label-delim">)</span>
                         </span>
                         <span class="fmt-caption-delim">  </span>
                         <semx element="name" source="_">Subfigure 2</semx>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Figure</span>
                         <semx element="autonum" source="A">1</semx>
                         <span class="fmt-autonum-delim">-</span>
                         <semx element="autonum" source="figureA-1">1</semx>
                         <span class="fmt-autonum-delim"> </span>
                         <semx element="autonum" source="note2">b</semx>
                         <span class="fmt-autonum-delim">)</span>
                      </fmt-xref-label>
                      <image src="rice_images/rice_image1.png" height="20" width="auto" id="_" mimetype="image/png"/>
                   </figure>
                </figure>
             </clause>
          </sections>
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
               <div id="figureA-1" class="figure" style="page-break-after: avoid;page-break-inside: avoid;">
                 <div id="note1" class="figure">
                   <img src="rice_images/rice_image1.png" height="20" width="30" title="titletxt" alt="alttext"/>
                   <p class="FigureTitle" style="text-align:center;">a)  Subfigure 1</p>
                 </div>
                 <div id="note2" class="figure">
                   <img src="rice_images/rice_image1.png" height="20" width="auto"/>
                   <p class="FigureTitle" style="text-align:center;">b)  Subfigure 2</p>
                 </div>
                 <p class="FigureTitle" style="text-align:center;">Figure 1-1 — Overall title</p>
               </div>
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

  it "indent Japanese paragraphs" do
    presxml = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
           <sections><clause id="A" displayorder="1">
           <p>ABC</p>
           </clause></sections>
           </iso-standard>
    INPUT
    html = <<~OUTPUT
      #{HTML_HDR}
         <div id="A">
         <h1/>
         <p>ABC</p>
               </div>
             </div>
         </body>
       </html>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", presxml, true)))).to be_equivalent_to Xml::C14n.format(html)
    presxml.sub!(/<sections>/,
                 "<bibdata><language>ja</language></bibdata><sections>")
    html.gsub!('lang="en"', 'lang="ja"')
      .sub!("<p>ABC</p>", "<p>&#x3000;ABC</p>")
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", presxml, true))))
      .to be_equivalent_to Xml::C14n.format(html)
  end

  it "processes sources on paragraphs and lists" do
    input = <<~INPUT
         <iso-standard xmlns="http://riboseinc.com/isoxml">
               <sections>
        <clause id="x" inline-header="false" obligation="normative">
          <title>Clause</title>
          <p id="_">
            Paragraph
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">1</origin>
            </source>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">2</origin>
            </source>
          </p>
          <ul id="_">
            <li>
              <p id="_">List</p>
            </li>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">3</origin>
            </source>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">4</origin>
            </source>
          </ul>
          <ol id="_">
            <li>
              <p id="_">List</p>
            </li>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">5</origin>
            </source>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">6</origin>
            </source>
          </ol>
          <dl id="_">
            <dt>List</dt>
            <dd>
              <p id="_">Entry</p>
            </dd>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">7</origin>
            </source>
            <source status="identical">
              <origin bibitemid="x" type="inline" citeas="">8</origin>
            </source>
          </dl>
        </clause>
      </sections>
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
             <clause id="x" inline-header="false" obligation="normative" displayorder="2">
                <title id="_">Clause</title>
                <fmt-title depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="x">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Clause</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="x">1</semx>
                </fmt-xref-label>
                <p id="_">
             Paragraph
             
             
           </p>
                <p>
                   [SOURCE:
                   <origin bibitemid="x" type="inline" citeas="" id="_">1</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">1</fmt-origin>
                   </semx>
                   ;
                   <origin bibitemid="x" type="inline" citeas="" id="_">2</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">2</fmt-origin>
                   </semx>
                   ]
                </p>
                <ul id="_">
                   <li>
                      <p id="_">List</p>
                   </li>
                </ul>
                <p>
                   [SOURCE:
                   <origin bibitemid="x" type="inline" citeas="" id="_">3</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">3</fmt-origin>
                   </semx>
                   ;
                   <origin bibitemid="x" type="inline" citeas="" id="_">4</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">4</fmt-origin>
                   </semx>
                   ]
                </p>
                <ol id="_" type="alphabet">
                   <li id="_" label="a">
                      <p id="_">List</p>
                   </li>
                </ol>
                <p>
                   [SOURCE:
                   <origin bibitemid="x" type="inline" citeas="" id="_">5</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">5</fmt-origin>
                   </semx>
                   ;
                   <origin bibitemid="x" type="inline" citeas="" id="_">6</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">6</fmt-origin>
                   </semx>
                   ]
                </p>
                <dl id="_">
                   <dt>List</dt>
                   <dd>
                      <p id="_">Entry</p>
                   </dd>
                </dl>
                <p>
                   [SOURCE:
                   <origin bibitemid="x" type="inline" citeas="" id="_">7</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">7</fmt-origin>
                   </semx>
                   ;
                   <origin bibitemid="x" type="inline" citeas="" id="_">8</origin>
                   <semx element="origin" source="_">
                      <fmt-origin bibitemid="x" type="inline" citeas="&lt;span class=&quot;fmt-element-name&quot;&gt;Clause&lt;/span&gt; 1">8</fmt-origin>
                   </semx>
                   ]
                </p>
             </clause>
          </sections>
       </iso-standard>
    OUTPUT
    html = <<~HTML
       <html lang="en">
          <head/>
          <body lang="en">
             <div class="title-section">
                <p> </p>
             </div>
             <br/>
             <div class="prefatory-section">
                <p> </p>
             </div>
             <br/>
             <div class="main-section">
                <br/>
                <div id="_" class="TOC">
                   <h1 class="IntroTitle">Contents</h1>
                </div>
                <div id="x">
                   <h1>1  Clause</h1>
                   <p id="_">
             Paragraph
     
     
           </p>
                   <p>[SOURCE: 1
             ;
               2]</p>
                   <div class="ul_wrap">
                      <ul id="_">
                         <li>
                            <p id="_">List</p>
                         </li>
                      </ul>
                   </div>
                   <p>[SOURCE: 3
             ;
               4]</p>
                   <div class="ol_wrap">
                      <ol type="a" id="_" class="alphabet">
                         <li id="_">
                            <p id="_">List</p>
                         </li>
                      </ol>
                   </div>
                   <p>[SOURCE: 5
             ;
               6]</p>
                   <div class="figdl">
                      <dl id="_">
                         <dt>
                            <p>List</p>
                         </dt>
                         <dd>
                            <p id="_">Entry</p>
                         </dd>
                      </dl>
                   </div>
                   <p>[SOURCE: 7
             ;
               8]</p>
                </div>
             </div>
          </body>
       </html>
    HTML
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

  it "do not label figures embedded within other assets" do
    input = <<~INPUT
      <standard-document xmlns="https://www.metanorma.org/ns/standoc" type="semantic">
        <preface>
          <foreword id="A">
            <p id="B">
            <table id="C">
            <colgroup><col width="100%"/></colgroup>
            <tbody><tr><td>
            <figure id="D">X</figure>
            </td></tr>
            </tbody>
            </table>
            </p>
       </foreword></preface>
       <sections>
          <clause id="A1">
            <p id="B1">
            <table id="C1">
            <colgroup><col width="100%"/></colgroup>
            <tbody><tr><td>
            <figure id="D1">X</figure>
            </td></tr>
            </tbody>
            </table>
            </p>
       </clause></sections>
          <annex id="A2">
            <p id="B2">
            <table id="C2">
            <colgroup><col width="100%"/></colgroup>
            <tbody><tr><td>
            <figure id="D2">X</figure>
            </td></tr>
            </tbody>
            </table>
            </p>
       </annex>
       </standard-document>
    INPUT
    presxml = <<~OUTPUT
       <standard-document xmlns="https://www.metanorma.org/ns/standoc" type="presentation">
          <preface>
             <clause type="toc" id="_" displayorder="1">
                <fmt-title depth="1">Contents</fmt-title>
             </clause>
             <foreword id="A" displayorder="2">
                <title id="_">Foreword</title>
                <fmt-title depth="1">
                   <semx element="title" source="_">Foreword</semx>
                </fmt-title>
                <p id="B">
                   <table id="C" autonum="1">
                      <fmt-name>
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">Table</span>
                            <semx element="autonum" source="C">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Table</span>
                         <semx element="autonum" source="C">1</semx>
                      </fmt-xref-label>
                      <thead> </thead>
                      <colgroup>
                         <col width="100%"/>
                      </colgroup>
                      <tbody>
                         <tr>
                            <td>
                               <figure id="D" autonum="1">
                                  <fmt-name>
                                     <span class="fmt-caption-label">
                                        <span class="fmt-element-name">Figure</span>
                                        <semx element="autonum" source="D">1</semx>
                                     </span>
                                  </fmt-name>
                                  <fmt-xref-label>
                                     <span class="fmt-element-name">Figure</span>
                                     <semx element="autonum" source="D">1</semx>
                                  </fmt-xref-label>
                                  X
                               </figure>
                            </td>
                         </tr>
                      </tbody>
                   </table>
                </p>
             </foreword>
          </preface>
          <sections>
             <clause id="A1" displayorder="3">
                <fmt-title depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="A1">1</semx>
                   </span>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="A1">1</semx>
                </fmt-xref-label>
                <p id="B1">
                   <table id="C1" autonum="1-1">
                      <fmt-name>
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">Table</span>
                            <semx element="autonum" source="A1">1</semx>
                            <span class="fmt-autonum-delim">-</span>
                            <semx element="autonum" source="C1">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Table</span>
                         <semx element="autonum" source="A1">1</semx>
                         <span class="fmt-autonum-delim">-</span>
                         <semx element="autonum" source="C1">1</semx>
                      </fmt-xref-label>
                      <thead> </thead>
                      <colgroup>
                         <col width="100%"/>
                      </colgroup>
                      <tbody>
                         <tr>
                            <td>
                               <figure id="D1">X</figure>
                            </td>
                         </tr>
                      </tbody>
                   </table>
                </p>
             </clause>
          </sections>
          <annex id="A2" autonum="A" displayorder="4">
             <fmt-title>
                <span class="fmt-caption-label">
                   <span class="fmt-element-name">Annex</span>
                   <semx element="autonum" source="A2">A</semx>
                </span>
                <br/>
                <span class="fmt-obligation">(informative)</span>
             </fmt-title>
             <fmt-xref-label>
                <span class="fmt-element-name">Annex</span>
                <semx element="autonum" source="A2">A</semx>
             </fmt-xref-label>
             <p id="B2">
                <table id="C2" autonum="A-1">
                   <fmt-name>
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">Table</span>
                         <semx element="autonum" source="A2">A</semx>
                         <span class="fmt-autonum-delim">-</span>
                         <semx element="autonum" source="C2">1</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <span class="fmt-element-name">Table</span>
                      <semx element="autonum" source="A2">A</semx>
                      <span class="fmt-autonum-delim">-</span>
                      <semx element="autonum" source="C2">1</semx>
                   </fmt-xref-label>
                   <thead> </thead>
                   <colgroup>
                      <col width="100%"/>
                   </colgroup>
                   <tbody>
                      <tr>
                         <td>
                            <figure id="D2">X</figure>
                         </td>
                      </tr>
                   </tbody>
                </table>
             </p>
          </annex>
       </standard-document>
    OUTPUT
    expect(strip_guid(Xml::C14n.format(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
      .sub(%r{<localized-strings>.*</localized-strings>}m, "")))
      .to be_equivalent_to Xml::C14n.format(presxml)
  end
end
