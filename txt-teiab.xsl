<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="2.0">

  <xsl:template match="t:ab">
      <xsl:text>
</xsl:text>
      <xsl:apply-templates/>
      <!-- if next div or ab begins with lb[inWord], then add hyphen -->
      <xsl:if test="following::t:lb[1][@type='inWord'] and not($edition-type='diplomatic')">
          <xsl:text>-</xsl:text>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
