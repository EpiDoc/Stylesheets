<!-- $Id$ --><xsl:stylesheet xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
  <!-- Contains named templates for creta file structure (aka "metadata" aka "supporting data") -->  
  <!-- Called from htm-tpl-structure.xsl -->
  
  <xsl:template name="creta-structure">
    <fo:block margin-top="12.5pt" margin-bottom="3.1pt" hyphenate="true" page-break-after="avoid">
      Text
    </fo:block>
        
        <xsl:call-template name="creta-body-structure"/>
  
  </xsl:template>
    
    <xsl:template name="creta-body-structure">
      <fo:block-container id="body-{replace(//t:idno[@type='filename'], '\s+', '_')}">
        <fo:block>
              <xsl:variable name="edtxt">
                <xsl:apply-templates select="//t:div[@type='edition']">
                  <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
                  <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
                  <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
                </xsl:apply-templates>
              </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
            </fo:block>
        
        <fo:block font-weight="800">Apparato</fo:block>
        <fo:block>
          <xsl:apply-templates select="//t:div[@type='apparatus']">
            <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
          </xsl:apply-templates></fo:block>
        
        <fo:block font-weight="800">Traduzione</fo:block>
        <fo:block><xsl:variable name="trtxt">
          <xsl:apply-templates select="//t:div[@type='translation']">
            <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
          </xsl:apply-templates>
        </xsl:variable>
          <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
          <xsl:apply-templates select="$trtxt" mode="sqbrackets"/></fo:block>
        
        <fo:block font-weight="800">Commento</fo:block>
        <fo:block>
          <xsl:apply-templates select="//t:div[@type='commentary']">
            <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
            <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
          </xsl:apply-templates>
        </fo:block>
        
      </fo:block-container>
    </xsl:template> 
  
  
  <!-- various links in bibliography  -->
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='phi']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>PHI</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='aio']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>AIO</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='seg']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>SEG</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='cgrn']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>CGRN</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='thetima']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>ΘΕΤΙΜΑ</a></xsl:template>

  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='axon']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>Axon</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='poinikastas']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>Poinikastas</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='ela']">
    ➚<a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>ELA</a></xsl:template>

  <!-- bold chosen edition in bibliography  -->
  <xsl:template mode="creta" match="t:bibl[@type='main_edition']"><strong><xsl:apply-templates mode="creta"/></strong></xsl:template>


  <!-- lb in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p//t:lb"><br/><xsl:apply-templates/></xsl:template>
  
  <!-- emph in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p//t:emph"><strong><xsl:apply-templates/></strong></xsl:template>
  
  <!-- foreign words in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p//t:foreign"><i><xsl:apply-templates/></i></xsl:template>
  
  <!-- apices in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']//t:hi[@rend='superscript']"><sup><xsl:apply-templates/></sup></xsl:template>
  
  <!-- simple link to full bibliographic references -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p/t:bibl/t:ref[@target]">
    <xsl:variable name="bib-id" select="substring-after(@target,'#')"/>
    <a><xsl:attribute name="class"><xsl:value-of select="'link'"/></xsl:attribute><xsl:attribute name="href"><xsl:value-of select="concat('../texts/riferimenti_bibliografici.html#',$bib-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute><xsl:apply-templates mode="creta"/></a>
  </xsl:template>

  <!-- ref for mentions of inscriptions and literary sources in the commentary -->
  <xsl:template mode="creta" match="t:div[@type='commentary']/t:p/t:ref[@target]">
    <a><xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute><xsl:apply-templates mode="creta"/></a></xsl:template>

  <!-- apices in apparatus -->
  <xsl:template mode="creta" match="t:div[@type='apparatus']//t:hi[@rend='superscript']"><sup><xsl:apply-templates/></sup></xsl:template> 
  
  <!-- foreign words in apparatus -->
  <xsl:template match="t:div[@type='apparatus']//t:foreign"><i><xsl:apply-templates mode="creta"/></i></xsl:template>
  
  <!-- foreign words in header -->
  <xsl:template match="t:teiHeader//t:foreign"><i><xsl:apply-templates mode="creta"/></i></xsl:template>

</xsl:stylesheet>