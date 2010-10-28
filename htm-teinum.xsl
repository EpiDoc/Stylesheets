<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teinum.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">
  <!-- Template in teinum.xsl -->
  <xsl:import href="teinum.xsl"/>
  
  <xsl:template match="t:num">
     <span>
        <xsl:if test="contains(@value,'/') and $leiden-style='ddbdp'">
           <xsl:attribute name="title">
              <xsl:text>fraction: </xsl:text>
              <xsl:value-of select="@value"/>
           </xsl:attribute>
        </xsl:if>
      <xsl:choose>
         <xsl:when test="ancestor::t:*[@xml:lang][1][@xml:lang = 'la']">
            <span class="latinnum">
               <xsl:apply-imports/>
            </span>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-imports/>
         </xsl:otherwise>
      </xsl:choose>
     </span>
  </xsl:template>
  
</xsl:stylesheet>