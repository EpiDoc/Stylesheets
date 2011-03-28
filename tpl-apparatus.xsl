<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: tpl-apparatus.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t" version="1.0">

   <!-- Generates the apparatus from the edition -->
   <!-- 
    Adding to Apparatus:
    1. Add to apparatus: [htm | txt]-tpl-apparatus.xsl add case to the ifs and for-each (3 places) 
       - NOTE the app-link 'if' is checking for nested cases, therefore looking for ancestors.
    2. Indicator in text: [htm | txt]-element.xsl to add call-template to [htm | txt]-tpl-apparatus.xsl for links and/or stars.
    3. Add to ddbdp-app template below using local-name() to define context
  -->


   <!-- Defines the output of individual elements in apparatus -->
   <xsl:template name="ddbdp-app">
      <xsl:variable name="div-loc">
         <xsl:for-each select="ancestor::t:div[@type='textpart']">
            <xsl:value-of select="@n"/>
            <xsl:text>.</xsl:text>
         </xsl:for-each>
      </xsl:variable>
      <xsl:choose>
         <xsl:when
            test="not(ancestor::t:choice or ancestor::t:subst or ancestor::t:app or
            ancestor::t:hi[@rend = 'diaeresis' or @rend = 'grave' or @rend = 'acute' or @rend = 'asper' or @rend = 'lenis'
            or @rend = 'circumflex'])">
            <xsl:value-of select="$div-loc"/>
            <xsl:value-of select="preceding::t:*[local-name() = 'lb'][1]/@n"/>
            <xsl:if test="descendant::t:lb">
               <xsl:text>-</xsl:text>
               <xsl:value-of select="descendant::t:lb[position() = last()]/@n"/>
            </xsl:if>
            <xsl:text>. </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> : </xsl:text>
         </xsl:otherwise>
      </xsl:choose>

      <xsl:choose>
         <!-- choice [ sic & corr ] -->
         <xsl:when test="local-name() = 'choice' and child::t:sic and child::t:corr">

            <xsl:choose>
               <xsl:when test="$leiden-style = 'sammelbuch'">
                  <xsl:apply-templates select="t:corr/node()"/>
               </xsl:when>
               <xsl:otherwise>
                  <!-- when ddbdp changeover happens:
                    <xsl:text>Read </xsl:text>
                    <xsl:apply-templates select="t:corr/node()"/>
                    <xsl:text> (correction)</xsl:text>
                 -->
                  <xsl:apply-templates select="t:sic/node()"/>
                  <xsl:call-template name="childCertainty"/>
                  <xsl:text> papyrus</xsl:text>
               </xsl:otherwise>
            </xsl:choose>


         </xsl:when>

         <!-- choice [ orig & reg ] -->
         <xsl:when test="local-name() = 'choice' and child::t:orig and child::t:reg">

            <xsl:choose>
               <xsl:when test="$leiden-style = 'sammelbuch'">
                  <xsl:apply-templates select="t:reg/node()"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:if test="t:reg[not(@xml:lang)]">
                  <!-- when ddbdp changeover happens:
                    <xsl:text>Read </xsl:text>
                    <xsl:apply-templates select="t:reg/node()"/>
                 -->
                  <xsl:apply-templates select="t:orig/node()"/>
                  <xsl:call-template name="childCertainty"/>
                  <xsl:text> papyrus</xsl:text>
                  </xsl:if>
                  <xsl:if test="t:reg[not(@xml:lang)] and t:reg[@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang]">
                     <xsl:text>; </xsl:text>
                  </xsl:if>
                  <xsl:if test="t:reg[@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang]">
                     <xsl:text>i.e. </xsl:text>
                     <xsl:if test="t:reg/@xml:lang='grc'">
                        <xsl:text>Greek </xsl:text>
                     </xsl:if>
                     <xsl:if test="t:reg/@xml:lang='la'">
                        <xsl:text>Latin </xsl:text>
                     </xsl:if>
                     <xsl:if test="t:reg/@xml:lang='cop'">
                        <xsl:text>Coptic </xsl:text>
                     </xsl:if>
                     <!--
                ## commented out until ticket http://idp.atlantides.org/trac/idp/ticket/700 (part 2) implemented ## 
                      <xsl:if test="//t:langUsage/t:language/@ident = t:reg/@xml:lang">
                        <xsl:value-of select="//t:langUsage/t:language[@ident = t:reg/@xml:lang]/text()"/>
                     </xsl:if>
                     -->
                     <xsl:apply-templates select="t:reg[@xml:lang]/node()"/>
                  </xsl:if>
               </xsl:otherwise>
            </xsl:choose>


         </xsl:when>

         <!-- subst -->
         <xsl:when test="local-name() = 'subst'">
            <xsl:text>corr. from </xsl:text>
            <xsl:apply-templates select="t:del/node()"/>
            <xsl:call-template name="childCertainty"/>
         </xsl:when>

         <!-- app -->
         <xsl:when test="local-name() = 'app'">
            <xsl:choose>
               <xsl:when test="@type = 'alternative'">
                  <xsl:text>or </xsl:text>
                  <xsl:apply-templates select="t:rdg/node()"/>
                  <xsl:call-template name="childCertainty"/>
               </xsl:when>
               <xsl:when test="@type = 'editorial' or @type = 'BL' or @type = 'SoSOL'">
                  <xsl:if test="@type = 'BL'">
                     <xsl:text>BL</xsl:text>
                  </xsl:if>
                  <xsl:choose>
                     <xsl:when test="string(normalize-space(t:lem/@resp))">
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="t:lem/@resp"/>
                     </xsl:when>
                     <xsl:when test="@type = 'editorial'">
                        <xsl:text>Subsequent ed.</xsl:text>
                     </xsl:when>
                     <xsl:when test="@type = 'SoSOL'">
                        <xsl:text>SoSOL</xsl:text>
                     </xsl:when>
                  </xsl:choose>
                  <xsl:text>: </xsl:text>
                  <xsl:choose>
                     <xsl:when test="not(string(normalize-space(t:rdg))) and not(t:rdg/t:gap)">
                        <xsl:text> Om.</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:apply-templates select="t:rdg/node()"/>
                     </xsl:otherwise>
                  </xsl:choose>
                  <xsl:text> Original ed.</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>

         <!-- hi -->
         <xsl:when test="local-name() = 'hi'">
            <xsl:call-template name="trans-string">
               <xsl:with-param name="trans-text">
                  <xsl:call-template name="string-after-space">
                     <xsl:with-param name="test-string"
                        select="preceding-sibling::node()[1][self::text()]"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>

            <xsl:choose>
               <xsl:when test="@rend = 'diaeresis'">
                  <xsl:call-template name="trans-string"/>
                  <xsl:if test="t:gap">
                     <xsl:if test="t:gap[@reason='lost']"><xsl:text>[</xsl:text></xsl:if>
                     <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
                  </xsl:if>
                  <xsl:text>̈</xsl:text>
                  <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
               </xsl:when>
               <xsl:when test="@rend = 'grave'">
                  <xsl:call-template name="trans-string"/>
                  <xsl:if test="t:gap">
                     <xsl:if test="t:gap[@reason='lost']"><xsl:text>[</xsl:text></xsl:if>
                     <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
                  </xsl:if>
                  <xsl:text>̀</xsl:text>
                  <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
               </xsl:when>
               <xsl:when test="@rend = 'acute'">
                  <xsl:call-template name="trans-string"/>
                  <xsl:if test="t:gap">
                     <xsl:if test="t:gap[@reason='lost']"><xsl:text>[</xsl:text></xsl:if>
                     <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
                  </xsl:if>
                  <xsl:text>́</xsl:text>
                  <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
               </xsl:when>
               <xsl:when test="@rend = 'asper'">
                  <xsl:call-template name="trans-string"/>
                  <xsl:if test="t:gap">
                     <xsl:if test="t:gap[@reason='lost']"><xsl:text>[</xsl:text></xsl:if>
                     <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
                  </xsl:if>
                  <xsl:text>̔</xsl:text>
                  <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
               </xsl:when>
               <xsl:when test="@rend = 'lenis'">
                  <xsl:call-template name="trans-string"/>
                  <xsl:if test="t:gap">
                     <xsl:if test="t:gap[@reason='lost']"><xsl:text>[</xsl:text></xsl:if>
                     <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
                  </xsl:if>
                  <xsl:text>̓</xsl:text>
                  <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
               </xsl:when>
               <xsl:when test="@rend = 'circumflex'">
                  <xsl:call-template name="trans-string"/>
                  <xsl:if test="t:gap">
                     <xsl:if test="t:gap[@reason='lost']"><xsl:text>[</xsl:text></xsl:if>
                     <xsl:text>&#xa0;&#xa0;&#x323;</xsl:text>
                  </xsl:if>
                  <xsl:text>͂</xsl:text>
                  <xsl:if test="t:gap[@reason='lost']"><xsl:text>]</xsl:text></xsl:if>
               </xsl:when>
            </xsl:choose>

            <xsl:call-template name="trans-string">
               <xsl:with-param name="trans-text">
                  <xsl:call-template name="string-before-space">
                     <xsl:with-param name="test-string"
                        select="following-sibling::node()[1][self::text()]"/>
                  </xsl:call-template>
               </xsl:with-param>
            </xsl:call-template>

            <xsl:text> pap.</xsl:text>
         </xsl:when>

         <!-- del -->
         <xsl:when test="local-name() = 'del'">
            <xsl:choose>
               <xsl:when test="@rend = 'slashes'">
                  <xsl:text>Text canceled with slashes</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'cross-strokes'">
                  <xsl:text>Text canceled with cross-strokes</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>

         <xsl:when test="local-name() = 'milestone'">
            <xsl:if test="@rend = 'box'">
               <xsl:text>Text in box.</xsl:text>
            </xsl:if>
         </xsl:when>

      </xsl:choose>
   </xsl:template>


   <xsl:template name="string-after-space">
      <xsl:param name="test-string"/>

      <xsl:choose>
         <xsl:when test="contains($test-string, ' ')">
            <xsl:call-template name="string-after-space">
               <xsl:with-param name="test-string" select="substring-after($test-string, ' ')"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$test-string"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template name="string-before-space">
      <xsl:param name="test-string"/>

      <xsl:choose>
         <xsl:when test="contains($test-string, ' ')">
            <xsl:call-template name="string-before-space">
               <xsl:with-param name="test-string" select="substring-before($test-string, ' ')"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="$test-string"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>


   <xsl:template name="trans-string">
      <xsl:param name="trans-text" select="."/>
      <xsl:value-of select="translate($trans-text, $all-grc, $grc-lower-strip)"/>
   </xsl:template>

   <xsl:template name="childCertainty">
      <xsl:if test="child::t:certainty[@match='..']">
         <xsl:text>(?)</xsl:text>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
