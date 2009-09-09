<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teihead.xsl 193 2007-09-26 16:06:39Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  
  
  <xsl:template match="t:div/t:head">
      <h2>
         <xsl:apply-templates/>
      </h2>
  </xsl:template>
  
</xsl:stylesheet>