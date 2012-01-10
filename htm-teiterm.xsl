<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  <xsl:template match="t:term">
      <xsl:choose>
      <!-- Adds caption for hgv translations -->
      <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and ancestor::t:div[@type = 'translation'] and @target">
            <xsl:variable name="lang" select="ancestor::t:div[@type = 'translation']/@xml:lang"/>
            <xsl:variable name="term" select="@target"/>
        
            <xsl:choose>
               <xsl:when test="ancestor::t:lem">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                    <xsl:when test="document($hgv-gloss)//t:item[@xml:id = $term]/t:gloss[@xml:lang = $lang]/text()"><span class="term">
                    <xsl:apply-templates/>
                    <span class="gloss" style="display:none"><xsl:value-of select="document($hgv-gloss)//t:item[@xml:id = $term]/t:gloss[@xml:lang = $lang]"/></span>                 
                    </span></xsl:when>
                    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
      
      
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
    
  </xsl:template>
</xsl:stylesheet>