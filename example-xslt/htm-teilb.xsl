<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teilb.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Actual display and increment calculation found in teilb.xsl -->
  <xsl:import href="teilb.xsl"/>

  <xsl:template match="lb">
    <xsl:choose>
      <xsl:when test="ancestor::lg and $verse-lines = 'on'">
        <xsl:apply-imports/>
      </xsl:when>
      
      <xsl:otherwise>        
        <xsl:variable name="div-loc">
          <xsl:for-each select="ancestor::div[@type= 'textpart']">
            <xsl:value-of select="@n"/>
            <xsl:text>-</xsl:text>
          </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="line">
          <xsl:if test="@n">
            <xsl:value-of select="@n"/>
          </xsl:if>
        </xsl:variable>
        
        <xsl:if
          test="@type='worddiv' and preceding::*[1][not(local-name() = 'space' or local-name() = 'g')]">
          <xsl:text>-</xsl:text>
        </xsl:if>
        <br id="a{$div-loc}l{$line}"/>
        <xsl:choose>
          <xsl:when test="not(number(@n)) and $leiden-style = 'ddbdp'">
            <xsl:call-template name="margin-num" />
          </xsl:when>
          <xsl:when test="@n mod $line-inc = 0 and not(@n = 0)">
            <xsl:call-template name="margin-num" />
          </xsl:when>
          <xsl:when test="preceding-sibling::*[1][local-name() = 'gap'][@unit = 'line']">
            <xsl:call-template name="margin-num" />
          </xsl:when>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  
  <xsl:template name="margin-num">
    <span class="linenumber">
      <xsl:value-of select="@n"/>
    </span>
  </xsl:template>

</xsl:stylesheet>
