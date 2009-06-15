<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teiq.xsl 217 2007-10-02 13:34:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="q">
    <xsl:choose>
      <xsl:when test="$leiden-style = 'ddbdp'">
        <xsl:text>'</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>'</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
