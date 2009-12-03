<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teihead.xsl 193 2007-09-26 16:06:39Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  
  <xsl:template match="t:div/t:head">
      <xsl:choose>
         <xsl:when test="starts-with($leiden-style, 'edh')"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
            <xsl:text>
&#xD;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>