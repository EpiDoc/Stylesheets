<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">
  
  
  <xsl:template match="t:div/t:head">
      <h2>
         <xsl:apply-templates/>
      </h2>
  </xsl:template>
  
</xsl:stylesheet>