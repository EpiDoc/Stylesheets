<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teisicandcorr.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Contains templates for sic and choice/corr -->


  <xsl:template match="t:sic">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic' and parent::t:choice[@type='correction']">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="parent::t:choice">
                  <xsl:choose>
                     <xsl:when test="$leiden-style = 'edh'">
                        <xsl:apply-templates/>
                     </xsl:when>
                     <xsl:otherwise/>
                  </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>{</xsl:text>
                  <xsl:apply-templates/>
                  <!-- cert-low template found in tpl-certlow.xsl -->
            <xsl:call-template name="cert-low"/>
                  <xsl:text>}</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template match="t:choice/t:corr">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic' and parent::t:choice[@type='correction']"/>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="$leiden-style = 'ddbdp'">
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
               <xsl:when test="$leiden-style = 'edh'">
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