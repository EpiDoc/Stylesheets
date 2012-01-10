<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-lang.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Contains all language related named templates -->  
   
   <xsl:template name="london-structure">
      <xsl:call-template name="default-structure"/>
   </xsl:template>
   
   
   <xsl:template name="hgv-structure">
      <html>
         <head>
            <title>
               <xsl:choose>
                  <xsl:when test="//t:sourceDesc//t:bibl/text()">
                     <xsl:value-of select="//t:sourceDesc//t:bibl"/>
                  </xsl:when>
                  <xsl:when test="//t:idno[@type='filename']/text()">
                     <xsl:value-of select="//t:idno[@type='filename']"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:text></xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </title>
            <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
            <!-- Found in htm-tpl-cssandscripts.xsl -->
            <xsl:call-template name="css-script"/>
         </head>
         <body>
            
            <!-- Heading for a ddb style file -->
            <xsl:if test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
               <h1>
                  <xsl:choose>
                     <xsl:when test="//t:sourceDesc//t:bibl/text()">
                        <xsl:value-of select="//t:sourceDesc//t:bibl"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="//t:idno[@type='filename']"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </h1>
            </xsl:if>         
            
            <!-- Main text output -->
            <xsl:apply-templates/>
            
            <!-- Found in htm-tpl-license.xsl -->
            <xsl:call-template name="license"/>
            
         </body>
      </html>
   </xsl:template>
   
   <xsl:template name="default-structure">
      <html>
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

   <xsl:template name="default-body-structure">
      <!-- Heading for a ddb style file -->
      <xsl:if test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
         <h1>
            <xsl:choose>
               <xsl:when test="//t:sourceDesc//t:bibl/text()">
                  <xsl:value-of select="//t:sourceDesc//t:bibl"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="//t:idno[@type='filename']"/>
               </xsl:otherwise>
            </xsl:choose>
         </h1>
      </xsl:if>         
      
      <!-- Main text output -->
      <xsl:variable name="maintxt">
         <xsl:apply-templates/>
      </xsl:variable>
      
      <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
      <xsl:apply-templates select="$maintxt" mode="sqbrackets"/>
      
      <!-- Found in htm-tpl-license.xsl -->
      <xsl:call-template name="license"/>
   </xsl:template>
   
</xsl:stylesheet>
