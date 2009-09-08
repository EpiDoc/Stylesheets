<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teiab.xsl 178 2007-09-24 15:00:13Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="ab">
    <xsl:text>&#xA;&#xD;</xsl:text>
    <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>
