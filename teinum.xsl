<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teinum.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">  
  <!-- latinnum span added in htm-teinum.xsl -->
  
  <xsl:template match="t:num[child::node()]">
      <xsl:choose>
         <xsl:when test="ancestor::t:*[@xml:lang][1][@xml:lang = 'grc'] and not($leiden-style = 'ddbdp')">
            <xsl:if test="@value &gt;= 1000">
               <xsl:text>͵</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:if test="not(@value mod 1000 = 0)">
               <xsl:text>´</xsl:text>
            </xsl:if>
         </xsl:when>
      
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:apply-templates/>
<!--            <xsl:if test="contains(@value, '/') and not(@value = '1/2' or @value = '2/3' or @value = '3/4')">-->
            <xsl:if test="@rend='fraction'">
               <xsl:text>´</xsl:text>
            </xsl:if>
         </xsl:when>
      
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>