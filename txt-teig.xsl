<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teig.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  
  <!-- Import templates can be found in teig.xsl -->
  <xsl:import href="teig.xsl"/>

  <xsl:template match="t:g">
      <xsl:call-template name="lb-dash"/>
      <xsl:call-template name="w-space"/>

      <xsl:choose>
         <xsl:when test="starts-with($leiden-style, 'edh')"/>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:call-template name="g-ddbdp"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-imports/>
         </xsl:otherwise>
      </xsl:choose>
    
      <!-- Found in teig.xsl -->
    <xsl:call-template name="w-space"/>
  </xsl:template>

</xsl:stylesheet>