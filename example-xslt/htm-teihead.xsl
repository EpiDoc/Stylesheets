<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teihead.xsl 193 2007-09-26 16:06:39Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  
  <xsl:template match="div/head">
    <h2>
      <xsl:apply-templates/>
    </h2>
  </xsl:template>
  
</xsl:stylesheet>
