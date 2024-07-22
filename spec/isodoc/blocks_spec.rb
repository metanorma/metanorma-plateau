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
      <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
        <preface>
          <clause type="toc" id="_" displayorder="1">
            <title depth="1">Contents</title>
          </clause>
        </preface>
        <sections>
          <clause id="A" displayorder="2">
            <title>1</title>
            <figure id="figureA-1" keep-with-next="true" keep-lines-together="true">
              <name>
                Figure 1-1 — Split-it-right
                <em>sample</em>
                divider
                <fn reference="1">
                  <p>X</p>
                </fn>
              </name>
              <image src="rice_images/rice_image1.png" height="20" width="30" id="_" mimetype="image/png" alt="alttext" title="titletxt"/>
              <image src="rice_images/rice_image1.png" height="20" width="auto" id="_" mimetype="image/png"/>
              <image src="data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSKudfOulrSOp3WOyDZu6QdvCchPGolfO0o/XBs/fNwfjZ0frl3/zy7////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAABAALAAAAAAQABAAAAVVICSOZGlCQAosJ6mu7fiyZeKqNKToQGDsM8hBADgUXoGAiqhSvp5QAnQKGIgUhwFUYLCVDFCrKUE1lBavAViFIDlTImbKC5Gm2hB0SlBCBMQiB0UjIQA7" height="20" width="auto" id="_" mimetype="image/png"/>
              <image src="data:application/xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjw/eG1sLXN0eWxlc2hlZXQgdHlwZT0idGV4dC94c2wiIGhyZWY9Ii4uLy4uLy4uL3hzbC9yZXNfZG9jL2ltZ2ZpbGUueHNsIj8+CjwhRE9DVFlQRSBpbWdmaWxlLmNvbnRlbnQgU1lTVEVNICIuLi8uLi8uLi9kdGQvdGV4dC5lbnQiPgo8aW1nZmlsZS5jb250ZW50IG1vZHVsZT0iZnVuZGFtZW50YWxzX29mX3Byb2R1Y3RfZGVzY3JpcHRpb25fYW5kX3N1cHBvcnQiIGZpbGU9ImFjdGlvbl9zY2hlbWFleHBnMS54bWwiPgo8aW1nIHNyYz0iYWN0aW9uX3NjaGVtYWV4cGcxLmdpZiI+CjxpbWcuYXJlYSBzaGFwZT0icmVjdCIgY29vcmRzPSIyMTAsMTg2LDM0MywyMjciIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9iYXNpY19hdHRyaWJ1dGVfc2NoZW1hL2Jhc2ljX2F0dHJpYnV0ZV9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMTAsMTAsOTYsNTEiIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9hY3Rpb25fc2NoZW1hL2FjdGlvbl9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMjEwLDI2NCwzNTgsMzA1IiBocmVmPSIuLi8uLi9yZXNvdXJjZXMvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEueG1sIiAvPgo8L2ltZz4KPC9pbWdmaWxlLmNvbnRlbnQ+Cg==" height="20" width="auto" id="_" mimetype="application/xml"/>
              <fn reference="a">
                <p id="_">
                  The time
                  <stem type="AsciiMath">t_90</stem>
                  was estimated to be 18,2 min for this example.
                </p>
              </fn>
              <p class="dl">A: B</p>
              <source status="generalisation">
                [SOURCE:
                <xref type="inline" target="ISO712">ISO 712, Section 1</xref>
                — with adjustments]
              </source>
            </figure>
            <figure id="figure-B">
              <name>Figure 1-2</name>
              <pre alt="A B">A &lt;
        B</pre>
            </figure>
            <figure id="figure-C" unnumbered="true">
              <pre>A &lt;
        B</pre>
            </figure>
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
               <div id="figureA-1" class="figure" style="page-break-after: avoid;page-break-inside: avoid;">
                 <img src="rice_images/rice_image1.png" height="20" width="30" title="titletxt" alt="alttext"/>
                 <img src="rice_images/rice_image1.png" height="20" width="auto"/>
                 <img src="data:image/gif;base64,R0lGODlhEAAQAMQAAORHHOVSKudfOulrSOp3WOyDZu6QdvCchPGolfO0o/XBs/fNwfjZ0frl3/zy7////wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACH5BAkAABAALAAAAAAQABAAAAVVICSOZGlCQAosJ6mu7fiyZeKqNKToQGDsM8hBADgUXoGAiqhSvp5QAnQKGIgUhwFUYLCVDFCrKUE1lBavAViFIDlTImbKC5Gm2hB0SlBCBMQiB0UjIQA7" height="20" width="auto"/>
                 <img src="data:application/xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjw/eG1sLXN0eWxlc2hlZXQgdHlwZT0idGV4dC94c2wiIGhyZWY9Ii4uLy4uLy4uL3hzbC9yZXNfZG9jL2ltZ2ZpbGUueHNsIj8+CjwhRE9DVFlQRSBpbWdmaWxlLmNvbnRlbnQgU1lTVEVNICIuLi8uLi8uLi9kdGQvdGV4dC5lbnQiPgo8aW1nZmlsZS5jb250ZW50IG1vZHVsZT0iZnVuZGFtZW50YWxzX29mX3Byb2R1Y3RfZGVzY3JpcHRpb25fYW5kX3N1cHBvcnQiIGZpbGU9ImFjdGlvbl9zY2hlbWFleHBnMS54bWwiPgo8aW1nIHNyYz0iYWN0aW9uX3NjaGVtYWV4cGcxLmdpZiI+CjxpbWcuYXJlYSBzaGFwZT0icmVjdCIgY29vcmRzPSIyMTAsMTg2LDM0MywyMjciIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9iYXNpY19hdHRyaWJ1dGVfc2NoZW1hL2Jhc2ljX2F0dHJpYnV0ZV9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMTAsMTAsOTYsNTEiIGhyZWY9Ii4uLy4uL3Jlc291cmNlcy9hY3Rpb25fc2NoZW1hL2FjdGlvbl9zY2hlbWEueG1sIiAvPgo8aW1nLmFyZWEgc2hhcGU9InJlY3QiIGNvb3Jkcz0iMjEwLDI2NCwzNTgsMzA1IiBocmVmPSIuLi8uLi9yZXNvdXJjZXMvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEvc3VwcG9ydF9yZXNvdXJjZV9zY2hlbWEueG1sIiAvPgo8L2ltZz4KPC9pbWdmaWxlLmNvbnRlbnQ+Cg==" height="20" width="auto"/>
                 <a href="#_" class="TableFootnoteRef">a</a>
                 <aside class="footnote">
                   <div id="fn:_">
                     <span>
                       Footnote
                       <span id="_" class="TableFootnoteRef">a)</span>
                        
                     </span>
                     <p id="_">
                       The time
                       <span class="stem">(#(t_90)#)</span>
                       was estimated to be 18,2 min for this example.
                     </p>
                   </div>
                 </aside>
                 <p class="dl">A: B</p>
                 <div class="BlockSource">
                   <p>
                     [SOURCE:
                     <a href="#ISO712">ISO 712, Section 1</a>
                     — with adjustments]
                   </p>
                 </div>
                 <p class="FigureTitle" style="text-align:center;">
                   Figure 1-1 — Split-it-right
                   <i>sample</i>
                   divider
                   <a class="FootnoteRef" href="#fn:1">
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
             <aside id="fn:1" class="footnote">
               <p>X</p>
             </aside>
           </div>
         </body>
       </html>
    OUTPUT

    word = <<~OUTPUT
      <body lang="EN-US" link="blue" vlink="#954F72">
           <div class="WordSection1">
             <p> </p>
           </div>
           <p class="section-break">
             <br clear="all" class="section"/>
           </p>
           <div class="WordSection2">
             <p class="page-break">
               <br clear="all" style="mso-special-character:line-break;page-break-before:always"/>
             </p>
             <div id="_" type="toc" class="TOC">
               <p class="zzContents">Contents</p>
             </div>
             <p> </p>
           </div>
           <p class="section-break">
             <br clear="all" class="section"/>
           </p>
           <div class="WordSection3">
             <div id="A">
               <h1>1</h1>
               <table id="figureA-1" class="MsoTableGrid" style="border-collapse:collapse;border:none;mso-padding-alt: 0cm 5.4pt 0cm 5.4pt;mso-border-insideh:none;mso-border-insidev:none;page-break-after: avoid;page-break-inside: avoid;" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                   <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                     <p class="Figure">
                       <img src="rice_images/rice_image1.png" height="20" alt="alttext" title="titletxt" width="30"/>
                     </p>
                   </td>
                 </tr>
                 <tr>
                   <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                     <p class="dl">A: B</p>
                   </td>
                 </tr>
                 <tr>
                   <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                     <div class="BlockSource">
                       <p>
                         [SOURCE:
                         <a href="#ISO712">ISO 712, Section 1</a>
                         — with adjustments]
                       </p>
                     </div>
                   </td>
                 </tr>
                 <tr>
                   <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                     <p class="Tabletitle" style="text-align:center;">
                       Figure 1-1 — Split-it-right
                       <i>sample</i>
                       divider
                       <a href="#_" class="TableFootnoteRef">1</a>
                       <aside>
                         <div id="ftn_">
                           <span>
                             Footnote
                             <span id="_" class="TableFootnoteRef">1)</span>
                             <span style="mso-tab-count:1">  </span>
                           </span>
                           <p>X</p>
                         </div>
                       </aside>
                     </p>
                   </td>
                 </tr>
               </table>
               <table id="figure-B" class="MsoTableGrid" style="border-collapse:collapse;border:none;mso-padding-alt: 0cm 5.4pt 0cm 5.4pt;mso-border-insideh:none;mso-border-insidev:none;" border="0" cellspacing="0" cellpadding="0">
                 <tr>
                   <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                     <p class="Tabletitle" style="text-align:center;">Figure 1-2</p>
                   </td>
                 </tr>
               </table>
               <table id="figure-C" class="MsoTableGrid" style="border-collapse:collapse;border:none;mso-padding-alt: 0cm 5.4pt 0cm 5.4pt;mso-border-insideh:none;mso-border-insidev:none;" border="0" cellspacing="0" cellpadding="0"/>
             </div>
             <div class="normref_div">
               <h1>
                 2
                 <span style="mso-tab-count:1">  </span>
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
           <br clear="all" style="page-break-before:left;mso-break-type:section-break"/>
           <div class="colophon"/>
         </body>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true).gsub(/&lt;/, "&#x3c;"))))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", presxml, true)))).to be_equivalent_to Xml::C14n.format(html)
    FileUtils.rm_rf "spec/assets/odf1.emf"
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::WordConvert.new({})
      .convert("test", presxml, true)
      .gsub(/^.*<body/m, "<body").gsub(/<\/body>.$/m, "</body>")
      .gsub(/['"][^'".]+\.(gif|xml)['"]/, "'_.\\1'")
      .gsub(/mso-bookmark:_Ref\d+/, "mso-bookmark:_Ref"))))
      .to be_equivalent_to Xml::C14n.format(word)
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
            <title depth="1">Contents</title>
          </clause>
        </preface>
        <sections>
          <clause id="A" displayorder="2">
            <title>1</title>
            <figure id="figureA-1" keep-with-next="true" keep-lines-together="true">
              <name>Figure 1-1 — Overall title</name>
              <figure id="note1">
                <name>a)  Subfigure 1</name>
                <image src="rice_images/rice_image1.png" height="20" width="30" id="_" mimetype="image/png" alt="alttext" title="titletxt"/>
              </figure>
              <figure id="note2">
                <name>b)  Subfigure 2</name>
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
    word = <<~OUTPUT
             <body lang="EN-US" link="blue" vlink="#954F72">
        <div class="WordSection1">
          <p> </p>
        </div>
        <p class="section-break">
          <br clear="all" class="section"/>
        </p>
        <div class="WordSection2">
          <p class="page-break">
            <br clear="all" style="mso-special-character:line-break;page-break-before:always"/>
          </p>
          <div id="_" type="toc" class="TOC">
            <p class="zzContents">Contents</p>
          </div>
          <p> </p>
        </div>
        <p class="section-break">
          <br clear="all" class="section"/>
        </p>
        <div class="WordSection3">
          <div id="A">
            <h1>1</h1>
            <table id="figureA-1" class="MsoTableGrid" style="border-collapse:collapse;border:none;mso-padding-alt: 0cm 5.4pt 0cm 5.4pt;mso-border-insideh:none;mso-border-insidev:none;page-break-after: avoid;page-break-inside: avoid;" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                  <p class="Figure">
                    <img src="rice_images/rice_image1.png" height="20" alt="alttext" title="titletxt" width="30"/>
                  </p>
                </td>
              </tr>
              <tr>
                <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                  <p class="SubfigureCaption">a)  Subfigure 1</p>
                </td>
              </tr>
              <tr>
                <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                  <p class="Figure">
                    <img src="rice_images/rice_image1.png" height="20" width="auto"/>
                  </p>
                </td>
              </tr>
              <tr>
                <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                  <p class="SubfigureCaption">b)  Subfigure 2</p>
                </td>
              </tr>
              <tr>
                <td valign="top" style="padding:0cm 5.4pt 0cm 5.4pt">
                  <p class="Tabletitle" style="text-align:center;">Figure 1-1 — Overall title</p>
                </td>
              </tr>
            </table>
          </div>
        </div>
        <br clear="all" style="page-break-before:left;mso-break-type:section-break"/>
        <div class="colophon"/>
      </body>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true).gsub(/&lt;/, "&#x3c;"))))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", presxml, true)))).to be_equivalent_to Xml::C14n.format(html)
    FileUtils.rm_rf "spec/assets/odf1.emf"
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::WordConvert.new({})
      .convert("test", presxml, true)
      .gsub(/^.*<body/m, "<body").gsub(/<\/body>.$/m, "</body>")
      .gsub(/['"][^'".]+\.(gif|xml)['"]/, "'_.\\1'")
      .gsub(/mso-bookmark:_Ref\d+/, "mso-bookmark:_Ref"))))
      .to be_equivalent_to Xml::C14n.format(word)
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
            <title depth="1">Contents</title>
          </clause>
        </preface>
        <sections>
          <clause id="x" inline-header="false" obligation="normative" displayorder="2">
            <title depth="1">
              1
              <tab/>
              Clause
            </title>
            <p id="_">
          Paragraph


        </p>
            <p>
              [SOURCE:
              <origin bibitemid="x" type="inline" citeas="Clause 1">1</origin>
              ;
              <origin bibitemid="x" type="inline" citeas="Clause 1">2</origin>
              ]
            </p>
            <ul id="_">
              <li>
                <p id="_">List</p>
              </li>
            </ul>
            <p>
              [SOURCE:
              <origin bibitemid="x" type="inline" citeas="Clause 1">3</origin>
              ;
              <origin bibitemid="x" type="inline" citeas="Clause 1">4</origin>
              ]
            </p>
            <ol id="_" type="alphabetic">
              <li id="_" label="a">
                <p id="_">List</p>
              </li>
            </ol>
            <p>
              [SOURCE:
              <origin bibitemid="x" type="inline" citeas="Clause 1">5</origin>
              ;
              <origin bibitemid="x" type="inline" citeas="Clause 1">6</origin>
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
              <origin bibitemid="x" type="inline" citeas="Clause 1">7</origin>
              ;
              <origin bibitemid="x" type="inline" citeas="Clause 1">8</origin>
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
                <h1>
              1
               
              Clause
            </h1>
                <p id="_">
          Paragraph


        </p>
                <p>
              [SOURCE:
              1
              ;
              2
              ]
            </p>
                <div class="ul_wrap">
                  <ul id="_">
                    <li>
                      <p id="_">List</p>
                    </li>
                  </ul>
                </div>
                <p>
              [SOURCE:
              3
              ;
              4
              ]
            </p>
                <div class="ol_wrap">
                  <ol id="_">
                    <li id="_">
                      <p id="_">List</p>
                    </li>
                  </ol>
                </div>
                <p>
              [SOURCE:
              5
              ;
              6
              ]
            </p>
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
                <p>
              [SOURCE:
              7
              ;
              8
              ]
            </p>
              </div>
            </div>
          </body>
        </html>
    HTML
    word = <<~DOC
      <body lang="EN-US" link="blue" vlink="#954F72">
          <div class="WordSection1">
            <p> </p>
          </div>
          <p class="section-break">
            <br clear="all" class="section"/>
          </p>
          <div class="WordSection2">
            <p class="page-break">
              <br clear="all" style="mso-special-character:line-break;page-break-before:always"/>
            </p>
            <div id="_" type="toc" class="TOC">
              <p class="zzContents">Contents</p>
            </div>
            <p> </p>
          </div>
          <p class="section-break">
            <br clear="all" class="section"/>
          </p>
          <div class="WordSection3">
            <div id="x">
              <h1>
                1
                <span style="mso-tab-count:1">  </span>
                Clause
              </h1>
              <p id="_">
          Paragraph


        </p>
              <p>
              [SOURCE:
              1
              ;
              2
              ]
            </p>
              <div class="ul_wrap">
                <ul id="_">
                  <li>
                    <p id="_">List</p>
                  </li>
                </ul>
              </div>
              <p>
              [SOURCE:
              3
              ;
              4
              ]
            </p>
              <div class="ol_wrap">
                <ol id="_">
                  <li id="_">
                    <p id="_">List</p>
                  </li>
                </ol>
              </div>
              <p>
              [SOURCE:
              5
              ;
              6
              ]
            </p>
              <table id="_" class="dl">
                <tr>
                  <td valign="top" align="left">
                    <p align="left" style="margin-left:0pt;text-align:left;">List</p>
                  </td>
                  <td valign="top">
                    <p id="_">Entry</p>
                  </td>
                </tr>
              </table>
              <p>
              [SOURCE:
              7
              ;
              8
              ]
            </p>
            </div>
          </div>
          <br clear="all" style="page-break-before:left;mso-break-type:section-break"/>
          <div class="colophon"/>
        </body>
    DOC
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
  .convert("test", presxml, true)))).to be_equivalent_to Xml::C14n.format(html)
    FileUtils.rm_rf "spec/assets/odf1.emf"
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::WordConvert.new({})
      .convert("test", presxml, true)
      .gsub(/^.*<body/m, "<body").gsub(/<\/body>.$/m, "</body>")
      .gsub(/['"][^'".]+\.(gif|xml)['"]/, "'_.\\1'")
      .gsub(/mso-bookmark:_Ref\d+/, "mso-bookmark:_Ref"))))
      .to be_equivalent_to Xml::C14n.format(word)
  end
end
