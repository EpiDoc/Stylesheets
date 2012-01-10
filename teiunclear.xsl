<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">

   <xsl:template match="t:unclear">
      <xsl:param name="text-content">
         <xsl:choose>
            <xsl:when test="ancestor::t:orig[not(ancestor::t:choice)]">
               <xsl:value-of select="translate(., $all-grc, $grc-upper-strip)"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="."/>
            </xsl:otherwise>
         </xsl:choose>
      </xsl:param>

      <xsl:choose>
         <xsl:when test="starts-with($leiden-style, 'edh')">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="$edition-type = 'diplomatic'">
            <!-- Calculates the number of middots to output -->
            <xsl:variable name="unclear-length">
               <!-- collects all children text together -->
               <xsl:variable name="un-len-text">
                  <xsl:for-each select="text()">
                     <xsl:value-of select="."/>
                  </xsl:for-each>
               </xsl:variable>
               <!-- Outputs an 'a' per child <g> -->
               <xsl:variable name="un-len-g">
                  <xsl:for-each select="t:g">
                     <xsl:text>a</xsl:text>
                  </xsl:for-each>
               </xsl:variable>
               <xsl:value-of select="string-length($un-len-text) + string-length($un-len-g)"/>
            </xsl:variable>

            <xsl:call-template name="middot">
               <xsl:with-param name="unc-len" select="$unclear-length"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="t:g">
                  <xsl:apply-templates/>
                  <!-- templates (including tests for parent::unclear) are in teig.xsl -->
               </xsl:when>
               <xsl:otherwise>
                  <xsl:call-template name="subpunct">
                     <xsl:with-param name="unc-len" select="string-length($text-content)"/>
                     <xsl:with-param name="abs-len" select="string-length($text-content)+1"/>
                     <xsl:with-param name="text-content" select="$text-content"/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template name="middot">
      <xsl:param name="unc-len"/>

      <xsl:if test="not($unc-len = 0)">
         <xsl:text>·</xsl:text>
         <xsl:call-template name="middot">
            <xsl:with-param name="unc-len" select="$unc-len - 1"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>

   <xsl:template name="subpunct">
      <xsl:param name="abs-len"/>
      <xsl:param name="unc-len"/>
      <xsl:param name="text-content"/>
      <xsl:if test="$unc-len!=0">
         <xsl:value-of select="substring($text-content, number($abs-len - $unc-len),1)"/>
         <xsl:text>̣</xsl:text>
         <xsl:call-template name="subpunct">
            <xsl:with-param name="unc-len" select="$unc-len - 1"/>
            <xsl:with-param name="abs-len" select="string-length($text-content)+1"/>
            <xsl:with-param name="text-content" select="$text-content"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
