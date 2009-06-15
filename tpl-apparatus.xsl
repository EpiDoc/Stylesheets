<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: tpl-apparatus.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- Generates the apparatus from the edition -->
  <!-- 
    Adding to Apparatus:
    1. Add to apparatus: [htm | txt]-tpl-apparatus.xsl add case to the ifs and for-each (3 places) 
       - NOTE the app-link 'if' is checking for nested cases, therefore looking for ancestors.
    2. Indicator in text: [htm | txt]-element.xsl to add call-template to [htm | txt]-tpl-apparatus.xsl for links and/or stars.
    3. Add to ddbdp-app template below using local-name() to define context
  -->

  <!-- Defines the output of individual elements in apparatus -->
  <xsl:template name="ddbdp-app">
    <xsl:variable name="div-loc">
      <xsl:for-each select="ancestor::div[starts-with(@type, 'textpart_')]">
        <xsl:value-of select="@n"/>
        <xsl:text>.</xsl:text>
      </xsl:for-each>
    </xsl:variable>
    <xsl:choose>
      <xsl:when
        test="not(ancestor::choice[child::sic and child::corr] or ancestor::subst or ancestor::app or 
        ancestor::hi[@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'])">
        <xsl:value-of select="$div-loc"/>
        <xsl:value-of select="preceding::*[local-name() = 'lb'][1]/@n"/>
        <xsl:text>. </xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> : </xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:choose>
      <!-- choice -->
      <xsl:when test="local-name() = 'choice' and child::sic and child::corr">
        <xsl:apply-templates select="sic/node()"/>
        <xsl:text> pap.</xsl:text>
      </xsl:when>

      <!-- subst -->
      <xsl:when test="local-name() = 'subst'">
        <xsl:text>corr. from </xsl:text>
        <xsl:apply-templates select="del/node()"/>
      </xsl:when>

      <!-- app -->
      <xsl:when test="local-name() = 'app'">
        <xsl:choose>
          <xsl:when test="@type = 'alternative'">
            <xsl:text>or </xsl:text>
            <xsl:apply-templates select="rdg/node()"/>
          </xsl:when>
          <xsl:when test="@type = 'editorial' or @type = 'BL'">
            <xsl:if test="@type = 'BL'">
              <xsl:text>BL</xsl:text>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="string(normalize-space(lem/@resp))">
                <xsl:text> </xsl:text>
                <xsl:value-of select="lem/@resp"/>
              </xsl:when>
              <xsl:when test="@type = 'editorial'">
                <xsl:text>Subsequent ed.</xsl:text>
              </xsl:when>
            </xsl:choose>
            <xsl:text>: </xsl:text>
            <xsl:choose>
              <xsl:when test="not(string(normalize-space(rdg/node())))">
                <xsl:text> Om.</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="rdg/node()"/>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text> Original ed.</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>

      <!-- hi -->
      <xsl:when test="local-name() = 'hi'">
        <xsl:call-template name="trans-string">
          <xsl:with-param name="trans-text">
            <xsl:call-template name="string-after-space">
              <xsl:with-param name="test-string" select="preceding-sibling::node()[1][self::text()]"/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:choose>
          <xsl:when test="@rend = 'diaeresis'">
            <xsl:call-template name="trans-string"/>
            <xsl:text>&#x0308;</xsl:text>
          </xsl:when>
          <xsl:when test="@rend = 'varia'">
            <xsl:call-template name="trans-string"/>
            <xsl:text>&#x0300;</xsl:text>
          </xsl:when>
          <xsl:when test="@rend = 'oxia'">
            <xsl:call-template name="trans-string"/>
            <xsl:text>&#x0301;</xsl:text>
          </xsl:when>
          <xsl:when test="@rend = 'dasia'">
            <xsl:call-template name="trans-string"/>
            <xsl:text>&#x0314;</xsl:text>
          </xsl:when>
          <xsl:when test="@rend = 'psili'">
            <xsl:call-template name="trans-string"/>
            <xsl:text>&#x0313;</xsl:text>
          </xsl:when>
          <xsl:when test="@rend = 'perispomeni'">
            <xsl:call-template name="trans-string"/>
            <xsl:text>&#x0342;</xsl:text>
          </xsl:when>
        </xsl:choose>

        <xsl:call-template name="trans-string">
          <xsl:with-param name="trans-text">
            <xsl:call-template name="string-before-space">
              <xsl:with-param name="test-string" select="following-sibling::node()[1][self::text()]"/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>

        <xsl:text> pap.</xsl:text>
      </xsl:when>

      <!-- del -->
      <xsl:when test="local-name() = 'del'">
        <xsl:choose>
          <xsl:when test="@rend = 'slashes'">
            <xsl:text>Text canceled with slashes</xsl:text>
          </xsl:when>
          <xsl:when test="@rend = 'cross-strokes'">
            <xsl:text>Text canceled with cross-strokes</xsl:text>
          </xsl:when>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="local-name() = 'milestone'">
        <xsl:if test="@rend = 'box'">
          <xsl:text>Text in box.</xsl:text>
        </xsl:if>
      </xsl:when>

    </xsl:choose>
  </xsl:template>


  <xsl:template name="string-after-space">
    <xsl:param name="test-string"/>

    <xsl:choose>
      <xsl:when test="contains($test-string, ' ')">
        <xsl:call-template name="string-after-space">
          <xsl:with-param name="test-string" select="substring-after($test-string, ' ')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$test-string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  

  <xsl:template name="string-before-space">
    <xsl:param name="test-string"/>

    <xsl:choose>
      <xsl:when test="contains($test-string, ' ')">
        <xsl:call-template name="string-before-space">
          <xsl:with-param name="test-string" select="substring-before($test-string, ' ')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$test-string"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="trans-string">
    <xsl:param name="trans-text" select="."/>
    <xsl:value-of select="translate($trans-text, $all-grc, $grc-lower-strip)"/>
  </xsl:template>

</xsl:stylesheet>
