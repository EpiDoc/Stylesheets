<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- General template in [htm|txt]teimilestone.xsl -->

  <xsl:template match="t:milestone[@unit='block']">
     <!-- adds pipe for block, flanked by spaces if not within word -->
      <xsl:if test="not(ancestor::w)">
         <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:text>|</xsl:text>
      <xsl:if test="not(ancestor::w)">
         <xsl:text> </xsl:text>
      </xsl:if>
  </xsl:template>

  <xsl:template match="t:milestone[@rend = 'box']">
     <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"></xsl:param>
     <xsl:if test="$parm-internal-app-style = 'ddbdp'">
      <!-- Adds links/indication to apparatus - found in [htm|txt]-tpl-apparatus -->
      <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>
</xsl:stylesheet>