<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Called from teisupplied.xsl -->

  <xsl:template name="supplied-parallel">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="$parm-leiden-style = 'dclp'">⎣<xsl:apply-templates/>⎦</xsl:when>
          <xsl:otherwise><span class="underline"><xsl:apply-templates/></span></xsl:otherwise>
      </xsl:choose>
      
  </xsl:template>

</xsl:stylesheet>