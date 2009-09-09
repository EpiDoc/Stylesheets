<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teilb.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Imported by [htm|txt]-teilb.xsl -->
  
  <xsl:template match="t:lb">
      <xsl:if test="ancestor::l">
         <xsl:choose>
            <xsl:when test="@type = 'worddiv'">
               <xsl:text>|</xsl:text>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text> | </xsl:text>
            </xsl:otherwise>
         </xsl:choose>
      
         <xsl:choose>
        <!-- If verse-line is needed in ddbdp and @n is not a number ie 2a -->
        <xsl:when test="$verse-lines = 'on' and not(number(@n)) and $leiden-style = 'ddbdp'">
               <xsl:call-template name="lb-content"/>
            </xsl:when>
            <xsl:when test="@n mod $line-inc = 0 and not(@n = 0)">
               <xsl:call-template name="lb-content"/>
            </xsl:when>
         </xsl:choose>
      </xsl:if>
  </xsl:template>
  

  <xsl:template name="lb-content">
      <xsl:choose>
         <xsl:when test="@type = 'worddiv'">
            <xsl:text>(</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>)</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>(</xsl:text>
            <xsl:value-of select="@n"/>
            <xsl:text>) </xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>