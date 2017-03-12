<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   exclude-result-prefixes="t" version="2.0">
   <!-- More specific templates in teimilestone.xsl -->

   <xsl:template match="t:milestone">
       <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <!-- <xsl:message>htm-teimilestone.xsl: match=t:milestone; parm-leiden-style: <xsl:value-of select="$parm-leiden-style"/></xsl:message> -->
      
       <xsl:choose>
         <xsl:when
             test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch') and ancestor::t:div[@type = 'translation']">
            <xsl:if test="@rend = 'break'">
               <br/>
            </xsl:if>
            <sup>
               <strong>
                  <xsl:value-of select="@n"/>
               </strong>
            </sup>
            <xsl:text> </xsl:text>
         </xsl:when>
           <xsl:when test="($parm-leiden-style = 'ddbdp' or $parm-leiden-style = 'sammelbuch')">
            <xsl:choose>
               <xsl:when test="@rend = 'wavy-line'">
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>~~~~~~~~</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'paragraphos'">
                  <!-- <xsl:message><xsl:text>    </xsl:text>paragraphos!</xsl:message> -->
                  <xsl:if test="following-sibling::node()[not(self::text() and normalize-space(self::text())='')][1]/self::t:lb[@break='no']">-</xsl:if>
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>——</xsl:text>
               </xsl:when>
               <xsl:when test="@rend = 'horizontal-rule'">
                  <xsl:if test="not(parent::t:supplied)">
                     <br/>
                  </xsl:if>
                  <xsl:text>————————</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <br/>
            <xsl:value-of select="@rend"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

</xsl:stylesheet>
