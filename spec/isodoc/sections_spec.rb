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
          <status>
            <stage abbreviation='IS' language=''>60</stage>
          </status>
          <language>ja</language>
          <ext>
            <doctype language=''>international-standard</doctype>
          </ext>
        </bibdata>
        <preface>
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
          <foreword id="foreword" obligation="informative" displayorder="1">
            <title>Foreword</title>
            <p id="A">This is a preamble</p>
          </foreword>
          <clause type="toc" id="_" displayorder="2">
            <title depth="1">目　次</title>
          </clause>
        </preface>
                   <sections>
             <introduction id="B" obligation="informative" unnumbered="true" displayorder="3">
               <title>Introduction</title>
               <clause id="C" inline-header="false" obligation="informative">
                 <title depth="2">
                   0.1
                   <tab/>
                   Introduction Subsection
                 </title>
               </clause>
               <p>This is patent boilerplate</p>
             </introduction>
             <clause id="D" obligation="normative" type="scope" displayorder="4">
               <title depth="1">
                 1
                 <tab/>
                 Scope
               </title>
               <p id="E">Text</p>
             </clause>
             <clause id="H" obligation="normative" displayorder="5">
               <title depth="1">
                 2
                 <tab/>
                 Terms, definitions, symbols and abbreviated terms
               </title>
               <terms id="I" obligation="normative">
                 <title depth="2">
                   2.1
                   <tab/>
                   Normal Terms
                 </title>
                 <term id="J">
                   <name>2.1.1</name>
                   <preferred>
                     <strong>Term2</strong>
                   </preferred>
                 </term>
               </terms>
               <definitions id="K" inline-header="true">
                 <title>2.2</title>
                 <dl>
                   <dt>Symbol</dt>
                   <dd>Definition</dd>
                 </dl>
               </definitions>
             </clause>
             <definitions id="L" displayorder="6">
               <title>3</title>
               <dl>
                 <dt>Symbol</dt>
                 <dd>Definition</dd>
               </dl>
             </definitions>
             <clause id="M" inline-header="false" obligation="normative" displayorder="7">
               <title depth="1">
                 4
                 <tab/>
                 Clause 4
               </title>
               <clause id="N" inline-header="false" obligation="normative">
                 <title depth="2">
                   4.1
                   <tab/>
                   Introduction
                 </title>
               </clause>
               <clause id="O" inline-header="false" obligation="normative">
                 <title depth="2">
                   4.2
                   <tab/>
                   Clause 4.2
                 </title>
               </clause>
             </clause>
             <references id="R" normative="true" obligation="informative" displayorder="8">
               <title depth="1">
                 5
                 <tab/>
                 Normative References
               </title>
             </references>
           </sections>
           <annex id="P" inline-header="false" obligation="normative" displayorder="9">
             <title>
               附属書 A
               <br/>
               (規定)
               <br/>
               <strong>Annex</strong>
             </title>
             <clause id="Q" inline-header="false" obligation="normative">
               <title depth="2">
                 A.1
                 <tab/>
                 Annex A.1
               </title>
               <clause id="Q1" inline-header="false" obligation="normative">
                 <title depth="3">
                   A.1.1
                   <tab/>
                   Annex A.1a
                 </title>
               </clause>
             </clause>
             <appendix id="Q2" inline-header="false" obligation="normative">
               <title depth="2">
                 Appendix 1
                 <tab/>
                 An Appendix
               </title>
             </appendix>
           </annex>
           <bibliography>
             <clause id="S" obligation="informative" displayorder="10">
               <title depth="1">Bibliography</title>
               <references id="T" normative="false" obligation="informative">
                 <title depth="2">Bibliography Subsection</title>
               </references>
             </clause>
           </bibliography>
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
             <div id="foreword">
               <h1 class="ForewordTitle">Foreword</h1>
               <p id="A">This is a preamble</p>
             </div>
             <br/>
             <div id="_" class="TOC">
               <h1 class="IntroTitle">目　次</h1>
             </div>
             <br/>
             <div class="Section3" id="B">
               <h1 class="IntroTitle">Introduction</h1>
               <div id="C">
                 <h2>
                 0.1
                  
                 Introduction Subsection
               </h2>
               </div>
               <p>This is patent boilerplate</p>
             </div>
             <div id="D">
               <h1>
               1
                
               Scope
             </h1>
               <p id="E">Text</p>
             </div>
             <div id="H">
               <h1>
               2
                
               Terms, definitions, symbols and abbreviated terms
             </h1>
               <div id="I">
                 <h2>
                 2.1
                  
                 Normal Terms
               </h2>
                 <p class="TermNum" id="J">2.1.1</p>
                 <p class="Terms" style="text-align:left;">
                   <b>Term2</b>
                 </p>
               </div>
               <div id="K">
                 <span class="zzMoveToFollowing inline-header">
                   <b>2.2  </b>
                 </span>
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
                 <h1>3</h1>
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
                 <h1>
                4
                 
                Clause 4
              </h1>
                 <div id="N">
                   <h2>
                  4.1
                   
                  Introduction
                </h2>
                 </div>
                 <div id="O">
                   <h2>
                  4.2
                   
                  Clause 4.2
                </h2>
                 </div>
               </div>
               <div>
                 <h1>
                5
                 
                Normative References
              </h1>
               </div>
               <br/>
               <div id="P" class="Section3">
                 <h1 class="Annex">
                   附属書 A
                   <br/>
                   (規定)
                   <br/>
                   <b>Annex</b>
                 </h1>
                 <div id="Q">
                   <h2>
                A.1
                 
                Annex A.1
              </h2>
                   <div id="Q1">
                     <h3>
                  A.1.1
                   
                  Annex A.1a
                </h3>
                   </div>
                 </div>
                 <div id="Q2">
                   <h2>
                Appendix 1
                 
                An Appendix
              </h2>
                 </div>
               </div>
               <br/>
               <div>
                 <h1 class="Section3">Bibliography</h1>
                 <div>
                   <h2 class="Section3">Bibliography Subsection</h2>
                 </div>
               </div>
             </div>
           </body>
         </html>
    OUTPUT
    word = <<~WORD
      <html xmlns:epub='http://www.idpf.org/2007/ops' lang='ja'>
         <head>
           <style></style>
           <style></style>
         </head>
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
            <div id="foreword">
              <h1 class="ForewordTitle">Foreword</h1>
              <p class="ForewordText" id="A">This is a preamble</p>
            </div>
            <p class="page-break">
              <br clear="all" style="mso-special-character:line-break;page-break-before:always"/>
            </p>
            <div id="_" type="toc" class="TOC">
              <p class="zzContents">目　次</p>
            </div>
            <p> </p>
          </div>
          <p class="section-break">
            <br clear="all" class="section"/>
          </p>
          <div class="WordSection3">
            <div class="Section3" id="B">
              <h1 class="IntroTitle">Introduction</h1>
              <div id="C">
                <h2>
                  0.1
                  <span style="mso-tab-count:1">  </span>
                  Introduction Subsection
                </h2>
              </div>
              <p>This is patent boilerplate</p>
            </div>
            <div id="D">
              <h1>
                1
                <span style="mso-tab-count:1">  </span>
                Scope
              </h1>
              <p id="E">Text</p>
            </div>
            <div id="H">
              <h1>
                2
                <span style="mso-tab-count:1">  </span>
                Terms, definitions, symbols and abbreviated terms
              </h1>
              <div id="I">
                <h2>
                  2.1
                  <span style="mso-tab-count:1">  </span>
                  Normal Terms
                </h2>
                <p class="TermNum" id="J">2.1.1</p>
                <p class="Terms" style="text-align:left;">
                  <b>Term2</b>
                </p>
              </div>
              <div id="K">
                <span class="zzMoveToFollowing inline-header">
                  <b>
                    2.2
                    <span style="mso-tab-count:1">  </span>
                  </b>
                </span>
                <table class="dl">
                  <tr>
                    <td valign="top" align="left">
                      <p align="left" style="margin-left:0pt;text-align:left;">Symbol</p>
                    </td>
                    <td valign="top">Definition</td>
                  </tr>
                </table>
              </div>
            </div>
                          <div id="L" class="Symbols">
                 <h1>3</h1>
                 <table class="dl">
                   <tr>
                     <td valign="top" align="left">
                       <p align="left" style="margin-left:0pt;text-align:left;">Symbol</p>
                     </td>
                     <td valign="top">Definition</td>
                   </tr>
                 </table>
               </div>
               <div id="M">
                 <h1>
                   4
                   <span style="mso-tab-count:1">  </span>
                   Clause 4
                 </h1>
                 <div id="N">
                   <h2>
                     4.1
                     <span style="mso-tab-count:1">  </span>
                     Introduction
                   </h2>
                 </div>
                 <div id="O">
                   <h2>
                     4.2
                     <span style="mso-tab-count:1">  </span>
                     Clause 4.2
                   </h2>
                 </div>
               </div>
               <div class="normref_div">
                 <h1>
                   5
                   <span style="mso-tab-count:1">  </span>
                   Normative References
                 </h1>
               </div>
               <p class="page-break">
                 <br clear="all" style="mso-special-character:line-break;page-break-before:always"/>
               </p>
               <div id="P" class="Section3">
                 <h1 class="Annex">
                   附属書 A
                   <br/>
                   (規定)
                   <br/>
                   <b>Annex</b>
                 </h1>
                 <div id="Q">
                   <h2>
                     A.1
                     <span style="mso-tab-count:1">  </span>
                     Annex A.1
                   </h2>
                   <div id="Q1">
                     <h3>
                       A.1.1
                       <span style="mso-tab-count:1">  </span>
                       Annex A.1a
                     </h3>
                   </div>
                 </div>
                 <div id="Q2">
                   <h2>
                     Appendix 1
                     <span style="mso-tab-count:1">  </span>
                     An Appendix
                   </h2>
                 </div>
               </div>
               <p class="page-break">
                 <br clear="all" style="mso-special-character:line-break;page-break-before:always"/>
               </p>
               <div class="bibliography">
                 <h1 class="Section3">Bibliography</h1>
                 <div>
                   <h2 class="BiblioTitle">Bibliography Subsection</h2>
                 </div>
               </div>
             </div>
             <br clear="all" style="page-break-before:left;mso-break-type:section-break"/>
             <div class="colophon"/>
           </body>
    WORD
    expect(xmlpp(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
      .new(presxml_options)
      .convert("test", input, true)))
      .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to xmlpp(presxml)
    expect(xmlpp(IsoDoc::Plateau::HtmlConvert.new({})
      .convert("test", presxml, true)))
      .to be_equivalent_to xmlpp(html)
    expect(xmlpp(IsoDoc::Plateau::WordConvert.new({})
      .convert("test", presxml, true)))
      .to be_equivalent_to xmlpp(word)
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
               <title depth="1">Contents</title>
             </clause>
           </preface>
           <sections>
             <clause id="S1" obligation="normative" displayorder="2">
               <title depth="1">
                 1
                 <tab/>
                 Scope
               </title>
               <clause id="S2" obligation="normative">
                 <title depth="2">
                   1.1
                   <tab/>
                   Scope
                 </title>
                 <clause id="S3" obligation="normative">
                   <title depth="3">
                     1.1.1
                     <tab/>
                     Scope
                   </title>
                   <clause id="S4" obligation="normative">
                     <title depth="4">
                       (1)
                       <tab/>
                       Scope
                     </title>
                     <clause id="S5" obligation="normative">
                       <title depth="5">
                         1)
                         <tab/>
                         Scope
                       </title>
                       <clause id="S6a" obligation="normative">
                         <title depth="6">
                           ①
                           <tab/>
                           Scope
                         </title>
                       </clause>
                       <clause id="S6b" obligation="normative">
                         <title depth="6">
                           ②
                           <tab/>
                           Scope
                         </title>
                       </clause>
                       <clause id="S6c" obligation="normative">
                         <title depth="6">
                           ③
                           <tab/>
                           Scope
                         </title>
                       </clause>
                     </clause>
                   </clause>
                 </clause>
               </clause>
             </clause>
           </sections>
           <annex id="P" inline-header="false" obligation="normative" displayorder="3">
             <title>
               Annex A
               <br/>
               (normative)
               <br/>
               <strong>Annex</strong>
             </title>
             <clause id="A1" obligation="normative">
               <title depth="2">
                 A.1
                 <tab/>
                 Scope
               </title>
               <clause id="A2" obligation="normative">
                 <title depth="3">
                   A.1.1
                   <tab/>
                   Scope
                 </title>
                 <clause id="A3" obligation="normative">
                   <title depth="4">
                     (1)
                     <tab/>
                     Scope
                   </title>
                   <clause id="A4" obligation="normative">
                     <title depth="5">
                       1)
                       <tab/>
                       Scope
                     </title>
                     <clause id="A6a" obligation="normative">
                       <title depth="6">
                         ①
                         <tab/>
                         Scope
                       </title>
                     </clause>
                     <clause id="A6b" obligation="normative">
                       <title depth="6">
                         ②
                         <tab/>
                         Scope
                       </title>
                     </clause>
                     <clause id="A6c" obligation="normative">
                       <title depth="6">
                         ③
                         <tab/>
                         Scope
                       </title>
                     </clause>
                   </clause>
                 </clause>
               </clause>
             </clause>
           </annex>
         </iso-standard>
    OUTPUT
    expect(xmlpp(strip_guid(IsoDoc::Plateau::PresentationXMLConvert
       .new(presxml_options)
       .convert("test", input, true)))
       .sub(%r{<localized-strings>.*</localized-strings>}m, ""))
      .to be_equivalent_to xmlpp(presxml)
  end
end
