<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">
  
    <xsl:template match="t:orig" priority="1">
        <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
        <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
        <xsl:choose>
            <xsl:when test="parent::t:choice">
                <xsl:choose>
                    <xsl:when test="$parm-leiden-style='medcyprus' and $parm-edition-type!='diplomatic'"/>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="origChildren">
                    <xsl:apply-templates/>                    
                </xsl:variable>
                <!-- Emit all uppercase characters for all text children of t:orig -->
                <xsl:value-of select="upper-case(translate(normalize-unicode(translate($origChildren,'&#x03f2;','&#x03f9;'),'NFD'),'&#x0300;&#x0301;&#x0308;&#x0313;&#x0314;&#x0342;&#x0345;',''))"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
  
</xsl:stylesheet>