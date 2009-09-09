<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teiseg.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- seg[@type='autopsy'] span added in htm-teiseg.xsl -->
  
  <xsl:template match="seg | w">
      <xsl:if test="leiden-style='london' and (@part='M' or @part='F')                     and not(preceding-sibling::node()[1][self::gap])">
         <xsl:text>-</xsl:text>
      </xsl:if>
    
      <xsl:apply-templates/>
    
      <!-- Found in tpl-certlow.xsl -->
    <xsl:call-template name="cert-low"/>
    
      <xsl:if test="leiden-style='london' and (@part='I' or @part='M')        and not(following-sibling::node()[1][self::gap])       and not(descendant::ex[last()])">
         <xsl:text>-</xsl:text>
      </xsl:if>
  </xsl:template>
  
 

</xsl:stylesheet>