<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:EDF="http://epidoc.sourceforge.net/ns/functions" exclude-result-prefixes="t EDF" version="2.0">
   <!-- Templates imported by [htm|txt]-teig.xsl -->

   <xsl:function name="EDF:f-wwrap">
      <!-- called by teisupplied.xsl, teig.xsl and teispace.xsl -->
      <xsl:param name="ww-context"/>
      <xsl:choose>
         <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='lb' and (@break='no' or @type='inWord'))             or normalize-space(.)='' and following-sibling::node()[1][local-name()='lb' and (@break='no' or @type='inWord')]]">
            <xsl:value-of select="true()"/>
      </xsl:when>
         <!--      imported change    https://sourceforge.net/p/epidoc/code/2602/-->
       <!-- Added to controll '-' when there is a milestone@rend='paragraphos' followed by a lb@break='no' see: https://github.com/DCLP/dclpxsltbox/issues/52-->
          <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='milestone' and (@rend='paragraphos'))
             or normalize-space(.)='' and following-sibling::node()[1][local-name()='milestone' and (@rend='paragraphos')]
               and $ww-context/following-sibling::node()[2][(local-name()='lb' and (@break='no' or @type='inWord'))
               or normalize-space(.)='' and following-sibling::node()[2][local-name()='lb' and (@break='no' or @type='inWord')]]]">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <!-- Added to controll '-' when there is a milestone@rend='paragraphos' followed by a lb@break='no' see: https://github.com/DCLP/dclpxsltbox/issues/52 -->
         <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='milestone' and (@rend='paragraphos'))
            or normalize-space(.)='' and following-sibling::node()[1][local-name()='milestone' and (@rend='paragraphos')]
            and $ww-context/following-sibling::node()[2][(local-name()='lb' and (@break='no' or @type='inWord'))
            or normalize-space(.)='' and following-sibling::node()[2][local-name()='lb' and (@break='no' or @type='inWord')]]]">
            <xsl:value-of select="true()"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="false()"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:function>

   <xsl:template name="lb-dash">
      <!-- function EDF:f-wwrap declared in htm-teilb.xsl; tests if lb break=no immediately follows g -->
      <xsl:if test="EDF:f-wwrap(.) = true()">
         <xsl:text>- </xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template name="w-space">
      <xsl:if test="ancestor::w">
         <xsl:text> </xsl:text>
      </xsl:if>
   </xsl:template>

   <xsl:template match="t:g">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:choose>
         <xsl:when test="starts-with($parm-leiden-style, 'edh')"/>
         <xsl:when test="starts-with(@ref,'#') and //t:glyph[@xml:id=substring-after(current()/@ref,'#')]">
            <xsl:for-each select="//t:glyph[@xml:id=substring-after(current()/@ref,'#')]">
               <xsl:choose>
                  <xsl:when test="t:charProp[t:localName='glyph-display']">
                     <xsl:value-of select="t:charProp[t:localName='glyph-display']/t:value"/>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="t:charProp[t:localName='text-display']/t:value"/>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:for-each>
         </xsl:when>
         <xsl:when test="contains(@ref,'#')">
            <xsl:value-of select="substring-after(@ref,'#')"/>
         </xsl:when>
         <xsl:when test="@ref">
            <xsl:value-of select="@ref"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="@type"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!-- London specific template -->
   <xsl:template name="g-london">
       <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
       <xsl:choose>
         <xsl:when test="@type = 'chirho'">
            <xsl:text>⳩</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'taurho'">
            <xsl:text>⳨</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
           <xsl:when test="$parm-edition-type='diplomatic'">
            <xsl:choose>
               <xsl:when test="@type='crux' or @type='cross'">
                  <xsl:text>†</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='crosses'">
                  <xsl:text>††</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='denarius'">
                  <xsl:text>𐆖</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='drachma'">
                  <xsl:text>𐅵</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='sestercius'">
                  <xsl:text>𐆘</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='year'">
                  <xsl:text>L</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='stop'">
                  <xsl:text>•</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:otherwise>
                  <span class="smaller" style="font-style:italic;">
                     <xsl:text> </xsl:text>
                     <xsl:value-of select="@type"/>
                     <xsl:call-template name="g-unclear-symbol"/>
                     <xsl:text> </xsl:text>
                  </span>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <span class="smaller" style="font-style:italic;">
               <xsl:text> </xsl:text>
               <xsl:value-of select="@type"/>
               <xsl:call-template name="g-unclear-string"/>
               <xsl:text> </xsl:text>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <!-- IOSPE specific template -->
   <!-- called from htm-teig.xml -->
   <xsl:template name="g-iospe">
       <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
       <xsl:choose>
         <xsl:when test="@type = 'stauros'">
            <xsl:text>+</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'staurogram'">
            <xsl:text>⳨</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'leaf'">
            <xsl:text>❦</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'dipunct'">
            <xsl:text>:</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
           <xsl:when test="$parm-edition-type='diplomatic'">
            <xsl:choose>
               <!--<xsl:when test="@type='denarius'">
                  <xsl:text>𐆖</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='sestercius'">
                  <xsl:text>𐆘</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>-->
               <xsl:when test="@type='year'">
                  <xsl:text>L</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='stop'">
                  <xsl:text>•</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:otherwise>
                  <span class="smaller" style="font-style:italic;">
                     <xsl:text> </xsl:text>
                     <xsl:value-of select="@type"/>
                     <xsl:call-template name="g-unclear-string"/>
                     <xsl:text> </xsl:text>
                  </span>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <span class="smaller" style="font-style:italic;">
               <xsl:text> </xsl:text>
               <xsl:value-of select="@type"/>
               <xsl:call-template name="g-unclear-string"/>
               <xsl:text> </xsl:text>
            </span>
         </xsl:otherwise>
      </xsl:choose>
      
   </xsl:template>

   <!-- ddb specific template -->
   <xsl:template name="g-ddbdp">
      <xsl:param name="location" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="@type='apostrophe'">
            <xsl:if test="$location='apparatus'">
               <xsl:text>’</xsl:text>
               <xsl:call-template name="g-unclear-symbol"/>               
            </xsl:if>
         </xsl:when>
         <xsl:when test="@type='check' or @type='check-mark'">
            <xsl:text>／</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='chirho'">
            <xsl:text>☧</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='dash'">
            <xsl:text>—</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='dipunct'">
            <xsl:text>∶</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='filled-circle'">
            <xsl:text>⦿</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='filler' and @rend='extension'">
            <xsl:text>―</xsl:text>
            <xsl:call-template name="g-unclear-string"/>
         </xsl:when>
         <xsl:when test="@type='latin-interpunct' or @type='middot' or @type='mid-punctus'">
            <xsl:text>·</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='monogram'">
            <span class="italic">
               <xsl:text>monogr.</xsl:text>
               <xsl:call-template name="g-unclear-symbol"/>
            </span>
         </xsl:when>
         <xsl:when test="@type='upper-brace-opening'">
            <xsl:text>⎧</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='center-brace-opening'">
            <xsl:text>⎨</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='lower-brace-opening'">
            <xsl:text>⎩</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='upper-brace-closing'">
            <xsl:text>⎫</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='center-brace-closing'">
            <xsl:text>⎬</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='lower-brace-closing'">
            <xsl:text>⎭</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-upper-opening'">
            <xsl:text>⎛</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-middle-opening'">
            <xsl:text>⎜</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-lower-opening'">
            <xsl:text>⎝</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-upper-closing'">
            <xsl:text>⎞</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-middle-closing'">
            <xsl:text>⎟</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-lower-closing'">
            <xsl:text>⎠</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'rho-cross'">
            <xsl:text>⳨</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='slanting-stroke'">
            <xsl:text>/</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='stauros'">
            <xsl:text>†</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='tachygraphic marks'">
            <span class="italic">
               <xsl:text>tachygr. marks</xsl:text>
               <xsl:call-template name="g-unclear-symbol"/>
            </span>
         </xsl:when>
         <xsl:when test="@type='tripunct'">
            <xsl:text>⋮</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='tetrapunct'">
            <xsl:text>⁞</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='double-vertical-bar'">
            <xsl:text>‖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='long-vertical-bar'">
            <xsl:text>|</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='diple-obelismene'">
            <xsl:text>⤚</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='diple-periestigmene'">
            <xsl:text>⸖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-punctuation-closing'">
            <xsl:text>)</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='parens-punctuation-opening'">
            <xsl:text>(</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='downwards-ancora'">
            <xsl:text>⸔</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='upwards-ancora'">
            <xsl:text>⸕</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='antisigma'">
            <xsl:text>ͻ</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='antisigma-periestigmene'">
            <xsl:text>ͽ</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='hypodiastole'">
            <xsl:text>⸒</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='swungdash'">
            <xsl:text>⁓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='tetrapunct'">
            <xsl:text>⁞</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>         
         <xsl:when test="@type='x'">
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='xs'">
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <!-- Interim error reporting + change from https://sourceforge.net/p/epidoc/code/2532/ -->
         <xsl:otherwise>
            <xsl:text> ((</xsl:text>
            <xsl:value-of select="@type"/>
            <xsl:call-template name="g-unclear-string"/>
            <xsl:text>)) </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

    <!-- RIB specific template -->
    <xsl:template name="g-rib">
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
        <xsl:choose>
            <xsl:when test="@type = 'chirho'">
                <xsl:text>☧</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='century'">
                <xsl:text>𐆛</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='milliaria'">
                <xsl:text>ↀ</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='leaf'">
                <xsl:text>❦</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='palm'">
                <xsl:text>††</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='star'">
                <xsl:text>*</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='interpunct' and not(node())">
                <xsl:text>·</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='interpunct' and node()">
                <xsl:apply-templates/>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='sestertius' and not(node())">
                <xsl:text>𐆘</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='sestertius' and node()">
                <xsl:apply-templates/>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='denarius'">
                <xsl:text>⸙</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='barless-A'">
                <xsl:text>Λ</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='dot'">
                <xsl:text>.</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='stop'">
                <xsl:text>•</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:when test="@type='crux' or @type='cross'">
                <xsl:text>†</xsl:text>
                <xsl:call-template name="g-unclear-symbol"/>
            </xsl:when>
            <xsl:otherwise>
                <span class="smaller" style="font-style:italic;">
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@type"/>
                    <xsl:call-template name="g-unclear-string"/>
                    <xsl:text> </xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
   <!-- creta specific template -->
   <xsl:template name="g-creta">
      <xsl:choose>
         <xsl:when test="@type='dipunct'">
            <xsl:text>∶</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='tripunct'">
            <xsl:text>⋮</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='|'">
            <xsl:text>|</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='middot'">
            <xsl:text>·</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='leaf'">
            <xsl:text>❦</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='year'">
            <xsl:text>∟</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='chirho'">
            <xsl:text>☧</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='stauros'">
            <xsl:text>†</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='swastika'">
            <xsl:text>卐</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='palmula'">
            <xsl:text>⸙</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='⧖'">
            <xsl:text>⧖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>         
         <xsl:when test="@type='⨇'">
            <xsl:text>⨇</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='denarius'">
            <xsl:text>𐆖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='ligo'">
            <xsl:text>(ligo)</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:value-of select="@type"/>
            <xsl:call-template name="g-unclear-string"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="g-unclear-symbol">
      <!-- adds underdot below symbol if parent:unclear -->
      <xsl:if test="parent::t:unclear">
         <xsl:text>̣</xsl:text>
      </xsl:if>
   </xsl:template>
   
   <xsl:template name="g-unclear-string">
      <!-- adds question mark after string if parent:unclear -->
      <xsl:if test="parent::t:unclear">
         <xsl:text>?</xsl:text>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
