<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">  
  
  <!--<xsl:template match="orig">
    <xsl:choose>
       DEPRECATED : this instance should no longer occur
            See instead <am> (teiabbrandexpan.xsl) 
      <xsl:when test="ancestor::expan and not(contains(@n, 'unresolved'))"/>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>-->
  
  <xsl:template match="t:orig[not(parent::t:choice)]//text()" priority="1">
      <xsl:value-of select="translate(., $all-grc, $grc-upper-strip)"/>
  </xsl:template>
  
  
</xsl:stylesheet>