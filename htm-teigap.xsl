<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teigap.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Imported templates can be found in teigap.xsl -->
  <xsl:import href="teigap.xsl"/>
  
  <xsl:template match="t:gap[@reason = 'lost']">
      <xsl:if test="@extent='unknown' and @reason='lost' and @unit='line' and $leiden-style = 'ddbdp' 
         and not(preceding-sibling::t:*[1][local-name() = 'lb'])">
         <!--     adds a newline character before gap-extent-line in DDbDP unless <lb/> present    -->
         <br/>
      </xsl:if>
      <xsl:apply-imports/>
  </xsl:template>
  
</xsl:stylesheet>