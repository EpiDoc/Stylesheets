<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teiaddanddel.xsl 1510 2008-08-14 15:27:51Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Contains templates for subst, add and del -->

  <xsl:template match="subst">
    <xsl:apply-templates/>

    <xsl:if test="$apparatus-style = 'ddbdp'">
    <!-- Found in [htm|txt]-tpl-apparatus -->
      <xsl:call-template name="app-link">
        <xsl:with-param name="location" select="'text'"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>


  <xsl:template match="add">
    <xsl:choose>
      <xsl:when test="$leiden-style = 'ddbdp'">
        <xsl:choose>
          <xsl:when test="parent::subst"/>
          <xsl:when test="@place = 'supralinear'">
            <xsl:text>\</xsl:text>
          </xsl:when>
          <xsl:when test="@place = 'infralinear'">
            <xsl:text>/</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="parent::subst or @place='overstrike'">
            <xsl:text>&#xAB;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>`</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:apply-templates/>
    <xsl:call-template name="cert-low"/>

    <xsl:choose>
      <xsl:when test="$leiden-style = 'ddbdp'">
        <xsl:choose>
          <xsl:when test="parent::subst"/>
          <xsl:when test="@place = 'supralinear'">
            <xsl:text>/</xsl:text>
          </xsl:when>
          <xsl:when test="@place = 'infralinear'">
            <xsl:text>\</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="parent::subst or @place='overstrike'">
            <xsl:text>&#xBB;</xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>&#xb4;</xsl:text>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="del">
    <xsl:if test="$apparatus-style = 'ddbdp'">
      <xsl:if test="@rend = 'slashes' or @rend = 'cross-strokes'">
        <!-- Found in [htm | txt]-tpl-apparatus -->
        <xsl:call-template name="app-link">
          <xsl:with-param name="location" select="'text'"/>
        </xsl:call-template>
      </xsl:if>
    </xsl:if>

    <xsl:choose>
      <xsl:when test="$leiden-style = 'ddbdp' and @rend='slashes'">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="$leiden-style = 'ddbdp' and @rend='cross-strokes'">
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:when test="parent::subst"/>
      <xsl:otherwise>
        <xsl:text>&#x301A;</xsl:text>
        <xsl:apply-templates/>
        <xsl:call-template name="cert-low"/>
        <xsl:text>&#x301B;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
