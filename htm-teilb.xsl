<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   xmlns:EDF="http://epidoc.sourceforge.net/ns/functions"
  exclude-result-prefixes="t EDF" version="2.0">
   <!-- Actual display and increment calculation found in teilb.xsl -->
   <xsl:import href="teilb.xsl"/>

   <xsl:template match="t:lb">
      <xsl:param name="location"/>
      
      <xsl:choose>
         <xsl:when test="ancestor::t:lg and $verse-lines = 'on'">
            <xsl:apply-imports/>
            <!-- use the particular templates in teilb.xsl -->
         </xsl:when>

         <xsl:otherwise>
            <xsl:variable name="div-loc">
               <xsl:for-each select="ancestor::t:div[@type= 'textpart']">
                  <xsl:value-of select="@n"/>
                  <xsl:text>-</xsl:text>
               </xsl:for-each>
            </xsl:variable>
            <xsl:variable name="line">
               <xsl:if test="@n">
                  <xsl:value-of select="@n"/>
               </xsl:if>
            </xsl:variable>

            <xsl:if test="(@break='no' or @type='inWord')">
               <!-- print hyphen if break=no  -->
               <xsl:choose>
                  <!--    *unless* diplomatic edition  -->
                  <xsl:when test="$edition-type='diplomatic'"/>
                  <!--    *or unless* the lb is first in its ancestor div  -->
                  <xsl:when test="generate-id(self::t:lb) = generate-id(ancestor::t:div[1]/t:*[child::t:lb][1]/t:lb[1])"/>
                  <xsl:when test="$leiden-style = 'ddbdp' and ((not(ancestor::*[name() = 'TEI'])) or $location='apparatus')" />                                      
                  <!--   *or unless* the second part of an app in ddbdp  -->
                  <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and
                           (ancestor::t:corr or ancestor::t:reg or ancestor::t:rdg or ancestor::t:del[parent::t:subst])"/>
                  <!--  *unless* previous line ends with space / g / supplied[reason=lost]  -->
                  <!-- in which case the hyphen will be inserted before the space/g r final ']' of supplied
                     (tested by EDF:f-wwrap in teig.xsl, which is called by teisupplied.xsl, teig.xsl and teispace.xsl) -->
                  <xsl:when test="preceding-sibling::node()[1][local-name() = 'space' or
                        local-name() = 'g' or (local-name()='supplied' and @reason='lost') or
                        (normalize-space(.)='' 
                                 and preceding-sibling::node()[1][local-name() = 'space' or
                                 local-name() = 'g' or (local-name()='supplied' and @reason='lost')])]"/>              
                  <xsl:otherwise>
                      <xsl:text>-</xsl:text>
                  </xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="generate-id(self::t:lb) = generate-id(ancestor::t:div[1]/t:*[child::t:lb][1]/t:lb[1])">
                  <a id="a{$div-loc}l{$line}">
                     <xsl:comment>0</xsl:comment>
                  </a>
                  <!-- for the first lb in a div, create an empty anchor instead of a line-break -->
               </xsl:when>
               <xsl:when
                  test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') 
                  and (ancestor::t:sic 
                        or ancestor::t:reg
                        or ancestor::t:rdg or ancestor::t:del[ancestor::t:choice])
                        or ancestor::t:del[@rend='corrected'][parent::t:subst]">
                  <xsl:choose>
                     <xsl:when test="@break='no' or @type='inWord'">
                        <xsl:text>|</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text> | </xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:when
                  test="$leiden-style = 'ddbdp' and ((not(ancestor::*[name() = 'TEI']))  or $location='apparatus')">
                  <xsl:choose>
                     <xsl:when test="@break='no' or @type='inWord'">
                        <xsl:text>|</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text> | </xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>              
               <xsl:otherwise>
                  <br id="a{$div-loc}l{$line}"/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
               <xsl:when test="$location = 'apparatus'" />
               <xsl:when
                  test="not(number(@n)) and ($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
                  <!--         non-numerical line-nos always printed in DDbDP         -->
                  <xsl:call-template name="margin-num"/>
               </xsl:when>
               <xsl:when
                  test="number(@n) and @n mod $line-inc = 0 and not(@n = 0) and 
                  not(following::t:*[1][local-name() = 'gap' or local-name()='space'][@unit = 'line'] and 
                  ($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch'))">
                  <!-- prints line-nos divisible by stated increment, unless zero
                     and unless it is a gap line or vacat in DDbDP -->
                  <xsl:call-template name="margin-num"/>
               </xsl:when>
               <xsl:when test="$leiden-style = 'ddbdp' and preceding-sibling::t:*[1][local-name()='gap'][@unit = 'line']">
                  <!-- always print line-no after gap line in ddbdp -->
                  <xsl:call-template name="margin-num"/>
               </xsl:when>
               <xsl:when test="$leiden-style = 'ddbdp' and following::t:lb[1][ancestor::t:reg[following-sibling::t:orig[not(descendant::t:lb)]]]">
                  <!-- always print line-no when broken orig in line, in ddbdp -->
                  <xsl:call-template name="margin-num"/>
               </xsl:when>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="margin-num">
      <xsl:choose>
         <!-- don't print marginal line number inside tags that are relegated to the apparatus (ddbdp) -->
         <xsl:when
            test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') 
            and (ancestor::t:sic
            or ancestor::t:reg
            or ancestor::t:rdg or ancestor::t:del[ancestor::t:choice])
            or ancestor::t:del[@rend='corrected'][parent::t:subst]"/>
         <xsl:otherwise>
            <span>
                  <xsl:choose>
                     <xsl:when test="$leiden-style = 'ddbdp' and following::t:lb[1][ancestor::t:reg[following-sibling::t:orig[not(descendant::t:lb)]]]">
                        <xsl:attribute name="class">
                           <xsl:text>linenumberbroken</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                           <xsl:text>line-break missing in orig</xsl:text>
                        </xsl:attribute>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:attribute name="class">
                           <xsl:text>linenumber</xsl:text>
                         </xsl:attribute>
                     </xsl:otherwise>
                  </xsl:choose>
               <xsl:value-of select="@n"/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
