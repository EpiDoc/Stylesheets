<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teihead.xsl 193 2007-09-26 16:06:39Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:template match="div/head">
    <xsl:apply-templates/>
    <xsl:text>&#xA;&#xD;</xsl:text>
  </xsl:template>
  
</xsl:stylesheet>
