<!-- $Id$ --><xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="t" version="2.0">

  <xsl:template match="t:div">
    <xsl:param name="parm-internal-app-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-external-app-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-leiden-style" tunnel="yes" required="no"/>
    <xsl:param name="parm-edition-type" tunnel="yes" required="no"/>
    <xsl:param name="parm-verse-lines" tunnel="yes" required="no"/>
    <xsl:param name="parm-line-inc" tunnel="yes" required="no"/>
    <!-- div[@type = 'edition']" and div[@type='textpart'] can be found in htm-teidivedition.xsl -->
        <xsl:comment>
                line-increment parameter div: <xsl:value-of select="$parm-line-inc"/>
            </xsl:comment>
        <fo:block>
          <xsl:if test="parent::t:body and @type">
            <xsl:attribute name="id">
              <xsl:value-of select="generate-id(@type)"/>
            </xsl:attribute>
          </xsl:if>
          <!-- Temporary headings so we know what is where -->
          <xsl:if test="not(t:head)">
            <xsl:choose>
              <xsl:when test="@type='commentary' and @subtype='frontmatter'"><fo:block>Introduction</fo:block></xsl:when>
              <xsl:when test="@type='commentary' and @subtype='linebyline'"><fo:block>Notes</fo:block></xsl:when>
              <xsl:when test="@type = 'translation'">
                  <fo:block>
                     <xsl:value-of select="/t:TEI/t:teiHeader/t:profileDesc/t:langUsage/t:language[@ident = current()/@xml:lang]"/>
                     <xsl:text> </xsl:text>
                     <xsl:value-of select="@type"/>
                  </fo:block>
              </xsl:when>
              <xsl:when test="@type='commentary'"></xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="@type"/>
                     <xsl:if test="string(@subtype)">
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="@subtype"/>
                     </xsl:if>
                  </xsl:otherwise>
              </xsl:choose>
          </xsl:if>

          <!-- Body of the div -->
          <xsl:apply-templates/>

        </fo:block>

  </xsl:template>

</xsl:stylesheet>