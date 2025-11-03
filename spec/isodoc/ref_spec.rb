require "spec_helper"

RSpec.describe IsoDoc do
  it "processes IsoXML bibliographies" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
        <bibdata>
          <language>en</language>
        </bibdata>
        <preface>
          <foreword>
            <p id="_f06fd0d1-a203-4f3d-a515-0bdba0f8d83f">
              <eref bibitemid="ISO712"/>
              <eref bibitemid="ISBN"/>
              <eref bibitemid="ISSN"/>
              <eref bibitemid="ISO16634"/>
              <eref bibitemid="ref1"/>
              <eref bibitemid="ref10"/>
              <eref bibitemid="ref12"/>
              <eref bibitemid="A"/>
            </p>
          </foreword>
        </preface>
        <bibliography>
          <references id="_normative_references" normative="true" obligation="informative">
            <title>Normative References</title>
            <p>The following documents are referred to in the text in such a way that some or all of their content constitutes requirements of this document. For dated references, only the edition cited applies. For undated references, the latest edition of the referenced document (including any amendments) applies.</p>
            <bibitem id="ISO712" type="standard">
              <title format="text/plain">Cereals or cereal products</title>
              <title format="text/plain" type="main">Cereals and cereal products</title>
              <docidentifier type="ISO">ISO 712</docidentifier>
              <contributor>
                <role type="publisher"/>
                <organization>
                  <name>International Organization for Standardization</name>
                </organization>
              </contributor>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <bibitem id="ISO16634" type="standard">
              <title format="text/plain" language="x">Cereals, pulses, milled cereal products, xxxx, oilseeds and animal feeding stuffs</title>
              <title format="text/plain" language="en">Cereals, pulses, milled cereal products, oilseeds and animal feeding stuffs</title>
              <docidentifier type="ISO">ISO 16634:-- (all parts)</docidentifier>
              <date type="published">
                <on>--</on>
              </date>
              <contributor>
                <role type="publisher"/>
                <organization>
                  <name>ISO</name>
                </organization>
              </contributor>
              <language>en</language>
              <script>Latn</script>
              <note format="text/plain" reference="1" type="Unpublished-Status">Under preparation. (Stage at the time of publication ISO/DIS 16634)</note>
              <extent type="part">
                <referenceFrom>all</referenceFrom>
              </extent>
            </bibitem>
            <bibitem id="ISO20483" type="standard">
              <title format="text/plain">Cereals and pulses</title>
              <docidentifier type="ISO">ISO 20483:2013-2014</docidentifier>
              <date type="published">
                <from>2013</from>
                <to>2014</to>
              </date>
              <contributor>
                <role type="publisher"/>
                <organization>
                  <name>International Organization for Standardization</name>
                </organization>
              </contributor>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <bibitem id="ref1">
              <formattedref format="application/x-isodoc+xml">
                <smallcap>Standard No I.C.C 167</smallcap> .

                <em>Determination of the protein content in cereal and cereal products for food and animal feeding stuffs according to the Dumas combustion method</em>
                (see

                <link target="http://www.icc.or.at"/>
                )</formattedref>
              <docidentifier type="ICC">167</docidentifier>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <note>
              <p>This is an annotation of ISO 20483:2013-2014</p>
            </note>
          </references>
          <references id="_bibliography" normative="false" obligation="informative">
            <title>Bibliography</title>
            <bibitem id="ISBN" type="book">
              <title format="text/plain">Chemicals for analytical laboratory use</title>
              <docidentifier type="ISBN">ISBN</docidentifier>
              <docidentifier type="metanorma">[1]</docidentifier>
              <contributor>
                <role type="publisher"/>
                <organization>
                  <abbreviation>ISBN</abbreviation>
                </organization>
              </contributor>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <bibitem id="_" anchor="A" type="inbook">
             <title>
               <em>Work</em>
             </title>
             <uri type="citation">http://www.example.com</uri>
             <docidentifier type="title">Work</docidentifier>
             <date type="issued">
               <from>1991</from>
               <to>1992</to>
             </date>
             <date type="published">
               <on>1996-01-02</on>
             </date>
             <contributor>
               <role type="author"/>
               <person>
                 <name>
                   <formatted-initials>S.</formatted-initials>
                   <surname>Wozniak</surname>
                 </name>
               </person>
             </contributor>
             <contributor>
               <role type="author"/>
               <person>
                 <name>
                   <forename>Steve</forename>
                   <surname>Jobs</surname>
                 </name>
               </person>
             </contributor>
             <contributor>
               <role type="author"/>
               <person>
                 <name>
                   <forename>J.</forename>
                   <forename>Edgar</forename>
                   <surname>Hoover</surname>
                 </name>
               </person>
             </contributor>
             <contributor>
               <role type="publisher"/>
               <organization>
                 <name>International Standardization Organization</name>
               </organization>
             </contributor>
             <edition>4</edition>
             <version>draft</version>
              <language>en</language>
              <script>Latn</script>
             <note>Also available in paperback.</note>
             <abstract>This is a <em>journey</em> into sound</abstract>
             <place>Geneva</place>
             <relation type="includedIn">
               <bibitem type="book">
                 <title>Collected Essays</title>
                 <contributor>
                   <role type="editor"/>
                   <person>
                     <name>
                       <formatted-initials>W. H</formatted-initials>
                       <surname>Gates</surname>
                     </name>
                   </person>
                 </contributor>
                 <contributor>
                   <role type="author"/>
                   <organization>
                     <name>UNICEF</name>
                   </organization>
                 </contributor>
                 <series>
                   <title>Bibliographers Anonymous</title>
                </series>
               </bibitem>
             </relation>
             <extent>
               <locality type="volume">
                 <referenceFrom>4</referenceFrom>
               </locality>
               <locality type="issue">
                 <referenceFrom>2</referenceFrom>
                 <referenceTo>3</referenceTo>
               </locality>
               <locality type="page">
                 <referenceFrom>12</referenceFrom>
                 <referenceTo>13</referenceTo>
               </locality>
               <locality type="page">
                 <referenceFrom>19</referenceFrom>
               </locality>
             </extent>
             <classification>A</classification>
         <classification type="B">C</classification>
         <classification>D</classification>
         <keyword>key word</keyword>
         <keyword>word key</keyword>
        </bibitem>
                      <bibitem type="article" id="ISSN">
              <title>Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday</title>
        <docidentifier type="DOI">https://doi.org/10.1017/9781108877831</docidentifier>
        <docidentifier type="ISBN">9781108877831</docidentifier>
        <date type="published"><on>2022</on></date>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Aluffi</surname><forename>Paolo</forename></name>
          </person>
        </contributor>
                <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Anderson</surname><forename>David</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Hering</surname><forename>Milena</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Mustaţă</surname><forename>Mircea</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Payne</surname><forename>Sam</forename></name>
          </person>
        </contributor>
        <edition>1</edition>
              <language>en</language>
              <script>Latn</script>
        <series>
        <title>London Mathematical Society Lecture Note Series</title>
        <number>472</number>
        <partnumber>472</partnumber>
        <run>N.S.</run>
        </series>
            <contributor>
              <role type="publisher"/>
              <organization>
                <name>Cambridge University Press</name>
              </organization>
            </contributor>
            <place>Cambridge, UK</place>
            <extent>
                <localityStack>
                  <locality type="volume"><referenceFrom>1</referenceFrom></locality>
                  <locality type="issue"><referenceFrom>7</referenceFrom></locality>
        <locality type="page">
          <referenceFrom>89</referenceFrom>
          <referenceTo>112</referenceTo>
        </locality>
                </localityStack>
            </extent>
      </bibitem>
            <note>
              <p>This is an annotation of document ISSN.</p>
            </note>
            <note>
              <p>This is another annotation of document ISSN.</p>
            </note>
            <bibitem id="ISO3696" type="standard">
              <title format="text/plain">Water for analytical laboratory use</title>
              <docidentifier type="ISO">ISO 3696</docidentifier>
              <contributor>
                <role type="publisher"/>
                <organization>
                  <name>ISO</name>
                </organization>
              </contributor>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <bibitem id="ref10">
              <formattedref format="application/x-isodoc+xml">
                <smallcap>Standard No I.C.C 167</smallcap> .

                <em>Determination of the protein content in cereal and cereal products for food and animal feeding stuffs according to the Dumas combustion method</em>
                (see

                <link target="http://www.icc.or.at"/>
                )</formattedref>
              <docidentifier type="metanorma">[10]</docidentifier>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <bibitem id="ref11">
              <title>Internet Calendaring and Scheduling Core Object Specification (iCalendar)</title>
              <docidentifier type="IETF">RFC 10</docidentifier>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
            <bibitem id="ref12">
              <formattedref format="application/x-isodoc+xml">CitationWorks. 2019.

                <em>How to cite a reference</em>
                .</formattedref>
              <docidentifier type="metanorma">[Citn]</docidentifier>
              <docidentifier type="IETF">RFC 20</docidentifier>
              <language>en</language>
              <script>Latn</script>
            </bibitem>
          </references>
        </bibliography>
      </iso-standard>
    INPUT
    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <bibdata>
             <language current="true">en</language>
          </bibdata>
          <preface>
             <clause type="toc" id="_" displayorder="1">
                <fmt-title depth="1" id="_">Contents</fmt-title>
             </clause>
             <foreword id="_" displayorder="2">
                <title id="_">Foreword</title>
                <fmt-title depth="1" id="_">
                   <semx element="title" source="_">Foreword</semx>
                </fmt-title>
                <p id="_">
                   <eref bibitemid="ISO712" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISO712">ISO 712</fmt-xref>
                   </semx>
                   <eref bibitemid="ISBN" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISBN">[1]</fmt-xref>
                   </semx>
                   <eref bibitemid="ISSN" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISSN">[3]</fmt-xref>
                   </semx>
                   <eref bibitemid="ISO16634" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISO16634">ISO 16634:--</fmt-xref>
                   </semx>
                   <eref bibitemid="ref1" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ref1">ICC 167</fmt-xref>
                   </semx>
                   <eref bibitemid="ref10" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ref10">[5]</fmt-xref>
                   </semx>
                   <eref bibitemid="ref12" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ref12">Citn</fmt-xref>
                   </semx>
                   <eref bibitemid="A" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-link target="http://www.example.com">
                         <em>Work</em>
                      </fmt-link>
                   </semx>
                </p>
             </foreword>
          </preface>
          <sections>
             <references id="_" normative="true" obligation="informative" displayorder="3">
                <title id="_">Normative References</title>
                <fmt-title depth="1" id="_">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="_">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Normative References</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="_">1</semx>
                </fmt-xref-label>
                <p>The following documents are referred to in the text in such a way that some or all of their content constitutes requirements of this document. For dated references, only the edition cited applies. For undated references, the latest edition of the referenced document (including any amendments) applies.</p>
                <bibitem id="ISO712" type="standard">
                   <biblio-tag><strong>ISO 712</strong>, </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Cereals and cereal products</span>
                   </formattedref>
                   <title format="text/plain">Cereals or cereal products</title>
                   <title format="text/plain" type="main">Cereals and cereal products</title>
                   <docidentifier type="ISO">ISO 712</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 712</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Organization for Standardization</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ISO16634" type="standard">
                   <biblio-tag>
                      <strong>ISO 16634:-- (all parts)</strong>
                      <fn id="_" reference="1" original-reference="1" target="_">
                         <p>Under preparation. (Stage at the time of publication ISO/DIS 16634)</p>
                         <fmt-fn-label>
                            <span class="fmt-caption-label">
                               <sup>
                                  <semx element="autonum" source="_">1</semx>
                               </sup>
                            </span>
                         </fmt-fn-label>
                      </fn>
                      ,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Cereals, pulses, milled cereal products, oilseeds and animal feeding stuffs</span>
                   </formattedref>
                   <title format="text/plain" language="x">Cereals, pulses, milled cereal products, xxxx, oilseeds and animal feeding stuffs</title>
                   <title format="text/plain" language="en">Cereals, pulses, milled cereal products, oilseeds and animal feeding stuffs</title>
                   <docidentifier type="ISO">ISO 16634:-- (all parts)</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 16634:-- (all parts)</docidentifier>
                   <date type="published">
                      <on>--</on>
                   </date>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>ISO</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                   <note format="text/plain" reference="1" type="Unpublished-Status">Under preparation. (Stage at the time of publication ISO/DIS 16634)</note>
                   <extent type="part">
                      <referenceFrom>all</referenceFrom>
                   </extent>
                </bibitem>
                <bibitem id="ISO20483" type="standard">
                   <biblio-tag><strong>ISO 20483:2013-2014</strong>, </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Cereals and pulses</span>
                   </formattedref>
                   <title format="text/plain">Cereals and pulses</title>
                   <docidentifier type="ISO">ISO 20483:2013-2014</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 20483:2013-2014</docidentifier>
                   <date type="published">
                      <from>2013</from>
                      <to>2014</to>
                   </date>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Organization for Standardization</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref1">
                   <biblio-tag><strong>ICC 167</strong>, </biblio-tag>
                   <formattedref format="application/x-isodoc+xml">
                      <smallcap>Standard No I.C.C 167</smallcap>
                      .
                      <em>Determination of the protein content in cereal and cereal products for food and animal feeding stuffs according to the Dumas combustion method</em>
                      (see
                      <link target="http://www.icc.or.at" id="_"/>
                      <semx element="link" source="_">
                         <fmt-link target="http://www.icc.or.at"/>
                      </semx>
                      )
                   </formattedref>
                   <docidentifier type="ICC">ICC 167</docidentifier>
                   <docidentifier scope="biblio-tag">ICC 167</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <note>
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">NOTE</span>
                      </span>
                      <span class="fmt-label-delim">
                         <tab/>
                      </span>
                   </fmt-name>
                   <p>This is an annotation of ISO 20483:2013-2014</p>
                </note>
             </references>
          </sections>
          <bibliography>
             <references id="_" normative="false" obligation="informative" displayorder="4">
                <title id="_">Bibliography</title>
                <fmt-title depth="1" id="_">
                   <semx element="title" source="_">Bibliography</semx>
                </fmt-title>
                <bibitem id="ISBN" type="book">
                   <biblio-tag>
                      [1]
                      <tab/>
                   </biblio-tag>
                   <formattedref>Chemicals for analytical laboratory use. n.p.: n.d</formattedref>
                   <title format="text/plain">Chemicals for analytical laboratory use</title>
                   <docidentifier type="metanorma-ordinal">[1]</docidentifier>
                   <docidentifier type="ISBN">ISBN</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <abbreviation>ISBN</abbreviation>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="A" anchor="A" type="inbook">
                   <biblio-tag>
                      [2]
                      <tab/>
                   </biblio-tag>
                   <formattedref>
                      Wozniak S., Jobs S., &amp; Hoover J.E.
                      <em>Work</em>
                      . Collected Essays UNICEF). Fourth edition. (Bibliographers Anonymous). Geneva: International Standardization Organization. 1996. vol. 4 p. 19. Available from:
                      <span class="biburl">
                         <link target="http://www.example.com" id="_">http://www.example.com</link>
                         <semx element="link" source="_">
                            <fmt-link target="http://www.example.com">http://www.example.com</fmt-link>
                         </semx>
                      </span>
                   </formattedref>
                   <title>
                      <em>Work</em>
                   </title>
                   <uri type="citation">http://www.example.com</uri>
                   <docidentifier type="metanorma-ordinal">[2]</docidentifier>
                   <docidentifier type="title">Work</docidentifier>
                   <date type="issued">
                      <from>1991</from>
                      <to>1992</to>
                   </date>
                   <date type="published">
                      <on>1996-01-02</on>
                   </date>
                   <contributor>
                      <role type="author"/>
                      <person>
                         <name>
                            <formatted-initials>S.</formatted-initials>
                            <surname>Wozniak</surname>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="author"/>
                      <person>
                         <name>
                            <forename>Steve</forename>
                            <surname>Jobs</surname>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="author"/>
                      <person>
                         <name>
                            <forename>J.</forename>
                            <forename>Edgar</forename>
                            <surname>Hoover</surname>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Standardization Organization</name>
                      </organization>
                   </contributor>
                   <edition>4</edition>
                   <version>draft</version>
                   <language>en</language>
                   <script>Latn</script>
                   <note>Also available in paperback.</note>
                   <abstract>
                      This is a
                      <em>journey</em>
                      into sound
                   </abstract>
                   <place>Geneva</place>
                   <relation type="includedIn">
                      <bibitem type="book">
                         <title>Collected Essays</title>
                         <contributor>
                            <role type="editor"/>
                            <person>
                               <name>
                                  <formatted-initials>W. H</formatted-initials>
                                  <surname>Gates</surname>
                               </name>
                            </person>
                         </contributor>
                         <contributor>
                            <role type="author"/>
                            <organization>
                               <name>UNICEF</name>
                            </organization>
                         </contributor>
                         <series>
                            <title>Bibliographers Anonymous</title>
                         </series>
                      </bibitem>
                   </relation>
                   <extent>
                      <locality type="volume">
                         <referenceFrom>4</referenceFrom>
                      </locality>
                      <locality type="issue">
                         <referenceFrom>2</referenceFrom>
                         <referenceTo>3</referenceTo>
                      </locality>
                      <locality type="page">
                         <referenceFrom>12</referenceFrom>
                         <referenceTo>13</referenceTo>
                      </locality>
                      <locality type="page">
                         <referenceFrom>19</referenceFrom>
                      </locality>
                   </extent>
                   <classification>A</classification>
                   <classification type="B">C</classification>
                   <classification>D</classification>
                   <keyword>key word</keyword>
                   <keyword>word key</keyword>
                </bibitem>
                <bibitem type="article" id="ISSN">
                   <biblio-tag>
                      [3]
                      <tab/>
                   </biblio-tag>
                   <formattedref>Aluffi P., Anderson D., Hering M., Mustaţă M., &amp; Payne S. (eds.). Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday. London Mathematical Society Lecture Note Series (N.S.). 2022, vol. 1 no. 7, pp. 89–112</formattedref>
                   <title>Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday</title>
                   <docidentifier type="metanorma-ordinal">[3]</docidentifier>
                   <docidentifier type="DOI">DOI https://doi.org/10.1017/9781108877831</docidentifier>
                   <docidentifier type="ISBN">ISBN 9781108877831</docidentifier>
                   <date type="published">
                      <on>2022</on>
                   </date>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Aluffi</surname>
                            <forename>Paolo</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Anderson</surname>
                            <forename>David</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Hering</surname>
                            <forename>Milena</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Mustaţă</surname>
                            <forename>Mircea</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Payne</surname>
                            <forename>Sam</forename>
                         </name>
                      </person>
                   </contributor>
                   <edition>1</edition>
                   <language>en</language>
                   <script>Latn</script>
                   <series>
                      <title>London Mathematical Society Lecture Note Series</title>
                      <number>472</number>
                      <partnumber>472</partnumber>
                      <run>N.S.</run>
                   </series>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>Cambridge University Press</name>
                      </organization>
                   </contributor>
                   <place>Cambridge, UK</place>
                   <extent>
                      <localityStack>
                         <locality type="volume">
                            <referenceFrom>1</referenceFrom>
                         </locality>
                         <locality type="issue">
                            <referenceFrom>7</referenceFrom>
                         </locality>
                         <locality type="page">
                            <referenceFrom>89</referenceFrom>
                            <referenceTo>112</referenceTo>
                         </locality>
                      </localityStack>
                   </extent>
                </bibitem>
                <note>
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">NOTE</span>
                      </span>
                      <span class="fmt-label-delim">
                         <tab/>
                      </span>
                   </fmt-name>
                   <p>This is an annotation of document ISSN.</p>
                </note>
                <note>
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">NOTE</span>
                      </span>
                      <span class="fmt-label-delim">
                         <tab/>
                      </span>
                   </fmt-name>
                   <p>This is another annotation of document ISSN.</p>
                </note>
                <bibitem id="ISO3696" type="standard">
                   <biblio-tag>
                      [4]
                      <tab/>
                      ISO 3696,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Water for analytical laboratory use</span>
                   </formattedref>
                   <title format="text/plain">Water for analytical laboratory use</title>
                   <docidentifier type="metanorma-ordinal">[4]</docidentifier>
                   <docidentifier type="ISO">ISO 3696</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 3696</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>ISO</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref10">
                   <biblio-tag>
                      [5]
                      <tab/>
                   </biblio-tag>
                   <formattedref format="application/x-isodoc+xml">
                      <smallcap>Standard No I.C.C 167</smallcap>
                      .
                      <em>Determination of the protein content in cereal and cereal products for food and animal feeding stuffs according to the Dumas combustion method</em>
                      (see
                      <link target="http://www.icc.or.at" id="_"/>
                      <semx element="link" source="_">
                         <fmt-link target="http://www.icc.or.at"/>
                      </semx>
                      )
                   </formattedref>
                   <docidentifier type="metanorma-ordinal">[5]</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref11">
                   <biblio-tag>
                      [6]
                      <tab/>
                      IETF RFC 10,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Internet Calendaring and Scheduling Core Object Specification (iCalendar)</span>
                   </formattedref>
                   <title>Internet Calendaring and Scheduling Core Object Specification (iCalendar)</title>
                   <docidentifier type="metanorma-ordinal">[6]</docidentifier>
                   <docidentifier type="IETF">IETF RFC 10</docidentifier>
                   <docidentifier scope="biblio-tag">IETF RFC 10</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref12">
                   <biblio-tag>
                      Citn
                      <tab/>
                      IETF RFC 20,
                   </biblio-tag>
                   <formattedref format="application/x-isodoc+xml">
                      CitationWorks. 2019.
                      <em>How to cite a reference</em>
                      .
                   </formattedref>
                   <docidentifier type="metanorma">[Citn]</docidentifier>
                   <docidentifier type="IETF">IETF RFC 20</docidentifier>
                   <docidentifier scope="biblio-tag">IETF RFC 20</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
             </references>
          </bibliography>
          <fmt-footnote-container>
             <fmt-fn-body id="_" target="_" reference="1">
                <semx element="fn" source="_">
                   <p>
                      <fmt-fn-label>
                         <span class="fmt-caption-label">
                            <sup>
                               <semx element="autonum" source="_">1</semx>
                            </sup>
                         </span>
                         <span class="fmt-caption-delim">
                            <tab/>
                         </span>
                      </fmt-fn-label>
                      Under preparation. (Stage at the time of publication ISO/DIS 16634)
                   </p>
                </semx>
             </fmt-fn-body>
          </fmt-footnote-container>
       </iso-standard>
    OUTPUT

    pres_output = IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)
    expect(Canon.format_xml(strip_guid(pres_output
      .sub(%r{<localized-strings>.*</localized-strings>}m, "")
      .gsub(/reference="[^"]+"/, 'reference="1"'))))
      .to be_equivalent_to Canon.format_xml(presxml)

    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <bibdata>
             <language current="true">ja</language>
          </bibdata>
          <preface>
             <clause type="toc" id="_" displayorder="1">
                <fmt-title depth="1" id="_">目　次</fmt-title>
             </clause>
             <foreword id="_" displayorder="2">
                <title id="_">まえがき</title>
                <fmt-title depth="1" id="_">
                   <semx element="title" source="_">まえがき</semx>
                </fmt-title>
                <p id="_">
                   <eref bibitemid="ISO712" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISO712">ISO 712</fmt-xref>
                   </semx>
                   <eref bibitemid="ISBN" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISBN">[1]</fmt-xref>
                   </semx>
                   <eref bibitemid="ISSN" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISSN">[3]</fmt-xref>
                   </semx>
                   <eref bibitemid="ISO16634" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ISO16634">ISO 16634:-- (規格群)</fmt-xref>
                   </semx>
                   <eref bibitemid="ref1" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ref1">ICC 167</fmt-xref>
                   </semx>
                   <eref bibitemid="ref10" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ref10">[5]</fmt-xref>
                   </semx>
                   <eref bibitemid="ref12" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-xref target="ref12">Citn</fmt-xref>
                   </semx>
                   <eref bibitemid="A" id="_"/>
                   <semx element="eref" source="_">
                      <fmt-link target="http://www.example.com">
                         <em>Work</em>
                      </fmt-link>
                   </semx>
                </p>
             </foreword>
          </preface>
          <sections>
             <references id="_" normative="true" obligation="informative" displayorder="3">
                <title id="_">Normative References</title>
                <fmt-title depth="1" id="_">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="_">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Normative References</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                    
                   <semx element="autonum" source="_">1</semx>
                </fmt-xref-label>
                <p>The following documents are referred to in the text in such a way that some or all of their content constitutes requirements of this document. For dated references, only the edition cited applies. For undated references, the latest edition of the referenced document (including any amendments) applies.</p>
                <bibitem id="ISO712" type="standard">
                   <biblio-tag>
                      <strong>ISO 712</strong>
                      ,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Cereals and cereal products</span>
                   </formattedref>
                   <title format="text/plain">Cereals or cereal products</title>
                   <title format="text/plain" type="main">Cereals and cereal products</title>
                   <docidentifier type="ISO">ISO 712</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 712</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Organization for Standardization</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ISO16634" type="standard">
                   <biblio-tag>
                      <strong>ISO 16634:-- (</strong>
                      <span style="font-family:&quot;MS Gothic&quot;">規格群</span>
                      <strong>)</strong>
                      <fn id="_" reference="1" original-reference="1" target="_">
                         <p>Under preparation。（Stage at the time of publication ISO/DIS 16634）</p>
                         <fmt-fn-label>
                            <span class="fmt-caption-label">
                               <sup>
                                  <semx element="autonum" source="_">1</semx>
                               </sup>
                            </span>
                         </fmt-fn-label>
                      </fn>
                      ,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Cereals, pulses, milled cereal products, xxxx, oilseeds and animal feeding stuffs</span>
                   </formattedref>
                   <title format="text/plain" language="x">Cereals, pulses, milled cereal products, xxxx, oilseeds and animal feeding stuffs</title>
                   <title format="text/plain" language="en">Cereals, pulses, milled cereal products, oilseeds and animal feeding stuffs</title>
                   <docidentifier type="ISO">ISO 16634:-- (規格群)</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 16634:-- (規格群)</docidentifier>
                   <date type="published">
                      <on>--</on>
                   </date>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>ISO</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                   <note format="text/plain" reference="1" type="Unpublished-Status">Under preparation. (Stage at the time of publication ISO/DIS 16634)</note>
                   <extent type="part">
                      <referenceFrom>all</referenceFrom>
                   </extent>
                </bibitem>
                <bibitem id="ISO20483" type="standard">
                   <biblio-tag>
                      <strong>ISO 20483:2013-2014</strong>
                      ,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Cereals and pulses</span>
                   </formattedref>
                   <title format="text/plain">Cereals and pulses</title>
                   <docidentifier type="ISO">ISO 20483:2013-2014</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 20483:2013-2014</docidentifier>
                   <date type="published">
                      <from>2013</from>
                      <to>2014</to>
                   </date>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Organization for Standardization</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref1">
                   <biblio-tag>
                      <strong>ICC 167</strong>
                      ,
                   </biblio-tag>
                   <formattedref format="application/x-isodoc+xml">
                      <smallcap>Standard No I.C.C 167</smallcap>
                      .
                      <em>Determination of the protein content in cereal and cereal products for food and animal feeding stuffs according to the Dumas combustion method</em>
                      (see
                      <link target="http://www.icc.or.at" id="_"/>
                      <semx element="link" source="_">
                         <fmt-link target="http://www.icc.or.at"/>
                      </semx>
                      )
                   </formattedref>
                   <docidentifier type="ICC">ICC 167</docidentifier>
                   <docidentifier scope="biblio-tag">ICC 167</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <note>
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">注記</span>
                      </span>
                      <span class="fmt-label-delim">
                         <tab/>
                      </span>
                   </fmt-name>
                   <p>This is an annotation of ISO 20483:2013-2014</p>
                </note>
             </references>
          </sections>
          <bibliography>
             <references id="_" normative="false" obligation="informative" displayorder="4">
                <title id="_">Bibliography</title>
                <fmt-title depth="1" id="_">
                   <semx element="title" source="_">Bibliography</semx>
                </fmt-title>
                <bibitem id="ISBN" type="book">
                   <biblio-tag>
                      [1]
                      <tab/>
                   </biblio-tag>
                   <formattedref>Chemicals for analytical laboratory use. 都市はありません。：日付なし</formattedref>
                   <title format="text/plain">Chemicals for analytical laboratory use</title>
                   <docidentifier type="metanorma-ordinal">[1]</docidentifier>
                   <docidentifier type="ISBN">ISBN</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <abbreviation>ISBN</abbreviation>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="A" anchor="A" type="inbook">
                   <biblio-tag>
                      [2]
                      <tab/>
                   </biblio-tag>
                   <formattedref>
                      Wozniak S., Jobs S., Hoover J.E.
                      <em>Work</em>
                      . Collected Essays UNICEF）. 第4版. （Bibliographers Anonymous）. Geneva： International Standardization Organization. 1996. 巻4 19頁. 入手先： 
                      <span class="biburl">
                         <link target="http://www.example.com" id="_">http://www.example.com</link>
                         <semx element="link" source="_">
                            <fmt-link target="http://www.example.com">http://www.example.com</fmt-link>
                         </semx>
                      </span>
                   </formattedref>
                   <title>
                      <em>Work</em>
                   </title>
                   <uri type="citation">http://www.example.com</uri>
                   <docidentifier type="metanorma-ordinal">[2]</docidentifier>
                   <docidentifier type="title">Work</docidentifier>
                   <date type="issued">
                      <from>1991</from>
                      <to>1992</to>
                   </date>
                   <date type="published">
                      <on>1996-01-02</on>
                   </date>
                   <contributor>
                      <role type="author"/>
                      <person>
                         <name>
                            <formatted-initials>S.</formatted-initials>
                            <surname>Wozniak</surname>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="author"/>
                      <person>
                         <name>
                            <forename>Steve</forename>
                            <surname>Jobs</surname>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="author"/>
                      <person>
                         <name>
                            <forename>J.</forename>
                            <forename>Edgar</forename>
                            <surname>Hoover</surname>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>International Standardization Organization</name>
                      </organization>
                   </contributor>
                   <edition>4</edition>
                   <version>draft</version>
                   <language>en</language>
                   <script>Latn</script>
                   <note>Also available in paperback.</note>
                   <abstract>
                      This is a
                      <em>journey</em>
                      into sound
                   </abstract>
                   <place>Geneva</place>
                   <relation type="includedIn">
                      <bibitem type="book">
                         <title>Collected Essays</title>
                         <contributor>
                            <role type="editor"/>
                            <person>
                               <name>
                                  <formatted-initials>W. H</formatted-initials>
                                  <surname>Gates</surname>
                               </name>
                            </person>
                         </contributor>
                         <contributor>
                            <role type="author"/>
                            <organization>
                               <name>UNICEF</name>
                            </organization>
                         </contributor>
                         <series>
                            <title>Bibliographers Anonymous</title>
                         </series>
                      </bibitem>
                   </relation>
                   <extent>
                      <locality type="volume">
                         <referenceFrom>4</referenceFrom>
                      </locality>
                      <locality type="issue">
                         <referenceFrom>2</referenceFrom>
                         <referenceTo>3</referenceTo>
                      </locality>
                      <locality type="page">
                         <referenceFrom>12</referenceFrom>
                         <referenceTo>13</referenceTo>
                      </locality>
                      <locality type="page">
                         <referenceFrom>19</referenceFrom>
                      </locality>
                   </extent>
                   <classification>A</classification>
                   <classification type="B">C</classification>
                   <classification>D</classification>
                   <keyword>key word</keyword>
                   <keyword>word key</keyword>
                </bibitem>
                <bibitem type="article" id="ISSN">
                   <biblio-tag>
                      [3]
                      <tab/>
                   </biblio-tag>
                   <formattedref>Aluffi P., Anderson D., Hering M., Mustaţă M.,  Payne S. （編）. Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday. London Mathematical Society Lecture Note Series （N.S.）. 2022, 巻1 いいえ7, 89〜112頁</formattedref>
                   <title>Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday</title>
                   <docidentifier type="metanorma-ordinal">[3]</docidentifier>
                   <docidentifier type="DOI">DOI https://doi.org/10.1017/9781108877831</docidentifier>
                   <docidentifier type="ISBN">ISBN 9781108877831</docidentifier>
                   <date type="published">
                      <on>2022</on>
                   </date>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Aluffi</surname>
                            <forename>Paolo</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Anderson</surname>
                            <forename>David</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Hering</surname>
                            <forename>Milena</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Mustaţă</surname>
                            <forename>Mircea</forename>
                         </name>
                      </person>
                   </contributor>
                   <contributor>
                      <role type="editor"/>
                      <person>
                         <name>
                            <surname>Payne</surname>
                            <forename>Sam</forename>
                         </name>
                      </person>
                   </contributor>
                   <edition>1</edition>
                   <language>en</language>
                   <script>Latn</script>
                   <series>
                      <title>London Mathematical Society Lecture Note Series</title>
                      <number>472</number>
                      <partnumber>472</partnumber>
                      <run>N.S.</run>
                   </series>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>Cambridge University Press</name>
                      </organization>
                   </contributor>
                   <place>Cambridge, UK</place>
                   <extent>
                      <localityStack>
                         <locality type="volume">
                            <referenceFrom>1</referenceFrom>
                         </locality>
                         <locality type="issue">
                            <referenceFrom>7</referenceFrom>
                         </locality>
                         <locality type="page">
                            <referenceFrom>89</referenceFrom>
                            <referenceTo>112</referenceTo>
                         </locality>
                      </localityStack>
                   </extent>
                </bibitem>
                <note>
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">注記</span>
                      </span>
                      <span class="fmt-label-delim">
                         <tab/>
                      </span>
                   </fmt-name>
                   <p>This is an annotation of document ISSN.</p>
                </note>
                <note>
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <span class="fmt-element-name">注記</span>
                      </span>
                      <span class="fmt-label-delim">
                         <tab/>
                      </span>
                   </fmt-name>
                   <p>This is another annotation of document ISSN.</p>
                </note>
                <bibitem id="ISO3696" type="standard">
                   <biblio-tag>
                      [4]
                      <tab/>
                      ISO 3696,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Water for analytical laboratory use</span>
                   </formattedref>
                   <title format="text/plain">Water for analytical laboratory use</title>
                   <docidentifier type="metanorma-ordinal">[4]</docidentifier>
                   <docidentifier type="ISO">ISO 3696</docidentifier>
                   <docidentifier scope="biblio-tag">ISO 3696</docidentifier>
                   <contributor>
                      <role type="publisher"/>
                      <organization>
                         <name>ISO</name>
                      </organization>
                   </contributor>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref10">
                   <biblio-tag>
                      [5]
                      <tab/>
                   </biblio-tag>
                   <formattedref format="application/x-isodoc+xml">
                      <smallcap>Standard No I.C.C 167</smallcap>
                      .
                      <em>Determination of the protein content in cereal and cereal products for food and animal feeding stuffs according to the Dumas combustion method</em>
                      (see
                      <link target="http://www.icc.or.at" id="_"/>
                      <semx element="link" source="_">
                         <fmt-link target="http://www.icc.or.at"/>
                      </semx>
                      )
                   </formattedref>
                   <docidentifier type="metanorma-ordinal">[5]</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref11">
                   <biblio-tag>
                      [6]
                      <tab/>
                      IETF RFC 10,
                   </biblio-tag>
                   <formattedref>
                      <span class="stddocTitle">Internet Calendaring and Scheduling Core Object Specification (iCalendar)</span>
                   </formattedref>
                   <title>Internet Calendaring and Scheduling Core Object Specification (iCalendar)</title>
                   <docidentifier type="metanorma-ordinal">[6]</docidentifier>
                   <docidentifier type="IETF">IETF RFC 10</docidentifier>
                   <docidentifier scope="biblio-tag">IETF RFC 10</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
                <bibitem id="ref12">
                   <biblio-tag>
                      Citn
                      <tab/>
                      IETF RFC 20,
                   </biblio-tag>
                   <formattedref format="application/x-isodoc+xml">
                      CitationWorks. 2019.
                      <em>How to cite a reference</em>
                      .
                   </formattedref>
                   <docidentifier type="metanorma">[Citn]</docidentifier>
                   <docidentifier type="IETF">IETF RFC 20</docidentifier>
                   <docidentifier scope="biblio-tag">IETF RFC 20</docidentifier>
                   <language>en</language>
                   <script>Latn</script>
                </bibitem>
             </references>
          </bibliography>
          <fmt-footnote-container>
             <fmt-fn-body id="_" target="_" reference="1">
                <semx element="fn" source="_">
                   <p>
                      <fmt-fn-label>
                         <span class="fmt-caption-label">
                            <sup>
                               <semx element="autonum" source="_">1</semx>
                            </sup>
                         </span>
                         <span class="fmt-caption-delim">
                            <tab/>
                         </span>
                      </fmt-fn-label>
                      Under preparation。（Stage at the time of publication ISO/DIS 16634）
                   </p>
                </semx>
             </fmt-fn-body>
          </fmt-footnote-container>
       </iso-standard>
    OUTPUT
    pres_output = IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input
      .sub("<language>en</language>", "<language>ja</language>"), true)
    expect(Canon.format_xml(strip_guid(pres_output
      .sub(%r{<localized-strings>.*</localized-strings>}m, "")
      .gsub(/reference="[^"]+"/, 'reference="1"'))))
      .to be_equivalent_to Canon.format_xml(presxml)
  end

  it "tailors rendering to language of reference" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
        <bibdata>
          <language>en</language>
        </bibdata>
        <bibliography>
          <references id="_normative_references" normative="true" obligation="informative">
            <title>Normative References</title>
                      <bibitem type="article" id="ISSN">
              <title>Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday</title>
        <docidentifier type="DOI">https://doi.org/10.1017/9781108877831</docidentifier>
        <docidentifier type="ISBN">9781108877831</docidentifier>
        <date type="published"><on>2022</on></date>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Aluffi</surname><forename>Paolo</forename></name>
          </person>
        </contributor>
                <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Anderson</surname><forename>David</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Hering</surname><forename>Milena</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Mustaţă</surname><forename>Mircea</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Payne</surname><forename>Sam</forename></name>
          </person>
        </contributor>
        <edition>1</edition>
        <language>en</language>
        <series>
        <title>London Mathematical Society Lecture Note Series</title>
        <number>472</number>
        <partnumber>472</partnumber>
        <run>N.S.</run>
        </series>
            <contributor>
              <role type="publisher"/>
              <organization>
                <name>Cambridge University Press</name>
              </organization>
            </contributor>
            <place>Cambridge, UK</place>
            <extent>
                <localityStack>
                  <locality type="volume"><referenceFrom>1</referenceFrom></locality>
                  <locality type="issue"><referenceFrom>7</referenceFrom></locality>
        <locality type="page">
          <referenceFrom>89</referenceFrom>
          <referenceTo>112</referenceTo>
        </locality>
                </localityStack>
            </extent>
      </bibitem>
       <bibitem type="article" id="ISSN1" language="ja">
              <title>Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday</title>
        <docidentifier type="DOI">https://doi.org/10.1017/9781108877831</docidentifier>
        <docidentifier type="ISBN">9781108877831</docidentifier>
        <date type="published"><on>2022</on></date>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Aluffi</surname><forename>Paolo</forename></name>
          </person>
        </contributor>
                <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Anderson</surname><forename>David</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Hering</surname><forename>Milena</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Mustaţă</surname><forename>Mircea</forename></name>
          </person>
        </contributor>
        <contributor>
          <role type="editor"/>
          <person>
            <name><surname>Payne</surname><forename>Sam</forename></name>
          </person>
        </contributor>
        <edition>1</edition>
        <language>ja</language>
        <series>
        <title>London Mathematical Society Lecture Note Series</title>
        <number>472</number>
        <partnumber>472</partnumber>
        <run>N.S.</run>
        </series>
            <contributor>
              <role type="publisher"/>
              <organization>
                <name>Cambridge University Press</name>
              </organization>
            </contributor>
            <place>Cambridge, UK</place>
            <extent>
                <localityStack>
                  <locality type="volume"><referenceFrom>1</referenceFrom></locality>
                  <locality type="issue"><referenceFrom>7</referenceFrom></locality>
        <locality type="page">
          <referenceFrom>89</referenceFrom>
          <referenceTo>112</referenceTo>
        </locality>
                </localityStack>
            </extent>
      </bibitem>
      </references>
      </bibliography>
      </iso-standard>
    INPUT
    pres_output = Nokogiri::XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true))
    issn_en = <<~OUTPUT
      <formattedref>Aluffi P., Anderson D., Hering M., Mustaţă M., &amp; Payne S. (eds.). Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday. London Mathematical Society Lecture Note Series (N.S.). 2022a, vol. 1 no. 7, pp. 89–112</formattedref>
    OUTPUT
    issn_ja = <<~OUTPUT
      <formattedref>Aluffi P., Anderson D., Hering M., Mustaţă M., &amp; Payne S. (eds.)　『Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday』　「London Mathematical Society Lecture Note Series (N.S.)」　2022b, vol. 1 no. 7, pp. 89–112</formattedref>
    OUTPUT
    expect(Canon.format_xml(pres_output
      .at("//*[@id = 'ISSN']/xmlns:formattedref").to_xml))
      .to be_equivalent_to Canon.format_xml(issn_en)
    expect(Canon.format_xml(pres_output
      .at("//*[@id = 'ISSN1']/xmlns:formattedref").to_xml))
      .to be_equivalent_to Canon.format_xml(issn_ja)

    issn_en = <<~OUTPUT
      <formattedref>Aluffi P., Anderson D., Hering M., Mustaţă M.,  Payne S. （編）. Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday. London Mathematical Society Lecture Note Series （N.S.）. 2022a, 巻1 いいえ7, 89〜112頁</formattedref>
    OUTPUT

    issn_ja = <<~OUTPUT
      <formattedref>Aluffi P.、 Anderson D.、 Hering M.、 Mustaţă M.、  Payne S. （編）　『Facets of Algebraic Geometry: A Collection in Honor of William Fulton's 80th Birthday』　「London Mathematical Society Lecture Note Series （N.S.）」　2022b、巻1 いいえ7、 89〜112頁</formattedref>
    OUTPUT

    pres_output = Nokogiri::XML(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input
      .sub("<language>en</language>", "<language>ja</language>"), true))
    expect(Canon.format_xml(pres_output
      .at("//*[@id = 'ISSN']/xmlns:formattedref").to_xml))
      .to be_equivalent_to Canon.format_xml(issn_en)
    expect(Canon.format_xml(pres_output
      .at("//*[@id = 'ISSN1']/xmlns:formattedref").to_xml))
      .to be_equivalent_to Canon.format_xml(issn_ja)
  end
end
