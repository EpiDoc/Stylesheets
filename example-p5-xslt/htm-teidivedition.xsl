<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">

   <!-- Other div matches can be found in htm-teidiv.xsl -->

   <!-- Text edition div -->
   <xsl:template match="t:div[@type = 'edition']" priority="1">
       <xsl:param name="parm-apparatus-style" tunnel="yes" required="no"></xsl:param>
       <div id="edition">
         <!-- Found in htm-tpl-lang.xsl -->
         <xsl:call-template name="attr-lang"/>
         <xsl:apply-templates/>

         <!-- Apparatus creation: look in tpl-apparatus.xsl for documentation and templates -->
           <xsl:if test="$parm-apparatus-style = 'ddbdp'">
            <!-- Framework found in htm-tpl-apparatus.xsl -->
            <xsl:call-template name="tpl-apparatus"/>
         </xsl:if>

      </div>
   </xsl:template>


   <!-- Textpart div -->
   <xsl:template match="t:div[@type='textpart']" priority="1">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
       <xsl:variable name="div-type">
           <xsl:for-each select="ancestor::t:div[@type!='edition']">
               <xsl:value-of select="@type"/>
               <xsl:text>-</xsl:text>
           </xsl:for-each>
       </xsl:variable>
       <xsl:variable name="div-loc">
         <xsl:for-each select="ancestor::t:div[@type='textpart'][@n]">
            <xsl:value-of select="@n"/>
            <xsl:text>-</xsl:text>
         </xsl:for-each>
      </xsl:variable>
      <xsl:if test="@n">
         <span class="textpartnumber" id="{$div-type}ab{$div-loc}{@n}">
           <!-- add ancestor textparts -->
             <xsl:if test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and @subtype">
              <xsl:value-of select="@subtype"/>
              <xsl:text> </xsl:text>
           </xsl:if>
              <xsl:value-of select="@n"/>
         </span>
      </xsl:if>
      
      <!-- Custodial events here -->
      <!-- first get the value of the columns @corresp -->
      <xsl:variable name="corresp" select="@corresp"/>
      <!-- then find each custEvent with a matching @corresp value -->
      
      <!--<xsl:if test="//t:custEvent[@type='unrolled']">
         <xsl:variable name="unroll-corresp" select="//t:custEvent[@type='unrolled']/@corresp"/>
         <xsl:variable name="unrolled-date" select="//t:custEvent[@type='unrolled']/@when"/>
         <xsl:variable name="unrolled-by" select="concat(//t:custEvent[@type='unrolled']/t:forename,' ',//t:custEvent[@type='unrolled']/t:surname)"/>
         <xsl:if test="contains($unroll-corresp,@corresp)">
            <span class="unrolled" id="ur{$div-loc}{@n}">
               Unrolled <xsl:value-of select="$unrolled-date"/> by <xsl:value-of select="$unrolled-by"/>
            </span>
            <br/>
            
         </xsl:if>
      </xsl:if>-->
      
      <xsl:for-each select="//t:custEvent">
         
         <xsl:if test="contains(@corresp,$corresp)">
            <span class="custevent" id="ce{$div-loc}{@n}">
               
               <!-- type of event -->
               <xsl:if test="@type">
               <xsl:value-of select="concat(upper-case(substring(@type, 1, 1)), substring(@type, 2))"/>
                  <xsl:if test="@when"><xsl:text> </xsl:text><xsl:value-of select="@when"/></xsl:if><xsl:text> by </xsl:text>
               </xsl:if> 
               
               <!-- responsible individual -->
               <xsl:choose>
               <xsl:when test="t:forename or t:surname">
                  <xsl:value-of select="t:forename"/>
                  <xsl:if test="t:forename and t:surname">
                     <xsl:text> </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="t:surname"/>
               </xsl:when>
               <xsl:otherwise>
                  [unidentified responsible individual]
               </xsl:otherwise>
            </xsl:choose></span>
            <br/>
         </xsl:if>
         
      </xsl:for-each>
      
      <br/>
      <xsl:apply-templates/>
   </xsl:template>
</xsl:stylesheet>
