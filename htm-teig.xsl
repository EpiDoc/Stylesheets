<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teig.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <!-- Import templates can be found in teig.xsl -->
  <xsl:import href="teig.xsl"/>

  <xsl:template match="g">
    <xsl:call-template name="lb-dash" />
    <xsl:call-template name="w-space" />
    
    <xsl:choose>
      <xsl:when test="$leiden-style = 'ddbdp'">
        <!-- Found in teig.xsl -->
        <xsl:call-template name="g-ddbdp" />
      </xsl:when>
      <xsl:when test="$leiden-style = 'london'">
        <xsl:call-template name="g-london" />
      </xsl:when>
      <xsl:when test="$edition-type = 'diplomatic'">
        <xsl:text> </xsl:text>
        <em>
          <span class="smaller">
            <xsl:apply-imports/>
          </span>
        </em>
        <xsl:text> </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <i>
          <xsl:apply-imports/>
        </i>
      </xsl:otherwise>
    </xsl:choose>
    
    <xsl:call-template name="w-space" />
  </xsl:template>

</xsl:stylesheet>
