<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation -->
  <xsl:include href="tpl-apparatus.xsl"/>

  <!-- Apparatus framework -->
  <xsl:template name="tpl-apparatus">
    <!-- An apparatus is only created if one of the following is true -->
     <xsl:if test=".//t:choice | .//t:subst | .//t:app |
       .//t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'] |
       .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">

         <h2>Apparatus</h2>
         <div id="apparatus">
        <!-- An entry is created for-each of the following instances
                  * choice, subst or app not nested in another;
                  * hi not nested in the app part of an app;
                  * del or milestone.
        -->
            <xsl:for-each select="(.//t:choice | .//t:subst | .//t:app)[not(ancestor::t:*[local-name()=('choice','subst','app')])] |
               .//t:hi[@rend=('diaeresis','grave','acute','asper','lenis','circumflex')][not(ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg') 
               or self::t:del[@rend='corrected'] 
               or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')])] |
           .//t:del[@rend='slashes' or @rend='cross-strokes'] | .//t:milestone[@rend = 'box']">
               
               <!-- Found in tpl-apparatus.xsl -->
               <xsl:call-template name="ddbdp-app">
                  <xsl:with-param name="apptype">
                     <xsl:choose>
                        <xsl:when test="self::t:choice[child::t:orig and child::t:reg]">
                           <xsl:text>origreg</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::t:choice[child::t:sic and child::t:corr]">
                           <xsl:text>siccorr</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::t:subst">
                           <xsl:text>subst</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::t:app[@type='alternative']">
                           <xsl:text>appalt</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::t:app[@type='editorial'][starts-with(t:lem/@resp,'BL ')]">
                           <xsl:text>appbl</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::t:app[@type='editorial'][starts-with(t:lem/@resp,'PN ')]">
                           <xsl:text>apppn</xsl:text>
                        </xsl:when>
                        <xsl:when test="self::t:app[@type='editorial']">
                           <xsl:text>apped</xsl:text>
                        </xsl:when>
                     </xsl:choose>
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:for-each>
         </div>
      </xsl:if>
  </xsl:template>

<!-- called from tpl-apparatus.xsl -->
<xsl:template name="lbrk-app">
   <br/>
</xsl:template>

  <!-- Used in htm-{element} and above to add linking to and from apparatus -->
  <xsl:template name="app-link">
    <!-- location defines the direction of linking -->
    <xsl:param name="location"/>
      <!-- Does not produce links for translations -->
    <xsl:if test="not(ancestor::t:div[@type = 'translation'])">
      <!-- Only produces a link if it is not nested in an element that would be in apparatus -->
      <xsl:if test="not((local-name() = 'choice' or local-name() = 'subst' or local-name() = 'app')
         and (ancestor::t:choice or ancestor::t:subst or ancestor::t:app))">
            <xsl:variable name="app-num">
               <xsl:value-of select="name()"/>
               <xsl:number level="any" format="01"/>
            </xsl:variable>
            <xsl:call-template name="generate-app-link">
              <xsl:with-param name="location" select="$location"/>
              <xsl:with-param name="app-num" select="$app-num"/>
            </xsl:call-template>
         </xsl:if>
      </xsl:if>
  </xsl:template>
  
  <!-- Called by app-link to generate the actual HTML, so other projects can override this template for their own style -->
  <xsl:template name="generate-app-link">
    <xsl:param name="location"/>
    <xsl:param name="app-num"/>
    <xsl:choose>
       <xsl:when test="$location = 'text'">
          <a>
             <xsl:attribute name="href">
                <xsl:text>#to-app-</xsl:text>
                <xsl:value-of select="$app-num"/>
             </xsl:attribute>
             <xsl:attribute name="id">
                <xsl:text>from-app-</xsl:text>
                <xsl:value-of select="$app-num"/>
             </xsl:attribute>
             <xsl:text>(*)</xsl:text>
          </a>
       </xsl:when>
       <xsl:when test="$location = 'apparatus'">
          <a>
             <xsl:attribute name="id">
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
  </xsl:template>

</xsl:stylesheet>