<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: start-edition.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="tei">
  <xsl:output method="xml" encoding="UTF-8"/>

  <xsl:include href="global-varsandparams.xsl"/>

  <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
  <xsl:include href="htm-teiab.xsl"/>
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
  <xsl:include href="htm-teixref.xsl"/>
  
  <!-- tei stylesheets that are also used by start-txt -->
  <xsl:include href="teiabbrandexpan.xsl"/>
  <xsl:include href="teiaddanddel.xsl"/>
  <xsl:include href="teichoice.xsl"/>
  <xsl:include href="teihandshift.xsl"/>
  <xsl:include href="teiheader.xsl"/>
  <xsl:include href="teimilestone.xsl"/>
  <xsl:include href="teiorig.xsl"/>
  <xsl:include href="teiq.xsl"/>
  <xsl:include href="teisicandcorr.xsl"/>
  <xsl:include href="teispace.xsl"/>
  <xsl:include href="teisupplied.xsl"/>
  <xsl:include href="teiunclear.xsl"/>

  <!-- html related stylesheets for named templates -->
  <xsl:include href="htm-tpl-cssandscripts.xsl"/>
  <xsl:include href="htm-tpl-apparatus.xsl"/>
  <xsl:include href="htm-tpl-lang.xsl"/>
  <xsl:include href="htm-tpl-metadata.xsl"/>
  <xsl:include href="htm-tpl-nav.xsl"/>
  <xsl:include href="htm-tpl-license.xsl"/>

  <!-- global named templates with no html, also used by start-txt -->
  <xsl:include href="tpl-reasonlost.xsl"/>
  <xsl:include href="tpl-certlow.xsl"/>
  <xsl:include href="tpl-text.xsl"/>



  <!-- HTML FILE -->
  <xsl:template match="/">
    <html>
      <head>        
        <title>
          <xsl:if test="$leiden-style = 'ddbdp'">
            <xsl:value-of select="TEI.2/@id"/>
            <xsl:text> </xsl:text>
          </xsl:if>
          <xsl:text>Greek Leiden Edition View</xsl:text>
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <!-- Found in htm-tpl-cssandscripts.xsl -->
        <xsl:call-template name="css-script"/>
      </head>
      <body>

        <!-- Found in htm-tpl-nav.xsl -->
        <xsl:call-template name="topNavigation"/>

        
        <!-- Heading for a ddb style file -->
        <xsl:if test="$leiden-style = 'ddbdp'">
          <h1>
            <xsl:value-of select="TEI.2/@id"/>
          </h1>
        </xsl:if>


        <!-- Found in htm-tpl-metadata.xsl -->
        <!-- Would need to change once combined 
        <xsl:if test="starts-with(//TEI.2/@id, 'hgv')">
          <xsl:call-template name="metadata"/>
        </xsl:if>-->
        
        
        <!-- Main text output -->
        <xsl:apply-templates/>
        
        <xsl:call-template name="license"/>

      </body>
    </html>
  </xsl:template>



</xsl:stylesheet>
