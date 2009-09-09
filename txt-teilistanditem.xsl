<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teilistanditem.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Need to find unicode for bullets, indenting -->

  <xsl:template match="t:list">
      <xsl:apply-templates/>
  </xsl:template>
  
  
  <xsl:template match="t:item">
      <xsl:text>
&#xD;</xsl:text>
      <!-- Adds numbering if ordered -->
    <xsl:if test="parent::t:list[@type = 'ordered']">
         <xsl:number count="t:item" from="t:list"/>
         <xsl:text>. </xsl:text>
      </xsl:if>
    
      <xsl:apply-templates/>
  </xsl:template>
  
</xsl:stylesheet>