<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teinum.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Template in teinum.xsl -->
  <xsl:import href="teinum.xsl"/>
  
  <xsl:template match="num">
    <xsl:choose>
      <xsl:when test="ancestor::*[@lang][1][@lang = 'la']">
        <span class="latinnum">
          <xsl:apply-imports />
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-imports />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
