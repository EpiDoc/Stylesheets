<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teimilestone.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- More specific templates in teimilestone.xsl -->

  <xsl:template match="t:milestone">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp' and ancestor::t:div[@type = 'translation']">
            <xsl:if test="@rend = 'break'">
               <xsl:text>
&#xD;</xsl:text>
            </xsl:if>
            <xsl:value-of select="@n"/>
            <xsl:text> </xsl:text>
         </xsl:when>
         <xsl:when test="@rend = 'paragraphos'">
            <xsl:choose>
               <xsl:when test="$leiden-style = 'ddbdp'">
                  <xsl:if test="not(parent::t:supplied)">
                     <xsl:text>
&#xD;</xsl:text>
                  </xsl:if>
                  <xsl:text>————————</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>
&#xD;</xsl:text>
                  <xsl:text>paragraphos</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>