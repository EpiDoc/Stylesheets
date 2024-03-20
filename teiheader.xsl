<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">

   <xsl:template match="t:teiHeader"/>
  
   <!-- The template below clashed with and so has been merged with one in htm-teifacsimile.xsl 2024-03-20 -->
   <!--<xsl:template match="t:facsimile">
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      <xsl:choose>
         <xsl:when test="$parm-edn-structure='medcyprus'"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>-->

</xsl:stylesheet>