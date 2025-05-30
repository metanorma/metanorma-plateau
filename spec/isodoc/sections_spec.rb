require "spec_helper"

RSpec.describe IsoDoc::Plateau do
  it "processes Japanese" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
        <bibdata>
          <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
          <title language="en" format="text/plain" type="title-intro">Introduction</title>
          <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
          <title language="en" format="text/plain" type="title-part">Title Part</title>
          <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
          <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
          <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
          <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
          <docidentifier primary="true" type="PLATEAU">TRZ 1000-1:2000</docidentifier>
          <status>
            <stage abbreviation='IS' language=''>60</stage>
          </status>
          <language>ja</language>
          <ext>
            <doctype language=''>international-standard</doctype>
          </ext>
        </bibdata>
        <preface>
          <abstract id="abstract1" obligation="informative">
            <title>Abstract 1</title>
            <p id="A0">This is an abstract</p>
          </abstract>
          <abstract id="abstract2" obligation="informative">
            <title>Abstract 2</title>
            <p id="A1">This is another abstract</p>
          </abstract>
          <foreword id="foreword" obligation="informative">
            <title>Foreword</title>
            <p id="A">This is a preamble</p>
          </foreword>
          <introduction id="B" obligation="informative">
            <title>Introduction</title>
            <clause id="C" inline-header="false" obligation="informative">
              <title>Introduction Subsection</title>
            </clause>
            <p>This is patent boilerplate</p>
          </introduction>
          <clause id="U" type="revhistory">
            <title>Rev History</title>
          </clause>
        </preface>
        <sections>
          <clause id="D" obligation="normative" type="scope">
            <title>Scope</title>
            <p id="E">Text</p>
          </clause>
          <clause id="H" obligation="normative">
            <title>Terms, definitions, symbols and abbreviated terms</title>
            <terms id="I" obligation="normative">
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
          </clause>
          <definitions id="L">
            <dl>
              <dt>Symbol</dt>
              <dd>Definition</dd>
            </dl>
          </definitions>
          <clause id="M" inline-header="false" obligation="normative">
            <title>Clause 4</title>
            <clause id="N" inline-header="false" obligation="normative">
              <title>Introduction</title>
            </clause>
            <clause id="O" inline-header="false" obligation="normative">
              <title>Clause 4.2</title>
            </clause>
          </clause>
        </sections>
        <annex id="P" inline-header="false" obligation="normative">
          <title>Annex</title>
          <clause id="Q" inline-header="false" obligation="normative">
            <title>Annex A.1</title>
            <clause id="Q1" inline-header="false" obligation="normative">
              <title>Annex A.1a</title>
            </clause>
          </clause>
          <appendix id="Q2" inline-header="false" obligation="normative">
            <title>An Appendix</title>
          </appendix>
        </annex>
        <annex id="V" commentary="true" inline-header="false" obligation="informative">
          <title>Commentary</title>
        </annex>
        <bibliography>
          <references id="R" normative="true" obligation="informative">
            <title>Normative References</title>
          </references>
          <clause id="S" obligation="informative">
            <title>Bibliography</title>
            <references id="T" normative="false" obligation="informative">
              <title>Bibliography Subsection</title>
            </references>
          </clause>
        </bibliography>
      </iso-standard>
    INPUT

    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <bibdata>
             <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
             <title language="en" format="text/plain" type="title-intro">Introduction</title>
             <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
             <title language="en" format="text/plain" type="title-part">Title Part</title>
             <title language="ja" format="text/plain" type="main">Introduction Française — Titre Principal — Part du Titre</title>
             <title language="ja" format="text/plain" type="title-intro">Introduction Française</title>
             <title language="ja" format="text/plain" type="title-main">Titre Principal</title>
             <title language="ja" format="text/plain" type="title-part">Part du Titre</title>
             <docidentifier primary="true" type="PLATEAU">TRZ 1000-1:2000</docidentifier>
             <status>
                <stage abbreviation="IS" language="">60</stage>
                <stage abbreviation="IS" language="ja">International Standard</stage>
             </status>
             <language current="true">ja</language>
             <ext>
                <doctype language="">international-standard</doctype>
                <doctype language="ja">日本産業規格</doctype>
             </ext>
          </bibdata>
          <preface>
             <abstract id="abstract1" obligation="informative" displayorder="1">
                <title id="_">Abstract 1</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Abstract 1</semx>
                </fmt-title>
                <p id="A0">This is an abstract</p>
             </abstract>
             <abstract id="abstract2" obligation="informative" displayorder="2">
                <title id="_">Abstract 2</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Abstract 2</semx>
                </fmt-title>
                <p id="A1">This is another abstract</p>
             </abstract>
             <clause id="U" type="revhistory" displayorder="3">
                <title id="_">Rev History</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Rev History</semx>
                </fmt-title>
             </clause>
             <clause type="toc" id="_" displayorder="4">
                <fmt-title id="_" depth="1">目　次</fmt-title>
             </clause>
             <foreword id="foreword" obligation="informative" displayorder="5">
                <title id="_">Foreword</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Foreword</semx>
                </fmt-title>
                <p id="A">This is a preamble</p>
             </foreword>
          </preface>
          <sections>
             <introduction id="B" obligation="informative" unnumbered="true" displayorder="6">
                <title id="_">Introduction</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Introduction</semx>
                </fmt-title>
                <clause id="C" inline-header="false" obligation="informative">
                   <title id="_">Introduction Subsection</title>
                   <fmt-title id="_" depth="2">
                      <semx element="title" source="_">Introduction Subsection</semx>
                   </fmt-title>
                </clause>
                <p>This is patent boilerplate</p>
             </introduction>
             <clause id="D" obligation="normative" type="scope" displayorder="7">
                <title id="_">Scope</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="D">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Scope</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                   <semx element="autonum" source="D">1</semx>
                </fmt-xref-label>
                <p id="E">Text</p>
             </clause>
             <clause id="H" obligation="normative" displayorder="8">
                <title id="_">Terms, definitions, symbols and abbreviated terms</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="H">2</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Terms, definitions, symbols and abbreviated terms</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                   <semx element="autonum" source="H">2</semx>
                </fmt-xref-label>
                <terms id="I" obligation="normative">
                   <title id="_">Normal Terms</title>
                   <fmt-title id="_" depth="2">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="H">2</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="I">1</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">Normal Terms</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="H">2</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="I">1</semx>
                   </fmt-xref-label>
                   <term id="J">
                      <fmt-name id="_">
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="H">2</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="I">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="J">1</semx>
                         </span>
                      </fmt-name>
                      <fmt-xref-label>
                         <semx element="autonum" source="H">2</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="I">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="J">1</semx>
                      </fmt-xref-label>
               <preferred id="_">
                  <expression>
                     <name>Term2</name>
                  </expression>
               </preferred>
               <fmt-preferred>
                  <p>
                     <semx element="preferred" source="_">
                        <strong>Term2</strong>
                     </semx>
                  </p>
               </fmt-preferred>
                   </term>
                </terms>
                <definitions id="K">
                   <title id="_">記号</title>
                   <fmt-title id="_" depth="2">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="H">2</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="K">2</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">記号</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="H">2</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="K">2</semx>
                   </fmt-xref-label>
                   <dl>
                      <dt>Symbol</dt>
                      <dd>Definition</dd>
                   </dl>
                </definitions>
             </clause>
             <definitions id="L" displayorder="9">
                <title id="_">記号</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="L">3</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">記　号</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                   <semx element="autonum" source="L">3</semx>
                </fmt-xref-label>
                <dl>
                   <dt>Symbol</dt>
                   <dd>Definition</dd>
                </dl>
             </definitions>
             <clause id="M" inline-header="false" obligation="normative" displayorder="10">
                <title id="_">Clause 4</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="M">4</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Clause 4</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                   <semx element="autonum" source="M">4</semx>
                </fmt-xref-label>
                <clause id="N" inline-header="false" obligation="normative">
                   <title id="_">Introduction</title>
                   <fmt-title id="_" depth="2">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="M">4</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="N">1</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">Introduction</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="M">4</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="N">1</semx>
                   </fmt-xref-label>
                </clause>
                <clause id="O" inline-header="false" obligation="normative">
                   <title id="_">Clause 4.2</title>
                   <fmt-title id="_" depth="2">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="M">4</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="O">2</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">Clause 4.2</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="M">4</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="O">2</semx>
                   </fmt-xref-label>
                </clause>
             </clause>
             <references id="R" normative="true" obligation="informative" displayorder="11">
                <title id="_">Normative References</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="R">5</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Normative References</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                   <semx element="autonum" source="R">5</semx>
                </fmt-xref-label>
             </references>
          </sections>
          <annex id="P" inline-header="false" obligation="normative" autonum="A" displayorder="12">
             <title id="_">
                <strong>Annex</strong>
             </title>
             <fmt-title id="_">
                <span class="fmt-caption-label">
                   <span class="fmt-element-name">附属書</span>
                   <semx element="autonum" source="P">A</semx>
                </span>
                <br/>
                <span class="fmt-obligation">（規定）</span>
                <span class="fmt-caption-delim">
                   <br/>
                </span>
                <semx element="title" source="_">
                   <strong>Annex</strong>
                </semx>
             </fmt-title>
             <fmt-xref-label>
                <span class="fmt-element-name">附属書</span>
                <semx element="autonum" source="P">A</semx>
             </fmt-xref-label>
             <clause id="Q" inline-header="false" obligation="normative">
                <title id="_">Annex A.1</title>
                <fmt-title id="_" depth="2">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="Q">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Annex A.1</semx>
                </fmt-title>
                <fmt-xref-label>
                   <semx element="autonum" source="P">A</semx>
                   <span class="fmt-autonum-delim">.</span>
                   <semx element="autonum" source="Q">1</semx>
                </fmt-xref-label>
                <clause id="Q1" inline-header="false" obligation="normative">
                   <title id="_">Annex A.1a</title>
                   <fmt-title id="_" depth="3">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="P">A</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="Q">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="Q1">1</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">Annex A.1a</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="Q">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="Q1">1</semx>
                   </fmt-xref-label>
                </clause>
             </clause>
             <appendix id="Q2" inline-header="false" obligation="normative" autonum="1">
                <title id="_">An Appendix</title>
                <fmt-title id="_" depth="2">
                   <span class="fmt-caption-label">
                      <span class="fmt-element-name">Appendix</span>
                      <semx element="autonum" source="Q2">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">An Appendix</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Appendix</span>
                   <semx element="autonum" source="Q2">1</semx>
                </fmt-xref-label>
                <fmt-xref-label container="P">
                   <span class="fmt-xref-container">
                      <span class="fmt-element-name">附属書</span>
                      <semx element="autonum" source="P">A</semx>
                   </span>
                   <span class="fmt-conn">の</span>
                   <span class="fmt-element-name">Appendix</span>
                   <semx element="autonum" source="Q2">1</semx>
                </fmt-xref-label>
             </appendix>
          </annex>
          <bibliography>
             <clause id="S" obligation="informative" displayorder="13">
                <title id="_">Bibliography</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Bibliography</semx>
                </fmt-title>
                <references id="T" normative="false" obligation="informative">
                   <title id="_">Bibliography Subsection</title>
                   <fmt-title id="_" depth="2">
                      <semx element="title" source="_">Bibliography Subsection</semx>
                   </fmt-title>
                </references>
             </clause>
          </bibliography>
          <annex id="V" commentary="true" inline-header="false" obligation="informative" displayorder="14">
             <p class="CommentaryStandardNumber">TRZ 1000-1
       </p>
             <p class="CommentaryStandardName">Introduction Française — Titre Principal — </p>
             <p class="zzSTDTitle1">
                その :
                <br/>
                <strong>Part du Titre</strong>
             </p>
             <title id="_">Commentary</title>
             <fmt-title id="_">
                <semx element="title" source="_">Commentary</semx>
             </fmt-title>
          </annex>
       </iso-standard>
    OUTPUT

    html = <<~OUTPUT
       <html lang="ja">
          <head/>
          <body lang="ja">
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
                <div id="abstract1">
                   <h1 class="AbstractTitle">Abstract 1</h1>
                   <p id="A0">　This is an abstract</p>
                </div>
                <br/>
                <div id="abstract2">
                   <h1 class="AbstractTitle">Abstract 2</h1>
                   <p id="A1">　This is another abstract</p>
                </div>
                <br/>
                <div id="U" class="Section3">
                   <h1 class="IntroTitle">Rev History</h1>
                </div>
                <br/>
                <div id="_" class="TOC">
                   <h1 class="IntroTitle">目　次</h1>
                </div>
                <br/>
                <div id="foreword">
                   <h1 class="ForewordTitle">Foreword</h1>
                   <p id="A">　This is a preamble</p>
                </div>
                <br/>
                <div class="Section3" id="B">
                   <h1 class="IntroTitle">Introduction</h1>
                   <div id="C">
                      <h2>Introduction Subsection</h2>
                   </div>
                   <p>　This is patent boilerplate</p>
                </div>
                <div id="D">
                   <h1>1　Scope</h1>
                   <p id="E">　Text</p>
                </div>
                <div id="H">
                   <h1>2　Terms, definitions, symbols and abbreviated terms</h1>
                   <div id="I">
                      <h2>2.1　Normal Terms</h2>
                      <p class="TermNum" id="J">2.1.1</p>
                      <p class="Terms" style="text-align:left;">
                         <b>Term2</b>
                      </p>
                   </div>
                   <div id="K">
                      <h2>2.2　記号</h2>
                      <div class="figdl">
                         <dl>
                            <dt>
                               <p>Symbol</p>
                            </dt>
                            <dd>Definition</dd>
                         </dl>
                      </div>
                   </div>
                </div>
                <div id="L" class="Symbols">
                   <h1>3　記　号</h1>
                   <div class="figdl">
                      <dl>
                         <dt>
                            <p>Symbol</p>
                         </dt>
                         <dd>Definition</dd>
                      </dl>
                   </div>
                </div>
                <div id="M">
                   <h1>4　Clause 4</h1>
                   <div id="N">
                      <h2>4.1　Introduction</h2>
                   </div>
                   <div id="O">
                      <h2>4.2　Clause 4.2</h2>
                   </div>
                </div>
                <div>
                   <h1>5　Normative References</h1>
                </div>
                <br/>
                <div id="P" class="Section3">
                   <h1 class="Annex">
                      附属書A
                      <br/>
                      <span class="obligation">（規定）</span>
                      <br/>
                      <b>Annex</b>
                   </h1>
                   <div id="Q">
                      <h2>A.1　Annex A.1</h2>
                      <div id="Q1">
                         <h3>A.1.1　Annex A.1a</h3>
                      </div>
                   </div>
                   <div id="Q2">
                      <h2>Appendix 1　An Appendix</h2>
                   </div>
                </div>
                <br/>
                <div>
                   <h1 class="Section3">Bibliography</h1>
                   <div>
                      <h2 class="Section3">Bibliography Subsection</h2>
                   </div>
                </div>
                <br/>
                <div id="V" class="Section3">
                   <p class="CommentaryStandardNumber">　TRZ 1000-1
       </p>
                   <p class="CommentaryStandardName">　Introduction Française — Titre Principal — </p>
                   <p class="zzSTDTitle1">
                      　その :
                      <br/>
                      <b>Part du Titre</b>
                   </p>
                   <h1 class="Annex">Commentary</h1>
                </div>
             </div>
          </body>
       </html>
    OUTPUT
        pres_output = IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)
    expect(Xml::C14n.format(strip_guid(pres_output
      .sub(%r{<localized-strings>.*</localized-strings>}m, ""))))
      .to be_equivalent_to Xml::C14n.format(presxml)
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", pres_output, true))))
      .to be_equivalent_to Xml::C14n.format(html)
  end

  it "places revhistory, TOC without abstracts" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
        <bibdata>
          <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
          <title language="en" format="text/plain" type="title-intro">Introduction</title>
          <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
          <title language="en" format="text/plain" type="title-part">Title Part</title>
          <docidentifier primary="true" type="PLATEAU">TRZ 1000-1:2000</docidentifier>
          <status>
            <stage abbreviation='IS' language=''>60</stage>
          </status>
          <language>ja</language>
          <ext>
            <doctype language=''>international-standard</doctype>
          </ext>
        </bibdata>
        <preface><clause id="U" type="revhistory">
            <title>Rev History</title>
          </clause>
        </preface>
        <sections>
          <clause id="D" obligation="normative" type="scope">
            <title>Scope</title>
            <p id="E">Text</p>
          </clause>
         </sections>
       </iso-standard>
    INPUT
    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <bibdata>
             <title language="en" format="text/plain" type="main">Introduction — Main Title — Title — Title Part</title>
             <title language="en" format="text/plain" type="title-intro">Introduction</title>
             <title language="en" format="text/plain" type="title-main">Main Title — Title</title>
             <title language="en" format="text/plain" type="title-part">Title Part</title>
             <docidentifier primary="true" type="PLATEAU">TRZ 1000-1:2000</docidentifier>
             <status>
                <stage abbreviation="IS" language="">60</stage>
                <stage abbreviation="IS" language="ja">International Standard</stage>
             </status>
             <language current="true">ja</language>
             <ext>
                <doctype language="">international-standard</doctype>
                <doctype language="ja">日本産業規格</doctype>
             </ext>
          </bibdata>
          
          <preface>
             <clause id="U" type="revhistory" displayorder="1">
                <title id="_">Rev History</title>
                <fmt-title id="_" depth="1">
                   <semx element="title" source="_">Rev History</semx>
                </fmt-title>
             </clause>
             <clause type="toc" id="_" displayorder="2">
                <fmt-title id="_" depth="1">目　次</fmt-title>
             </clause>
          </preface>
          <sections>
             <clause id="D" obligation="normative" type="scope" displayorder="3">
                <title id="_">Scope</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="D">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Scope</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">箇条</span>
                   <semx element="autonum" source="D">1</semx>
                </fmt-xref-label>
                <p id="E">Text</p>
             </clause>
          </sections>
       </iso-standard>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)))
      .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to Xml::C14n.format(presxml)
  end

  it "labels deep-nested sections" do
    input = <<~INPUT
      <iso-standard xmlns="http://riboseinc.com/isoxml">
       <sections>
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
       <clause id="S6a" obligation="normative">
         <title>Scope</title>
       </clause>
       <clause id="S6b" obligation="normative">
         <title>Scope</title>
       </clause>
       <clause id="S6c" obligation="normative">
         <title>Scope</title>
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
       <clause id="A6a" obligation="normative">
         <title>Scope</title>
       </clause>
       <clause id="A6b" obligation="normative">
         <title>Scope</title>
       </clause>
       <clause id="A6c" obligation="normative">
         <title>Scope</title>
       </clause>
       </clause>
       </clause>
       </clause>
       </clause>
       </annex>
       </iso-standard>
    INPUT
    presxml = <<~OUTPUT
       <iso-standard xmlns="http://riboseinc.com/isoxml" type="presentation">
          <preface>
             <clause type="toc" id="_" displayorder="1">
                <fmt-title id="_" depth="1">Contents</fmt-title>
             </clause>
          </preface>
          <sections>
             <clause id="S1" obligation="normative" displayorder="2">
                <title id="_">Scope</title>
                <fmt-title id="_" depth="1">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="S1">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Scope</semx>
                </fmt-title>
                <fmt-xref-label>
                   <span class="fmt-element-name">Clause</span>
                   <semx element="autonum" source="S1">1</semx>
                </fmt-xref-label>
                <clause id="S2" obligation="normative">
                   <title id="_">Scope</title>
                   <fmt-title id="_" depth="2">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="S1">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="S2">1</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">Scope</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="S1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="S2">1</semx>
                   </fmt-xref-label>
                   <clause id="S3" obligation="normative">
                      <title id="_">Scope</title>
                      <fmt-title id="_" depth="3">
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="S1">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="S2">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="S3">1</semx>
                         </span>
                         <span class="fmt-caption-delim">
                            <tab/>
                         </span>
                         <semx element="title" source="_">Scope</semx>
                      </fmt-title>
                      <fmt-xref-label>
                         <semx element="autonum" source="S1">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="S2">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="S3">1</semx>
                      </fmt-xref-label>
                      <clause id="S4" obligation="normative">
                         <title id="_">Scope</title>
                         <fmt-title id="_" depth="4">
                            <span class="fmt-caption-label">
                               <semx element="autonum" source="S1">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S2">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S3">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S4">1</semx>
                            </span>
                            <span class="fmt-caption-delim">
                               <tab/>
                            </span>
                            <semx element="title" source="_">Scope</semx>
                         </fmt-title>
                         <fmt-xref-label>
                            <semx element="autonum" source="S1">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="S2">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="S3">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="S4">1</semx>
                         </fmt-xref-label>
                         <clause id="S5" obligation="normative">
                            <title id="_">Scope</title>
                            <fmt-title id="_" depth="5">
                               <span class="fmt-caption-label">
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
                               <span class="fmt-caption-delim">
                                  <tab/>
                               </span>
                               <semx element="title" source="_">Scope</semx>
                            </fmt-title>
                            <fmt-xref-label>
                               <semx element="autonum" source="S1">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S2">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S3">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S4">1</semx>
                               <span class="fmt-autonum-delim">.</span>
                               <semx element="autonum" source="S5">1</semx>
                            </fmt-xref-label>
                            <clause id="S6a" obligation="normative">
                               <title id="_">Scope</title>
                               <fmt-title id="_" depth="6">
                                  <span class="fmt-caption-label">
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
                                     <semx element="autonum" source="S6a">1</semx>
                                  </span>
                                  <span class="fmt-caption-delim">
                                     <tab/>
                                  </span>
                                  <semx element="title" source="_">Scope</semx>
                               </fmt-title>
                               <fmt-xref-label>
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
                                  <semx element="autonum" source="S6a">1</semx>
                               </fmt-xref-label>
                            </clause>
                            <clause id="S6b" obligation="normative">
                               <title id="_">Scope</title>
                               <fmt-title id="_" depth="6">
                                  <span class="fmt-caption-label">
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
                                     <semx element="autonum" source="S6b">2</semx>
                                  </span>
                                  <span class="fmt-caption-delim">
                                     <tab/>
                                  </span>
                                  <semx element="title" source="_">Scope</semx>
                               </fmt-title>
                               <fmt-xref-label>
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
                                  <semx element="autonum" source="S6b">2</semx>
                               </fmt-xref-label>
                            </clause>
                            <clause id="S6c" obligation="normative">
                               <title id="_">Scope</title>
                               <fmt-title id="_" depth="6">
                                  <span class="fmt-caption-label">
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
                                     <semx element="autonum" source="S6c">3</semx>
                                  </span>
                                  <span class="fmt-caption-delim">
                                     <tab/>
                                  </span>
                                  <semx element="title" source="_">Scope</semx>
                               </fmt-title>
                               <fmt-xref-label>
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
                                  <semx element="autonum" source="S6c">3</semx>
                               </fmt-xref-label>
                            </clause>
                         </clause>
                      </clause>
                   </clause>
                </clause>
             </clause>
          </sections>
          <annex id="P" inline-header="false" obligation="normative" autonum="A" displayorder="3">
             <title id="_">
                <strong>Annex</strong>
             </title>
             <fmt-title id="_">
                <span class="fmt-caption-label">
                   <span class="fmt-element-name">Annex</span>
                   <semx element="autonum" source="P">A</semx>
                </span>
                <br/>
                <span class="fmt-obligation">(normative)</span>
                <span class="fmt-caption-delim">
                   <br/>
                </span>
                <semx element="title" source="_">
                   <strong>Annex</strong>
                </semx>
             </fmt-title>
             <fmt-xref-label>
                <span class="fmt-element-name">Annex</span>
                <semx element="autonum" source="P">A</semx>
             </fmt-xref-label>
             <clause id="A1" obligation="normative">
                <title id="_">Scope</title>
                <fmt-title id="_" depth="2">
                   <span class="fmt-caption-label">
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                   </span>
                   <span class="fmt-caption-delim">
                      <tab/>
                   </span>
                   <semx element="title" source="_">Scope</semx>
                </fmt-title>
                <fmt-xref-label>
                   <semx element="autonum" source="P">A</semx>
                   <span class="fmt-autonum-delim">.</span>
                   <semx element="autonum" source="A1">1</semx>
                </fmt-xref-label>
                <clause id="A2" obligation="normative">
                   <title id="_">Scope</title>
                   <fmt-title id="_" depth="3">
                      <span class="fmt-caption-label">
                         <semx element="autonum" source="P">A</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A1">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A2">1</semx>
                      </span>
                      <span class="fmt-caption-delim">
                         <tab/>
                      </span>
                      <semx element="title" source="_">Scope</semx>
                   </fmt-title>
                   <fmt-xref-label>
                      <semx element="autonum" source="P">A</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A1">1</semx>
                      <span class="fmt-autonum-delim">.</span>
                      <semx element="autonum" source="A2">1</semx>
                   </fmt-xref-label>
                   <clause id="A3" obligation="normative">
                      <title id="_">Scope</title>
                      <fmt-title id="_" depth="4">
                         <span class="fmt-caption-label">
                            <semx element="autonum" source="P">A</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A1">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A2">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A3">1</semx>
                         </span>
                         <span class="fmt-caption-delim">
                            <tab/>
                         </span>
                         <semx element="title" source="_">Scope</semx>
                      </fmt-title>
                      <fmt-xref-label>
                         <semx element="autonum" source="P">A</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A1">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A2">1</semx>
                         <span class="fmt-autonum-delim">.</span>
                         <semx element="autonum" source="A3">1</semx>
                      </fmt-xref-label>
                      <clause id="A4" obligation="normative">
                         <title id="_">Scope</title>
                         <fmt-title id="_" depth="5">
                            <span class="fmt-caption-label">
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
                            <span class="fmt-caption-delim">
                               <tab/>
                            </span>
                            <semx element="title" source="_">Scope</semx>
                         </fmt-title>
                         <fmt-xref-label>
                            <semx element="autonum" source="P">A</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A1">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A2">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A3">1</semx>
                            <span class="fmt-autonum-delim">.</span>
                            <semx element="autonum" source="A4">1</semx>
                         </fmt-xref-label>
                         <clause id="A6a" obligation="normative">
                            <title id="_">Scope</title>
                            <fmt-title id="_" depth="6">
                               <span class="fmt-caption-label">
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
                                  <semx element="autonum" source="A6a">1</semx>
                               </span>
                               <span class="fmt-caption-delim">
                                  <tab/>
                               </span>
                               <semx element="title" source="_">Scope</semx>
                            </fmt-title>
                            <fmt-xref-label>
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
                               <semx element="autonum" source="A6a">1</semx>
                            </fmt-xref-label>
                         </clause>
                         <clause id="A6b" obligation="normative">
                            <title id="_">Scope</title>
                            <fmt-title id="_" depth="6">
                               <span class="fmt-caption-label">
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
                                  <semx element="autonum" source="A6b">2</semx>
                               </span>
                               <span class="fmt-caption-delim">
                                  <tab/>
                               </span>
                               <semx element="title" source="_">Scope</semx>
                            </fmt-title>
                            <fmt-xref-label>
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
                               <semx element="autonum" source="A6b">2</semx>
                            </fmt-xref-label>
                         </clause>
                         <clause id="A6c" obligation="normative">
                            <title id="_">Scope</title>
                            <fmt-title id="_" depth="6">
                               <span class="fmt-caption-label">
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
                                  <semx element="autonum" source="A6c">3</semx>
                               </span>
                               <span class="fmt-caption-delim">
                                  <tab/>
                               </span>
                               <semx element="title" source="_">Scope</semx>
                            </fmt-title>
                            <fmt-xref-label>
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
                               <semx element="autonum" source="A6c">3</semx>
                            </fmt-xref-label>
                         </clause>
                      </clause>
                   </clause>
                </clause>
             </clause>
          </annex>
       </iso-standard>
    OUTPUT
    expect(Xml::C14n.format(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
       .new(presxml_options)
       .convert("test", input, true)))
       .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to Xml::C14n.format(presxml)
  end
end
