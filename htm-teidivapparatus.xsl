<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teidivedition.xsl 2090 2013-10-24 15:23:22Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   
   <!-- only triggered if there is a <div type="apparatus"> (i.e. "external appartus") in the XML -->

   <!--<xsl:import href="teidivapparatus.xsl"/>-->

   <!-- Other div matches can be found in htm-teidiv.xsl -->

   <xsl:template match="t:div[@type = 'apparatus']" priority="1">
      
   </xsl:template>
   
   <xsl:template match="t:div[@type = 'apparatus']//t:app">
      
   </xsl:template>
   
   <xsl:template match="t:div[@type = 'apparatus']//t:rdg">
      
   </xsl:template>
   


</xsl:stylesheet>
