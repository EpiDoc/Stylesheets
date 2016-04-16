<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">  
  
  <xsl:template match="t:orig[not(parent::t:choice)]//text()" priority="1">
      <xsl:value-of select="upper-case(translate(normalize-unicode(translate(.,'&#x03f2;','&#x03f9;'),'NFD'),'&#x0300;&#x0301;&#x0308;&#x0313;&#x0314;&#x0342;&#x0345;',''))"/>
      <!--<xsl:value-of select="translate(., $all-grc, $grc-upper-strip)"/>-->
  </xsl:template>
  
  
</xsl:stylesheet>