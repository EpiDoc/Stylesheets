<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teihandshift.xsl 1448 2008-08-07 12:58:50Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">

  <xsl:template match="t:handShift">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:text>(hand </xsl:text>
            <xsl:value-of select="substring-after(@new, 'm')"/>
            <xsl:text>)</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>