<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:EDF="http://epidoc.sourceforge.net/ns/functions" xmlns:fn="http://www.w3.org/2005/xpath-functions" exclude-result-prefixes="t EDF" version="2.0">
   <!-- Templates imported by [htm|txt]-teig.xsl -->
   <xsl:import href="functions.xsl"/>
   <xsl:template name="lb-dash">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <!-- function EDF:f-wwrap declared in functions.xsl; tests if lb break=no immediately follows g -->
      <!-- UNLESS diplomatic -->
      <!-- or UNLESS project MedCyprus -->
      <xsl:if test="EDF:f-wwrap(.) = true() and not($parm-edition-type = 'diplomatic') and not($parm-leiden-style = 'medcyprus')">
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
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:param name="parm-glyph-variant" tunnel="yes" required="no"/>

      <xsl:choose>
         <!-- **** TEMPORARY FIX FOR MEDCYPRUS TEMPLATE **** -->
         <xsl:when test="$parm-leiden-style = ('medcyprus')">
            <xsl:variable name="symbol" select="substring-after(@ref, '#')"/>
            <!-- if you are running this template outside EFES, change the path to the symbols authority list accordingly -->
            <xsl:variable name="symbols-al" select="concat('file:', system-property('user.dir'), '/webapps/ROOT/content/xml/authority/symbols.xml')"/>
            <xsl:choose>
               <xsl:when test="doc-available($symbols-al) = fn:true() and document($symbols-al)//t:glyph[@xml:id = $symbol]">
                  <xsl:variable name="symbol-id" select="document($symbols-al)//t:glyph[@xml:id = $symbol]"/>
                  <xsl:choose>
                     <xsl:when test="$parm-edition-type = 'diplomatic' and $symbol-id//t:mapping[@type = 'glyph-display']">
                        <xsl:value-of select="$symbol-id//t:mapping[@type = 'glyph-display']"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="$symbol-id//t:mapping[@type = 'text-display']"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:choose>
                     <xsl:when test="@ref">
                        <xsl:value-of select="@ref"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:value-of select="."/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!-- **** TEMPORARY FIX FOR MEDCYPRUS TEMPLATE - END **** -->
         <!--         if text-display set, give priority to the content of g, if any-->
         <xsl:when test="$parm-glyph-variant = 'text-display'">
            <xsl:choose>
               <xsl:when test="text()">
                  <xsl:value-of select="."/>
               </xsl:when>
               <xsl:otherwise>
                  <!--                  because the value is alternative to project specific lists, this will use defaults.-->
                  <xsl:call-template name="chardecl">
                     <xsl:with-param name="g" select="."/>
                  </xsl:call-template>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <!--         <g>§</g>-->
         <xsl:when test="not(@ref) and not(@type)">
            <xsl:choose>
               <xsl:when test="text()">
                  <xsl:value-of select="."/>
               </xsl:when>
               <xsl:otherwise>unspecified</xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="chardecl">
               <xsl:with-param name="g" select="."/>
            </xsl:call-template>
         </xsl:otherwise>
      </xsl:choose>

   </xsl:template>

   <xsl:template name="chardecl">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
      <xsl:param name="parm-glyph-variant" tunnel="yes" required="no"/>
      <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
      
      <xsl:param name="g"/>
      
      <!--      stores the chardecl: if locally included, uses that one, otherways uses the common one, i.e. local definitions override -->
      <xsl:variable name="chardecl" select="//t:charDecl"/>
      <xsl:variable name="glyphID" select="EDF:refID(current()/@ref)"/>
      
      <xsl:choose>
         
         <!--     if there is ref AND there actually is a glyph in the list with that id, then check what to print from the values in that glyph-->
         <xsl:when test="starts-with(@ref, '#') and $chardecl//t:glyph[@xml:id = $glyphID]">
            
            <xsl:for-each select="$chardecl//t:glyph[@xml:id = $glyphID]">
               <xsl:choose>
               <xsl:when test="$g[ancestor::t:div[@subtype='ogham']]">
               <span>
                    <!-- Extract `rend` for CSS class -->
                    <xsl:attribute name="class">
                        <xsl:value-of select="t:mapping[@type = 'ogham']/@rend"/>
                    </xsl:attribute>
                    <!-- Output diplomatic content -->
                    <xsl:value-of select="t:mapping[@type = 'ogham']"/>
                </span>

                  
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>

               <xsl:when test="$parm-edition-type = 'diplomatic'">
                     
                     
                           <xsl:value-of select="t:mapping[@type = 'diplomatic']"/>
                           
                           <xsl:call-template name="g-unclear-symbol"/>
                           
                  </xsl:when>
                  <xsl:when test="$parm-edition-type = 'interpretive'">
                     
<xsl:choose>
        <xsl:when test="$g[@ref = concat('#', $glyphID)]">
            <xsl:choose>
                <xsl:when test="$g/@type">
                    <xsl:value-of select="t:mapping[@type = $g/@type]"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="t:mapping[@type = 'interpretation']"/>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="g-unclear-symbol"/>
        </xsl:when>
    </xsl:choose>


                  </xsl:when>
                  </xsl:choose>
                  
            </xsl:for-each>
         </xsl:when>
         
         <!--         If there is a ref, but it does not start with #, it should be another URI,
         which is assumed to be like https://example.com/myCharDeclFile.xml#glyphID or
         ../../myCharDeclFile.xml#glyphID -->
         
         
         
         
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
         <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@type = 'crux' or @type = 'cross'">
                  <xsl:text>†</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'crosses'">
                  <xsl:text>††</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'denarius'">
                  <xsl:text>𐆖</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'drachma'">
                  <xsl:text>𐅵</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'sestercius'">
                  <xsl:text>𐆘</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'year'">
                  <xsl:text>L</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'stop'">
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
         <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:choose>
               <!--<xsl:when test="@type='denarius'">
                  <xsl:text>Ɩ</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type='sestercius'">
                  <xsl:text>Ƙ</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>-->
               <xsl:when test="@type = 'year'">
                  <xsl:text>L</xsl:text>
                  <xsl:call-template name="g-unclear-symbol"/>
               </xsl:when>
               <xsl:when test="@type = 'stop'">
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
      <xsl:param name="location" tunnel="yes" required="no"/>
      <xsl:choose>
         <xsl:when test="@type = 'downwards-ancora'">
            <xsl:text>⸔</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'upwards-ancora'">
            <xsl:text>⸕</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'antisigma'">
            <xsl:text>ͻ</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'antisigma-periestigmene'">
            <xsl:text>ͽ</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'apostrophe' or @type = 'diastole'">
            <xsl:text>’</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'asteriskos'">
            <xsl:text>※</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'backslash'">
            <xsl:text>\</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'upper-brace-opening'">
            <xsl:text>⎧</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'center-brace-opening'">
            <xsl:text>⎨</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'lower-brace-opening'">
            <xsl:text>⎩</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'upper-brace-closing'">
            <xsl:text>⎫</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'center-brace-closing'">
            <xsl:text>⎬</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'lower-brace-closing'">
            <xsl:text>⎭</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'check' or @type = 'check-mark'">
            <xsl:text>／</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'chirho'">
            <xsl:text>☧</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'dash'">
            <xsl:text>—</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'diple'">
            <xsl:text>›</xsl:text>
            <xsl:call-template name="g-unclear-string"/>
         </xsl:when>
         <xsl:when test="@type = 'diple-obelismene'">
            <xsl:text>⤚</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'diple-periestigmene'">
            <xsl:text>⸖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'dipunct' or @type = 'dicolon'">
            <xsl:text>∶</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'dot'">
            <xsl:text>•</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'filled-circle'">
            <xsl:text>⦿</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'filler' and @rend = 'extension'">
            <xsl:text>―</xsl:text>
            <xsl:call-template name="g-unclear-string"/>
         </xsl:when>
         <xsl:when test="@type = 'filler' and @rend = 'diple'">
            <xsl:text>›</xsl:text>
            <xsl:call-template name="g-unclear-string"/>
         </xsl:when>
         <xsl:when test="@type = 'hypodiastole'">
            <xsl:text>⸒</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'latin-interpunct' or @type = 'middot' or @type = 'mid-punctus'">
            <xsl:text>·</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'monogram'">
            <span class="italic">
               <xsl:text>monogr.</xsl:text>
               <xsl:call-template name="g-unclear-symbol"/>
            </span>
         </xsl:when>
         <xsl:when test="@type = 'dotted-obelos'">
            <xsl:text>⸓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'obelos'">
            <xsl:text>―</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-punctuation-closing'">
            <xsl:text>)</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-punctuation-opening'">
            <xsl:text>(</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-upper-opening'">
            <xsl:text>⎛</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-middle-opening'">
            <xsl:text>⎜</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-lower-opening'">
            <xsl:text>⎝</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-upper-closing'">
            <xsl:text>⎞</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-middle-closing'">
            <xsl:text>⎟</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'parens-lower-closing'">
            <xsl:text>⎠</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'low-punctus'">
            <xsl:text>.</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'high-punctus'">
            <xsl:text>˙</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'rho-cross'">
            <xsl:text>⳨</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'double-slanting-stroke'">
            <xsl:text>⸗</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'slanting-stroke'">
            <xsl:text>/</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'stauros'">
            <xsl:text>†</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'swungdash'">
            <xsl:text>⁓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'tachygraphic marks'">
            <span class="italic">
               <xsl:text>tachygr. marks</xsl:text>
               <xsl:call-template name="g-unclear-symbol"/>
            </span>
         </xsl:when>
         <xsl:when test="@type = 'tetrapunct'">
            <xsl:text>⁞</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'tripunct'">
            <xsl:text>⋮</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'double-vertical-bar'">
            <xsl:text>‖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'long-vertical-bar'">
            <xsl:text>|</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'chi-periestigmenon'">
            <xsl:text>Χ·</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'x'">
            <xsl:text>☓</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'xs'">
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
         <xsl:when test="@type = 'century'">
            <xsl:text>𐆛</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'milliaria'">
            <xsl:text>ↀ</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'leaf'">
            <xsl:text>❦</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'palm'">
            <xsl:text>††</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'star'">
            <xsl:text>*</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'interpunct' and not(node())">
            <xsl:text>·</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'interpunct' and node()">
            <xsl:apply-templates/>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'sestertius' and not(node())">
            <xsl:text>𐆘</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'sestertius' and node()">
            <xsl:apply-templates/>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'denarius'">
            <xsl:text>⸙</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'barless-A'">
            <xsl:text>Λ</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'dot'">
            <xsl:text>.</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'stop'">
            <xsl:text>•</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'crux' or @type = 'cross'">
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
         <xsl:when test="@type = 'dipunct'">
            <xsl:text>∶</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'tripunct'">
            <xsl:text>⋮</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = '|'">
            <xsl:text>|</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'middot'">
            <xsl:text>·</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'leaf'">
            <xsl:text>❦</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'year'">
            <xsl:text>∟</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'chirho'">
            <xsl:text>☧</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'stauros'">
            <xsl:text>†</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'swastika'">
            <xsl:text>卐</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'palmula'">
            <xsl:text>⸙</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = '⧖'">
            <xsl:text>⧖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = '⨇'">
            <xsl:text>⨇</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'denarius'">
            <xsl:text>𐆖</xsl:text>
            <xsl:call-template name="g-unclear-symbol"/>
         </xsl:when>
         <xsl:when test="@type = 'ligo'">
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