<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teisicandcorr.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t" version="1.0">
   <!-- Contains templates for choice/sic and choice/corr and surplus -->

   <xsl:template match="t:choice/t:sic">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic' or $leiden-style = 'sammelbuch'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="$leiden-style='ddbdp'">
            <!-- commented out until later DDbDP switch-over
                 <xsl:apply-templates/>
                 <xsl:call-template name="cert-low"/> -->
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>

   <!--<xsl:template match="t:surplus">
      MOVED TO teisurplus.xsl -->

   <xsl:template match="t:choice/t:corr">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic' or $leiden-style = 'sammelbuch'"/>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="$leiden-style = 'ddbdp'">
                  <!-- to be removed when later DDbDP switch-over -->
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
                  <xsl:call-template name="cert-low"/>
               </xsl:when>
               <xsl:when test="$leiden-style = 'seg'">
                  <xsl:text>&lt;</xsl:text>
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
                  <xsl:call-template name="cert-low"/>
                  <xsl:text>&gt;</xsl:text>
               </xsl:when>
               <xsl:when test="starts-with($leiden-style, 'edh')">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>⌜</xsl:text>
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
                  <xsl:call-template name="cert-low"/>
                  <xsl:text>⌝</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
