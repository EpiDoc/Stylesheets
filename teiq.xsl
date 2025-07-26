<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
    
    <xsl:template match="t:q">
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
        <xsl:param name="parm-edn-structure" tunnel="yes" required="no"/>
        <xsl:choose>
            <xsl:when test="($parm-edn-structure = 'rib')">
                <xsl:text>‘</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>’</xsl:text>
            </xsl:when>
            <xsl:when test="($parm-leiden-style = ('ddbdp','dclp','sammelbuch', 'ogham'))">
                <xsl:text>'</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>'</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>