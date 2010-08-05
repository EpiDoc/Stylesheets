<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-lang.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">
  <!-- Contains all language related named templates -->  
  
  <xsl:template name="attr-lang">
      <xsl:if test="ancestor-or-self::t:*[@xml:lang]">
         <xsl:attribute name="xml:lang">
            <xsl:value-of select="ancestor-or-self::t:*[@xml:lang][1]/@xml:lang"/>
         </xsl:attribute>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>