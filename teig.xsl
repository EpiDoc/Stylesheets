<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
   exclude-result-prefixes="t EDF"  version="2.0">
   <!-- Templates imported by [htm|txt]-teig.xsl -->

   <xsl:function name="EDF:f-wwrap">
      <!-- called by teisupplied.xsl, teig.xsl and teispace.xsl -->
      <xsl:param name="ww-context"/>
      <xsl:choose>
         <xsl:when test="$ww-context/following-sibling::node()[1][(local-name()='lb' and (@break='no' or @type='inWord'))
            or normalize-space(.)='' and following-sibling::node()[1][local-name()='lb' and (@break='no' or @type='inWord')]]">
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
      <xsl:if test="not(starts-with($leiden-style, 'edh'))">
         <xsl:value-of select="@type"/>
      </xsl:if>
   </xsl:template>

   <!-- London specific template -->
   <xsl:template name="g-london">
      <xsl:choose>
         <xsl:when test="@type = 'chirho'">
            <xsl:text>&#x2ce9;</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'taurho'">
            <xsl:text>&#x2ce8;</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="$edition-type='diplomatic'">
            <xsl:choose>
               <xsl:when test="@type='crux' or @type='cross'">
                  <xsl:text>&#x2020;</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='crosses'">
                  <xsl:text>&#x2020;&#x2020;</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='denarius'">
                  <xsl:text>&#x10196;</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='sestercius'">
                  <xsl:text>&#x10198;</xsl:text>
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

   <!-- ddb specific template -->
   <xsl:template name="g-ddbdp">
      <xsl:choose>
         <xsl:when test="@type='apostrophe'">
            <xsl:text>’</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
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
            <xsl:text>&#x2ce8;</xsl:text>
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
         <xsl:when test="@type='double-vertical-bar'">
            <xsl:text>‖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type='long-vertical-bar'">
            <xsl:text>|</xsl:text>
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
         <!-- Interim error reporting -->
         <xsl:otherwise>
            <text> ((</text>
            <xsl:value-of select="@type"/>
            <xsl:call-template name="g-unclear-string"/>
            <text>)) </text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>
   
   <xsl:template name="g-unclear-symbol">
      <!-- adds underdot below symbol if parent:unclear -->
      <xsl:if test="parent::t:unclear">
         <xsl:text>&#x0323;</xsl:text>
      </xsl:if>
   </xsl:template>
   
   <xsl:template name="g-unclear-string">
      <!-- adds question mark after string if parent:unclear -->
      <xsl:if test="parent::t:unclear">
         <xsl:text>?</xsl:text>
      </xsl:if>
   </xsl:template>

</xsl:stylesheet>
