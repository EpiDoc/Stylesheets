<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teilistbiblandbibl.xsl 1448 2008-08-07 12:58:50Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Need to find unicode for bullets, indenting -->
  
  <xsl:template match="t:listBibl">
      <xsl:apply-templates/>
  </xsl:template>
  
  
  <xsl:template match="t:bibl">
      <xsl:text>
&#xD;</xsl:text>
      <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>