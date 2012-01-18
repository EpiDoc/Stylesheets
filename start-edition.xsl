<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" 
   exclude-result-prefixes="t" version="2.0">
   <xsl:output method="xml" encoding="UTF-8"/>

   <xsl:include href="global-varsandparams.xsl"/>

   <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
   <xsl:include href="htm-teiab.xsl"/>
   <xsl:include href="htm-teiaddanddel.xsl"/>
   <xsl:include href="htm-teiapp.xsl"/>
   <xsl:include href="htm-teidiv.xsl"/>
   <xsl:include href="htm-teidivedition.xsl"/>
   <xsl:include href="htm-teiforeign.xsl"/>
   <xsl:include href="htm-teifigure.xsl"/>
   <xsl:include href="htm-teig.xsl"/>
   <xsl:include href="htm-teigap.xsl"/>
   <xsl:include href="htm-teihead.xsl"/>
   <xsl:include href="htm-teihi.xsl"/>
   <xsl:include href="htm-teilb.xsl"/>
   <xsl:include href="htm-teilgandl.xsl"/>
   <xsl:include href="htm-teilistanditem.xsl"/>
   <xsl:include href="htm-teilistbiblandbibl.xsl"/>
   <xsl:include href="htm-teimilestone.xsl"/>
   <xsl:include href="htm-teinote.xsl"/>
   <xsl:include href="htm-teinum.xsl"/>
   <xsl:include href="htm-teip.xsl"/>
   <xsl:include href="htm-teiseg.xsl"/>
   <xsl:include href="htm-teispace.xsl"/>
   <xsl:include href="htm-teisupplied.xsl"/>
   <xsl:include href="htm-teiterm.xsl"/>
   <xsl:include href="htm-teiref.xsl"/>

   <!-- tei stylesheets that are also used by start-txt -->
   <xsl:include href="teiabbrandexpan.xsl"/>
   <xsl:include href="teicertainty.xsl"/>
   <xsl:include href="teichoice.xsl"/>
   <xsl:include href="teihandshift.xsl"/>
   <xsl:include href="teiheader.xsl"/>
   <xsl:include href="teimilestone.xsl"/>
   <xsl:include href="teiorig.xsl"/>
   <xsl:include href="teiorigandreg.xsl"/>
   <xsl:include href="teiq.xsl"/>
   <xsl:include href="teisicandcorr.xsl"/>
   <xsl:include href="teispace.xsl"/>
   <xsl:include href="teisupplied.xsl"/>
   <xsl:include href="teisurplus.xsl"/>
   <xsl:include href="teiunclear.xsl"/>

   <!-- html related stylesheets for named templates -->
   <xsl:include href="htm-tpl-cssandscripts.xsl"/>
   <xsl:include href="htm-tpl-apparatus.xsl"/>
   <xsl:include href="htm-tpl-lang.xsl"/>
   <xsl:include href="htm-tpl-metadata.xsl"/>
   <xsl:include href="htm-tpl-structure.xsl"/>
   <!--<xsl:include href="htm-tpl-nav.xsl"/>--><!--      No longer exists      -->
   <xsl:include href="htm-tpl-license.xsl"/>
   <xsl:include href="htm-tpl-sqbrackets.xsl"/>

   <!-- global named templates with no html, also used by start-txt -->
   <!--<xsl:include href="tpl-reasonlost.xsl"/>--> <!-- Deprecated -->
   <xsl:include href="tpl-certlow.xsl"/>
   <xsl:include href="tpl-text.xsl"/>



   <!-- HTML FILE -->
   <xsl:template match="/">
      <xsl:choose>
         <xsl:when test="$edn-structure = 'london'">
            <!-- this and other structure templates found in htm-tpl-structure.xsl -->
            <xsl:call-template name="london-structure"/>
         </xsl:when>
         <xsl:when test="$edn-structure = 'hgv'">
            <xsl:call-template name="hgv-structure"/>
         </xsl:when>
         <xsl:when test="$edn-structure = 'ddbdp'">
            <div>
              <xsl:call-template name="default-body-structure"/>
            </div>
         </xsl:when>
         <xsl:otherwise>
            <xsl:call-template name="default-structure"/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>



</xsl:stylesheet>
