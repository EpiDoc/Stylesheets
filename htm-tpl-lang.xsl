<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-lang.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Contains all language related named templates -->  
  
  <xsl:template name="attr-lang">
    <xsl:if test="ancestor-or-self::*[@lang]">
      <xsl:attribute name="lang">
        <xsl:value-of select="ancestor-or-self::*[@lang][1]/@lang"/>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>
  
  <!-- Idiosyncratic to InsAph - to be killed
    <xsl:template match="term">
    <span class="lang">
      <xsl:call-template name="attr-lang"/>
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->
  
</xsl:stylesheet>
