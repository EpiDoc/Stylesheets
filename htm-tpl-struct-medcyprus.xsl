<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                xmlns:fn="http://www.w3.org/2005/xpath-functions"
                version="2.0">
  <!-- Contains named templates for medcyprus file structure (aka "metadata" aka "supporting data") -->  
   
   <!-- Called from htm-tpl-structure.xsl -->

   <xsl:template name="medcyprus-body-structure">
     <xsl:variable name="editor" select="//t:titleStmt/t:author|//t:titleStmt/t:editor"/>  
     <!-- if you are running this template outside EFES, change the path to the bibliography authority list accordingly -->
     <xsl:variable name="bibliography-al" select="concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/bibliography.xml')"/>
     
     <p>
       <b>License: </b> <a target="_blank" href="{//t:licence/@target}"><xsl:value-of select="//t:licence"/></a>
       <br/><b>Authority: </b> <xsl:apply-templates select="//t:publicationStmt/t:authority"/>
       <br/><b>Identification number: </b> <xsl:value-of select="//t:publicationStmt/t:idno[@type='filename']"/>
       <br/><b>Editor(s): </b> <xsl:for-each select="//t:titleStmt/t:author|//t:titleStmt/t:editor">
         <xsl:value-of select="."/><xsl:if test="position()!=last()">, </xsl:if>
       </xsl:for-each>
     </p>
     
     <p>
       <b>Location: </b>
       <xsl:choose>
         <xsl:when test="//t:origin/t:origPlace/text()">
           <xsl:apply-templates select="//t:origin/t:origPlace" mode="medcyprus-location"/>
         </xsl:when>
         <xsl:otherwise>Unknown</xsl:otherwise>
       </xsl:choose>
       
       <xsl:if test="//t:repository/text()!='n/a' and //t:repository/text()!=''">
       <br/><b>Repository: </b>
         <xsl:for-each select="//t:msIdentifier//t:repository">
           <xsl:apply-templates select="." mode="medcyprus-location"/>
         </xsl:for-each>
           <!-- Named template found below. -->
           <xsl:call-template name="medcyprus-invno"/>
       </xsl:if>
       
       <br/><b>Date: </b>
         <xsl:choose>
           <xsl:when test="//t:origin/t:origDate/text()">
             <xsl:value-of select="//t:origin/t:origDate"/>
             <xsl:if test="//t:origin/t:origDate[@evidence]">
               <xsl:text>(</xsl:text>
               <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence],' ')">
                 <xsl:value-of select="translate(.,'-',' ')"/>
                 <xsl:if test="position()!=last()">
                   <xsl:text>, </xsl:text>
                 </xsl:if>
               </xsl:for-each>
               <xsl:text>)</xsl:text>
             </xsl:if>
           </xsl:when>
           <xsl:otherwise>Unknown.</xsl:otherwise>
         </xsl:choose>
     </p>
     
     <p>
       <!--<b>Description of inscription: </b>
         <xsl:apply-templates select="//t:supportDesc" mode="medcyprus-dimensions"/>-->
       <b>Inscription support: </b>
       <xsl:apply-templates select="//t:rs[@type='inscription-support']"/>
       <br/><b>Placement within the building: </b>
       <xsl:apply-templates select="//t:support//t:rs[@type='placement-building']"/>
       <br/><b>Dimensions: </b>
       <xsl:apply-templates select="//t:support//t:dimensions" mode="medcyprus-dimensions"/>
       <br/><b>Articulation of inscription in relation to the murals: </b>
       <xsl:apply-templates select="//t:layoutDesc" mode="medcyprus-dimensions"/>
       <br/><b>Letters: </b>
       <xsl:apply-templates select="//t:handDesc" mode="medcyprus-letter-height"/>
       <br/><b>Iconography: </b>
       <xsl:for-each select="//t:rs[@type='iconography']">
         <xsl:apply-templates select="." mode="medcyprus-dimensions"/>
         <xsl:if test="position()!=last()">; </xsl:if>
       </xsl:for-each>
     </p>
     
     <p><b>Visit to the monument: </b>
       <xsl:choose>
         <xsl:when test="//t:provenance[@type='observed']/text()!='n/a'">
           <xsl:apply-templates select="//t:provenance[@type='observed']"/>
         </xsl:when>
         <xsl:otherwise>
           <xsl:apply-templates select="//t:provenance[not(@type='observed')]"/>
         </xsl:otherwise>
       </xsl:choose>
     
     <xsl:if test="//t:profileDesc/t:creation">
       <br/><b>Text constituted from: </b> 
       <xsl:apply-templates select="//t:profileDesc/t:creation"/> 
       <xsl:if test="//t:div[@type='edition']/@source">
         <xsl:variable name="source-id" select="substring-after(//t:div[@type='edition'][1]/@source, '#')"/> 
           <xsl:choose>
             <xsl:when test="doc-available($bibliography-al) = fn:true() and document($bibliography-al)//t:bibl[@xml:id=$source-id][not(@sameAs)]">
               <xsl:variable name="source" select="document($bibliography-al)//t:bibl[@xml:id=$source-id][not(@sameAs)]"/>
               <a href="{concat('../concordance/bibliography/',$source-id,'.html')}" target="_blank">
                 <xsl:choose>
                   <xsl:when test="$source//t:title[@type='short']">
                     <xsl:apply-templates select="$source//t:title[@type='short'][1]"/>
                   </xsl:when>
                   <xsl:when test="$source//t:surname and $source//t:date">
                     <xsl:for-each select="$source//t:surname[not(parent::*/preceding-sibling::t:title[not(@type='short')])]">
                       <xsl:apply-templates select="."/>
                       <xsl:if test="position()!=last()"> – </xsl:if>
                     </xsl:for-each>
                     <xsl:text> </xsl:text>
                     <xsl:apply-templates select="$source//t:date"/>
                   </xsl:when>
                   <xsl:otherwise>
                     <xsl:apply-templates select="$source-id"/>
                   </xsl:otherwise>
                 </xsl:choose>
               </a>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="$source-id"/>
             </xsl:otherwise>
           </xsl:choose>
       </xsl:if>
     </xsl:if>
     </p>
     
     <p><b>Type of text: </b>
       <xsl:apply-templates select="//t:term[@type='textType']"/>
       <xsl:if test="//t:div[@type='edition']//t:lg[@met]">
         <xsl:text>; metre: </xsl:text>
         <xsl:for-each select="//t:div[@type='edition']//t:lg/@met">
           <xsl:value-of select="."/><xsl:if test="position()!=last()">, </xsl:if>
         </xsl:for-each>
       </xsl:if>
     </p>
     

     <div class="section-container tabs" data-section="tabs">
       <section><!-- #1 interpretative (verse-lines off) -->
         <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="epidoc-xslt-medcyprus-edition">Interpretative</i18n:text></a></p>
         <div class="content" id="edition" data-section-content="data-section-content">
           <!-- Edited text output -->
           <xsl:variable name="edtxt">
             <xsl:apply-templates select="//t:div[@type='edition']">
               <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
               <xsl:with-param name="parm-verse-lines" select="'off'" tunnel="yes"/>
             </xsl:apply-templates>
           </xsl:variable>
           <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
           <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
         </div>
       </section>
       <xsl:if test="//t:div[@type='edition'][descendant::t:lg or descendant::t:l]">
         <section><!-- #2 verse (optional) -->
           <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="epidoc-xslt-medcyprus-edition">Verse</i18n:text></a></p>
           <div class="content" id="edition" data-section-content="data-section-content">
             <p style="font-size:smaller;">[Lineation and marginal numbering reflect verse lines. Vertical bars ("|") and parenthetical numbers represent epigraphic lines.]</p>
             <!-- Edited text output -->
             <xsl:variable name="edtxt">
               <xsl:apply-templates select="//t:div[@type='edition']">
                 <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
                 <xsl:with-param name="parm-verse-lines" select="'on'" tunnel="yes"/>
               </xsl:apply-templates>
             </xsl:variable>
             <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
             <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
           </div>
         </section>
       </xsl:if>
       <section><!-- #3 diplomatic -->
         <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="epidoc-xslt-medcyprus-diplomatic">Diplomatic</i18n:text></a></p>
         <div class="content" id="diplomatic" data-section-content="data-section-content">
           <!-- Edited text output -->
           <xsl:variable name="edtxt">
             <xsl:apply-templates select="//t:div[@type='edition']">
               <xsl:with-param name="parm-edition-type" select="'diplomatic'" tunnel="yes"/>
               <xsl:with-param name="parm-verse-lines" select="'off'" tunnel="yes"/>
             </xsl:apply-templates>
           </xsl:variable>
           <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
           <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
         </div>
       </section>
       <xsl:if test="//t:facsimile//t:graphic[@rend='primary'][1]">
         <section>
           <p class="title" data-section-title="data-section-title">
             <a href="#"><i18n:text i18n:key="epidoc-xslt-medcyprus-image">Image</i18n:text></a></p>
           <div class="content" id="primary_image" data-section-content="data-section-content">
             <a href="/images/{//t:facsimile//t:graphic[@rend='primary'][1]/@url}" target="_blank">
               <img src="/images/{//t:facsimile//t:graphic[@rend='primary'][1]/@url}" style="max-width:100%"/>
             </a>
           </div>
         </section>
       </xsl:if>
     </div>

     <div id="apparatus">
       <!-- Apparatus text output -->
       <xsl:variable name="apptxt">
         <xsl:apply-templates select="//t:div[@type='apparatus']"/>
       </xsl:variable>
       <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
       <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
     </div>

     <div id="translation">
       <h4>English translation</h4>
       <xsl:if test="//t:div[@type='translation']/@source">
         <xsl:variable name="source-id" select="substring-after(//t:div[@type='translation'][1]/@source, '#')"/>
             <p><xsl:text>Translation source: </xsl:text> 
               <xsl:choose>
                 <xsl:when test="doc-available($bibliography-al) = fn:true() and document($bibliography-al)//t:bibl[@xml:id=$source-id][not(@sameAs)]">
                   <xsl:variable name="source" select="document($bibliography-al)//t:bibl[@xml:id=$source-id][not(@sameAs)]"/>
                   <a href="../concordance/bibliography/{$source-id}.html" target="_blank">
                     <xsl:choose>
                       <xsl:when test="$source//t:title[@type='short']">
                         <xsl:apply-templates select="$source//t:title[@type='short'][1]"/>
                       </xsl:when>
                       <xsl:when test="$source//t:surname and $source//t:date">
                         <xsl:for-each select="$source//t:surname[not(parent::*/preceding-sibling::t:title[not(@type='short')])]">
                           <xsl:apply-templates select="."/>
                           <xsl:if test="position()!=last()"> – </xsl:if>
                         </xsl:for-each>
                         <xsl:text> </xsl:text>
                         <xsl:apply-templates select="$source//t:date"/>
                       </xsl:when>
                       <xsl:otherwise>
                         <xsl:value-of select="$source-id"/>
                       </xsl:otherwise>
                     </xsl:choose>
                   </a>
                 </xsl:when>
                 <xsl:otherwise>
                   <xsl:value-of select="$source-id"/>
                 </xsl:otherwise>
               </xsl:choose>
             </p>
       </xsl:if>
       
       <xsl:if test="//t:div[@type='translation']/@resp">
         <xsl:variable name="resp-id" select="substring-after(//t:div[@type='translation'][1]/@resp, '#')"/>
         <xsl:variable name="resp" select="$editor[@xml:id=$resp-id]"/>
         <p><xsl:text>Translation by: </xsl:text> 
           <xsl:choose>
             <xsl:when test="$resp">
               <xsl:value-of select="$resp"/>
             </xsl:when>
             <xsl:otherwise>
               <xsl:value-of select="$resp-id"/> 
             </xsl:otherwise>
           </xsl:choose>
         </p>
       </xsl:if>
       
       <!-- Translation text output -->
       <xsl:variable name="transtxt">
         <xsl:apply-templates select="//t:div[@type='translation']//t:p|//t:div[@type='translation']//t:ab"/>
       </xsl:variable>
       <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
       <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
     </div>

     <div id="commentary">
       <h4>Commentary</h4>
       <!-- Commentary text output -->
       <xsl:variable name="commtxt">
         <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
       </xsl:variable>
       <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
       <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
     </div>
     
     <div id="bibliography">
       <h4>Editions</h4>
       <xsl:for-each select="//t:div[@type='bibliography']//t:bibl">
         <p><xsl:apply-templates/></p>
       </xsl:for-each>
       
     </div>
     
     <div id="images">
       <h4>Images</h4>
       <xsl:choose>
         <xsl:when test="//t:facsimile//t:graphic">
           <xsl:for-each select="//t:facsimile//t:graphic">
             <span>&#160;</span>
             <xsl:apply-templates select="." />
           </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
           <xsl:for-each select="//t:facsimile[not(//t:graphic)]">
             <xsl:text>None available.</xsl:text>
           </xsl:for-each>
         </xsl:otherwise>
       </xsl:choose>
     </div>
   </xsl:template>

   <xsl:template name="medcyprus-structure">
      <xsl:variable name="title">
         <xsl:call-template name="medcyprus-title" />
      </xsl:variable>

      <html>
         <head>
            <title>
               <xsl:value-of select="$title"/>
            </title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
            <!-- Found in htm-tpl-cssandscripts.xsl -->
            <xsl:call-template name="css-script"/>
         </head>
         <body>
            <h1>
               <xsl:value-of select="$title"/>
            </h1>
            <xsl:call-template name="medcyprus-body-structure" />
         </body>
      </html>
   </xsl:template>

  <xsl:template match="t:height[ancestor::t:handDesc][text()!='']" mode="medcyprus-letter-height">
    <xsl:value-of select="."/>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@unit"/>
  </xsl:template>
  
  <xsl:template match="t:dimensions" mode="medcyprus-dimensions">
      <xsl:if test="//text()">
        <xsl:if test="t:height/text()">
          <xsl:if test="normalize-space(t:height/text()) != 'n/a'"><xsl:text>h: </xsl:text></xsl:if> 
            <xsl:value-of select="t:height"/>
            <xsl:if test="t:width/text()">
              <xsl:text> x </xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:if test="t:width/text()">w: 
            <xsl:value-of select="t:width"/>
         </xsl:if>
         <xsl:if test="t:depth/text()">x d:
            <xsl:value-of select="t:depth"/>
         </xsl:if>
         <xsl:if test="t:dim[@type='diameter']/text()">x diam.:
            <xsl:value-of select="t:dim[@type='diameter']"/>
         </xsl:if>
      </xsl:if>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@unit"/>
    <xsl:if test="@scope">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="replace(@scope, '_', ' ')"/>
      <xsl:text>)</xsl:text>
    </xsl:if>
    <xsl:if test="following-sibling::t:dimensions">
      <xsl:text>; </xsl:text>
    </xsl:if>
   </xsl:template>
   
  <xsl:template match="t:placeName|t:origPlace|t:repository" mode="medcyprus-location">
      <xsl:choose>
        <xsl:when test="starts-with(@ref, 'locations.xml') or starts-with(@ref, '#')"><a href="../indices/epidoc/locations.html#{substring-after(@ref, '#')}"><xsl:apply-templates/></a></xsl:when>
        <xsl:when test="starts-with(@ref, 'http')"><a href="{@ref}"><xsl:apply-templates/></a></xsl:when>
         <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="medcyprus-invno">
     <xsl:if test="//t:msIdentifier//t:idno[string(translate(normalize-space(.),' ',''))]">
         <xsl:text> (Inv. no. </xsl:text>
       <xsl:for-each select="//t:msIdentifier//t:idno[string(translate(normalize-space(.),' ',''))]">
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:for-each>
         <xsl:text>)</xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="medcyprus-title">
     <xsl:value-of select="//t:publicationStmt/t:idno[@type='filename']"/>
     <xsl:text> – </xsl:text>     
     <xsl:value-of select="upper-case(substring(normalize-space(//t:origPlace), 1, 1))" />
     <xsl:value-of select="substring(normalize-space(//t:origPlace), 2)" />
     <xsl:text>. </xsl:text>
     <xsl:value-of select="//t:titleStmt/t:title"/>
     <xsl:text>, </xsl:text>
     <xsl:value-of select="//t:origDate"/>
   </xsl:template>

 </xsl:stylesheet>
