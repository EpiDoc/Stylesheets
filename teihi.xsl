<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t"  version="1.0">
   <!-- html hi part of transformation in htm-teihi.xsl -->

   <xsl:template match="t:hi">
      <xsl:choose>
         <xsl:when
            test="@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'">
            <xsl:apply-templates/>
            <xsl:if test="$apparatus-style = 'ddbdp'">
               <!-- found in [htm|txt]-tpl-apparatus.xsl -->
               <xsl:call-template name="app-link">
                  <xsl:with-param name="location" select="'text'"/>
               </xsl:call-template>
            </xsl:if>
         </xsl:when>
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
            <xsl:choose>
               <xsl:when test="@rend='superscript'">
                  <xsl:text>\</xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text>/</xsl:text>
               </xsl:when>
               <xsl:when test="@rend='subscript'">
                  <xsl:text>/</xsl:text>
                  <xsl:apply-templates/>
                  <xsl:text>\</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
