<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teinote.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Template in teinote.xsl -->
  <xsl:import href="teinote.xsl"/>
  
  <xsl:template match="note">
    <xsl:choose>
      <xsl:when test="ancestor::p or ancestor::l or ancestor::ab">
        <xsl:apply-imports/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&#xA;&#xD;</xsl:text>
        <xsl:apply-imports/>
        <xsl:text>&#xA;&#xD;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
