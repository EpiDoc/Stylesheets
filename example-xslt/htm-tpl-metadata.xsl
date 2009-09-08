<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-metadata.xsl 1548 2008-08-20 09:54:25Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Called from start-edition.xsl -->

  <xsl:template name="metadata">
    <p>
      <strong>Publikation: </strong>
      <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
        /listBibl/bibl[@type = 'publication' and @subtype = 'principal']/title[@type = 'abbreviated']"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
        /listBibl/bibl[@type = 'publication' and @subtype = 'principal']/biblScope[@type='volume']"/>
      <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
        /listBibl/bibl[@type = 'publication' and @subtype = 'principal']/biblScope[@type='fascicle']"/>
      <xsl:text> </xsl:text>
      <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
        /listBibl/bibl[@type = 'publication' and @subtype = 'principal']/biblScope[@type='numbers']"/>
    </p>
    <xsl:if test="//div[@type = 'bibliography' and @subtype = 'otherPublications']">
      <p>
        <strong>Andere Publikationen: </strong>
        <xsl:for-each select="//div[@type = 'bibliography' and @subtype = 'otherPublications']//bibl">
          <xsl:value-of select="."/>
          <xsl:if test="following-sibling::bibl">
            <xsl:text>; </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </p>
    </xsl:if>
    <p>
      <strong>Datierung: </strong>
      <xsl:value-of select="//div[@type = 'commentary' and @subtype = 'textDate']
        /p/date[@type = 'textDate']"/>
    </p>
    <p>
      <strong>Ort: </strong>
      <xsl:value-of select="//div[@type = 'history' and @subtype = 'locations']/p"/>
    </p>
    <p>
      <strong>Originaltitel: </strong>
      <xsl:value-of select="//teiHeader/fileDesc/titleStmt/title"/>
    </p>
    <p>
      <strong>Material: </strong>
      <xsl:value-of select="//div[@type = 'description']//rs[@type = 'material']"/>
    </p>
    <p>
      <strong>Abbildung: </strong>
      <xsl:choose>
        <xsl:when test="//div[@type='bibliography' and @subtype='illustrations']//bibl[@type = 'illustration']">
          <xsl:for-each select="//div[@type='bibliography' and @subtype='illustrations']//bibl[@type = 'illustration']">
            <xsl:if test="preceding-sibling::bibl[@type = 'illustration']">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
          </xsl:for-each>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>keiner</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:if test="string(//div[@type='figure']//figure/@href)">
        <xsl:for-each select="//div[@type='figure']//figure[string(@href)]">
          <br/>
          <a href="{@href}">
            <xsl:value-of select="figDesc"/>
          </a>
        </xsl:for-each>
      </xsl:if>
    </p>
    <xsl:if test="//div[@type = 'bibliography' and @subtype = 'corrections']">
      <p>
        <strong>
          <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'corrections']/head"/>
          <xsl:text>: </xsl:text>
        </strong>
        <xsl:for-each select="//div[@type = 'bibliography' and @subtype = 'corrections']//bibl">
          <xsl:if test="preceding-sibling::bibl">
            <xsl:text>, </xsl:text>
          </xsl:if>
          <xsl:value-of select="."/>
        </xsl:for-each>
      </p>
    </xsl:if>
    <p>
      <strong>Text der DDBDP: </strong>
      <xsl:variable name="db-link">
        <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
          /listBibl/bibl[@type = 'DDbDP']/series"/>
        <xsl:text>:volume=</xsl:text>
        <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
          /listBibl/bibl[@type = 'DDbDP']/biblScope[@type = 'volume']"/>
        <xsl:text>:document=</xsl:text>
        <xsl:value-of select="//div[@type = 'bibliography' and @subtype = 'principalEdition']
          /listBibl/bibl[@type = 'DDbDP']/biblScope[@type = 'numbers']"/>
      </xsl:variable>
      <a>
        <xsl:attribute name="href">
          <xsl:text>http://www.perseus.tufts.edu/cgi-bin/ptext?doc=Perseus:text:1999.05.</xsl:text>
          <xsl:value-of select="$db-link"/>
        </xsl:attribute>
        <xsl:text>Server in Somerville</xsl:text>
      </a>
      <xsl:text> </xsl:text>
      <a>
        <xsl:attribute name="href">
          <xsl:text>http://perseus.mpiwg-berlin.mpg.de/cgi-bin/ptext?doc=Perseus:text:1999.05.</xsl:text>
          <xsl:value-of select="$db-link"/>
        </xsl:attribute>
        <xsl:text>Server in Berlin</xsl:text>
      </a>
    </p>
    <p>
      <strong>Bemerkungen: </strong>
      <xsl:value-of select="//div[@type = 'commentary' and @subtype = 'general']
        /p"/>
    </p>
    <xsl:if test="//div[@type='bibliography' and @subtype='translations']">
      <p>
        <strong>Übersetzungen: </strong>
        <xsl:for-each select="//div[@type='bibliography' and @subtype='translations']/listBibl">
          <xsl:value-of select="head"/>
          <xsl:text> </xsl:text>
          <xsl:for-each select="bibl[@type = 'translations']">
            <xsl:if test="preceding-sibling::bibl[@type = 'translations']">
              <xsl:text>, </xsl:text>
            </xsl:if>
            <xsl:value-of select="."/>
          </xsl:for-each>
        </xsl:for-each>
      </p>
    </xsl:if>
    <p>
      <strong>Inhalt: </strong>
      <xsl:for-each select="//teiHeader/profileDesc//keywords/term/rs[@type = 'textType']">
        <xsl:if test="preceding-sibling::rs">
          <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:value-of select="."/>
      </xsl:for-each>
    </p>
    <xsl:if test="//div[@type = 'commentary' and @subtype = 'mentionedDates']//date[@type = 'mentioned']">
      <p>
        <strong>
          <xsl:value-of select="//div[@type = 'commentary' and @subtype = 'mentionedDates']/head"/>
          <xsl:text>: </xsl:text>
        </strong>
        <xsl:for-each select="//div[@type = 'commentary' and @subtype = 'mentionedDates']/p">
          <xsl:value-of select="."/>
          <xsl:if test="following-sibling::p">
            <xsl:text>; </xsl:text>
          </xsl:if>
        </xsl:for-each>
      </p>
    </xsl:if>

  </xsl:template>

</xsl:stylesheet>
