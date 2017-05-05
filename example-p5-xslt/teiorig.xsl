<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">  
  
    
    <xsl:template match="t:orig[not(parent::t:choice)]//text()" priority="1">
        <xsl:value-of select="translate(., $all-grc, $grc-upper-strip)"/>
    </xsl:template>
    
    <!--
    <xsl:template match="t:orig[not(parent::t:choice)]" priority="1">
        <xsl:variable name="origChildren">
            <xsl:apply-templates/>                    
        </xsl:variable>
        <xsl:value-of select="translate($origChildren, $all-grc, $grc-upper-strip)"/>
    </xsl:template>
  -->
</xsl:stylesheet>