<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains named templates for InsLib file structure (aka "metadata" aka "supporting data") -->  
   
   <!-- Called from htm-tpl-structure.xsl -->

   <xsl:template name="inslib-body-structure">
     <p><b>Description: </b>
     <xsl:choose>
       <xsl:when test="//t:support/t:p/text()">
         <xsl:apply-templates select="//t:support/t:p" mode="inslib-dimensions"/>
       </xsl:when>
       <xsl:when test="//t:support//text()">
         <xsl:apply-templates select="//t:support" mode="inslib-dimensions"/>
       </xsl:when>
       <xsl:otherwise>Unknown</xsl:otherwise>
     </xsl:choose>

     <br />
     <b>Text: </b>
     <xsl:choose>
       <xsl:when test="//t:layoutDesc/t:layout//text()">
         <xsl:value-of select="//t:layoutDesc/t:layout"/>
       </xsl:when>
       <xsl:otherwise>Unknown.</xsl:otherwise>
     </xsl:choose>
     <br />
     <b>Letters: </b>
     <xsl:if test="//t:handDesc/t:handNote/text()">
       <xsl:value-of select="//t:handDesc/t:handNote"/>
     </xsl:if>
     </p>

     <p><b>Date: </b>
     <xsl:choose>
       <xsl:when test="//t:origin/t:origDate/text()">
         <xsl:value-of select="//t:origin/t:origDate"/>
         <xsl:if test="//t:origin/t:origDate[@type='evidence']">
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

     <p><b>Findspot: </b>
     <xsl:choose>
       <xsl:when test="//t:provenance[@type='found'][string(translate(normalize-space(.),' ',''))]">
         <xsl:apply-templates select="//t:provenance[@type='found']" mode="inslib-placename"/>
       </xsl:when>
       <xsl:otherwise>Unknown</xsl:otherwise>
     </xsl:choose>
     <br/>
     <b>Original location: </b>
     <xsl:choose>
       <xsl:when test="//t:origin/t:origPlace/text()">
         <xsl:apply-templates select="//t:origin/t:origPlace" mode="inslib-placename"/>
       </xsl:when>
       <xsl:otherwise>Unknown</xsl:otherwise>
     </xsl:choose>
     <br/>
     <b>Last recorded location: </b>
     <xsl:choose>
       <xsl:when test="//t:provenance[@type='observed'][string(translate(normalize-space(.),' ',''))]">
         <xsl:apply-templates select="//t:provenance[@type='observed']" mode="inslib-placename"/>
         <!-- Named template found below. -->
         <xsl:call-template name="inslib-invno"/> 
       </xsl:when>
       <xsl:when test="//t:msIdentifier//t:repository[string(translate(normalize-space(.),' ',''))]">
         <xsl:value-of select="//t:msIdentifier//t:repository[1]"/>
         <!-- Named template found below. -->
         <xsl:call-template name="inslib-invno"/>
       </xsl:when>
       <xsl:otherwise>Unknown</xsl:otherwise>
     </xsl:choose>
     </p>

     <div id="inslib-text">
          <div id="edition">
              <p><b>Interpretive edition:</b></p>
              <!-- Edited text output -->
              <xsl:variable name="edtxt">
                  <xsl:apply-templates select="//t:div[@type='edition']">
                      <xsl:with-param name="parm-edition-type" tunnel="yes" select="'interpretive'"/>
                      <xsl:with-param name="parm-verse-lines" tunnel="yes" select="'no'"/>
                   </xsl:apply-templates>
                </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
            </div>
          
          <xsl:if test="//t:div[@type='edition']//t:lg">
              <div id="verse">
                  <p><b>Verse edition:</b></p>
                  <!-- Edited text output -->
                  <xsl:variable name="edtxt">
                      <xsl:apply-templates select="//t:div[@type='edition']">
                          <xsl:with-param name="parm-edition-type" tunnel="yes" select="'interpretive'"/>
                          <xsl:with-param name="parm-verse-lines" tunnel="yes" select="'yes'"/>
                      </xsl:apply-templates>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
               </div>
         </xsl:if>
              
        <div id="diplomatic">
            <p><b>Diplomatic edition:</b></p>
            <!-- Edited text output -->
            <xsl:variable name="edtxt">
               <xsl:apply-templates select="//t:div[@type='edition']">
                  <xsl:with-param name="parm-edition-type" tunnel="yes" select="'diplomatic'"/>
                 <xsl:with-param name="parm-verse-lines" tunnel="yes" select="'no'"/>
              </xsl:apply-templates>
           </xsl:variable>
           <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
           <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
        </div>
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
       <h4 class="slimmer">Translation:</h4>
       <!-- Translation text output -->
       <xsl:variable name="transtxt">
         <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
       </xsl:variable>
       <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
       <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
     </div>

     <div id="commentary">
       <h4 class="slimmer">Commentary:</h4>
       <!-- Commentary text output -->
       <xsl:variable name="commtxt">
         <xsl:apply-templates select="//t:div[@type='commentary']//t:p"/>
       </xsl:variable>
       <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
       <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
     </div>

     <p><b>Bibliography: </b>
     <xsl:apply-templates select="//t:div[@type='bibliography']/t:p/node()"/> 
     <br/>
     <b>Text constituted from: </b>
     <xsl:apply-templates select="//t:creation"/>
     </p>
   </xsl:template>

   <xsl:template name="inslib-structure">
      <xsl:variable name="title">
         <xsl:call-template name="inslib-title" />
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
            <xsl:call-template name="inslib-body-structure" />
         </body>
      </html>
   </xsl:template>

   <xsl:template match="t:dimensions" mode="inslib-dimensions">
      <xsl:if test="//text()">
         <xsl:if test="t:width/text()">w: 
            <xsl:value-of select="t:width"/>
            <xsl:if test="t:height/text()">
               <xsl:text> × </xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:if test="t:height/text()">h: 
            <xsl:value-of select="t:height"/>
         </xsl:if>
          <xsl:if test="t:depth/text()"><xsl:text> × d:</xsl:text>
            <xsl:value-of select="t:depth"/>
         </xsl:if>
          <xsl:if test="t:dim[@type='diameter']/text()"><xsl:text> × diam.:</xsl:text>
            <xsl:value-of select="t:dim[@type='diameter']"/>
         </xsl:if>
      </xsl:if>
   </xsl:template>
   
   <xsl:template match="t:placeName|t:rs" mode="inslib-placename">
      <xsl:choose>
         <xsl:when test="contains(@ref,'pleiades.stoa.org') or contains(@ref,'geonames.org')">
            <a>
               <xsl:attribute name="href">
                  <xsl:value-of select="@ref"/>
               </xsl:attribute>
               <xsl:apply-templates/>
            </a>
      </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="inslib-invno">
      <xsl:if test="//t:idno[@type='invNo'][string(translate(normalize-space(.),' ',''))]">
         <xsl:text> (Inv. no. </xsl:text>
         <xsl:for-each select="//t:idno[@type='invNo'][string(translate(normalize-space(.),' ',''))]">
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
               <xsl:text>, </xsl:text>
            </xsl:if>
         </xsl:for-each>
         <xsl:text>)</xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="inslib-title">
     <xsl:choose>
       <xsl:when test="//t:titleStmt/t:title/text() and number(substring(//t:publicationStmt/t:idno[@type='filename']/text(),2,5))">
         <xsl:value-of select="substring(//t:publicationStmt/t:idno[@type='filename'],1,1)"/> 
         <xsl:text>. </xsl:text>
         <xsl:value-of select="number(substring(//t:publicationStmt/t:idno[@type='filename'],2,5)) div 100"/> 
         <xsl:text>. </xsl:text>
         <xsl:value-of select="//t:titleStmt/t:title"/>
       </xsl:when>
       <xsl:when test="//t:titleStmt/t:title/text()">
         <xsl:value-of select="//t:titleStmt/t:title"/>
       </xsl:when>
       <xsl:when test="//t:sourceDesc//t:bibl/text()">
         <xsl:value-of select="//t:sourceDesc//t:bibl"/>
       </xsl:when>
       <xsl:when test="//t:idno[@type='filename']/text()">
         <xsl:value-of select="//t:idno[@type='filename']"/>
       </xsl:when>
       <xsl:otherwise>
         <xsl:text>EpiDoc example output, InsLib style</xsl:text>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:template>

 </xsl:stylesheet>
