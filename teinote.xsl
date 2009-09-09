<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teinote.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Imported from [htm|txt]-teinote.xsl -->

  <xsl:template match="t:note">
      <xsl:text>(</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>)</xsl:text>
  </xsl:template>


</xsl:stylesheet>