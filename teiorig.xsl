<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">  
  
    <xsl:template match="t:orig" priority="1">
        <xsl:choose>
            <xsl:when test="parent::t:choice"><xsl:apply-templates/></xsl:when>
            <xsl:otherwise>
                <xsl:variable name="origChildren">
                    <xsl:apply-templates/>                    
                </xsl:variable>
                <!-- Emit all uppercase characters for all text children of t:orig -->
                <xsl:value-of select="translate($origChildren, $all-grc, $grc-upper-strip)"/>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
  
</xsl:stylesheet>