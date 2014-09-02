<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">

   <!-- Other div matches can be found in htm-teidiv*.xsl -->

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

          <xsl:if test="$parm-apparatus-style = 'iospe' and not(descendant::t:div[@type='textpart'][@n])">
             <!-- Template found in htm-tpl-apparatus.xsl -->
             <xsl:call-template name="tpl-iospe-apparatus"/>
          </xsl:if>

      </div>
   </xsl:template>


   <!-- Textpart div -->
    <xsl:template match="t:div[@type='edition']//t:div[@type='textpart']" priority="1">
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
        <xsl:param name="parm-apparatus-style" tunnel="yes" required="no"/>
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
      <xsl:if test="@n"><!-- prints div number -->
         <span class="textpartnumber" id="{$div-type}ab{$div-loc}{@n}">
           <!-- add ancestor textparts -->
             <xsl:if test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and @subtype">
              <xsl:value-of select="@subtype"/>
              <xsl:text> </xsl:text>
           </xsl:if>
              <xsl:value-of select="@n"/>
         </span>
      </xsl:if>
      <xsl:apply-templates/>
       <xsl:if test="$parm-apparatus-style = 'iospe' and @n">
           <!-- Template found in htm-tpl-apparatus.xsl -->
           <xsl:call-template name="tpl-iospe-apparatus"/>
       </xsl:if>
   </xsl:template>
</xsl:stylesheet>
