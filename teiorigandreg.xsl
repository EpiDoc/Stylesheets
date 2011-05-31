<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t" version="2.0">
   <!-- Contains templates for choice/orig and choice/reg and surplus -->

   <xsl:template match="t:choice/t:orig">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:choose>
               <xsl:when test="not(../t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)])">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>
         <!-- commented out until later DDbDP switch-over
               <xsl:apply-templates/>
               <xsl:call-template name="cert-low"/> -->
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="t:choice/t:reg">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:choose>
               <xsl:when test="@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang"/>
               <xsl:when test="preceding-sibling::t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)]"/>
               <xsl:otherwise>
                  <!-- to be removed when later DDbDP switch-over -->
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
                  <xsl:call-template name="cert-low"/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
