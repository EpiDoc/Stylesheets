<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teinote.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Imported from [htm|txt]-teinote.xsl -->

  <xsl:template match="note">
    <xsl:text>(</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
  </xsl:template>


</xsl:stylesheet>
