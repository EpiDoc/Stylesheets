<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teilistbiblandbibl.xsl 1448 2008-08-07 12:58:50Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:template match="listBibl">
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>


  <xsl:template match="bibl">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

</xsl:stylesheet>
