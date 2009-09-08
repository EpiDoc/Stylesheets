<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teimilestone.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- More specific templates in teimilestone.xsl -->
  
  <xsl:template match="milestone">
    <xsl:choose>
      <xsl:when test="$leiden-style = 'ddbdp' and ancestor::div[@type = 'translation']">
        <xsl:if test="@rend = 'break'">
          <br/>
        </xsl:if>
        <sup>
          <strong>
            <xsl:value-of select="@n"/>
          </strong>
        </sup>
        <xsl:text>&#160;</xsl:text>
      </xsl:when>
      <xsl:when test="@rend = 'paragraphos'">
        <xsl:choose>
          <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:if test="not(parent::supplied)">
              <br/>
            </xsl:if>
            <xsl:text>&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <br/>
            <xsl:text>paragraphos</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
