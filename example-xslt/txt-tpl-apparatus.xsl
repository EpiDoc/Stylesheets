<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-tpl-apparatus.xsl 1448 2008-08-07 12:58:50Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
  <xsl:include href="tpl-apparatus.xsl"/>
  
  <!-- Apparatus framework -->
  <xsl:template name="tpl-apparatus">
    <!-- An apparatus is only created if one of the following is true -->
    <xsl:if
      test=".//choice[child::sic and child::corr] | .//subst | .//app | 
      .//hi[@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'] |
      .//del[@rend='slashes' or @rend='cross-strokes'] | .//milestone[@rend = 'box']">
      
      <xsl:text>Apparatus&#xA;&#xD;</xsl:text>
      <!-- An entry is created for-each of the following instances -->
      <xsl:for-each
        select=".//choice[child::sic and child::corr] | .//subst | .//app | 
        .//hi[@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'] |
        .//del[@rend='slashes' or @rend='cross-strokes'] | .//milestone[@rend = 'box']">
        
        <xsl:call-template name="app-link">
          <xsl:with-param name="location" select="'apparatus'"/>
        </xsl:call-template>
        
        <!-- Found in tpl-apparatus.xsl -->
        <xsl:call-template name="ddbdp-app"/>
        
        <!-- Only creates a new line if the following is not true -->
        <xsl:if test="not(descendant::choice[child::sic and child::corr] | descendant::subst | descendant::app)">
          <xsl:text>&#xA;&#xD;</xsl:text>
        </xsl:if>
      </xsl:for-each>
      <!-- End of apparatus -->
      <xsl:text>&#xA;&#xD;&#xA;&#xD;</xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- Used in txt-{element} and above to indicate apparatus -->
  <xsl:template name="app-link">
    <!-- location defines the direction of linking -->
    <xsl:param name="location" />
    
    <!-- Only produces an indicator if it is not nested in an element that would be in apparatus -->
    <xsl:if
      test="not(ancestor::choice[child::sic and child::corr] or ancestor::subst or ancestor::app or 
      ancestor::hi[@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'] |
      ancestor::del[@rend='slashes' or @rend='cross-strokes'])">
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
