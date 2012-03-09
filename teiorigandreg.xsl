<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   <!-- Contains templates for choice/orig and choice/reg and surplus -->

   <xsl:template match="t:choice/t:orig">
      <xsl:apply-templates/>
      <xsl:if test="$leiden-style = 'ddbdp'">
         <!-- found in tpl-certlow.xsl -->
         <xsl:call-template name="cert-low"/>
         <!-- if context is inside the app-part of an app-like element, print reg as well -->
         <xsl:if test="ancestor::t:*[local-name()=('reg','corr','rdg') 
            or self::t:del[@rend='corrected']]">
            <!--<xsl:if test="ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg') 
               or self::t:del[@rend='corrected'] 
               or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')]">-->
               <xsl:text> (</xsl:text><xsl:for-each select="../t:reg">
                  <xsl:sort select="position()" order="descending"/>
                  <xsl:call-template name="multreg"/>
               </xsl:for-each><xsl:text>)</xsl:text>
            </xsl:if>
         </xsl:if>
   </xsl:template>

   <xsl:template match="t:choice/t:reg"/>
   <!-- reg is not displayed in text in any Leiden-style -->

</xsl:stylesheet>
