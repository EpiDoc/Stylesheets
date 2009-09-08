<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teilgandl.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- template line-context can be found in teilgandl.xsl -->
  <xsl:include href="teilgandl.xsl"/>

  <xsl:template match="lg">
    <xsl:apply-templates/>
  </xsl:template>


  <xsl:template match="l">
    <xsl:choose>
      <xsl:when test="$verse-lines = 'yes'">
        <xsl:text>&#xA;&#xD;</xsl:text>
        <xsl:choose>
          <xsl:when test="@n mod $line-inc = 0 and not(@n = 0)">
          <xsl:text>&#x9;</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>&#x9;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#x9;&#x9;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <!-- found in teilgandl.xsl -->
        <xsl:call-template name="line-context"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>

  </xsl:template>

</xsl:stylesheet>
