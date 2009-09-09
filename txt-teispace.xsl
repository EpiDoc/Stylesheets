<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teispace.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">

  <xsl:template name="space-content">
      <xsl:param name="vacat"/>
      <xsl:choose>
         <xsl:when test="$leiden-style = 'london'">
        <!-- Found in teispace.xsl -->
        <xsl:call-template name="space-content-1">
               <xsl:with-param name="vacat" select="t:$vacat"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
        <!-- Found in teispace.xsl -->
        <xsl:call-template name="space-content-2">
               <xsl:with-param name="vacat" select="t:$vacat"/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  <xsl:template name="dip-space">
      <xsl:call-template name="space-content-1">
         <xsl:with-param name="vacat" select="'vacat '"/>
      </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>