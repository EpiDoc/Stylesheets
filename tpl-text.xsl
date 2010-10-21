<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">

  <xsl:template match="text()[not(ancestor::t:note)]">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic' and ancestor::t:div[@type='edition'] and not(ancestor::t:head)">
            <xsl:variable name="apos">
               <xsl:text><![CDATA[']]></xsl:text>
            </xsl:variable>
            <xsl:value-of select="translate(translate(translate(.,$apos,''), '··&#xA; ,.;‘’', ''), $all-grc, $grc-upper-strip)"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:if test="starts-with(., ' ') and string-length(.) &gt; 1">
               <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="substring(., string-length(.)) = ' ' and not(local-name(following-sibling::*[1]) = 'lb')">
               <xsl:text> </xsl:text>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>