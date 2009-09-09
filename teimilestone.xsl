<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teimilestone.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- General template in [htm|txt]teimilestone.xsl -->

  <xsl:template match="t:milestone[@unit='block']">
      <xsl:if test="not(ancestor::w)">
         <xsl:text> </xsl:text>
      </xsl:if>
      <xsl:text>|</xsl:text>
      <xsl:if test="not(ancestor::w)">
         <xsl:text> </xsl:text>
      </xsl:if>
  </xsl:template>

  <xsl:template match="t:milestone[@rend = 'box']">
      <xsl:if test="$apparatus-style = 'ddbdp'">
      <!-- Adds links/indication to apparatus - found in [htm|txt]-tpl-apparatus -->
      <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>
</xsl:stylesheet>