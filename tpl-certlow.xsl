<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: tpl-certlow.xsl 1448 2008-08-07 12:58:50Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">
  <!-- Called by different elements -->
  
  <xsl:template name="cert-low">
      <xsl:if test="@cert='low' and $edition-type != 'diplomatic'">
         <xsl:text>(?)</xsl:text>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>