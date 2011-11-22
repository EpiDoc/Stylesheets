<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t"  version="2.0">
   <!-- html hi part of transformation in htm-teihi.xsl -->

   <xsl:template match="t:hi">
      <xsl:choose>
         <xsl:when test="@rend='ligature'">
            <xsl:if test="$leiden-style='seg'">
               <xsl:if test="string-length(normalize-space(.))=2">
                  <xsl:text>&#x035c;</xsl:text>
               </xsl:if>
            </xsl:if>
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when
            test="@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis' or @rend = 'circumflex'">
            <xsl:apply-templates/>
            <xsl:choose>
               <xsl:when test="$apparatus-style = 'ddbdp' and
                  ancestor::t:*[local-name()=('reg','corr','del','rdg')]">
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
               <xsl:when test="$apparatus-style = 'ddbdp'">
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
