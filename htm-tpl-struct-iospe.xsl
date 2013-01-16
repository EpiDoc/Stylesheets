<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-iospe.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains named templates for IOSPE file structure (aka "metadata" aka "supporting data") -->  
   
   <!-- Called from htm-tpl-structure.xsl -->
   
   <xsl:template name="iospe-structure"><html>
      <head>
         <title>
            <xsl:choose>
               <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
                  <xsl:choose>
                     <xsl:when test="//t:sourceDesc//t:bibl/text()">
                        <xsl:value-of select="//t:sourceDesc//t:bibl"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="//t:idno[@type='filename']"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when test="//t:titleStmt/t:title/text()">
                  <xsl:if test="//t:idno[@type='filename']/text()">
                     <xsl:value-of select="//t:idno[@type='filename']"/>
                     <xsl:text>. </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="//t:titleStmt/t:title"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>EpiDoc example output, default style</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </title>
         <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
         <!-- Found in htm-tpl-cssandscripts.xsl -->
         <xsl:call-template name="css-script"/>
      </head>
      <body>
         <xsl:call-template name="default-body-structure"/>
      </body>
   </html>
   </xsl:template>
   
   </xsl:stylesheet>
