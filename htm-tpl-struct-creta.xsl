<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
  version="2.0">
  <!-- Contains named templates for creta file structure (aka "metadata" aka "supporting data") -->  
  <!-- Called from htm-tpl-structure.xsl -->
  
  <xsl:template name="creta-title">
    <xsl:value-of select="//t:idno[@type='filename']"/>
  </xsl:template>
  
  <xsl:template name="creta-structure">
    <xsl:variable name="title">
      <xsl:call-template name="creta-title" />
    </xsl:variable>
    <html>
      <head>
        <title>
          <xsl:value-of select="$title"/>
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <xsl:call-template name="css-script"/> <!-- Found in htm-tpl-cssandscripts.xsl -->
      </head>
      <body>
        <h1><xsl:call-template name="creta-title" /></h1>
          <xsl:call-template name="creta-body-structure" />
      </body>
    </html>
  </xsl:template>
    
    <xsl:template name="creta-body-structure">
      <div id="creta-inscription-body" class="creta">
        <div id="title" class="creta">
          <h1><xsl:if test="//t:idno[@type='projectNo']/text()"><xsl:value-of select="number(//t:idno[@type='projectNo'])"/>. </xsl:if><xsl:apply-templates select="//t:titleStmt/t:title"/></h1>
        </div>
        <div id="descriptive_lemma" class="creta">
            <p>
              <b>Tipologia documentaria: </b>
                <xsl:choose>
                  <xsl:when test="//t:msContents/t:summary">
                    <xsl:apply-templates select="//t:msContents/t:summary"/>
                  </xsl:when>
                  <xsl:otherwise>?</xsl:otherwise>
                </xsl:choose>
              </p>
            <p><b>Supporto: </b>
              <xsl:choose>
                <xsl:when test="//t:support">
                  <xsl:value-of select="//t:support/t:p"/>
                  <xsl:if test="//t:dimensions//text()"> 
                    (<xsl:if test="//t:width/text()">w <xsl:value-of select="//t:width"/> <xsl:if test="//t:dimensions/t:height/text() or //t:depth/text() or //t:dim[@type='diameter']/text()">, </xsl:if></xsl:if>
                    <xsl:if test="//t:dimensions/t:height/text()">h <xsl:value-of select="//t:dimensions/t:height"/> <xsl:if test="//t:depth/text() or //t:dim[@type='diameter']/text()">, </xsl:if></xsl:if>
                    <xsl:if test="//t:depth/text()">d <xsl:value-of select="//t:depth"/> <xsl:if test="//t:dim[@type='diameter']/text()">, </xsl:if></xsl:if>
                    <xsl:if test="//t:dim[@type='diameter']/text()">diam. <xsl:value-of select="//t:dim[@type='diameter']"/></xsl:if>)
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>?</xsl:otherwise>
              </xsl:choose>
            </p>
          <xsl:if test="//t:layoutDesc/t:layout//text()">
                <p><b>Disposizione del testo: </b>
                    <xsl:value-of select="//t:layoutDesc/t:layout"/>
                </p>
              </xsl:if>
              <xsl:if test="//t:handDesc/t:handNote//text()">
                <p><b>Scrittura: </b>
                <xsl:choose>
                  <xsl:when test="//t:handDesc/t:handNote/t:p">
                    <xsl:value-of select="//t:handDesc/t:handNote/t:p"/><xsl:if test="//t:handDesc/t:handNote/t:height/text()">; h. <xsl:value-of select="//t:handDesc/t:handNote/t:height"/></xsl:if></xsl:when>
                  <xsl:otherwise>
                    <xsl:if test="//t:handDesc/t:handNote/t:height">h. <xsl:value-of select="//t:handDesc/t:handNote/t:height"/></xsl:if></xsl:otherwise>
                </xsl:choose>
                </p>
              </xsl:if>
              <p><b>Datazione: </b>
              <xsl:choose>
                <xsl:when test="//t:origin/t:origDate/text()">
                  <xsl:value-of select="//t:origin/t:origDate"/>
                  <xsl:if test="//t:origin/t:origDate[@type='evidence']">
                    <xsl:text>(</xsl:text>
                    <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence],' ')">
                      <xsl:value-of select="translate(.,'-',' ')"/>
                      <xsl:if test="position()!=last()">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                    </xsl:for-each>
                    <xsl:text>)</xsl:text>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>?</xsl:otherwise>
              </xsl:choose>
              </p>
              <p><b>Provenienza: </b>
              <xsl:choose>
                <xsl:when test="//t:origin/t:origPlace"><xsl:apply-templates select="//t:origin/t:origPlace"/></xsl:when>
                <xsl:otherwise>?</xsl:otherwise>
              </xsl:choose>
              </p>
              <xsl:if test="//t:provenance[@type='found']">
                <p><b>Luogo di ritrovamento: </b>
                <xsl:apply-templates select="//t:provenance[@type='found']"/>
                </p>
              </xsl:if>
              <p><b>Collocazione attuale: </b>
              <xsl:choose>
                <xsl:when test="//t:msIdentifier//t:repository">
                  <xsl:apply-templates select="//t:msIdentifier//t:repository"/>
                  <xsl:if test="//t:idno[@type='invNo'][string(translate(normalize-space(.),' ',''))]">
                    <xsl:text> (n. inv. </xsl:text>
                    <xsl:for-each select="//t:idno[@type='invNo'][string(translate(normalize-space(.),' ',''))]">
                      <xsl:value-of select="."/>
                      <xsl:if test="position()!=last()">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                    </xsl:for-each>
                    <xsl:text>)</xsl:text>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>?</xsl:otherwise>
              </xsl:choose>
            </p>
        </div>
            <div id="bibliography" class="creta">
              <xsl:apply-templates mode="creta" select="//t:div[@type='bibliography']/t:p"/>
            </div>
            <div id="edition" class="creta">
              <xsl:variable name="edtxt">
                <xsl:apply-templates select="//t:div[@type='edition']">
                  <xsl:with-param name="parm-edition-type" tunnel="yes"><xsl:text>interpretive</xsl:text></xsl:with-param>
                  <xsl:with-param name="parm-verse-lines" tunnel="yes"><xsl:text>off</xsl:text></xsl:with-param>
                  <xsl:with-param name="parm-line-inc" tunnel="yes"><xsl:text>5</xsl:text></xsl:with-param>
                </xsl:apply-templates>
              </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
            </div>
        
        <xsl:if test="//t:div[@type='apparatus']">
              <div id="apparatus" class="creta">
              <xsl:variable name="apptxt">
                <xsl:apply-templates select="//t:div[@type='apparatus']//t:p"/>
              </xsl:variable>
              <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
            </div>
            </xsl:if>
        
        <xsl:if test="//t:div[@type='translation']">
          <div id="translation" class="creta">
            <xsl:variable name="transtxt">
              <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
            </xsl:variable>
            <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
          </div>
        </xsl:if>
        
            <div id="commentary" class="creta">
              <xsl:variable name="commtxt">
                <xsl:apply-templates mode="creta" select="//t:div[@type='commentary']//t:p"/>
              </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
          </div>
      </div>
    </xsl:template> 
  
 
  
  <!-- links to external resources in bibliography  -->
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='phi']">
    <xsl:variable name="phi-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('http://epigraphy.packhum.org/text/',$phi-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>PHI</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='aio']">
    <xsl:variable name="aio-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('https://www.atticinscriptions.com/inscription/',$aio-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>AIO</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='seg']">
    <xsl:variable name="seg-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('http://dx.doi.org/10.1163/1874-6772_seg_',$seg-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>SEG</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='cgrn']">
    <xsl:variable name="cgrn-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('http://cgrn.ulg.ac.be/file/',$cgrn-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>CGRN</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='thetima']">
    <xsl:variable name="thetima-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('http://ancdialects.greek-language.gr/inscriptions/',$thetima-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>ΘΕΤΙΜΑ</a></xsl:template>

  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='axon']">
    <xsl:variable name="axon-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('https://mizar.unive.it/axon/public/axon/anteprima/anteprima/idSchede/',$axon-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>Axon</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='poinikastas']">
    <xsl:variable name="poinikastas-id" select="substring-after(@target,'#')"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('http://poinikastas.csad.ox.ac.uk/search-browse.shtml',$poinikastas-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>Poinikastas</a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='bibliography']/t:p/t:bibl/t:ptr[@target][@type='ela']">
    <xsl:variable name="ela-id" select="@target"/>
    ➚<a><xsl:attribute name="href"><xsl:value-of select="concat('http://www.epigraphiclandscape.unito.it/index.php/browse/',$ela-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute>ELA</a></xsl:template>

  <!-- bold chosen edition in bibliography  -->
  <xsl:template mode="creta" match="t:bibl[@type='main_edition']"><strong><xsl:apply-templates mode="creta"/></strong></xsl:template>


  <!-- p in bibliography and commentary -->
  <xsl:template mode="creta" match="t:p"><p><xsl:apply-templates mode="creta"/></p></xsl:template>
  
  <!-- emph in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p//t:emph"><strong><xsl:apply-templates/></strong></xsl:template>
  
  <!-- foreign words in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p//t:foreign"><i><xsl:apply-templates/></i></xsl:template>
  
  <!-- apices in bibliography and commentary -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']//t:hi[@rend='superscript']"><sup><xsl:apply-templates/></sup></xsl:template>
  
  <!-- link to full bibliographic references -->
  <xsl:template mode="creta" match="t:div[@type='bibliography' or @type='commentary']/t:p/t:bibl/t:ref[@target]">
    <xsl:variable name="bib-id" select="substring-after(@target,'#')"/>
    <a><xsl:attribute name="class"><xsl:value-of select="'link'"/></xsl:attribute><xsl:attribute name="href"><xsl:value-of select="concat('../texts/riferimenti_bibliografici.html#',$bib-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute><xsl:apply-templates mode="creta"/></a>
  </xsl:template>

  <!-- ref for mentions of inscriptions and literary sources in the commentary -->
  <xsl:template mode="creta" match="t:div[@type='commentary']/t:p/t:ref[@target][@type='ins']">
    <xsl:variable name="ins-id" select="substring-after(@target,'#')"/>
    <a><xsl:attribute name="href"><xsl:value-of select="concat('./',$ins-id,'.html')"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute><xsl:apply-templates mode="creta"/></a></xsl:template>
  
  <xsl:template mode="creta" match="t:div[@type='commentary']/t:p/t:ref[@target][@type='lit']">
    <xsl:variable name="lit-id" select="substring-after(@target,'#')"/>
    <a><xsl:attribute name="href"><xsl:value-of select="concat('../texts/fonti_letterarie.html',$lit-id)"/></xsl:attribute><xsl:attribute name="target"><xsl:value-of select="'_blank'"/></xsl:attribute><xsl:apply-templates mode="creta"/></a></xsl:template>
  

  <!-- apices in apparatus -->
  <xsl:template mode="creta" match="t:div[@type='apparatus']//t:hi[@rend='superscript']"><sup><xsl:apply-templates/></sup></xsl:template> 
  
  <!-- foreign words in apparatus -->
  <xsl:template match="t:div[@type='apparatus']//t:foreign"><i><xsl:apply-templates mode="creta"/></i></xsl:template>
  
  <!-- foreign words in header -->
  <xsl:template match="t:teiHeader//t:foreign"><i><xsl:apply-templates mode="creta"/></i></xsl:template>

</xsl:stylesheet>