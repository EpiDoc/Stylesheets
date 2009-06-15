<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teinum.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">  
  <!-- latinnum span added in htm-teinum.xsl -->
  
  <xsl:template match="num[child::node()]">
    <xsl:choose>
      <xsl:when test="ancestor::*[@lang][1][@lang = 'grc'] and not($leiden-style = 'ddbdp')">
        <xsl:if test="@value &gt;= 1000">
          <xsl:text>&#x0375;</xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="not(@value mod 1000 = 0)">
          <xsl:text>&#x00B4;</xsl:text>
        </xsl:if>
      </xsl:when>
      
      <xsl:when test="$leiden-style = 'ddbdp'">
        <xsl:apply-templates/>
        <xsl:if test="contains(@value, '/') and not(@value = '1/2' or @value = '2/3' or @value = '3/4')">
          <xsl:text>&#x00B4;</xsl:text>
        </xsl:if>
      </xsl:when>
      
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
</xsl:stylesheet>
