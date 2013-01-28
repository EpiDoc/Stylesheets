<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-inslib.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains named templates for InsLib file structure (aka "metadata" aka "supporting data") -->  
   
   <!-- Called from htm-tpl-structure.xsl -->
   
   <xsl:template name="inslib-structure">
      <xsl:variable name="title">
         <xsl:choose>
            <xsl:when test="//t:titleStmt/t:title/text()">
               <xsl:if test="//t:idno[@type='filename']/text()">
                  <xsl:value-of
                     select="number(//t:idno[@type='filename'])"/>
                  <xsl:text>. </xsl:text>
               </xsl:if>
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
              
               <p><b>Description:</b>
               <xsl:choose>
                     <xsl:when test="//t:support/t:p/text()">
                        <xsl:apply-templates select="//t:support/t:p" mode="inslib-dimensions"/>
                     </xsl:when>
                     <xsl:otherwise>Unknown</xsl:otherwise>
                  </xsl:choose>
                  
                  
               <br />
                  <b>Text:</b>
               <xsl:choose>
                  <xsl:when test="//t:layoutDesc/t:layout//text()">
                        <xsl:value-of select="//t:layoutDesc/t:layout"/>
                  </xsl:when>
                  <xsl:otherwise>Unknown.</xsl:otherwise>
               </xsl:choose>
                  <br />
                  <b>Letters:</b>
                     <xsl:if test="//t:handDesc/t:handNote/text()">
                        <xsl:value-of select="//t:handDesc/t:handNote"/>
                     </xsl:if>
               </p>
               
               <p><b>Date:</b>
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
               
               <p><b>Findspot:</b>
               <xsl:choose>
                  <xsl:when test="//t:provenance[@type='found']/text()">
                        <xsl:apply-templates select="//t:provenance[@type='found']" mode="inslib-placename"/>
                  </xsl:when>
                  <xsl:otherwise>Unknown</xsl:otherwise>
               </xsl:choose>
                  <br/>
                  <b>Original Location:</b>
                  <xsl:choose>
                     <xsl:when test="//t:origin/t:origPlace/text()">
                        <xsl:apply-templates select="//t:origin/t:origPlace" mode="inslib-placename"/>
                     </xsl:when>
                     <xsl:otherwise>Unknown</xsl:otherwise>
                  </xsl:choose>
                  <br/>
                  <b>Last recorded location:</b>
                  <xsl:choose>
                     <xsl:when test="//t:provenance[@type='observed']/text()">
                        <xsl:apply-templates select="//t:provenance[@type='observed']" mode="inslib-placename"/>
                     </xsl:when>
                     <xsl:otherwise>Unknown</xsl:otherwise>
                  </xsl:choose>
               </p>
            
               <div><b>Translation:</b>
                  <xsl:apply-templates select="//t:div[@type='translation']"/>
               </div>
            <div>
                  <b>Commentary:</b>
                  <xsl:apply-templates select="//t:div[@type='commentary']"/>
               </div>
            
               <p><b>Bibliography:</b>
               <xsl:apply-templates select="//t:div[@type='bibliography']"/> 
                  <br/>
                 <b>Text constituted from:</b>
                  <xsl:apply-templates select="//t:creation"/>
               </p>            
               
         </body>
      </html>
   </xsl:template>
   
   <xsl:template match="t:dimensions" mode="inslib-dimensions">
      <xsl:if test="text()">
         <xsl:if test="t:width/text()">w: 
            <xsl:value-of select="t:width"/>
            <xsl:if test="t:height/text()">
               <xsl:text> x </xsl:text>
            </xsl:if>
         </xsl:if>
         <xsl:if test="t:height/text()">h: 
            <xsl:value-of select="t:height"/>
         </xsl:if>
         <xsl:if test="t:depth/text()">x d:
            <xsl:value-of select="t:depth"/>
         </xsl:if>
         <xsl:if test="t:dim[@type='diameter']/text()">x diam.:
            <xsl:value-of select="t:dim[@type='diameter']"/>
         </xsl:if>
      </xsl:if>
   </xsl:template>
   
   <xsl:template match="t:placeName|t:rs" mode="inslib-placename">
      <xsl:if test="contains(@ref,'pleiades.stoa.org') or contains(@ref,'geonames.org')">
            <a>
               <xsl:attribute name="href">
                  <xsl:value-of select="@ref"/>
               </xsl:attribute>
               <xsl:apply-templates/>
            </a>
      </xsl:if>
   </xsl:template>
   
   </xsl:stylesheet>
