<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teisicandcorr.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t" version="1.0">
   <!-- Contains templates for sic and choice/corr and surplus -->

   <xsl:template match="t:choice/t:orig">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch'"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="t:choice/t:reg">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch'">
            <xsl:apply-templates/>
            <!-- cert-low template found in tpl-certlow.xsl -->
            <xsl:call-template name="cert-low"/>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
