<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">

  <xsl:template match="text()[not(ancestor::t:note)]">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic' and ancestor::t:div[@type='edition'] and not(ancestor::t:head)">
            <xsl:variable name="apos">
               <xsl:text><![CDATA[']]></xsl:text>
            </xsl:variable>
            <xsl:value-of select="translate(translate(translate(.,$apos,''), '··&#xA; ,.;‘’', ''), $all-grc, $grc-upper-strip)"/>
         </xsl:when>
         <xsl:when test="$leiden-style='edh-names' and 
            normalize-space(.) = '' and 
            following-sibling::t:*[1][local-name()='w'][@lemma='filius' or @lemma='libertus' or @lemma='filia' or @lemma='liberta'] and
            preceding-sibling::t:*[1][descendant-or-self::t:expan]"/>
         <xsl:otherwise>
            <xsl:if test="matches(., '^\s.')">
               <xsl:text> </xsl:text>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
            <xsl:if test="matches(.,'\s$') and not(local-name(following-sibling::t:*[1]) = 'lb')">
               <!--<xsl:if test="substring(., string-length(.)) = ' ' and not(local-name(following-sibling::t:*[1]) = 'lb')">-->
               <xsl:text> </xsl:text>
            </xsl:if>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>