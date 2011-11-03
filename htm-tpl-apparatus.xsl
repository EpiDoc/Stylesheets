<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
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
               
               <!--<xsl:variable name="preclbn" select="preceding::t:lb[1]/@n"/>
               <xsl:variable name="preclbid" select="generate-id(preceding::t:lb[1])"/>-->
               
               <!--<xsl:if test="not(following-sibling::t:*[local-name()=('choice','subst','app') or 
                  self::t:hi[@rend=('diaeresis','grave','acute','asper','lenis','circumflex')]][preceding::t:lb[1]/@n = $preclbn])">
                <xsl:call-template name="app-link">
                   <xsl:with-param name="location" select="'apparatus'"/>
                </xsl:call-template>
             </xsl:if>-->
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
                   <xsl:when test="self::t:app[@type='editorial']">
                      <xsl:text>apped</xsl:text>
                   </xsl:when>
                   <xsl:when test="self::t:app[@type='BL']">
                      <xsl:text>appbl</xsl:text>
                   </xsl:when>
                   <xsl:when test="self::t:app[@type='SoSOL']">
                      <xsl:text>appsosol</xsl:text>
                   </xsl:when>
                </xsl:choose>
             </xsl:with-param>
          </xsl:call-template>

               <!-- Does not create newline for two apps on same line nesting -->
          <!--<xsl:choose>
             <!-\-<xsl:when test="following-sibling::t:*[local-name()=('choice','subst','app') or 
                (local-name()='hi' and @rend=('diaeresis','grave','acute','asper','lenis','circumflex'))]
                [not(descendant::t:lb)][preceding::t:lb[1][generate-id(.)=$preclbid]]">-\->
             <xsl:when test="following-sibling::t:choice[not(descendant::t:lb)][preceding::t:lb[1][generate-id(.)=$preclbid]]
                or following-sibling::t:subst[not(descendant::t:lb)][preceding::t:lb[1][generate-id(.)=$preclbid]]
                or following-sibling::t:app[not(descendant::t:lb)][preceding::t:lb[1][generate-id(.)=$preclbid]]
                or following-sibling::hi[@rend=('diaeresis','grave','acute','asper','lenis','circumflex')]
                [not(descendant::t:lb)][preceding::t:lb[1][generate-id(.)=$preclbid]]">
                     <xsl:text>; </xsl:text>
                <!-\-<xsl:value-of select="following-sibling::t:*[local-name()=('choice','subst','app') or 
                   (local-name()='hi' and @rend=('diaeresis','grave','acute','asper','lenis','circumflex'))]
                   [not(descendant::t:lb)][1]/preceding::t:lb[1]/local-name()"/>-\->
                  </xsl:when>
                  <xsl:otherwise>
                     <br/>
                  </xsl:otherwise>
               </xsl:choose>-->
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