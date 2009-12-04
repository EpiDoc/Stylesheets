<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teiabbrandexpan.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Contains templates for expan and abbr -->

  <xsl:template match="t:expan">
      <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="t:abbr">
      <xsl:apply-templates/>
      <xsl:if test="not(ancestor::t:expan)">
         <xsl:text>(</xsl:text>
         <xsl:choose>
            <xsl:when test="$leiden-style = 'ddbdp'">
               <xsl:text> </xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>- - -</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
         <xsl:text>)</xsl:text>
         <xsl:if test="$leiden-style = 'ddbdp'">
        <!-- Found in tpl-certlow.xsl -->
        <xsl:call-template name="cert-low"/>
         </xsl:if>
      </xsl:if>
  </xsl:template>
  
  <xsl:template match="t:ex">
      <xsl:choose>
         <xsl:when test="$edition-type = 'interpretive'">
            <xsl:text>(</xsl:text>
            <xsl:apply-templates/>
            <!-- Found in tpl-certlow.xsl -->
        <xsl:call-template name="cert-low"/>
            <xsl:if test="$leiden-style='london' and ancestor::node()[@part='M' or @part='I']
               and last()">
               <xsl:text>-</xsl:text>
            </xsl:if>
            <xsl:text>)</xsl:text>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:am">
      <xsl:choose>
         <xsl:when test="$edition-type = 'interpretive'"/>
         <xsl:when test="$edition-type = 'diplomatic'">
            <xsl:apply-templates/>
         </xsl:when>
      </xsl:choose>

  </xsl:template>

</xsl:stylesheet>