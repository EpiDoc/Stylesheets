<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: txt-teiapp.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">

  <xsl:template match="t:app">
      <xsl:apply-templates/>

      <xsl:if test="$apparatus-style = 'ddbdp'">
      <!-- Found in txt-tpl-apparatus -->
      <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>


  <xsl:template match="t:rdg">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@resp='previous'"/>
               <xsl:when test="@resp='autopsy'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="@resp='previous'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:when test="@resp='autopsy'"/>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template match="t:wit">
      <xsl:choose>
      <!-- Temporary -->
      <xsl:when test="parent::t:app"/>

         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>



</xsl:stylesheet>