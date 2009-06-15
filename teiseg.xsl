<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teiseg.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- seg[@type='autopsy'] span added in htm-teiseg.xsl -->
  
  <xsl:template match="seg">
    <xsl:apply-templates/>
    <!-- Found in tpl-certlow.xsl -->
    <xsl:call-template name="cert-low"/>
  </xsl:template>

</xsl:stylesheet>
