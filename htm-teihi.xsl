<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teihi.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- hi imports in teihi.xsl, html span created here -->
  <xsl:import href="teihi.xsl"/>

  <xsl:template match="hi">
    <xsl:choose>
      <!-- No html code needed for these -->
      <xsl:when test="@rend = 'diaeresis' or @rend = 'varia' or @rend = 'oxia' or @rend = 'dasia' or @rend = 'psili' or @rend = 'perispomeni'">
        <xsl:apply-imports />
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='apex'                                                       -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='apex' and ancestor-or-self::*[@lang][1][@lang = 'la']">
        <xsl:element name="span">
          <xsl:attribute name="class">apex</xsl:attribute>
          <xsl:attribute name="title">apex over: <xsl:value-of select="."/></xsl:attribute>
          <xsl:value-of select="translate(., 'aeiou', 'áéíóú')"/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='intraline'                                                  -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='intraline'">
        <xsl:element name="span">
          <xsl:attribute name="class">line-through</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='italic'                                                     -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='italic'">
        <xsl:element name="span">
          <xsl:attribute name="class">italic</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='ligature'                                                   -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='ligature'">
        <xsl:element name="span">
          <xsl:attribute name="class">ligature</xsl:attribute>
          <xsl:attribute name="title">Ligature: these characters are joined</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='normal'                                                     -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='normal'">
        <xsl:element name="span">
          <xsl:attribute name="class">normal</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='reversed'                                                   -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='reversed'">
        <xsl:element name="span">
          <xsl:attribute name="class">reversed</xsl:attribute>
          <xsl:attribute name="title">reversed: <xsl:value-of select="."/></xsl:attribute>
          ((<xsl:apply-templates/>)) </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='small'                                                      -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='small'">
        <xsl:element name="span">
          <xsl:attribute name="class">small</xsl:attribute>
          <xsl:attribute name="title">small character: <xsl:value-of select="."/></xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='strong'                                                     -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='strong'">
        <xsl:element name="strong">
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='subscript'                                                  -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='subscript'">
        <xsl:choose>
          <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:apply-imports/>
          </xsl:when>
          <xsl:otherwise>
            <!-- To be decided -->
            <xsl:apply-templates/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='superscript'                                                -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='superscript'">
        <xsl:choose>
          <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:apply-imports/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:element name="sup">
              <xsl:apply-templates/>
            </xsl:element>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='supraline'                                                  -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- I wonder if this should be "overline" to match css practice? TE -->
      <xsl:when test="@rend='supraline'">
        <xsl:element name="span">
          <xsl:attribute name="class">supraline</xsl:attribute>
          <xsl:attribute name="title">line above</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='tall'                                                       -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='tall'">
        <xsl:element name="span">
          <xsl:attribute name="class">tall</xsl:attribute>
          <xsl:attribute name="title">tall character: <xsl:value-of select="."/></xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- @rend='underline'                                                  -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:when test="@rend='underline'">
        <xsl:element name="span">
          <xsl:attribute name="class">underline</xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:when>
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <!-- UNTRAPPED REND VALUE                                               -->
      <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
      <xsl:otherwise>
        <xsl:element name="span">
          <xsl:attribute name="class">error</xsl:attribute>
          <xsl:attribute name="title">
            <xsl:text>hi tag with rend=</xsl:text>
            <xsl:value-of select="@rend"/>
            <xsl:text> is not supported!</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
