<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teichoice.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">

  <xsl:template match="t:choice">
      <xsl:choose>
         <xsl:when test="child::t:sic and child::t:corr">
            <xsl:choose>
               <xsl:when test="starts-with($leiden-style, 'edh')">
                  <xsl:text>&lt;</xsl:text>
                  <xsl:apply-templates select="t:corr"/>
                  <xsl:text>=</xsl:text>
                  <xsl:value-of select="translate(t:sic, $all-grc, $grc-upper-strip)"/>
                  <xsl:text>&gt;</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
    
      <!-- Found in [htm|txt]-tpl-apparatus -->
     <xsl:if test="$apparatus-style = 'ddbdp' and ((child::t:sic and child::t:corr) or (child::t:orig and child::t:reg))">
         <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>

</xsl:stylesheet>