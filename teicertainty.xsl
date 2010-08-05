<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teichoice.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t"  version="1.0">

   <xsl:template match="t:certainty">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:text>(?)</xsl:text>
         </xsl:when>
         <xsl:when test="@match='..'">
            <xsl:text>?</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>?</xsl:text>
            <xsl:message>no template in teicertainty.xsl for your use of certainty</xsl:message>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
