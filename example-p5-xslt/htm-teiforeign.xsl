<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  <xsl:template match="t:foreign">
      <span class="lang">
      <!-- Found in htm-tpl-lang.xsl -->
      <xsl:call-template name="attr-lang"/>
         <xsl:apply-templates/>
      </span>
  </xsl:template>
  
</xsl:stylesheet>