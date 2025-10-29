require "spec_helper"

RSpec.describe IsoDoc::Plateau do
  it "processes IsoXML terms" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
        <sections>
          <terms id="_terms_and_definitions" obligation="normative"><title>Terms and Definitions</title>
            <term id="paddy1">
              <preferred><expression><name>paddy</name></expression></preferred>
              <domain>rice</domain>
              <definition><verbal-definition><p id="_eb29b35e-123e-4d1c-b50b-2714d41e747f">rice retaining its husk after threshing</p></verbal-definition></definition>
              <termexample id="_bd57bbf1-f948-4bae-b0ce-73c00431f892">
                <p id="_65c9a509-9a89-4b54-a890-274126aeb55c">Foreign seeds, husks, bran, sand, dust.</p>
                <ul>
                <li>A</li>
                </ul>
              </termexample>
              <termexample id="_bd57bbf1-f948-4bae-b0ce-73c00431f894">
                <ul>
                <li>A</li>
                </ul>
              </termexample>

              <source status="modified">
                <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011"><locality type="clause"><referenceFrom>3.1</referenceFrom></locality></origin>
                  <modification>
                  <p id="_e73a417d-ad39-417d-a4c8-20e4e2529489">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</p>
                </modification>
              </source>
            </term>

            <term id="paddy">
              <preferred><expression><name>paddy</name></expression></preferred>
              <admitted><expression><name>paddy rice</name></expression></admitted>
              <admitted><expression><name>rough rice</name></expression></admitted>
              <deprecates><expression><name>cargo rice</name></expression></deprecates>
              <definition><verbal-definition><p id="_eb29b35e-123e-4d1c-b50b-2714d41e747f">rice retaining its husk after threshing</p></verbal-definition></definition>
              <termnote id="_671a1994-4783-40d0-bc81-987d06ffb74e">
                <p id="_19830f33-e46c-42cc-94ca-a5ef101132d5">The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.</p>
              </termnote>
              <termexample id="_bd57bbf1-f948-4bae-b0ce-73c00431f893">
                <ul>
                <li>A</li>
                </ul>
              </termexample>
              <termnote id="_671a1994-4783-40d0-bc81-987d06ffb74f">
              <ul><li>A</li></ul>
                <p id="_19830f33-e46c-42cc-94ca-a5ef101132d5">The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.</p>
              </termnote>
              <source status="identical">
                <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011"><locality type="clause"><referenceFrom>3.1</referenceFrom></locality></origin>
              </source>
              <source status="modified">
                <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011"><locality type="clause"><referenceFrom>3.1</referenceFrom></locality></origin>
                  <modification>
                  <p id="_e73a417d-ad39-417d-a4c8-20e4e2529489">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</p>
                </modification>
              </source>
            </term>
            <term id="A">
              <preferred><expression><name>term1</name></expression></preferred>
              <definition><verbal-definition>term1 definition</verbal-definition></definition>
              <term id="B">
              <preferred><expression><name>term2</name></expression></preferred>
              <definition><verbal-definition>term2 definition</verbal-definition></definition>
              </term>
            </term>
          </terms>
        </sections>
      </iso-standard>
    INPUT
    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <preface>
             <clause type="toc" id="_" displayorder="1">
                <fmt-title depth="1" id="_">Contents</fmt-title>
             </clause>
          </preface>
          <sections>
             <terms id="_" obligation="normative" displayorder="2">
                <title id="_">Terms and Definitions</title>
                <fmt-title depth="1" id="_">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="_">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Terms and Definitions</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="_">1</semx>
                </fmt-xref-label>
                <term id="paddy1">
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="paddy1">1</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <semx element="autonum" source="_">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="paddy1">1</semx>
                   </fmt-xref-label>
                   <preferred id="_">
                      <expression>
                         <name>paddy</name>
                      </expression>
                   </preferred>
                   <fmt-preferred>
                      <p>
                         <semx element="preferred" source="_">
                            <strong>paddy</strong>
                         </semx>
                      </p>
                   </fmt-preferred>
                   <domain id="_">rice</domain>
                   <definition id="_">
                      <verbal-definition>
                         <p original-id="_">rice retaining its husk after threshing</p>
                      </verbal-definition>
                   </definition>
                   <fmt-definition id="_">
                      <semx element="definition" source="_">
                         <p id="_">
                            &lt;
                            <semx element="domain" source="_">rice</semx>
                            &gt; rice retaining its husk after threshing
                         </p>
                      </semx>
                   </fmt-definition>
                   <termexample id="_" autonum="1">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">EXAMPLE</span>
                            <semx element="autonum" source="_">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Example</span>
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy1">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy1">1</semx>
                         </span>
                         <span class="fmt-comma">,</span>
                         <span class="fmt-element-name">Example</span>
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <p id="_">Foreign seeds, husks, bran, sand, dust.</p>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                   </termexample>
                   <termexample id="_" autonum="2">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">EXAMPLE</span>
                            <semx element="autonum" source="_">2</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Example</span>
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy1">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy1">1</semx>
                         </span>
                         <span class="fmt-comma">,</span>
                         <span class="fmt-element-name">Example</span>
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                   </termexample>
                   <source status="modified" id="_">
                      <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                         <locality type="clause">
                            <referenceFrom>3.1</referenceFrom>
                         </locality>
                      </origin>
                      <modification id="_">
                         <p id="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</p>
                      </modification>
                   </source>
                   <fmt-termsource status="modified">
                      (SOURCE:
                      <semx element="source" source="_">
                         <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011" id="_">
                            <locality type="clause">
                               <referenceFrom>3.1</referenceFrom>
                            </locality>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                               <locality type="clause">
                                  <referenceFrom>3.1</referenceFrom>
                               </locality>
                               ISO 7301:2011,
                               <span class="citesec">3.1</span>
                            </fmt-origin>
                         </semx>
                         , modified,
                         <semx element="modification" source="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</semx>
                      </semx>
                      )
                   </fmt-termsource>
                </term>
                <term id="paddy">
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="paddy">2</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <semx element="autonum" source="_">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="paddy">2</semx>
                   </fmt-xref-label>
                   <preferred id="_">
                      <expression>
                         <name>paddy</name>
                      </expression>
                   </preferred>
                   <fmt-preferred>
                      <p>
                         <semx element="preferred" source="_">
                            <strong>paddy</strong>
                         </semx>
                      </p>
                   </fmt-preferred>
                   <admitted id="_">
                      <expression>
                         <name>paddy rice</name>
                      </expression>
                   </admitted>
                   <admitted id="_">
                      <expression>
                         <name>rough rice</name>
                      </expression>
                   </admitted>
                   <fmt-admitted>
                      <p>
                         ADMITTED:
                         <semx element="admitted" source="_">paddy rice</semx>
                      </p>
                      <p>
                         ADMITTED:
                         <semx element="admitted" source="_">rough rice</semx>
                      </p>
                   </fmt-admitted>
                   <deprecates id="_">
                      <expression>
                         <name>cargo rice</name>
                      </expression>
                   </deprecates>
                   <fmt-deprecates>
                      <p>
                         DEPRECATED:
                         <semx element="deprecates" source="_">cargo rice</semx>
                      </p>
                   </fmt-deprecates>
                   <definition id="_">
                      <verbal-definition>
                         <p original-id="_">rice retaining its husk after threshing</p>
                      </verbal-definition>
                   </definition>
                   <fmt-definition id="_">
                      <semx element="definition" source="_">
                         <p id="_">rice retaining its husk after threshing</p>
                      </semx>
                   </fmt-definition>
                   <termexample id="_" autonum="">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">EXAMPLE</span>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Example</span>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy">2</semx>
                         </span>
                         <span class="fmt-comma">,</span>
                         <span class="fmt-element-name">Example</span>
                      </fmt-xref-label>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                   </termexample>
                   <termnote id="_" autonum="1">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            Note
                            <semx element="autonum" source="_">1</semx>
                            to entry
                         </span>
                         <span class="fmt-label-delim">: </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Note</span>
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy">2</semx>
                         </span>
                         <span class="fmt-comma">,</span>
                         <span class="fmt-element-name">Note</span>
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <p id="_">The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.</p>
                   </termnote>
                   <termnote id="_" autonum="2">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            Note
                            <semx element="autonum" source="_">2</semx>
                            to entry
                         </span>
                         <span class="fmt-label-delim">: </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">Note</span>
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy">2</semx>
                         </span>
                         <span class="fmt-comma">,</span>
                         <span class="fmt-element-name">Note</span>
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                      <p id="_">The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.</p>
                   </termnote>
                   <source status="identical" id="_">
                      <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                         <locality type="clause">
                            <referenceFrom>3.1</referenceFrom>
                         </locality>
                      </origin>
                   </source>
                   <source status="modified" id="_">
                      <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                         <locality type="clause">
                            <referenceFrom>3.1</referenceFrom>
                         </locality>
                      </origin>
                      <modification id="_">
                         <p original-id="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</p>
                      </modification>
                   </source>
                   <fmt-termsource status="identical">
                      (SOURCE:
                      <semx element="source" source="_">
                         <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011" id="_">
                            <locality type="clause">
                               <referenceFrom>3.1</referenceFrom>
                            </locality>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                               <locality type="clause">
                                  <referenceFrom>3.1</referenceFrom>
                               </locality>
                               ISO 7301:2011,
                               <span class="citesec">3.1</span>
                            </fmt-origin>
                         </semx>
                      </semx>
                      /
                      <semx element="source" source="_">
                         <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011" id="_">
                            <locality type="clause">
                               <referenceFrom>3.1</referenceFrom>
                            </locality>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                               <locality type="clause">
                                  <referenceFrom>3.1</referenceFrom>
                               </locality>
                               ISO 7301:2011,
                               <span class="citesec">3.1</span>
                            </fmt-origin>
                         </semx>
                         , modified,
                         <semx element="modification" source="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</semx>
                      </semx>
                      )
                   </fmt-termsource>
                </term>
                <term id="A">
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A">3</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <semx element="autonum" source="_">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A">3</semx>
                   </fmt-xref-label>
                   <preferred id="_">
                      <expression>
                         <name>term1</name>
                      </expression>
                   </preferred>
                   <fmt-preferred>
                      <p>
                         <semx element="preferred" source="_">
                            <strong>term1</strong>
                         </semx>
                      </p>
                   </fmt-preferred>
                   <definition id="_">
                      <verbal-definition>term1 definition</verbal-definition>
                   </definition>
                   <fmt-definition id="_">
                      <semx element="definition" source="_">term1 definition</semx>
                   </fmt-definition>
                   <term id="B">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A">3</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="B">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A">3</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="B">1</semx>
                      </fmt-xref-label>
                      <preferred id="_">
                         <expression>
                            <name>term2</name>
                         </expression>
                      </preferred>
                      <fmt-preferred>
                         <p>
                            <semx element="preferred" source="_">
                               <strong>term2</strong>
                            </semx>
                         </p>
                      </fmt-preferred>
                      <definition id="_">
                         <verbal-definition>term2 definition</verbal-definition>
                      </definition>
                      <fmt-definition id="_">
                         <semx element="definition" source="_">term2 definition</semx>
                      </fmt-definition>
                   </term>
                </term>
             </terms>
          </sections>
       </iso-standard>
    OUTPUT

    pres_output = IsoDoc::Plateau::PresentationXMLConvert.new(presxml_options)
      .convert("test", input, true)
    expect(Canon.format_xml(strip_guid(pres_output)))
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
          </preface>
          <sections>
             <terms id="_" obligation="normative" displayorder="2">
                <title id="_">Terms and Definitions</title>
                <fmt-title depth="1" id="_">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="_">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Terms and Definitions</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                    
                   <semx element="autonum" source="_">1</semx>
                </fmt-xref-label>
                <term id="paddy1">
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="paddy1">1</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <semx element="autonum" source="_">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="paddy1">1</semx>
                   </fmt-xref-label>
                   <preferred id="_">
                      <expression>
                         <name>paddy</name>
                      </expression>
                   </preferred>
                   <fmt-preferred>
                      <p>
                         <semx element="preferred" source="_">
                            <strong>paddy</strong>
                         </semx>
                      </p>
                   </fmt-preferred>
                   <domain id="_">rice</domain>
                   <definition id="_">
                      <verbal-definition>
                         <p original-id="_">rice retaining its husk after threshing</p>
                      </verbal-definition>
                   </definition>
                   <fmt-definition id="_">
                      <semx element="definition" source="_">
                         <p id="_">
                            &lt;
                            <semx element="domain" source="_">rice</semx>
                            &gt; rice retaining its husk after threshing
                         </p>
                      </semx>
                   </fmt-definition>
                   <termexample id="_" autonum="1">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">例</span>
                             
                            <semx element="autonum" source="_">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">例</span>
                          
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy1">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy1">1</semx>
                         </span>
                         <span class="fmt-conn">の</span>
                         <span class="fmt-element-name">例</span>
                          
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <p id="_">Foreign seeds, husks, bran, sand, dust.</p>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                   </termexample>
                   <termexample id="_" autonum="2">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">例</span>
                             
                            <semx element="autonum" source="_">2</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">例</span>
                          
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy1">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy1">1</semx>
                         </span>
                         <span class="fmt-conn">の</span>
                         <span class="fmt-element-name">例</span>
                          
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                   </termexample>
                   <source status="modified" id="_">
                      <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                         <locality type="clause">
                            <referenceFrom>3.1</referenceFrom>
                         </locality>
                      </origin>
                      <modification id="_">
                         <p id="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</p>
                      </modification>
                   </source>
                   <fmt-termsource status="modified">
                      （出典： 
                      <semx element="source" source="_">
                         <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011" id="_">
                            <locality type="clause">
                               <referenceFrom>3.1</referenceFrom>
                            </locality>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                               <locality type="clause">
                                  <referenceFrom>3.1</referenceFrom>
                               </locality>
                               ISO 7301:2011、
                               <span class="citesec">第3.1</span>
                            </fmt-origin>
                         </semx>
                         、を一部変更し、
                         <semx element="modification" source="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</semx>
                      </semx>
                      ）
                   </fmt-termsource>
                </term>
                <term id="paddy">
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="paddy">2</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <semx element="autonum" source="_">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="paddy">2</semx>
                   </fmt-xref-label>
                   <preferred id="_">
                      <expression>
                         <name>paddy</name>
                      </expression>
                   </preferred>
                   <fmt-preferred>
                      <p>
                         <semx element="preferred" source="_">
                            <strong>paddy</strong>
                         </semx>
                      </p>
                   </fmt-preferred>
                   <admitted id="_">
                      <expression>
                         <name>paddy rice</name>
                      </expression>
                   </admitted>
                   <admitted id="_">
                      <expression>
                         <name>rough rice</name>
                      </expression>
                   </admitted>
                   <fmt-admitted>
                      <p>
                         代替用語：
                         <semx element="admitted" source="_">paddy rice</semx>
                      </p>
                      <p>
                         代替用語：
                         <semx element="admitted" source="_">rough rice</semx>
                      </p>
                   </fmt-admitted>
                   <deprecates id="_">
                      <expression>
                         <name>cargo rice</name>
                      </expression>
                   </deprecates>
                   <fmt-deprecates>
                      <p>
                         推奨しない用語：
                         <semx element="deprecates" source="_">cargo rice</semx>
                      </p>
                   </fmt-deprecates>
                   <definition id="_">
                      <verbal-definition>
                         <p original-id="_">rice retaining its husk after threshing</p>
                      </verbal-definition>
                   </definition>
                   <fmt-definition id="_">
                      <semx element="definition" source="_">
                         <p id="_">rice retaining its husk after threshing</p>
                      </semx>
                   </fmt-definition>
                   <termexample id="_" autonum="">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <span class="fmt-element-name">例</span>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">例</span>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy">2</semx>
                         </span>
                         <span class="fmt-conn">の</span>
                         <span class="fmt-element-name">例</span>
                      </fmt-xref-label>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                   </termexample>
                   <termnote id="_" autonum="1">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            注釈
                            <semx element="autonum" source="_">1</semx>
                         </span>
                         <span class="fmt-label-delim">: </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">注記</span>
                          
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy">2</semx>
                         </span>
                         <span class="fmt-conn">の</span>
                         <span class="fmt-element-name">注記</span>
                          
                         <semx element="autonum" source="_">1</semx>
                      </fmt-xref-label>
                      <p id="_">The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.</p>
                   </termnote>
                   <termnote id="_" autonum="2">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            注釈
                            <semx element="autonum" source="_">2</semx>
                         </span>
                         <span class="fmt-label-delim">: </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <span class="fmt-element-name">注記</span>
                          
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <fmt-xref-label container="paddy">
                         <span class="fmt-xref-container">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="paddy">2</semx>
                         </span>
                         <span class="fmt-conn">の</span>
                         <span class="fmt-element-name">注記</span>
                          
                         <semx element="autonum" source="_">2</semx>
                      </fmt-xref-label>
                      <ul>
                         <li id="_">
                            <fmt-name id="_">
                               <semx element="autonum" source="_">－</semx>
                            </fmt-name>
                            A
                         </li>
                      </ul>
                      <p id="_">The starch of waxy rice consists almost entirely of amylopectin. The kernels have a tendency to stick together after cooking.</p>
                   </termnote>
                   <source status="identical" id="_">
                      <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                         <locality type="clause">
                            <referenceFrom>3.1</referenceFrom>
                         </locality>
                      </origin>
                   </source>
                   <source status="modified" id="_">
                      <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                         <locality type="clause">
                            <referenceFrom>3.1</referenceFrom>
                         </locality>
                      </origin>
                      <modification id="_">
                         <p original-id="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</p>
                      </modification>
                   </source>
                   <fmt-termsource status="identical">
                      （出典： 
                      <semx element="source" source="_">
                         <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011" id="_">
                            <locality type="clause">
                               <referenceFrom>3.1</referenceFrom>
                            </locality>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                               <locality type="clause">
                                  <referenceFrom>3.1</referenceFrom>
                               </locality>
                               ISO 7301:2011、
                               <span class="citesec">第3.1</span>
                            </fmt-origin>
                         </semx>
                      </semx>
                      ／
                      <semx element="source" source="_">
                         <origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011" id="_">
                            <locality type="clause">
                               <referenceFrom>3.1</referenceFrom>
                            </locality>
                         </origin>
                         <semx element="origin" source="_">
                            <fmt-origin bibitemid="ISO7301" type="inline" citeas="ISO 7301:2011">
                               <locality type="clause">
                                  <referenceFrom>3.1</referenceFrom>
                               </locality>
                               ISO 7301:2011、
                               <span class="citesec">第3.1</span>
                            </fmt-origin>
                         </semx>
                         、を一部変更し、
                         <semx element="modification" source="_">The term "cargo rice" is shown as deprecated, and Note 1 to entry is not included here</semx>
                      </semx>
                      ）
                   </fmt-termsource>
                </term>
                <term id="A">
                   <fmt-name id="_">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A">3</semx>
                      </span>
                   </fmt-name>
                   <fmt-xref-label>
                      <semx element="autonum" source="_">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A">3</semx>
                   </fmt-xref-label>
                   <preferred id="_">
                      <expression>
                         <name>term1</name>
                      </expression>
                   </preferred>
                   <fmt-preferred>
                      <p>
                         <semx element="preferred" source="_">
                            <strong>term1</strong>
                         </semx>
                      </p>
                   </fmt-preferred>
                   <definition id="_">
                      <verbal-definition>term1 definition</verbal-definition>
                   </definition>
                   <fmt-definition id="_">
                      <semx element="definition" source="_">term1 definition</semx>
                   </fmt-definition>
                   <term id="B">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="_">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A">3</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="B">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <semx element="autonum" source="_">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A">3</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="B">1</semx>
                      </fmt-xref-label>
                      <preferred id="_">
                         <expression>
                            <name>term2</name>
                         </expression>
                      </preferred>
                      <fmt-preferred>
                         <p>
                            <semx element="preferred" source="_">
                               <strong>term2</strong>
                            </semx>
                         </p>
                      </fmt-preferred>
                      <definition id="_">
                         <verbal-definition>term2 definition</verbal-definition>
                      </definition>
                      <fmt-definition id="_">
                         <semx element="definition" source="_">term2 definition</semx>
                      </fmt-definition>
                   </term>
                </term>
             </terms>
          </sections>
       </iso-standard>
    OUTPUT
    input.sub!("<sections>", "<bibdata><language>ja</language></bibdata><sections>")
    xml = Nokogiri::XML(IsoDoc::Plateau::PresentationXMLConvert.new(presxml_options)
      .convert("test", input, true))
    xml.at("//xmlns:localized-strings")&.remove
    expect(Canon.format_xml(strip_guid(xml.to_xml)))
      .to be_equivalent_to Canon.format_xml(presxml)
  end
end
