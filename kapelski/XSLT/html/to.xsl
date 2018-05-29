<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
   xmlns="http://www.w3.org/1999/xhtml"
   xmlns:html="http://www.w3.org/1999/xhtml"
   xmlns:tei="http://www.tei-c.org/ns/1.0"
   xmlns:teidocx="http://www.tei-c.org/ns/teidocx/1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   exclude-result-prefixes="tei html teidocx xs"
   version="2.0">

   <xsl:import href="../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl"/>
    
    <xsl:import href="text-critical.xsl"/>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet" type="stylesheet">
      <desc>
         <p>TEI stylesheet for making HTML5 output (Zurb Foundation 6 http://foundation.zurb.com/sites/docs/).</p>
         <p>This software is dual-licensed:
            
            1. Distributed under a Creative Commons Attribution-ShareAlike 3.0
            Unported License http://creativecommons.org/licenses/by-sa/3.0/ 
            
            2. http://www.opensource.org/licenses/BSD-2-Clause
            
            
            
            Redistribution and use in source and binary forms, with or without
            modification, are permitted provided that the following conditions are
            met:
            
            * Redistributions of source code must retain the above copyright
            notice, this list of conditions and the following disclaimer.
            
            * Redistributions in binary form must reproduce the above copyright
            notice, this list of conditions and the following disclaimer in the
            documentation and/or other materials provided with the distribution.
            
            This software is provided by the copyright holders and contributors
            "as is" and any express or implied warranties, including, but not
            limited to, the implied warranties of merchantability and fitness for
            a particular purpose are disclaimed. In no event shall the copyright
            holder or contributors be liable for any direct, indirect, incidental,
            special, exemplary, or consequential damages (including, but not
            limited to, procurement of substitute goods or services; loss of use,
            data, or profits; or business interruption) however caused and on any
            theory of liability, whether in contract, strict liability, or tort
            (including negligence or otherwise) arising in any way out of the use
            of this software, even if advised of the possibility of such damage.
         </p>
         <p>Andrej Pančur, Institute for Contemporary History</p>
         <p>Copyright: 2013, TEI Consortium</p>
      </desc>
   </doc>
   
   <!-- Zaradi pravilnega izpisa tei:w, tei:pc in tei:c sem moral dodati strip-space -->
    <xsl:strip-space elements="*"/>
    
   <!-- Uredi parametre v skladu z dodatnimi zahtevami za pretvorbo te publikacije: -->
   
   <xsl:param name="path-general">../../../</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/to.xsl -->
   <xsl:param name="outputDir">/Users/administrator/Documents/moje/publikacije/kapelski/</xsl:param>
   
   <!-- Iz datoteke ../../../../publikacije-XSLT/sistory/html5-foundation6-chs/my-html_param.xsl -->
   <xsl:param name="title-bar-sticky">false</xsl:param>
   
   <!-- V html/head izpisani metapodatki -->
   <xsl:param name="description"></xsl:param>
   <xsl:param name="keywords"></xsl:param>
   <xsl:param name="title"></xsl:param>
    
    
    <!-- Slovene localisation of eZRC/TEI element, attribute and value names / glosses to Slovene -->
    <!-- Needed for teiHeader localisation and write-out of e.g. Janus elements -->
    <xsl:param name="localisation-file">teiLocalise-sl.xml</xsl:param>
    <xsl:key name="id" match="tei:*" use="@xml:id"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Novo ime za glavno vsebino</desc>
        <param name="thisLanguage"></param>
    </doc>
    <xsl:template name="nav-body-head">
        <xsl:param name="thisLanguage"/>
        <xsl:text>Prepisi</xsl:text>
    </xsl:template>
    
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>V css in javascript Hook dodam imageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="cssHook">
      <xsl:if test="$title-bar-sticky = 'true'">
         <xsl:value-of select="concat($path-general,'publikacije/themes/css/foundation/6/sistory-sticky_title_bar.css')"/>
      </xsl:if>
      <link href="http://cdnjs.cloudflare.com/ajax/libs/foundicons/3.0.0/foundation-icons.min.css" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'publikacije/themes/plugin/TipueSearch/6.1/tipuesearch/css/normalize.css')}" rel="stylesheet" type="text/css" />
      <link href="{concat($path-general,'publikacije/themes/css/plugin/TipueSearch/6.1/my-tipuesearch.css')}"  rel="stylesheet" type="text/css" />
      <!-- dodan imageViewer -->
      <link href="{concat($path-general,'publikacije/themes/plugin/ImageViewer/1.1.3/imageviewer.css')}" rel="stylesheet" type="text/css" />
      <!-- dodam projektno specifičen css, ki se nahaja v istem direktoriju kot ostali HTML dokumenti -->
      <link href="project.css" rel="stylesheet" type="text/css"/>
   </xsl:template>
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>[html] Hook where extra Javascript functions can be defined</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="javascriptHook">
      <script src="{concat($path-general,'publikacije/themes/foundation/6/js/vendor/jquery.js')}"></script>
      <!-- za highcharts -->
      <xsl:if test="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']]">
         <xsl:variable name="jsfile" select="//tei:figure[@type = 'chart'][tei:graphic[@mimeType = 'application/javascript']][1]/tei:graphic[@mimeType = 'application/javascript']/@url"/>
         <xsl:variable name="chart-jsfile" select="document($jsfile)/html/body/script[1]/@src"/>
         <script src="{$chart-jsfile[1]}"></script>
      </xsl:if>
      <!-- za back-to-top in highcharts je drugače potrebno dati jquery, vendar sedaj ne rabim dodajati jquery kodo,
         ker je že vsebovana zgoraj -->
      <!-- dodan imageViewer -->
      <script src="{concat($path-general,'publikacije/themes/plugin/ImageViewer/1.1.3/imageviewer.js')}"></script>
       <!-- dodan css jstree (mora biti za jquery.js -->
       <link href="{concat($path-general,'publikacije/themes/plugin/jstree/3.3.5/dist/themes/default/style.min.css')}" rel="stylesheet" type="text/css" />
       <!-- dodan jstree -->
      <script src="{concat($path-general,'publikacije/themes/plugin/jstree/3.3.5/dist/jstree.min.js')}"></script>
   </xsl:template>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl" class="hook">
        <desc>[html] Hook where Javascript calls can be inserted  just after &lt;body&gt;</desc>
        <param name="thisLanguage"></param>
    </doc>
    <xsl:template name="bodyJavascriptHook">
        <xsl:param name="thisLanguage"/>
        <!-- za iskalnik tipue -->
        <xsl:if test="//tei:divGen[@type='search']">
            <!-- v spodnjem js je shranjena vsebina za iskanje -->
            <script src="tipuesearch_content.js"></script>
            <!-- dodal bom pa poseben tipuesearch_set.js za samo ta projekt!!! Glej spodaj template[@name='tipuesearch_content'], kjer poleg zgornjega tipuesearch_content.js generiram še tipuesearch_set.js -->
            <script src="tipuesearch_set.js"></script>
            <!-- to pa ostane kot pri običajnem -->
            <script src="{concat($path-general,'publikacije/themes/plugin/TipueSearch/6.1/tipuesearch/tipuesearch.min.js')}"></script>
        </xsl:if>
    </xsl:template>
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>poleg tipuesearch_content.js sedaj generiram še tipuesearch_set.js</desc>
        <param name="tei-id"></param>
        <param name="sistoryAbsolutePath"></param>
    </doc>
    <xsl:template name="tipuesearch_content">
        <xsl:param name="tei-id"/>
        <xsl:param name="sistoryAbsolutePath"/>
        <xsl:variable name="datoteka-js" select="concat($outputDir,ancestor::tei:TEI/@xml:id,'/','tipuesearch_content.js')"/>
        <xsl:result-document href="{$datoteka-js}" method="text" encoding="UTF-8">
            <!-- ZAČETEK JavaScript dokumenta -->
            <xsl:text>var tipuesearch = {"pages": [
                                    </xsl:text>
            <!-- Shrani celotno besedilo v indeks za:
                     - vse child elemente od div, ki imajo @xml:id;
                     - vse child elemente od izbranih list elementov:
                         - list element ne sme imeti @xml:id,
                         - child element mora imeti @xml:id
                -->
            <xsl:for-each select="//node()[ancestor::tei:TEI/@xml:id = $tei-id][@xml:id][ancestor::tei:text][parent::tei:div][not(self::tei:div)] |
                //tei:listPerson[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
                //tei:listPlace[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
                //tei:listOrg[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
                //tei:listEvent[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
                //tei:listBibl[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id] |
                //tei:list[ancestor::tei:TEI/@xml:id = $tei-id][not(@xml:id)][ancestor::tei:text][parent::tei:div]/node()[@xml:id]">
                <!--<xsl:variable name="ancestorChapter-id" select="ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/@xml:id"/>-->
                <xsl:variable name="generatedLink">
                    <xsl:apply-templates mode="generateLink" select="."/>
                </xsl:variable>
                <xsl:variable name="besedilo">
                    <xsl:apply-templates mode="besedilo"/>
                </xsl:variable>
                <xsl:variable name="title-first">
                    <xsl:apply-templates select="parent::tei:div/tei:head[1]" mode="chapters-head"/>
                </xsl:variable>
                
                <xsl:text>{ "title": "</xsl:text>
                <xsl:value-of select="normalize-space(translate(translate($title-first,'&#xA;',' '),'&quot;',''))"/>
                <!--<xsl:value-of select="normalize-space(translate(translate(ancestor::tei:div[@xml:id][parent::tei:front | parent::tei:body | parent::tei:back]/tei:head[1],'&#xA;',' '),'&quot;',''))"/>-->
                <xsl:text>", "text": "</xsl:text>
                <xsl:value-of select="normalize-space(translate($besedilo,'&#xA;&quot;&#92;','&#x20;'))"/>
                <xsl:text>", "tags": "</xsl:text>
                <xsl:text>", "url": "</xsl:text>
                <xsl:value-of select="concat($sistoryAbsolutePath,$generatedLink)"/>
                <!--<xsl:value-of select="concat($ancestorChapter-id,'.html#',@xml:id)"/>-->
                <xsl:text>" }</xsl:text>
                <xsl:if test="position() != last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each>
            
            <!-- KONEC JavaScript dokumenta -->
            <xsl:text>
                     ]};
                </xsl:text>
        </xsl:result-document>
        
        <!-- generoram na novo še tipuesearch_set.js -->
        <xsl:variable name="datoteka-js-2" select="concat($outputDir,ancestor::tei:TEI/@xml:id,'/','tipuesearch_set.js')"/>
        <xsl:result-document href="{$datoteka-js-2}" method="text" encoding="UTF-8">
            <xsl:text>var tipuesearch_stop_words = ["a", "about", "above", "after", "again", "against", "all", "am", "an", "and", "any", "are", "aren't", "as", "at", "be", "because", "been", "before", "being", "below", "between", "both", "but", "by", "can't", "cannot", "could", "couldn't", "did", "didn't", "do", "does", "doesn't", "doing", "don't", "down", "during", "each", "few", "for", "from", "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having", "he", "he'd", "he'll", "he's", "her", "here", "here's", "hers", "herself", "him", "himself", "his", "how", "how's", "i", "i'd", "i'll", "i'm", "i've", "if", "in", "into", "is", "isn't", "it", "it's", "its", "itself", "let's", "me", "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "of", "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves", "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's", "should", "shouldn't", "so", "some", "such", "than", "that", "that's", "the", "their", "theirs", "them", "themselves", "then", "there", "there's", "these", "they", "they'd", "they'll", "they're", "they've", "this", "those", "through", "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd", "we'll", "we're", "we've", "were", "weren't", "what", "what's", "when", "when's", "where", "where's", "which", "while", "who", "who's", "whom", "why", "why's", "with", "won't", "would", "wouldn't", "you", "you'd", "you'll", "you're", "you've", "your", "yours", "yourself", "yourselves"];
</xsl:text>
            
            <xsl:text>var tipuesearch_replace = {'words': [
     {'word': 'tip', 'replace_with': 'tipue'},
     {'word': 'javscript', 'replace_with': 'javascript'},
     {'word': 'jqeury', 'replace_with': 'jquery'}
]};
</xsl:text>
            
            <xsl:text>var tipuesearch_weight = {'weight': [
     {'url': 'http://www.tipue.com', 'score': 20},
     {'url': 'http://www.tipue.com/search', 'score': 30},
     {'url': 'http://www.tipue.com/is', 'score': 10}
]};
</xsl:text>
            
            <!-- {'word': 'e-mail', 'stem': 'email'},
     {'word': 'javascript', 'stem': 'jquery'},
     {'word': 'javascript', 'stem': 'js'} -->
            <xsl:text>var tipuesearch_stem = {'words': [
     </xsl:text>
            <xsl:for-each-group select="//tei:w[@lemma]" group-by="lower-case(normalize-space(.))">
                <xsl:sort select="current-grouping-key()"/>
                <xsl:text>{'word': '</xsl:text>
                <xsl:value-of select="current-group()[1]/@lemma"/>
                <xsl:text>', 'stem': '</xsl:text>
                <xsl:value-of select="current-grouping-key()"/>
                <xsl:text>'}</xsl:text>
                <xsl:if test="position() != last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:text>&#xA;</xsl:text>
            </xsl:for-each-group>
            <xsl:text>
]};
</xsl:text>
            
            <xsl:text>var tipuesearch_related = {'searches': [
     {'search': 'tipue', 'related': 'Tipue Search'},
     {'search': 'tipue', 'before': 'Tipue Search', 'related': 'Getting Started'},
     {'search': 'tipue', 'before': 'Tipue', 'related': 'jQuery'},
     {'search': 'tipue', 'before': 'Tipue', 'related': 'Blog'}
]};
</xsl:text>
            
            <xsl:text>var tipuesearch_string_1 = 'Brez naslova';
var tipuesearch_string_2 = 'Pokaži rezultate za';
var tipuesearch_string_3 = 'Išči namesto';
var tipuesearch_string_4 = '1 zadetek';
var tipuesearch_string_5 = 'zadetki';
var tipuesearch_string_6 = 'Nazaj';
var tipuesearch_string_7 = 'Naprej';
var tipuesearch_string_8 = 'Ničesar ne najdem.';
var tipuesearch_string_9 = 'Common words are largely ignored.';
var tipuesearch_string_10 = 'Iskalni niz je prekratek';
var tipuesearch_string_11 = 'Mora biti en znak ali več.';
var tipuesearch_string_12 = 'Morajo biti';
var tipuesearch_string_13 = 'znaki ali več.';
var tipuesearch_string_14 = 'sekund';
var tipuesearch_string_15 = 'Iskanje v povezavi z';
</xsl:text>
            
            <xsl:text>var startTimer = new Date().getTime();
</xsl:text>
            
        </xsl:result-document>
    </xsl:template>
    
    
   
   <xsldoc:doc xmlns:xsldoc="http://www.oxygenxml.com/ns/doc/xsl">
      <xsldoc:desc>Dodam zaključni javascript za ImageViewer</xsldoc:desc>
   </xsldoc:doc>
   <xsl:template name="bodyEndHook">
      <script type="text/javascript">
         $(function () {
         var viewer = ImageViewer();
         $('.imageviewer').click(function () {
         var imgSrc = this.src,
         highResolutionImage = $(this).data('high-res-src');
         
         viewer.show(imgSrc, highResolutionImage);
         });
         });
      </script>
      <script src="{concat($path-general,'publikacije/themes/foundation/6/js/vendor/what-input.js')}"></script>
      <script src="{concat($path-general,'publikacije/themes/foundation/6/js/vendor/foundation.min.js')}"></script>
      <script src="{concat($path-general,'publikacije/themes/foundation/6/js/app.js')}"></script>
      <!-- back-to-top -->
      <script src="{concat($path-general,'publikacije/themes/js/plugin/back-to-top/back-to-top.js')}"></script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:divGen[@type='facsimile']">
      <style>
         #image-gallery {
         width: 100%;
         position: relative;
         height: 650px;
         background: #000;
         }
         #image-gallery .image-container {
         position: absolute;
         top: 0;
         left: 0;
         right: 0;
         bottom: 50px;
         }
         #image-gallery .prev,
         #image-gallery .next {
         position: absolute;
         height: 32px;
         margin-top: -66px;
         top: 50%;
         }
         #image-gallery .prev {
         left: 20px;
         }
         #image-gallery .next {
         right: 20px;
         cursor: pointer;
         }
         #image-gallery .footer-info {
         position: absolute;
         height: 50px;
         width: 100%;
         left: 0;
         bottom: 0;
         line-height: 50px;
         font-size: 24px;
         text-align: center;
         color: white;
         border-top: 1px solid #FFF;
         }
      </style>
      <div id="image-gallery">
         <div class="image-container"></div>
          <img src="{concat($path-general,'publikacije/themes/plugin/ImageViewer/1.1.3/images/left.svg')}" class="prev"/>
          <img src="{concat($path-general,'publikacije/themes/plugin/ImageViewer/1.1.3/images/right.svg')}"  class="next"/>
         <div class="footer-info">
            <span class="current"></span>/<span class="total"></span>
         </div>
      </div>
      
       <script type="text/javascript">
           <xsl:text>$(function () {
    var images = [</xsl:text>
           <xsl:for-each select="ancestor::tei:TEI/tei:facsimile/tei:surface">
               <xsl:text>{
        small : 'facs/small/</xsl:text><xsl:value-of select="tokenize(tei:graphic[@n='small']/@url,'/')[last()]"/><xsl:text>',
        big : 'facs/orig/</xsl:text><xsl:value-of select="tokenize(tei:graphic[@n='orig']/@url,'/')[last()]"/><xsl:text>'
    }</xsl:text>
               <xsl:if test="position() != last()">
                   <xsl:text>,</xsl:text>
               </xsl:if>
           </xsl:for-each>
           <xsl:text disable-output-escaping="yes"><![CDATA[
               ];
    
    var curImageIdx = 1,
        total = images.length;
    var wrapper = $('#image-gallery'),
        curSpan = wrapper.find('.current');
    var viewer = ImageViewer(wrapper.find('.image-container'));
 
    //display total count
    wrapper.find('.total').html(total);
    
    function showImage(){
        var imgObj = images[curImageIdx - 1];
        viewer.load(imgObj.small, imgObj.big);
        curSpan.html(curImageIdx);
    }
 
    wrapper.find('.next').click(function(){
         curImageIdx++;
        if(curImageIdx > total) curImageIdx = 1;
        showImage();
    });
 
    wrapper.find('.prev').click(function(){
         curImageIdx--;
        if(curImageIdx < 0) curImageIdx = total;
        showImage();
    });
 
    //initially show image
    showImage();
});]]></xsl:text>
       </script>
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc>Dodam vsebino Saxon-JS v prej prazni template</desc>
   </doc>
   <xsl:template name="divGen-process-content">
      <script type="text/javascript" src="SaxonJS.min.js"></script>
      <xsl:text disable-output-escaping="yes"><![CDATA[<script>
            window.onload = function() {
            SaxonJS.transform({
            stylesheetLocation: "para.sef",
            sourceLocation: "kapelski.xml"
            });
            }     
         </script>]]></xsl:text>
      
      <!-- dinamična para vsebina -->
      <div id="para"/>
      
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:quote">
      <xsl:choose>
         <!-- Če ni znotraj odstavka -->
         <xsl:when test="not(ancestor::tei:p)">
            <blockquote>
               <xsl:choose>
                  <xsl:when test="@xml:id and not(parent::tei:cit[@xml:id])">
                     <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                     </xsl:attribute>
                  </xsl:when>
                  <xsl:when test="parent::tei:cit[@xml:id]">
                     <xsl:attribute name="id">
                        <xsl:value-of select="parent::tei:cit/@xml:id"/>
                     </xsl:attribute>
                  </xsl:when>
               </xsl:choose>
               <xsl:apply-templates/>
               <!-- glej spodaj obrazložitev pri procesiranju elementov cit -->
               <xsl:if test="parent::tei:cit/tei:bibl">
                  <xsl:for-each select="parent::tei:cit/tei:bibl">
                     <cite>
                        <xsl:apply-templates/>
                     </cite>
                  </xsl:for-each>
               </xsl:if>
            </blockquote>
         </xsl:when>
         <!-- Če pa je znotraj odstavka, ga damo samo v element q, se pravi v narekovaje. -->
         <xsl:otherwise>
            <q>
               <xsl:apply-templates/>
            </q>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   <!-- Če je naveden tudi avtor citata, damo predhodno element quote v parent element cit
         in mu dodamo še sibling element bibl/author
    -->
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:cit">
      <xsl:apply-templates/>
   </xsl:template>
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
   </doc>
   <xsl:template match="tei:bibl[parent::tei:cit]">
      <!-- ta element pustimo prazen,ker ga procesiroma zgoraj v okviru elementa quote -->
   </xsl:template>
   
   <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
      <desc></desc>
      <param name="thisChapter-id"></param>
      <param name="title-bar-type"></param>
   </doc>
   <xsl:template name="title-bar-list-of-contents-subchapters">
      <xsl:param name="thisChapter-id"/>
      <xsl:param name="title-bar-type"/>
      <!-- odstranim, da mora imeti atribut type -->
      <xsl:if test="tei:div[@xml:id]">
         <ul>
            <xsl:attribute name="class">
               <xsl:if test="$title-bar-type = 'vertical'">vertical menu</xsl:if>
               <xsl:if test="$title-bar-type = 'dropdown'">menu</xsl:if>
            </xsl:attribute>
            <xsl:for-each select="tei:div">
               <li>
                  <xsl:if test="descendant-or-self::tei:div[@xml:id = $thisChapter-id]">
                     <xsl:attribute name="class">active</xsl:attribute>
                  </xsl:if>
                  <a>
                     <xsl:attribute name="href">
                        <xsl:apply-templates mode="generateLink" select="."/>
                     </xsl:attribute>
                     <!--<xsl:attribute name="href">
                                <xsl:variable name="this-subchapterID" select="@xml:id"/>
                                <xsl:value-of select="concat(ancestor::tei:div[1]/@xml:id,'.html#',$this-subchapterID)"/>
                            </xsl:attribute>-->
                     <xsl:apply-templates select="tei:head[1]" mode="chapters-head"/>
                  </a>
                  <xsl:call-template name="title-bar-list-of-contents-subchapters">
                     <xsl:with-param name="thisChapter-id" select="$thisChapter-id"/>
                     <xsl:with-param name="title-bar-type" select="$title-bar-type"/>
                  </xsl:call-template>
               </li>
            </xsl:for-each>
         </ul>
      </xsl:if>
   </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Prelome strani izkoristim za povezave na dinamično stran para.html</desc>
    </doc>
    <xsl:template match="tei:pb">
        <xsl:variable name="type">
            <xsl:choose>
                <xsl:when test="contains(@xml:id,'dipl')">dipl</xsl:when>
                <xsl:otherwise>crit</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <div class="dropdown pb" id="{@xml:id}">
            <button class="alert hollow tiny dropdown button">
                <xsl:text>Stran </xsl:text>
                <xsl:value-of select="@n"/>
            </button>
            <div class="dropdown-content">
                <xsl:if test="$type='dipl'">
                    <a href="{concat('para.html?type=page&amp;mode=facs-dipl&amp;page=',@n,'&amp;lb=1')}">faksimile</a>
                    <a href="{concat('para.html?type=page&amp;mode=dipl-crit&amp;page=',@n,'&amp;lb=1')}">kritični</a>
                    <a href="{concat('para.html?type=page&amp;mode=facs-dipl-crit&amp;page=',@n,'&amp;lb=1')}">vsi</a>
                </xsl:if>
                <xsl:if test="$type='crit'">
                    <a href="{concat('para.html?type=page&amp;mode=facs-crit&amp;page=',@n,'&amp;lb=1')}">faksimile</a>
                    <a href="{concat('para.html?type=page&amp;mode=dipl-crit&amp;page=',@n,'&amp;lb=1')}">diplomatični</a>
                    <a href="{concat('para.html?type=page&amp;mode=facs-dipl-crit&amp;page=',@n,'&amp;lb=1')}">vsi</a>
                </xsl:if>
            </div>
        </div>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>Mejnike izkoristim za povezave na dinamično stran para.html</desc>
    </doc>
    <xsl:template match="tei:milestone">
        <xsl:variable name="type">
            <xsl:choose>
                <xsl:when test="contains(@xml:id,'dipl')">dipl</xsl:when>
                <xsl:otherwise>crit</xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <div class="dropdown milestone" id="{@xml:id}">
            <button class="alert hollow tiny dropdown button">
                <xsl:text>Mejnik </xsl:text>
                <xsl:value-of select="@n"/>
            </button>
            <div class="dropdown-content">
                <xsl:if test="$type='dipl'">
                    <a href="{concat('para.html?type=section&amp;mode=dipl-crit&amp;section=',@n,'&amp;lb=1')}">kritični</a>
                </xsl:if>
                <xsl:if test="$type='crit'">
                    <a href="{concat('para.html?type=section&amp;mode=dipl-crit&amp;section=',@n,'&amp;lb=1')}">diplomatični</a>
                </xsl:if>
            </div>
        </div>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:fw">
        <div class="pageNum">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:label">
        <div class="{if (@rend) then (concat('text',@rend)) else 'padding'}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!-- poenostavljeno procesiranje besed, ločil in presledkov -->
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:w">
        <xsl:apply-templates/>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:pc">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc></desc>
    </doc>
    <xsl:template match="tei:c">
        <xsl:text> </xsl:text>
    </xsl:template>
    
</xsl:stylesheet>