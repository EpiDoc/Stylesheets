<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">  
  <!-- latinnum span added in htm-teinum.xsl -->
  
  <xsl:template match="t:num[child::node()]">
      <xsl:choose>
         <xsl:when test="ancestor::t:*[@xml:lang][1][@xml:lang = 'grc'] and
            not(($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')) and
            number(@value) and not(contains(@value,'/'))">
            <xsl:if test="$edition-type='interpretive' and number(@value) and not(contains(@value,'/')) and @value &gt;= 1000">
               <xsl:text>͵</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="$edition-type='interpretive' and not(@value mod 1000 = 0)">
               <xsl:text>´</xsl:text>
            </xsl:if>
         </xsl:when>
      
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
            <xsl:apply-templates/>
            <xsl:if test="@rend='tick'">
               <xsl:text>´</xsl:text>
            </xsl:if>
         </xsl:when>
      
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>