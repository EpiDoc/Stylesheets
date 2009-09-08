<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  
  <xsl:template name="license">
    <xsl:apply-templates select="//publicationStmt" mode="license"/>
  </xsl:template>
  
  <xsl:template match="publicationStmt" mode="license">
    <div id="license">
    <xsl:choose>
      <xsl:when test="p">
        <xsl:if test="contains(p/xref[@type='license']/@href,'creativecommons')">
          <img src="http://i.creativecommons.org/l/{substring-after(p/xref[@type='license']/@href, 'licenses/')}88x31.png" alt="{p/xref[@type='license']}" align="left"/>
        </xsl:if>
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="contains(availability/xref[@type='license']/@href,'creativecommons')">
          <img src="http://i.creativecommons.org/l/{substring-after(availability/xref[@type='license']/@href, 'licenses/')}88x31.png" alt="{availability/xref[@type='license']}" align="left"/>
        </xsl:if>
        <xsl:apply-templates select="availability"/>
      </xsl:otherwise>
    </xsl:choose>
    </div>
  </xsl:template>
  
  <xsl:template match="xref[@type='license']">
    <a rel="license" href="{@href}"><xsl:apply-templates/></a>
  </xsl:template>
  
</xsl:stylesheet>