<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t" version="2.0">

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
      <xsl:param name="apptype"/>
      <xsl:variable name="div-loc">
         <xsl:for-each select="ancestor::t:div[@type='textpart'][@n]">
            <xsl:value-of select="@n"/>
            <xsl:text>.</xsl:text>
         </xsl:for-each>
      </xsl:variable>
      <xsl:choose>
         <xsl:when
            test="not(ancestor::t:choice or ancestor::t:subst or ancestor::t:app or
            ancestor::t:hi[@rend=('diaeresis','grave','acute','asper','lenis','circumflex')])">
            <!-- either <br/> in htm-tpl-apparatus or \r\n in txt-tpl-apparatus -->
            <xsl:call-template name="lbrk-app"/>
            <!-- in htm-tpl-apparatus.xsl or txt-tpl-apparatus.xsl -->
            <xsl:call-template name="app-link">
               <xsl:with-param name="location" select="'apparatus'"/>
            </xsl:call-template>
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
         <xsl:when test="local-name()=('choice','subst','app')">
            <!-- if there are more app elements inside the text part of the element, deal with them here -->
            
         <xsl:if test="child::t:*[local-name()=('orig','sic','add','lem')]/t:*[local-name()=('choice','subst','app')]">
         <xsl:call-template name="txPtchild">
            <!-- template txPtchild below -->
            <xsl:with-param name="apptype" select="$apptype"/>
            <xsl:with-param name="childtype">
               <xsl:choose>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice[child::t:orig and child::t:reg]">
                     <xsl:text>origreg</xsl:text>
                  </xsl:when>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:choice[child::t:sic and child::t:corr]">
                     <xsl:text>siccorr</xsl:text>
                  </xsl:when>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:subst">
                     <xsl:text>subst</xsl:text>
                  </xsl:when>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='alternative']">
                     <xsl:text>appalt</xsl:text>
                  </xsl:when>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial'][starts-with(@resp,'BL ')]">
                     <xsl:text>appbl</xsl:text>
                  </xsl:when>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial'][starts-with(@resp,'PN ')]">
                     <xsl:text>apppn</xsl:text>
                  </xsl:when>
                  <xsl:when test="child::t:*[local-name()=('orig','sic','add','lem')]/t:app[@type='editorial']">
                     <xsl:text>apped</xsl:text>
                  </xsl:when>
               </xsl:choose>
            </xsl:with-param>
         </xsl:call-template>
      </xsl:if>
      <!-- generate the main content of the app here -->
      <xsl:call-template name="appcontent">
         <xsl:with-param name="apptype" select="$apptype"/>
      </xsl:call-template>
      <!-- if there are more app elements inside the app part of the element,
         these are handled in the individual templates for the elements in question -->
         </xsl:when>
         
         <!-- hi -->
         <xsl:when test="local-name() = 'hi'">
            <xsl:call-template name="hirend"/>
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
   
   <xsl:template name="txPtchild">
      <!-- prints apparatus content for apps nested in the part of an app normally printed in edition -->
      <xsl:param name="apptype"/>
      <xsl:param name="childtype"/>
      <xsl:choose>
         <xsl:when test="$childtype=('origreg','siccorr') and @xml:lang!=ancestor::t:*[@xml:lang][1]/@xml:lang">
            <xsl:text> i.e. </xsl:text>
            <xsl:call-template name="reglang">
               <xsl:with-param name="lang" select="@xml:lang"/>
            </xsl:call-template>
         </xsl:when>
         <xsl:when test="$childtype=('origreg','siccorr')">
            <xsl:text>l. </xsl:text>
         </xsl:when>
         <xsl:when test="$childtype='subst'">
            <xsl:text> corr. ex </xsl:text>
         </xsl:when>
         <xsl:when test="$childtype='appalt'">
            <xsl:text> or </xsl:text>
            <!--<xsl:if test="not(string(child::t:rdg)) and not(child::t:rdg/t:*)">-->
            <xsl:if test="t:rdg[not(.//text())]">
               <xsl:text>not </xsl:text>
               <xsl:apply-templates select="child::t:lem"/>
            </xsl:if>
         </xsl:when>
         <xsl:when test="$childtype='appbl' and t:lem/@resp">
            <xsl:if test="contains(child::t:*[local-name()=('orig','sic','add','lem')]/t:app/t:lem/t:lem/@resp,'cf.')">
               <xsl:text> cf.</xsl:text>
            </xsl:if>
            <xsl:text> BL </xsl:text>
            <xsl:choose>
               <xsl:when test="contains(child::t:*[local-name()=('orig','sic','add','lem')]/t:app/t:lem/t:lem/@resp,'cf.')">
                  <xsl:value-of select="substring-after(child::t:*[local-name()=('orig','sic','add','lem')]/t:app/t:lem/t:lem/@resp,'cf.')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="substring-after(child::t:*[local-name()=('orig','sic','add','lem')]/t:app/t:lem/t:lem/@resp,'BL ')"/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:text> : </xsl:text>
         </xsl:when>
         <xsl:when test="$childtype=('apped','apppn') and child::t:*[local-name()=('orig','sic','add','lem')]/t:app/t:lem/@resp">
            <xsl:value-of select="substring-after(child::t:*[local-name()=('orig','sic','add','lem')]/t:app/t:lem/@resp,'PN ')"/>
            <xsl:if test="$childtype='apppn'">
               <xsl:text> (via PN)</xsl:text>
            </xsl:if>
            <xsl:text> : </xsl:text>
         </xsl:when>
      </xsl:choose>
      <xsl:apply-templates select="child::t:*[local-name()=('orig','sic','add','lem')]/t:*[local-name()=('choice','subst','app')]/
         t:*[local-name()=('reg','corr','del','rdg')]/node()"/>
      <xsl:choose>
         <xsl:when test="$childtype='siccorr'">
            <xsl:text> (corr)</xsl:text>
         </xsl:when>
         <xsl:when test="$childtype=('appbl','apped','apppn')">
            <xsl:text> prev. ed.</xsl:text>
         </xsl:when>
      </xsl:choose>
      <xsl:if test="$apptype=('origreg','siccorr','subst')">
         <xsl:text>,</xsl:text>
      </xsl:if>
      <xsl:text> </xsl:text>
   </xsl:template>
   
   <xsl:template name="appcontent">
      <!-- prints the content of apparatus; called by ddb-apparatus or by individual elements if nested -->
      <xsl:param name="apptype"/>
      <xsl:choose>
         <!-- *REG*  (repeatable) -->
         <xsl:when test="$apptype='origreg'">
            <xsl:for-each select="t:reg">
               <xsl:sort select="position()" order="descending"/>
               <xsl:call-template name="multreg"/>
            </xsl:for-each>
         </xsl:when>
         <!-- *CORR* -->
         <xsl:when test="$apptype=('siccorr')">
            <xsl:text>l. </xsl:text>
            <xsl:apply-templates select="t:corr/node()"/>
            <xsl:text> (corr)</xsl:text>
         </xsl:when>
         <!-- *SUBST* -->
         <xsl:when test="$apptype='subst'">
            <xsl:text> corr. ex </xsl:text>
            <xsl:apply-templates select="t:del/node()"/>
         </xsl:when>
         <!-- *ALT* (repeatable) -->
         <xsl:when test="$apptype='appalt'">
            <xsl:for-each select="t:rdg">
                  <xsl:if test="position()!=1">
                     <xsl:text>,</xsl:text>
                  </xsl:if>
               <xsl:text> or </xsl:text>
               <xsl:if test="not(.//text())">
                  <xsl:text>not </xsl:text>
                  <xsl:apply-templates select="preceding-sibling::t:lem"/>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:for-each>
         </xsl:when>
         <!-- *ED* (repeatable) -->
         <xsl:when test="$apptype=('appbl','apppn','apped')">
            <xsl:if test="starts-with(t:lem/@resp,'BL ')">
               <xsl:if test="starts-with(substring-after(t:lem/@resp,'BL '),'cf.')">
                  <xsl:text> cf.</xsl:text>
               </xsl:if>
               <xsl:text> BL </xsl:text>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="starts-with(substring-after(t:lem/@resp,'BL '),'cf.')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'cf.')"/>
               </xsl:when>
               <xsl:when test="starts-with(t:lem/@resp,'BL ')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'BL ')"/>
               </xsl:when>
               <xsl:when test="starts-with(t:lem/@resp,'PN ')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'PN ')"/>
                  <xsl:text> (via PN)</xsl:text>
               </xsl:when>
               <xsl:when test="t:lem/@resp">
                  <xsl:value-of select="t:lem/@resp"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>subseq. ed.</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:text> : </xsl:text>
            <xsl:for-each select="t:rdg">
               <xsl:apply-templates/>
               <xsl:if test="starts-with(t:lem/@resp,'BL ')">
                  <xsl:if test="starts-with(substring-after(t:lem/@resp,'BL '),'cf.')">
                     <xsl:text> cf.</xsl:text>
                  </xsl:if>
                  <xsl:text> BL </xsl:text>
               </xsl:if>
               <xsl:text> </xsl:text>
               <xsl:choose>
                  <xsl:when test="starts-with(substring-after(@resp,'BL '),'cf.')">
                     <xsl:value-of select="substring-after(@resp,'cf.')"/>
                  </xsl:when>
                  <xsl:when test="starts-with(@resp,'BL ')">
                     <xsl:value-of select="substring-after(@resp,'BL ')"/>
                  </xsl:when>
                  <xsl:when test="starts-with(@resp,'PN ')">
                     <xsl:value-of select="substring-after(@resp,'PN ')"/>
                     <xsl:text> (via PN)</xsl:text>
                  </xsl:when>
                  <xsl:when test="string(@resp)">
                     <xsl:value-of select="@resp"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:text> prev. ed.</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:if test="position()!=last()">
                  <xsl:text> : </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
         <!--<xsl:when test="$apptype='appbl'">
            <xsl:if test="starts-with(t:lem/@resp,'cf.')">
               <xsl:text> cf.</xsl:text>
            </xsl:if>
            <xsl:text> BL </xsl:text>
            <xsl:choose>
               <xsl:when test="starts-with(substring-after(t:lem/@resp,'BL '),'cf.')">
                  <xsl:value-of select="substring-after(t:lem/@resp,'cf.')"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:value-of select="substring-after(t:lem/@resp,'BL ')"/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:text> : </xsl:text>
            <xsl:for-each select="t:rdg">
               <xsl:apply-templates/>
               <xsl:if test="not(@resp) and not(child::t:app[child::t:lem[@resp]])">
                  <xsl:text> prev. ed.</xsl:text>
               </xsl:if>
               <xsl:if test="position()!=last()">
                  <xsl:text> : </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>-->
         <!--<xsl:when test="$apptype=('apppn')">
            <xsl:value-of select="substring-after(t:lem/@resp,'PN ')"/>
            <xsl:text> (via PN)</xsl:text>
            <xsl:text> : </xsl:text>
            <xsl:for-each select="t:rdg">
               <xsl:apply-templates/>
               <xsl:if test="not(@resp) and not(child::t:app[child::t:lem[@resp]])">
                  <xsl:text> prev. ed.</xsl:text>
               </xsl:if>
               <xsl:if test="position()!=last()">
                  <xsl:text> : </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="$apptype=('apped')">
            <xsl:choose>
               <xsl:when test="t:lem/@resp">
                  <xsl:value-of select="t:lem/@resp"/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>subseq. ed.</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:text> : </xsl:text>
            <xsl:for-each select="t:rdg">
               <xsl:apply-templates/>
               <xsl:choose>
                  <xsl:when test="@resp">
                     <xsl:text> </xsl:text>
                     <xsl:value-of select="@resp"/>
                  </xsl:when>
                  <xsl:when test="t:app[t:lem[@resp]]"/>
                  <xsl:otherwise>
                  <xsl:text> prev. ed.</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:if test="position()!=last()">
                  <xsl:text> : </xsl:text>
               </xsl:if>
            </xsl:for-each>
         </xsl:when>-->
         <!--<xsl:otherwise>
           <xsl:choose>
              <xsl:when test="$apptype=('origreg','siccorr') and t:reg/@xml:lang!=ancestor-or-self::t:*[@xml:lang][1]/@xml:lang">
                 <xsl:text> i.e. </xsl:text>
                 <xsl:call-template name="reglang">
                    <xsl:with-param name="lang" select="t:reg/@xml:lang"/>
                 </xsl:call-template>
              </xsl:when>-->
              <!--<xsl:when test="$apptype='appalt'">
                 <xsl:text> or </xsl:text>
                 <xsl:if test="not(string(t:rdg))">
                    <xsl:text>not </xsl:text>
                    <xsl:apply-templates select="t:lem"/>
                 </xsl:if>
              </xsl:when>-->
              <!--<xsl:when test="$apptype='appbl' and t:lem/@resp">
                 <xsl:if test="starts-with(t:lem/@resp,'cf.')">
                    <xsl:text> cf.</xsl:text>
                 </xsl:if>
                 <xsl:text> BL </xsl:text>
                 <xsl:choose>
                    <xsl:when test="starts-with(t:lem/@resp,'cf.')">
                       <xsl:value-of select="substring-after(t:lem/@resp,'cf.')"/>
                    </xsl:when>
                    <xsl:otherwise>
                       <xsl:value-of select="substring-after(t:lem/@resp,'BL ')"/>
                    </xsl:otherwise>
                 </xsl:choose>
                 <xsl:text> : </xsl:text>
              </xsl:when>
              <xsl:when test="$apptype=('apped') and t:lem/@resp">
                 <xsl:value-of select="t:lem/@resp"/>
                 <xsl:text> : </xsl:text>
              </xsl:when>
              <xsl:when test="$apptype=('apppn') and t:lem/@resp">
                 <xsl:value-of select="substring-after(t:lem/@resp,'PN ')"/>
                 <xsl:text> (via PN)</xsl:text>
                 <xsl:text> : </xsl:text>
              </xsl:when>
           </xsl:choose>
           <xsl:apply-templates select="t:*[local-name()=('reg','corr','del','rdg')]/node()"/>-->
           <!--<xsl:choose>
              <xsl:if test="not(t:*[local-name()=('reg','corr','del','rdg')][child::t:app[child::t:lem[@resp]]])">
                 <xsl:text> prev. ed.</xsl:text>
              </xsl:if>
           </xsl:choose>
        </xsl:otherwise>-->
     </xsl:choose>
   </xsl:template>
   
   <xsl:template name="hirend">
      <!-- prints the value of diacritical <hi> values, either in text (with full word context) or in app (highlighted character only) -->
      <xsl:param name="hicontext" select="'yes'"/>
      <xsl:if test="$hicontext != 'no'">
      <xsl:call-template name="trans-string">
         <xsl:with-param name="trans-text">
            <xsl:call-template name="string-after-space">
               <xsl:with-param name="test-string"
                  select="preceding-sibling::node()[1][self::text()]"/>
            </xsl:call-template>
         </xsl:with-param>
      </xsl:call-template>
      </xsl:if>
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
      
      <xsl:if test="$hicontext != 'no'">
          <xsl:call-template name="trans-string">
             <xsl:with-param name="trans-text">
                <xsl:call-template name="string-before-space">
                   <xsl:with-param name="test-string"
                      select="following-sibling::node()[1][self::text()]"/>
                </xsl:call-template>
             </xsl:with-param>
          </xsl:call-template>
          <!-- found below: inserts "papyrus" or "ostrakon" depending on filename -->
          <xsl:call-template name="support"/>
      </xsl:if>
      
   </xsl:template>
   
   <xsl:template name="multreg">
      <!-- prints multiple regs in a single choice in sequence -->
      <xsl:choose>
         <xsl:when test="position()!=1">
            <xsl:text>i.e. </xsl:text>
         </xsl:when>
         <xsl:when test="@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang">
            <xsl:text>i.e. </xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>l. </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang">
         <xsl:call-template name="reglang">
            <xsl:with-param name="lang" select="@xml:lang"/>
         </xsl:call-template>
      </xsl:if>
      <xsl:apply-templates/>
      <xsl:if test="position()!=last()">
         <xsl:text>, </xsl:text>
      </xsl:if>
   </xsl:template>
   
   <xsl:template name="reglang">
      <!-- test to insert language for multi-lang regs -->
      <xsl:param name="lang"/>
      <xsl:choose>
         <xsl:when test="$lang='grc'">
            <xsl:text> Greek </xsl:text>
         </xsl:when>
         <xsl:when test="$lang='la'">
            <xsl:text> Latin </xsl:text>
         </xsl:when>
         <xsl:when test="$lang='cop'">
            <xsl:text> Coptic </xsl:text>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="string-after-space">
      <!-- finds all text content before hi up to the preceding space (or markup) -->
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
      <!-- finds all text content after hi up to the next space (or markup) -->
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
      <!-- transforms context of <hi> into lowercase unaccented for rendering in app -->
      <xsl:param name="trans-text" select="."/>
      <xsl:value-of select="translate($trans-text, $all-grc, $grc-lower-strip)"/>
   </xsl:template>

   <xsl:template name="childCertainty">
      <!-- called in various places; adds (?) if certainty element applied -->
      <xsl:if test="child::t:certainty[@match='..']">
         <xsl:text>(?)</xsl:text>
      </xsl:if>
   </xsl:template>
   
   <xsl:template name="support">
      <!-- called by template "hirend" above; decides whether text support is "ostrakon" or other (prob. = "papyrus") -->
      <xsl:choose>
         <xsl:when test="starts-with(//t:idno[@type='filename'],'o.')">
            <xsl:text> ostrakon</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text> papyrus</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
      
   </xsl:template>

</xsl:stylesheet>
