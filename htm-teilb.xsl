<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="t" version="2.0">
   <!-- Actual display and increment calculation found in teilb.xsl -->
   <xsl:import href="teilb.xsl"/>

   <xsl:template match="t:lb">
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

            <xsl:if
               test="(@break='no' or @type='inWord') 
               and preceding-sibling::node()[1][not(local-name() = 'space' or
                        local-name() = 'g' or
                        (local-name()='supplied' and @reason='lost') or
                        (normalize-space(.)='' 
                                 and preceding-sibling::node()[1][local-name() = 'space' or
                                 local-name() = 'g' or
                                 (local-name()='supplied' and @reason='lost')]))]
               and not(($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and
                           (ancestor::t:sic 
                           or ancestor::t:reg
                           or ancestor::t:rdg or ancestor::t:del[ancestor::t:choice])
                           or ancestor::t:del[@rend='corrected'][parent::t:subst])
               and not($edition-type='diplomatic')
               and not(generate-id(self::t:lb) = generate-id(ancestor::t:div[1]/t:*[child::t:lb][1]/t:lb[1]))">
               <!-- print hyphen if break=no
                              *unless* previous line ends with space / g / supplied[reason=lost]
                              *or unless* the second part of an app in ddbdp
                              *or unless* diplomatic edition
                              *or unless* the lb is first in its ancestor div  -->
               <!-- *old code* or ancestor::t:orig[../t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)]] 
                  ancestor::t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang) and
                  not(../t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)])]               -->
               <xsl:text>-</xsl:text>
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
               <xsl:otherwise>
                  <br id="a{$div-loc}l{$line}"/>
               </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
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
               <xsl:when test="$leiden-style = 'ddbdp' and ancestor::t:reg[following-sibling::t:orig[not(descendant::t:lb)]]">
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
               <xsl:attribute name="class">
                  <xsl:choose>
                     <xsl:when test="$leiden-style = 'ddbdp' and ancestor::t:reg[following-sibling::t:orig[not(descendant::t:lb)]]">
                        <xsl:text>linenumberbroken</xsl:text>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:text>linenumber</xsl:text>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:attribute>
               <xsl:value-of select="@n"/>
            </span>
         </xsl:otherwise>
      </xsl:choose>
      
      <!--<xsl:if test="not(apparatus-style = 'ddbdp' 
                                 and (ancestor::t:sic
                                          or ancestor::t:orig[../t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)]]
                                          or ancestor::t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)
                                                         and not(../t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)])]
                                          or ancestor::t:rdg or ancestor::t:del[ancestor::t:choice]
                                          or ancestor::t:reg[not(@xml:lang)][preceding-sibling::t:reg[not(@xml:lang)]]))">
         <span class="linenumber">
            <xsl:value-of select="@n"/>
         </span>
      </xsl:if>-->
   </xsl:template>

</xsl:stylesheet>
