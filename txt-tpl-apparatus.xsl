<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-tpl-apparatus.xsl 1448 2008-08-07 12:58:50Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
  <xsl:include href="tpl-apparatus.xsl"/>
  
  <!-- Apparatus framework -->
  <xsl:template name="tpl-apparatus">
    <!-- An apparatus is only created if one of the following is true -->
    <xsl:if test=".//t:choice[child::t:sic and child::t:corr] | .//t:subst | .//t:app |        
       .//t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'] |
       .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">
      
         <xsl:text>

Apparatus

</xsl:text>
         <!-- An entry is created for-each of the following instances -->
      <xsl:for-each select=".//t:choice[child::t:sic and child::t:corr] | .//t:subst | .//t:app |
         .//t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'] |
         .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">
        
            <xsl:call-template name="app-link">
               <xsl:with-param name="location" select="'apparatus'"/>
            </xsl:call-template>
        
            <!-- Found in tpl-apparatus.xsl -->
        <xsl:call-template name="ddbdp-app"/>
        
            <!-- Only creates a new line if the following is not true -->
        <xsl:if test="not(descendant::t:choice[child::t:sic and child::t:corr] | descendant::t:subst | descendant::t:app)">
               <xsl:text>
&#xD;</xsl:text>
            </xsl:if>
         </xsl:for-each>
         <!-- End of apparatus -->
      <xsl:text>
&#xD;
&#xD;</xsl:text>
      </xsl:if>
  </xsl:template>

  <!-- Used in txt-{element} and above to indicate apparatus -->
  <xsl:template name="app-link">
    <!-- location defines the direction of linking -->
    <xsl:param name="location"/>
    
      <!-- Only produces an indicator if it is not nested in an element that would be in apparatus -->
    <xsl:if test="not(ancestor::t:choice[child::t:sic and child::t:corr] or ancestor::t:subst or ancestor::t:app or        ancestor::t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'] |       ancestor::t:del[@rend='slashes' or @rend='cross-strokes'])">
         <xsl:choose>
            <xsl:when test="$location = 'text'">
               <xsl:text>(*)</xsl:text>
            </xsl:when>
            <xsl:when test="$location = 'apparatus'">
               <xsl:text>^</xsl:text>
               <xsl:text> </xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>