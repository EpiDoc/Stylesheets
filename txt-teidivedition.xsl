<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teidivedition.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- General div match found in txt-teidiv.xsl -->

  <xsl:template match="div[@type = 'edition']" priority="1">
    <!-- Two line breaks to give space -->
    <xsl:text>&#xA;&#xD;&#xA;&#xD;</xsl:text>
    <xsl:apply-templates/>
    
    <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
    <xsl:if test="$apparatus-style = 'ddbdp'">
      <!-- Framework found in txt-tpl-apparatus.xsl -->
      <xsl:call-template name="tpl-apparatus"/>
    </xsl:if>
  </xsl:template>


  <xsl:template match="div[starts-with(@type, 'textpart')]" priority="1">
    <xsl:text>&#xA;&#xD;</xsl:text>
    <xsl:value-of select="@n"/>
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
