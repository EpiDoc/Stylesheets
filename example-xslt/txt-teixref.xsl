<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teixref.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
  <xsl:include href="teixref.xsl"/>

  <xsl:template match="xref">
    <xsl:choose>
      <xsl:when test="@type = 'reprint from'">
        <xsl:text>&#xA;&#xD;</xsl:text>
        <!-- Found in teixref.xsl -->
        <xsl:call-template name="reprint-text">
          <xsl:with-param name="direction" select="'from'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@type = 'reprint in'">
        <xsl:text>&#xA;&#xD;</xsl:text>
        <!-- Found in teixref.xsl -->
        <xsl:call-template name="reprint-text">
          <xsl:with-param name="direction" select="'in'"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="link-text">
    <xsl:param name="href-link"/>
    <xsl:param name="val-doc"/>

    <xsl:value-of select="$val-doc"/>
  </xsl:template>

</xsl:stylesheet>
