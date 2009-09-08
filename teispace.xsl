<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teispace.xsl 1450 2008-08-07 13:17:24Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Found in [htm|txt]-teispace.xsl -->

  <xsl:template match="space">
    <xsl:if test="following::*[1][local-name() = 'lb'][@type='worddiv']">
      <xsl:text>- </xsl:text>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="$edition-type = 'diplomatic'">
        <xsl:choose>
          <xsl:when test="@unit='line'">
            <xsl:text>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;</xsl:text>
            <xsl:call-template name="dip-space"/>
          </xsl:when>
          <xsl:when test="@unit='character' or not(@unit)">
            <xsl:variable name="sp-ext">
              <xsl:choose>
                <xsl:when test="number(@extent)">
                  <xsl:number value="@extent"/>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:number value="3"/>
                </xsl:otherwise>
              </xsl:choose>
            </xsl:variable>
            <xsl:call-template name="nbsp">
              <xsl:with-param name="extent" select="$sp-ext"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:when>

      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$leiden-style='ddbdp'">
            <xsl:text>vac. </xsl:text>
          </xsl:when>
          <xsl:when test="$leiden-style='london'">
            <xsl:choose>
              <xsl:when test="@extent = 'unknown'">
                <!-- Found in [htm|txt]-teispace.xsl -->
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vac. '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@extent = string(1) and @unit='character'">
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'v. '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@extent = string(2) and @unit='character'">
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vv. '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="contains('345', @extent) and @unit='character'">
                <!-- Found in [htm|txt]-teispace.xsl -->
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vac. '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@extent >= 6 and @unit='character'">
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vacat '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@unit='line'">
                <xsl:text>&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;&#xa0;</xsl:text>
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vacat '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vac. '"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>


          <xsl:when test="$leiden-style='panciera'">
            <xsl:variable name="precision">
              <xsl:choose>
                <xsl:when test="not(@precision)"/>
                <xsl:when test="@precision = 'exact'"/>
                <xsl:when test="@precision = 'circa'">?</xsl:when>
              </xsl:choose>
            </xsl:variable>

            <xsl:choose>
              <xsl:when test="@extent = 'unknown'">
                <!-- Found in [htm|txt]-teispace.xsl -->
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vac. '"/>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@extent != 'unknown' and @unit='character'">
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat">vac.</xsl:with-param>
                  <xsl:with-param name="extent">
                    <xsl:value-of select="@extent"/>
                    <xsl:value-of select="$precision"/>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@extent = string(1) and @unit='line'">
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat">vac.</xsl:with-param>
                  <xsl:with-param name="extent"><xsl:value-of select="@extent"/> line<xsl:value-of select="$precision"/></xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="contains('23456789', @extent) and @unit='line'">
                <!-- Found in [htm|txt]-teispace.xsl -->
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat">vac.</xsl:with-param>
                  <xsl:with-param name="extent"><xsl:value-of select="@extent"/> lines<xsl:value-of select="$precision"/></xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:when test="@extent != 'unknown' and @unit != 'line' and @unit != 'character'">
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat">vac.</xsl:with-param>
                  <xsl:with-param name="extent">
                    <xsl:value-of select="@extent"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="@unit"/>
                    <xsl:value-of select="$precision"/>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="space-content">
                  <xsl:with-param name="vacat" select="'vac. '"/>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>


          <xsl:otherwise>
            <xsl:call-template name="space-content">
              <xsl:with-param name="vacat" select="'vac. '"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="nbsp">
    <xsl:param name="extent"/>
    <xsl:if test="$extent > 0">
      <xsl:text>&#xa0;</xsl:text>
      <xsl:call-template name="nbsp">
        <xsl:with-param name="extent" select="$extent - 1"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <!-- Called from [htm|txt]-teispace.xsl -->
  <xsl:template name="space-content-1">
    <xsl:param name="vacat"/>

    <xsl:text> </xsl:text>
    <xsl:if test="following-sibling::certainty[@target=current()/@id and @degree='low']">
      <xsl:text>?</xsl:text>
    </xsl:if>
    <xsl:value-of select="$vacat"/>
  </xsl:template>


  <!-- Called from [htm|txt]-teispace.xsl -->
  <xsl:template name="space-content-2">
    <xsl:param name="vacat"/>
    <xsl:param name="extent"/>

    <xsl:text>(</xsl:text>
    <xsl:value-of select="$vacat"/>
    <xsl:if test="following-sibling::certainty[@target=current()/@id and @degree='low']">
      <xsl:text>?</xsl:text>
    </xsl:if>
    <xsl:text> </xsl:text>
    <xsl:if test="string-length($extent) &gt; 0">
      <xsl:text> </xsl:text>
      <xsl:value-of select="$extent"/>
    </xsl:if>
    <xsl:text>)</xsl:text>
  </xsl:template>

</xsl:stylesheet>
