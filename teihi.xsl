<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"  version="2.0">
   <!-- html hi part of transformation in htm-teihi.xsl -->

    <xsl:template match="t:hi">
        <xsl:param name="parm-external-app-style" tunnel="yes" required="no"></xsl:param>
        <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"></xsl:param>
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:choose>
           <xsl:when test="@rend='ligature'">
               <xsl:choose>
                   <xsl:when test="$parm-leiden-style = 'rib'">
                       <xsl:choose>
                           <xsl:when test="string-length(normalize-space(.))=2">
                               <xsl:value-of select="substring(.,1,1)"/>
                               <xsl:text>&#x0361;</xsl:text>
                               <xsl:value-of select="substring(.,2,1)"/>
                           </xsl:when>
                           <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
                       </xsl:choose>
                   </xsl:when>
                   <xsl:otherwise>
                       <xsl:if test="$parm-leiden-style='seg'">
                           <xsl:if test="string-length(normalize-space(.))=2">
                               <xsl:text>&#x035c;</xsl:text>
                           </xsl:if>
                       </xsl:if>
                       <xsl:apply-templates/>
                   </xsl:otherwise>
               </xsl:choose>
         </xsl:when>
         <xsl:when
             test="@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'">
             <xsl:apply-templates/>
             <xsl:choose>
                 <!-- if context is inside the app-part of an app-like element, print diacritic in parens here -->
                 <xsl:when test="$parm-internal-app-style = 'ddbdp' and
                     ancestor::t:*[local-name()=('reg','corr','rdg') 
                     or self::t:del[@rend='corrected']]">
                     <!--ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg')
                         or self::t:del[@rend='corrected']
                         or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')]">-->
                     <xsl:text>(</xsl:text>
                     <!-- found in tpl-apparatus.xsl -->
                     <xsl:call-template name="hirend">
                         <xsl:with-param name="hicontext" select="'no'"/>
                     </xsl:call-template>
                     <xsl:text>)</xsl:text>
                 </xsl:when>
                 <xsl:when test="$parm-internal-app-style = 'ddbdp'">
                     <!-- found in [htm|txt]-tpl-apparatus.xsl -->
                     <xsl:call-template name="app-link">
                         <xsl:with-param name="location" select="'text'"/>
                     </xsl:call-template>
                 </xsl:when>
             </xsl:choose>
         </xsl:when>
           <xsl:otherwise>
               <xsl:apply-templates/>
           </xsl:otherwise>
       </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
