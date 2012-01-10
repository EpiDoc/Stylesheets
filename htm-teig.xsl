<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
  <!-- Import templates can be found in teig.xsl -->
  <xsl:import href="teig.xsl"/>

  <xsl:template match="t:g">
      <xsl:call-template name="lb-dash"/>
      <xsl:call-template name="w-space"/>
    
     <xsl:choose>
        <xsl:when test="starts-with($leiden-style, 'edh')"/>
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch')">
        <!-- Found in teig.xsl -->
        <xsl:call-template name="g-ddbdp"/>
         </xsl:when>
         <xsl:when test="$leiden-style = 'london'">
            <xsl:call-template name="g-london"/>
         </xsl:when>
         <xsl:when test="$edition-type = 'diplomatic'">
            <xsl:text> </xsl:text>
            <em>
               <span class="smaller">
                  <xsl:apply-imports/>
               </span>
            </em>
            <xsl:text> </xsl:text>
         </xsl:when>
        <xsl:when test="$leiden-style = 'dohnicht'">
           <xsl:text>⊂</xsl:text>
           <xsl:apply-imports/>
           <xsl:text>⊃</xsl:text>
        </xsl:when>
        <xsl:otherwise>
           <xsl:text>((</xsl:text>
           <xsl:apply-imports/>
           <xsl:text>))</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
    
      <xsl:call-template name="w-space"/>
  </xsl:template>

</xsl:stylesheet>