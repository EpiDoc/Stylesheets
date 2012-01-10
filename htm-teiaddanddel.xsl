<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">
   <!--  templates for subst, add and del found in teiaddanddel.xsl-->
   <xsl:import href="teiaddanddel.xsl"/>

   <xsl:template match="t:subst">
      <xsl:apply-imports/>
   </xsl:template>


   <xsl:template match="t:add">
      <xsl:choose>
         <!-- \* these rules deprecated, but not deleting them just yet in case they come in handy */
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and @place='above'">
            <span style="vertical-align:super;">
               <xsl:apply-imports/>
            </span>
         </xsl:when>
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and @place='below'">
            <span style="vertical-align:sub;">
               <xsl:apply-imports/>
            </span>
         </xsl:when>-->
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and @place='interlinear'">
            <span style="font-size:smaller;">
               <xsl:apply-imports/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-imports/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template match="t:del">
      <xsl:apply-imports/>
   </xsl:template>

</xsl:stylesheet>
