<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">

   <xsl:template match="t:choice">
       <xsl:param name="parm-apparatus-style" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
           <xsl:when test="child::t:sic and child::t:corr and starts-with($parm-leiden-style, 'edh')">
            <xsl:text>&lt;</xsl:text>
            <xsl:apply-templates select="t:corr"/>
            <xsl:text>=</xsl:text>
             <xsl:value-of select="translate(t:sic, $all-grc, $grc-upper-strip)"/>
            <xsl:text>&gt;</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>

      <!-- Found in [htm|txt]-tpl-apparatus -->
      <xsl:if
          test="$parm-apparatus-style = 'ddbdp' and ((child::t:sic and child::t:corr) or (child::t:orig and child::t:reg))">
         <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
