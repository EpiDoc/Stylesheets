<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <!-- Include all required stylesheets -->
    <xsl:include href="htm-teig.xsl"/>
    <xsl:include href="htm-teiab.xsl"/>
    <xsl:include href="htm-teidivedition.xsl"/>
    
    <!-- Override the templates that cause duplication -->
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>