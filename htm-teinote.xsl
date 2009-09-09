<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teinote.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Template in teinote.xsl -->
  <xsl:import href="teinote.xsl"/>

  <xsl:template match="t:note">
      <xsl:choose>
         <xsl:when test="ancestor::p or ancestor::l or ancestor::ab">
            <xsl:apply-imports/>
         </xsl:when>
         <xsl:otherwise>
            <p class="note">
               <xsl:apply-imports/>
            </p>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>