<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teisupplied.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">

  <xsl:template match="t:supplied[@reason='lost']">
      <xsl:if test="$leiden-style = 'ddbdp' and child::t:*[1][local-name() = 'milestone'][@rend = 'paragraphos']">
         <br/>
      </xsl:if>
      <xsl:choose>
         <xsl:when test="@evidence = 'parallel'">
        <!-- Found in [htm|txt]-teisupplied.xsl -->
        <xsl:call-template name="supplied-parallel"/>
         </xsl:when>
         <xsl:otherwise>
        <!-- Found in tpl-reasonlost.xsl -->
        <xsl:call-template name="lost-opener"/>
            <xsl:choose>
               <xsl:when test="$edition-type = 'diplomatic'">
                  <xsl:variable name="supplied-content">
                     <xsl:value-of select="descendant::text()"/>
                  </xsl:variable>
                  <xsl:variable name="sup-context-length">
                     <xsl:value-of select="string-length(normalize-space($supplied-content))"/>
                  </xsl:variable>
                  <xsl:variable name="space-ex">
                     <xsl:choose>
                        <xsl:when test="number(descendant::t:space/@extent)">
                           <xsl:number value="descendant::t:space/@extent"/>
                        </xsl:when>
                        <xsl:otherwise>
                           <xsl:number value="1"/>
                        </xsl:otherwise>
                     </xsl:choose>
                  </xsl:variable>
            
                  <xsl:for-each select="t:g">
                     <xsl:text>··</xsl:text>
                  </xsl:for-each>
                  <!-- Found in teigap.xsl -->
            <xsl:call-template name="dot-out">
                     <xsl:with-param name="cur-num" select="$sup-context-length"/>
                  </xsl:call-template>
                  <xsl:call-template name="dot-out">
                     <xsl:with-param name="cur-num" select="$space-ex"/>
                  </xsl:call-template>
            
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
            <!-- Found in tpl-cert-low.xsl -->
        <xsl:call-template name="cert-low"/>
            <!-- Found in tpl-reasonlost.xsl -->
        <xsl:call-template name="lost-closer"/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  

  <xsl:template match="t:supplied[@reason='omitted']">
      <xsl:choose>
         <xsl:when test="@evidence = 'parallel'">
        <!-- Found in [htm|txt]-teisupplied.xsl -->
        <xsl:call-template name="supplied-parallel"/>
         </xsl:when>
         <xsl:otherwise>
            <xsl:text>&lt;</xsl:text>
            <xsl:apply-templates/>
            <!-- Found in tpl-cert-low.xsl -->
        <xsl:call-template name="cert-low"/>
            <xsl:text>&gt;</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>
  

  <xsl:template match="t:supplied[@reason='subaudible']">
      <xsl:text>(</xsl:text>
      <xsl:apply-templates/>
      <xsl:call-template name="cert-low"/>
      <xsl:text>)</xsl:text>
  </xsl:template>
  

  <xsl:template match="t:supplied[@reason='explanation']">
      <xsl:text>(i.e. </xsl:text>
      <xsl:apply-templates/>
      <xsl:call-template name="cert-low"/>
      <xsl:text>)</xsl:text>
  </xsl:template>


</xsl:stylesheet>