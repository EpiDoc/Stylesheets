<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  <xsl:template match="t:ab">
      <div class="textpart">
         <xsl:if test="$leiden-style='iospe'">
            <xsl:variable name="div-loc">
               <xsl:for-each select="ancestor::t:div[@type='textpart']">
                  <xsl:value-of select="@n"/>
                  <xsl:text>-</xsl:text>
               </xsl:for-each>
            </xsl:variable>
            <xsl:attribute name="id">
               <xsl:value-of select="concat('div',$div-loc)"/>
            </xsl:attribute>
         </xsl:if>
         <xsl:apply-templates/>
         <!-- if next div or ab begins with lb[break=no], then add hyphen -->
         <xsl:if test="following::t:lb[1][@break='no' or @type='inWord'] and not($edition-type='diplomatic')">
            <xsl:text>-</xsl:text>
         </xsl:if>
      </div>
  </xsl:template>

</xsl:stylesheet>