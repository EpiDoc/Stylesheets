<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">
   <!-- Contains templates for subst, add and del -->
   
   <!-- Imported by htm-teiaddanddel.xsl or called directly from start-txt.xsl -->
   
   <xsl:template match="t:subst">
      <xsl:apply-templates/>

      <xsl:if test="$apparatus-style = 'ddbdp'">
         <!-- Found in [htm|txt]-tpl-apparatus -->
         <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
   </xsl:template>


   <xsl:template match="t:add">
      <xsl:choose>
         <xsl:when test="$leiden-style=('ddbdp','sammelbuch')">
            <xsl:choose>
               <xsl:when test="parent::t:subst"/>
               <xsl:when test="@place = 'above'">
                  <xsl:text>\</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'below'">
                  <xsl:text>/</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'left'">
                  <xsl:text>(added at left: </xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'right'">
                  <xsl:text>(added at right: </xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="$leiden-style='petrae'">
            <xsl:text>\</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="parent::t:subst or @place='overstrike'">
                  <xsl:text>«</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>`</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates/>
      <xsl:call-template name="cert-low"/>

      <xsl:choose>
         <xsl:when test="$leiden-style=('ddbdp','sammelbuch')">
            <xsl:choose>
               <!-- if parent subst and subst is in the app part of a further app element, include value of del -->
               <xsl:when test="ancestor::t:*[local-name()=('reg','corr','rdg') 
                  or self::t:del[@rend='corrected']]">
                  <!--<xsl:when test="parent::t:subst[ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg') 
                     or self::t:del[@rend='corrected'] 
                     or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')]]">-->
                  
                  
                  <!-- If add contains app, only render del (add is rendered before the subst by app templates) -->
                  <xsl:text> (</xsl:text><xsl:choose>
                     <xsl:when test="t:app"><xsl:call-template name="resolvesubst">
                           <!-- From tpl-apparatus.xsl -->
                           <xsl:with-param name="delpath" select="../t:del/node()"/>
                        </xsl:call-template></xsl:when>
                     <xsl:otherwise><xsl:call-template name="resolvesubst">
                           <!-- From tpl-apparatus.xsl -->
                           <xsl:with-param name="delpath" select="../t:del/node()"/>
                           <xsl:with-param name="addpath" select="node()"/>
                        </xsl:call-template></xsl:otherwise></xsl:choose><xsl:text>)</xsl:text>
               </xsl:when>
               <xsl:when test="parent::t:subst"/>
               <xsl:when test="@place = 'above'">
                  <xsl:text>/</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'below'">
                  <xsl:text>\</xsl:text>
               </xsl:when>
               <xsl:when test="@place = 'left' or @place = 'right'">
                  <xsl:text>)</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="$leiden-style='petrae'">
            <xsl:text>/</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="parent::t:subst or @place='overstrike'">
                  <xsl:text>»</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>´</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template match="t:del">
      <xsl:if test="$apparatus-style = 'ddbdp'">
         <xsl:if test="@rend = 'slashes' or @rend = 'cross-strokes'">
            <!-- Found in [htm | txt]-tpl-apparatus -->
            <xsl:call-template name="app-link">
               <xsl:with-param name="location" select="'text'"/>
            </xsl:call-template>
         </xsl:if>
      </xsl:if>

      <xsl:choose>
         <xsl:when test="starts-with($leiden-style, 'edh') or $leiden-style='petrae'">
            <xsl:text>[[</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>]]</xsl:text>
         </xsl:when>
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and @rend='slashes'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and @rend='cross-strokes'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="parent::t:subst"/>
         <xsl:otherwise>
            <xsl:text>&#x27e6;</xsl:text>
            <xsl:apply-templates/>
            <xsl:call-template name="cert-low"/>
            <xsl:text>&#x27e7;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
