<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-apparatus.xsl 1497 2008-08-12 13:51:16Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
  <xsl:include href="tpl-apparatus.xsl"/>

  <!-- Apparatus framework -->
  <xsl:template name="tpl-apparatus">
    <!-- An apparatus is only created if one of the following is true -->
    <xsl:if test=".//t:choice[child::t:sic and child::t:corr] | .//t:subst | .//t:app |
       .//t:hi[@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'] |
       .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">

         <h2>Apparatus</h2>
         <div id="apparatus">
        <!-- An entry is created for-each of the following instances -->
        <xsl:for-each select=".//t:choice[child::t:sic and child::t:corr] | .//t:subst | .//t:app |
           .//t:hi[@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'] |
           .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">

               <xsl:call-template name="app-link">
                  <xsl:with-param name="location" select="'apparatus'"/>
               </xsl:call-template>

               <!-- Found in tpl-apparatus.xsl -->
          <xsl:call-template name="ddbdp-app"/>

               <!-- Does not create newline for app, subst, choice nesting -->
          <xsl:choose>
                  <xsl:when test="local-name() = 'del'">
                     <br/>
                  </xsl:when>
                  <xsl:when test="not(descendant::t:choice[child::t:sic and child::t:corr] | descendant::t:subst | descendant::t:app)">
                     <br/>
                  </xsl:when>
               </xsl:choose>
            </xsl:for-each>
         </div>
      </xsl:if>
  </xsl:template>


  <!-- Used in htm-{element} and above to add linking to and from apparatus -->
  <xsl:template name="app-link">
    <!-- location defines the direction of linking -->
    <xsl:param name="location"/>
      <!-- Does not produce links for translations -->
    <xsl:if test="not(ancestor::t:div[@type = 'translation'])">
      <!-- Only produces a link if it is not nested in an element that would be in apparatus -->
      <xsl:if test="not((local-name() = 'choice' or local-name() = 'subst' or local-name() = 'app')
         and (ancestor::t:choice[child::t:sic and child::t:corr] or ancestor::t:subst or ancestor::t:app))">
            <xsl:variable name="app-num">
               <xsl:value-of select="name()"/>
               <xsl:number level="any" format="01"/>
            </xsl:variable>
            <xsl:choose>
               <xsl:when test="$location = 'text'">
                  <a>
                     <xsl:attribute name="href">
                        <xsl:text>#to-app-</xsl:text>
                        <xsl:value-of select="$app-num"/>
                     </xsl:attribute>
                     <xsl:attribute name="xml:id">
                        <xsl:text>from-app-</xsl:text>
                        <xsl:value-of select="$app-num"/>
                     </xsl:attribute>
                     <xsl:text>(*)</xsl:text>
                  </a>
               </xsl:when>
               <xsl:when test="$location = 'apparatus'">
                  <a>
                     <xsl:attribute name="xml:id">
                        <xsl:text>to-app-</xsl:text>
                        <xsl:value-of select="$app-num"/>
                     </xsl:attribute>
                     <xsl:attribute name="href">
                        <xsl:text>#from-app-</xsl:text>
                        <xsl:value-of select="$app-num"/>
                     </xsl:attribute>
                     <xsl:text>^</xsl:text>
                  </a>
                  <xsl:text> </xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:if>
      </xsl:if>
  </xsl:template>

</xsl:stylesheet>