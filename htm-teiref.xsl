<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <xsl:include href="teiref.xsl"/>
  
  <xsl:template match="t:ref">
      <xsl:choose>
         <xsl:when test="@type = 'reprint-from'">
            <br/>
            <!-- Found in teiref.xsl -->
        <xsl:call-template name="reprint-text">
               <xsl:with-param name="direction" select="'from'"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="@type = 'reprint-in'">
            <br/>
            <!-- Found in teiref.xsl -->
        <xsl:call-template name="reprint-text">
               <xsl:with-param name="direction" select="'in'"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="@type = 'Perseus'">
            <xsl:variable name="col" select="substring-before(@href, ';')"/>
            <xsl:variable name="vol" select="substring-before(substring-after(@href,';'),';')"/>
            <xsl:variable name="no" select="substring-after(substring-after(@href,';'),';')"/>
            <a href="http://www.perseus.tufts.edu/cgi-bin/ptext?doc=Perseus:text:1999.05.{$col}:volume={$vol}:document={$no}">
               <xsl:apply-templates/>
            </a>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  

  <xsl:template name="link-text">
      <xsl:param name="href-link"/>
      <xsl:param name="val-doc"/>
    
      <a href="{$href-link}">
         <xsl:value-of select="$val-doc"/>
      </a>
  </xsl:template>
  
</xsl:stylesheet>