<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teisicandcorr.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Contains templates for sic and choice/corr -->


  <xsl:template match="sic">
    <xsl:choose>
      <xsl:when test="$edition-type = 'diplomatic' and parent::choice[@type='correction']">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="parent::choice">
            <xsl:choose>
              <xsl:when test="$leiden-style = 'edh'">
                <xsl:apply-templates/>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>{</xsl:text>
            <xsl:apply-templates/>
            <!-- cert-low template found in tpl-certlow.xsl -->
            <xsl:call-template name="cert-low"/>
            <xsl:text>}</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="choice/corr">
    <xsl:choose>
      <xsl:when test="$edition-type = 'diplomatic' and parent::choice[@type='correction']"/>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:apply-templates/>
            <!-- cert-low template found in tpl-certlow.xsl -->
            <xsl:call-template name="cert-low"/>
          </xsl:when>
          <xsl:when test="$leiden-style = 'seg'">
            <xsl:text>&lt;</xsl:text>
            <xsl:apply-templates/>
            <!-- cert-low template found in tpl-certlow.xsl -->
            <xsl:call-template name="cert-low"/>
            <xsl:text>&gt;</xsl:text>
          </xsl:when>
          <xsl:when test="$leiden-style = 'edh'">
            <xsl:apply-templates/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#x231C;</xsl:text>
            <xsl:apply-templates/>
            <!-- cert-low template found in tpl-certlow.xsl -->
            <xsl:call-template name="cert-low"/>
            <xsl:text>&#x231D;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
