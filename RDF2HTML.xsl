<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dc="http://purl.org/dc/terms/" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:pi="http://papyri.info/ns"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:t="http://www.tei-c.org/ns/1.0"
  xmlns:xi="http://www.w3.org/2001/XInclude"
  version="2.0" exclude-result-prefixes="#all">
  
  <xsl:import href="global-varsandparams.xsl"/>
  
  <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
  <xsl:import href="htm-teiab.xsl"/>
  <xsl:import href="htm-teiapp.xsl"/>
  <xsl:import href="htm-teidiv.xsl"/>
  <xsl:import href="htm-teidivedition.xsl"/>
  <xsl:import href="htm-teiforeign.xsl"/>
  <xsl:import href="htm-teifigure.xsl"/>
  <xsl:import href="htm-teig.xsl"/>
  <xsl:import href="htm-teigap.xsl"/>
  <xsl:import href="htm-teihead.xsl"/>
  <xsl:import href="htm-teihi.xsl"/>
  <xsl:import href="htm-teilb.xsl"/>
  <xsl:import href="htm-teilgandl.xsl"/>
  <xsl:import href="htm-teilistanditem.xsl"/>
  <xsl:import href="htm-teilistbiblandbibl.xsl"/>
  <xsl:import href="htm-teimilestone.xsl"/>
  <xsl:import href="htm-teinote.xsl"/>
  <xsl:import href="htm-teinum.xsl"/>
  <xsl:import href="htm-teip.xsl"/>
  <xsl:import href="htm-teiseg.xsl"/>
  <xsl:import href="htm-teispace.xsl"/>
  <xsl:import href="htm-teisupplied.xsl"/>
  <xsl:import href="htm-teiterm.xsl"/>
  <xsl:import href="htm-teiref.xsl"/>
  
  <!-- tei stylesheets that are also used by start-txt -->
  <xsl:import href="teiabbrandexpan.xsl"/>
  <xsl:import href="teiaddanddel.xsl"/>
  <xsl:import href="teichoice.xsl"/>
  <xsl:import href="teihandshift.xsl"/>
  <xsl:import href="teiheader.xsl"/>
  <xsl:import href="teimilestone.xsl"/>
  <xsl:import href="teiorig.xsl"/>
  <xsl:import href="teiq.xsl"/>
  <xsl:import href="teisicandcorr.xsl"/>
  <xsl:import href="teispace.xsl"/>
  <xsl:import href="teisupplied.xsl"/>
  <xsl:import href="teiunclear.xsl"/>
  
  <!-- html related stylesheets for named templates -->
  <xsl:import href="htm-tpl-cssandscripts.xsl"/>
  <xsl:import href="htm-tpl-apparatus.xsl"/>
  <xsl:import href="htm-tpl-lang.xsl"/>
  <xsl:import href="htm-tpl-metadata.xsl"/>
  <xsl:import href="htm-tpl-nav.xsl"/>
  <xsl:import href="htm-tpl-license.xsl"/>
  
  <!-- global named templates with no html, also used by start-txt -->
  <xsl:import href="tpl-reasonlost.xsl"/>
  <xsl:import href="tpl-certlow.xsl"/>
  <xsl:import href="tpl-text.xsl"/>
  
  <xsl:param name="collection"/>
  <xsl:param name="related"/>
  <xsl:param name="replaces"/>
  <xsl:param name="isReplacedBy"/>
  <xsl:variable name="relations" select="tokenize($related, '\s+')"/>
  <xsl:variable name="path">/Users/hcayless/Development/APIS/idp.data</xsl:variable>
  <xsl:variable name="outbase">/Users/hcayless/Development/APIS/idp.html</xsl:variable>
  <xsl:variable name="doc-id">
    <xsl:choose>
      <xsl:when test="//t:idno[@type='apisid']"><xsl:value-of select="//t:idno[@type='apisid']"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="//t:idno[@type='filename']"/></xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:include href="pi-functions.xsl"/>
  
  <xsl:output method="html"/>
  
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="//dc:hasPart">
        <xsl:variable name="children" select="pi:get-toc(//dc:hasPart)"/>
        <xsl:variable name="hgv" select="contains(/rdf:RDF/rdf:Description/@rdf:about, '/hgv/') and contains($children[1], '/source')"/>
        <xsl:variable name="query">
          prefix dc: &lt;http://purl.org/dc/terms/&gt;
          construct {?a dc:identifier ?b}
          from &lt;rmi://localhost/papyri.info#pi&gt;
          where { &lt;<xsl:value-of select="/rdf:RDF/rdf:Description/@rdf:about"/>&gt; dc:hasPart ?a .
          ?a dc:identifier ?b .
          filter regex(str(?b), "^http:")}
        </xsl:variable>
        <xsl:variable name="hgvdoc">
          <xsl:if test="$hgv"><xsl:copy-of select="doc(concat('http://papyri.info/mulgara/sparql?query=', encode-for-uri($query)))"/></xsl:if>
        </xsl:variable>

        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="en">
          <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <link rel="stylesheet" href="/css/master.css" type="text/css" media="screen" title="no title" charset="utf-8" />
            <title>
              <xsl:choose>
                <xsl:when test="pi:get-id(/rdf:RDF/rdf:Description/@rdf:about) = ''"><xsl:value-of select="$collection"/></xsl:when>
                <xsl:otherwise><xsl:value-of select="pi:get-id(/rdf:RDF/rdf:Description/@rdf:about)"/></xsl:otherwise>
              </xsl:choose>
            </title>
            <script src="/js/jquery-1.4.2.min.js" type="text/javascript" charset="utf-8"></script>
            <script src="/js/jquery-ui-1.8.1.custom.min.js" type="text/javascript" charset="utf-8"></script>
          </head>
          <body>
            <div id="d" class="page">
              <div id="hd">
                <h1>
                  Papyri.info
                </h1>
              </div>
              <div id="bd">
                <xi:include href="left-nav.xml"/>
                <div id="main">
                  <div class="content ui-corner-all">
                    <h2><xsl:value-of select="pi:get-id(/rdf:RDF/rdf:Description/@rdf:about)"/></h2>
                    <xsl:choose>
                      <xsl:when test="count($children) &lt; 40">
                        <ul>
                          <xsl:for-each select="$children">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                      </xsl:when>
                      <xsl:when test="count($children) &lt; 80">
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &lt; 41]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv">
                                <xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; 40]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                      </xsl:when>
                      <xsl:when test="count($children) &lt; 120">
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &lt; 41]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; 40 and position() &lt; 81]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; 80]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                      </xsl:when>
                      <xsl:when test="count($children) &lt; 160">
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &lt; 41]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; 40 and position() &lt; 81]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; 80 and position() &lt; 121]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; 120]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:variable name="csize" select="ceiling(count(//dc:hasPart) div 5)"/>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &lt; $csize + 1]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; $csize and position() &lt; ($csize * 2) + 1]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; ($csize * 2) and position() &lt; ($csize * 3) + 1]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; ($csize * 3) and position() &lt; ($csize * 4) + 1]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                        <ul style="margin-left:2em;float:left;">
                          <xsl:for-each select="$children[position() &gt; ($csize * 4)]">
                            <li><a href="{substring-after(replace(., 'source$', ''), 'http://papyri.info')}"><xsl:choose>
                              <xsl:when test="$hgv"><xsl:value-of select="replace(pi:get-id($hgvdoc//rdf:Description[@rdf:about = current()]/dc:identifier/@rdf:resource), '_', ' ')"/></xsl:when>
                              <xsl:otherwise><xsl:value-of select="replace(replace(pi:get-id(.), ';;', '.'), ';', '.')"/></xsl:otherwise>
                            </xsl:choose></a></li>
                          </xsl:for-each>
                        </ul>
                      </xsl:otherwise>
                    </xsl:choose>
                  </div>
                </div>
              </div>
              <xi:include href="footer.xml"/>
            </div>
          </body>
        </html>
      </xsl:when>
      <xsl:otherwise>
        <xsl:variable name="ddbdp" select="$collection = 'ddbdp'"/>
        <xsl:variable name="hgv" select="$collection = 'hgv' or contains($related, 'hgv/')"/>
        <xsl:variable name="apis" select="$collection = 'apis' or contains($related, '/apis/')"/>
        <xsl:variable name="translation" select="contains($related, 'hgvtrans') or (contains($related, 'apis') and pi:get-docs($relations[contains(., 'apis')], 'xml')//t:div[@type = 'translation'])"/>
        <xsl:variable name="image" select="contains($related, 'http://papyri.info/images')"/>
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="en">
          <head>
            <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
            <link rel="stylesheet" href="/css/master.css" type="text/css" media="screen" title="no title" charset="utf-8" />
            <link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Cardo" />
            <title>
              <xsl:call-template name="get-references"/>
            </title>
            <script src="/js/jquery-1.4.2.min.js" type="text/javascript" charset="utf-8"></script>
            <script src="/js/jquery-ui-1.8.1.custom.min.js" type="text/javascript" charset="utf-8"></script>
            <script src="/js/OpenLayers.js" type="text/javascript" charset="utf-8"></script>
            <script src="/js/imageviewer.js" type="text/javascript" charset="utf-8"></script>
            <script src="/js/highlight.js" type="text/javascript" charset="utf-8"></script>
            <script type="text/javascript" charset="utf-8">
            	function init() {
            		$("li.dialog").each(function(i) {
            			$(this).after("&lt;li&gt;&lt;a href=\"#\" onclick=\"javascript:$('#"+this.id+"c').dialog({height:100,modal:true})\"&gt;"+this.title+"&lt;/a&gt;&lt;/li&gt;");
            			$(this).hide();
            		});
            		$("ul.nav li").hover(function(){$(this).css('background-color','#445B88');$(this).find("a").css('color','white')},function(){$(this).css('background-color','transparent');$(this).find("a").css('color','black')});
            		$("div.controls input").each(function() {
            		  if (!this.checked) {
            		    $("."+this.name).css('display','none');
            		  }
            		});
            		if ($(".translation").length == 0) {
            		  $(".transcription").css('width', '100%');
            		}
            		if ($("#image")) {
            		  initImage();
            		}
            	}
            </script>
          </head>
          <body onload="init()">
            <div id="d" class="page">
              <div id="hd">
                <h1>
                  Papyri.info
                </h1>
              </div>
              <div id="bd">
                <xi:include href="left-nav.xml"/>
                <div id="main">
                  <div class="content ui-corner-all">
                    <h3 style="text-align:center"><xsl:call-template name="get-references"><xsl:with-param name="links">yes</xsl:with-param></xsl:call-template></h3>
                    <xsl:if test="$hgv or $apis">
                      <h4 style="text-align:center" id="titledate"></h4>
                    </xsl:if>
                    <div id="controls" class="ui-widget">
                      <xsl:if test="$hgv or $apis">
                        <div id="metadatacontrols" class="ui-widget-content ui-corner-all">
                          <label for="mdt">metadata</label><input type="checkbox" name="metadata" id="mdt" checked="checked"/><br/>
                          <xsl:if test="$hgv">
                            <label for="hgvm">HGV metadata</label><input type="checkbox" name="hgv" id="hgvm" checked="checked"/>
                          </xsl:if>
                          <xsl:if test="$apis">
                            <label for="apism">APIS metadata</label><input type="checkbox" name="apis" id="apism" checked="checked"/>
                          </xsl:if>
                        </div>
                      </xsl:if>
                      <xsl:if test="$ddbdp or $image or $translation">
                        <div id="textcontrols" class="ui-widget-content ui-corner-all">
                          <label for="txt">text</label><input type="checkbox" name="text" id="txt" checked="checked"/><br/>
                          <xsl:if test="$ddbdp">
                            <label for="tcpt">transcription</label><input type="checkbox" name="transcription" id="tcpt" checked="checked"/>
                          </xsl:if>
                          <xsl:if test="$image">
                            <label for="img">images</label><input type="checkbox" name="image" id="img" checked="checked"/>
                          </xsl:if>
                          <xsl:if test="$translation">
                            <label for="tslt">translation</label><input type="checkbox" name="translation" id="tslt" checked="checked"/>
                          </xsl:if>
                        </div>
                      </xsl:if>
                    </div>
                    <xsl:if test="$collection = 'ddbdp'">
                      <xsl:if test="$hgv or $apis">
                        <div class="metadata">
                          <xsl:for-each select="$relations[contains(., 'hgv/')]">
                            <xsl:sort select="." order="ascending"/>
                            <xsl:choose>
                              <xsl:when test="doc-available(pi:get-filename(., 'xml'))">
                                <xsl:apply-templates select="doc(pi:get-filename(., 'xml'))/t:TEI" mode="metadata"/>
                              </xsl:when>
                              <xsl:otherwise><xsl:message>Error: <xsl:value-of select="pi:get-filename(., 'xml')"/> not available. Error in <xsl:value-of select="$doc-id"/>.</xsl:message></xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                          <xsl:for-each select="$relations[contains(., '/apis/')]">
                            <xsl:sort select="." order="ascending"/>
                            <xsl:choose>
                              <xsl:when test="doc-available(pi:get-filename(., 'xml'))">
                                <xsl:apply-templates select="doc(pi:get-filename(., 'xml'))/t:TEI" mode="metadata"/>
                              </xsl:when>
                              <xsl:otherwise><xsl:message>Error: <xsl:value-of select="pi:get-filename(., 'xml')"/> not available. Error in <xsl:value-of select="$doc-id"/>.</xsl:message></xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </div>
                      </xsl:if>
                      <div class="text">
                        <div class="transcription data">
                          <h2>DDbDP transcription: <xsl:value-of select="//t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='filename']"/> [<a href="./source">xml</a>]</h2>
                          <xsl:apply-templates select="/t:TEI"/>
                        </div>
                        <xsl:if test="$image">
                          <div id="image" class="data"> 
                            <ul>
                              <xsl:for-each select="$relations[contains(., 'images/')]">
                                <li><img src="{.}" alt="papyrus image"/></li>
                              </xsl:for-each>
                            </ul>
                          </div>
                        </xsl:if>
                        <xsl:if test="$translation">
                          <xsl:for-each select="pi:get-docs($relations[contains(., 'hgvtrans')], 'xml')/t:TEI//t:div[@type = 'translation']">
                            <xsl:sort select="number(.//t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='filename'])"/>
                            <div class="translation data">
                              <h2>HGV <xsl:value-of select="ancestor::t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type = 'filename']"/> Translation (<xsl:value-of select="ancestor::t:TEI/t:teiHeader//t:langUsage/t:language[@ident = current()/@xml:lang]"/>) 
                                [<a href="/hgvtrans/{ancestor::t:TEI/t:teiHeader//t:idno[@type = 'filename']}/source">xml</a>]</h2>
                              <xsl:apply-templates select="t:p"/>
                            </div>
                          </xsl:for-each>
                          <xsl:for-each select="$relations[contains(., '/apis/')]">
                            <xsl:choose>
                              <xsl:when test="doc-available(pi:get-filename(., 'xml'))"><xsl:apply-templates select="doc(pi:get-filename(., 'xml'))/t:TEI" mode="apistrans"/></xsl:when>
                              <xsl:otherwise><xsl:message>Error: <xsl:value-of select="pi:get-filename(., 'xml')"/> not available. Error in <xsl:value-of select="$doc-id"/>.</xsl:message></xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </xsl:if>
                      </div>
                    </xsl:if>
                    <xsl:if test="$collection = 'hgv'">
                      <div class="metadata">
                        <xsl:apply-templates select="/t:TEI" mode="metadata"/>
                        <xsl:if test="$apis">
                          <xsl:for-each select="$relations[contains(., '/apis/')]">
                            <xsl:choose>
                              <xsl:when test="doc-available(pi:get-filename(., 'xml'))">
                                <xsl:apply-templates select="doc(pi:get-filename(., 'xml'))/t:TEI" mode="metadata"/>
                              </xsl:when>
                              <xsl:otherwise><xsl:message>Error: <xsl:value-of select="pi:get-filename(., 'xml')"/> not available. Error in <xsl:value-of select="$doc-id"/>.</xsl:message></xsl:otherwise>
                            </xsl:choose>
                          </xsl:for-each>
                        </xsl:if>
                      </div>
                      <xsl:if test="$apis">
                        <xsl:for-each select="$relations[contains(., '/apis/')]">
                          <xsl:choose>
                            <xsl:when test="doc-available(pi:get-filename(., 'xml'))">
                              <xsl:apply-templates select="doc(pi:get-filename(., 'xml'))/t:TEI" mode="apistrans"/>
                            </xsl:when>
                            <xsl:otherwise><xsl:message>Error: <xsl:value-of select="pi:get-filename(., 'xml')"/> not available. Error in <xsl:value-of select="$doc-id"/>.</xsl:message></xsl:otherwise>
                          </xsl:choose>
                        </xsl:for-each>
                      </xsl:if>
                    </xsl:if>
                    <xsl:if test="$collection = 'apis'">
                      <div class="metadata">
                        <xsl:apply-templates select="/t:TEI" mode="metadata"/>
                      </div>
                    </xsl:if>
                  </div>
                </div>
              </div>
              <xi:include href="footer.xml"/>
            </div>
            <script type="text/javascript" charset="utf-8">
              $("#controls input").click(
                function() {
                  if (this.checked) {
                    $("."+this.name).show();
                    if (this.name == "transcription") {
                      $(".image").css('width','50%');
                      $(".translation").css('width','50%');
                    }
                  } else {
                    $("."+this.name).hide();
                    if (this.name == "transcription") {
                      $(".image").css('width','100%');
                      $(".translation").css('width','100%');
                    }
                  }
                }
              );
              $("#titledate").append(function() {
                var result = "";
                result += $(".mdtitle:first").text();
                if (result != "") {
                  result += " - ";
                }
                if ($("div.hgv .mddate").length > 0) {
                  result += $("div.hgv .mddate").map(function (i) {
                    return $(this).text();
                  }).get().join("; ");
                } else {
                  result += $(".mddate:first").text();
                }
                if ($(".mdprov").length > 0) {
                  result += " - ";
                  result += $(".mdprov:first").text();
                }
                return result;
              });
            </script>
          </body>
        </html>
      </xsl:otherwise>
    </xsl:choose>
    
    
  </xsl:template>
  
  <xsl:function name="pi:get-toc">
    <xsl:param name="parts"></xsl:param>
    <xsl:for-each select="$parts">
      <xsl:sort select="replace(pi:get-id(@rdf:resource), '[-a-z;/_,.]', '')" data-type="number"/>
      <xsl:sequence select="string(@rdf:resource)"/>
    </xsl:for-each>
  </xsl:function>
  
  <xsl:template match="t:TEI" mode="metadata">
    <xsl:variable name="md-collection"><xsl:choose>
      <xsl:when test="//t:idno[@type='apisid']">apis</xsl:when>
      <xsl:otherwise>hgv</xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
    <div class="metadata">
      <div class="{$md-collection} data">
        <xsl:choose>
          <xsl:when test="$md-collection = 'hgv'">
            <h2>
              HGV Metadata for <xsl:value-of select="//t:bibl[@type = 'publication' and @subtype='principal']"/> [<a href="http://aquila.papy.uni-heidelberg.de/Hauptregister/FMPro?-db=hauptregister_&amp;TM_Nr.={//t:idno[@type = 'filename']}&amp;-format=DTableVw.htm&amp;-lay=Liste&amp;-find">source</a>] [<a class="xml" href="/hgv/{//t:idno[@type='filename']}/source" target="_new">xml</a>]
            </h2>
          </xsl:when>
          <xsl:otherwise>
            <h2>
              APIS Metadata for <xsl:value-of select="//t:idno[@type='apisid']"/> [<a href="/apis/{//t:idno[@type='apisid']}/source">xml</a>] 
            </h2>
          </xsl:otherwise>
        </xsl:choose>
        <table class="metadata">
          <tbody>
            <!-- Title -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:titleStmt/t:title" mode="metadata"/>
            <!-- Summary -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msContents/t:summary" mode="metadata"/>
            <!-- Publications -->
            <xsl:apply-templates select="t:text/t:body/t:div[@type = 'bibliography' and @subtype = 'principalEdition']" mode="metadata"/>
            <!-- Inv. Id -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msIdentifier/t:idno" mode="metadata"/>
            <!-- Physical Desc. -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:physDesc/t:p" mode="metadata"/>
            <!-- Post-concordance BL Entries -->
            <xsl:apply-templates select="t:text/t:body/t:div[@type = 'bibliography' and @subtype = 'corrections']" mode="metadata"/>
            <!-- Translations -->
            <xsl:apply-templates select="t:text/t:body/t:div[@type = 'bibliography' and @subtype = 'translations']" mode="metadata"/>
            <!-- Provenance -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/(t:origPlace|t:p/t:place[@type='ancientFindspot'])" mode="metadata"/>
            <!-- Material -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:physDesc/t:objectDesc/t:supportDesc/t:support/t:material" mode="metadata"/>
            <!-- Language -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msContents/t:msItem/t:textLang" mode="metadata"/>
            <!-- Date -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin/t:origDate" mode="metadata"/>
            <!-- Notes (general|lines|palaeography|recto/verso|conservation|preservation) -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:msContents/t:msItem/t:note" mode="metadata"/>
            <!-- Print Illustrations -->
            <xsl:apply-templates select="t:text/t:body/t:div[@type = 'bibliography' and @subtype = 'illustrations'][.//t:bibl]" mode="metadata"/>
            <!-- Subjects -->
            <xsl:apply-templates select="t:teiHeader/t:profileDesc/t:textClass/t:keywords" mode="metadata"/>
            <!-- Associated Names -->
            <xsl:apply-templates select="t:teiHeader/t:fileDesc/t:sourceDesc/t:msDesc/t:history/t:origin[t:persName/@type = 'asn']" mode="metadata"/>
            <!-- Images -->
            <xsl:apply-templates select="t:text/t:body/t:div[@type = 'figure']" mode="metadata"/>
          </tbody>
        </table>
      </div>
      
    </div>
  </xsl:template>
  
  <xsl:template match="t:TEI" mode="apistrans">
    <div class="translation data">
      <h2>APIS Translation (English)</h2>
      <p><xsl:value-of select=".//t:div[@type = 'translation']/t:ab"/></p>
    </div>
  </xsl:template>
  
  <!-- Title -->
  <xsl:template match="t:title" mode="metadata">
    <tr>
      <th class="rowheader" rowspan="1">Title</th>
      <td><xsl:if test="not(starts-with(., 'kein'))"><xsl:attribute name="class">mdtitle</xsl:attribute></xsl:if><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Summary -->
  <xsl:template match="t:summary" mode="metadata">
    <tr>
      <th class="rowheader">Summary</th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Publications -->
  <xsl:template match="t:div[@type = 'bibliography' and @subtype='principalEdition']" mode="metadata">
    <xsl:variable name="pubcount" select="count(../t:div[@type = 'bibliography' and @subtype = 'otherPublications']//t:bibl) + 1"/>
    <tr>
      <th class="rowheader" rowspan="{$pubcount}">Publications</th>
      <td><xsl:value-of select=".//t:bibl"/></td>
    </tr>
    <xsl:for-each select="../t:div[@type = 'bibliography' and @subtype = 'otherPublications']//t:bibl">
      <tr>
        <td><xsl:value-of select="."/></td>
      </tr>
    </xsl:for-each>
  </xsl:template>
  
  <!-- Print Illustrations -->
  <xsl:template match="t:div[@type = 'bibliography' and @subtype='illustrations']" mode="metadata">
    <tr>
      <th class="rowheader">Print Illustrations</th>
      <td><xsl:for-each select=".//t:bibl"><xsl:value-of select="normalize-space(.)"/><xsl:if test="position() != last()">; </xsl:if></xsl:for-each></td>
    </tr>
  </xsl:template>
  
  <!-- Inv. Id -->
  <xsl:template match="t:msIdentifier/t:idno" mode="metadata">
    <tr>
      <th class="rowheader">Inv. Id</th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Physical Desc. -->
  <xsl:template match="t:physDesc/t:p" mode="metadata">
    <tr>
      <th class="rowheader">Physical Desc.</th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Post-Concordance BL Entries -->
  <xsl:template match="t:div[@type = 'bibliography' and @subtype='corrections']" mode="metadata">
    <tr>
      <th class="rowheader" rowspan="1">Post-Concordance BL Entries</th>
      <td>
        <xsl:for-each select=".//t:bibl"><xsl:value-of select="normalize-space(.)"/><xsl:if test="position() != last()">; </xsl:if></xsl:for-each>
      </td>
    </tr>
  </xsl:template>
  
  <!-- Translations -->
  <xsl:template match="t:div[@type = 'bibliography' and @subtype='translations']" mode="metadata">
    <tr>
      <th class="rowheader" rowspan="1">Translations</th>
      <td>
        <xsl:for-each select=".//t:bibl"><xsl:value-of select="normalize-space(.)"/><xsl:if test="position() != last()">; </xsl:if></xsl:for-each>
      </td>
    </tr>
  </xsl:template>
  
  <!-- Provenance -->
  <xsl:template match="t:origPlace|t:place" mode="metadata">
    <tr>
      <th class="rowheader" rowspan="1">Provenance</th>
      <td class="mdprov">
        <xsl:value-of select="."/>
      </td>
    </tr>
  </xsl:template>
  
  <!-- Material -->
  <xsl:template match="t:material" mode="metadata">
    <tr>
      <th class="rowheader">Material</th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Language -->
  <xsl:template match="t:textLang" mode="metadata">
    <tr>
      <th class="rowheader">Language</th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Date -->
  <xsl:template match="t:origDate" mode="metadata">
    <tr>
      <th class="rowheader">Date</th>
      <td class="mddate"><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Notes -->
  <xsl:template match="t:msItem/t:note" mode="metadata">
    <tr>
      <th class="rowheader">Note (<xsl:value-of select="replace(./@type, '_', '/')"/>)</th>
      <td><xsl:value-of select="."/></td>
    </tr>
  </xsl:template>
  
  <!-- Subjects -->
  <xsl:template match="t:keywords" mode="metadata">
    <tr>
      <th class="rowheader">Subjects</th>
      <td><xsl:for-each select="t:term"><xsl:value-of select="normalize-space(.)"/><xsl:if test="position() != last()">; </xsl:if></xsl:for-each></td>
    </tr>
  </xsl:template>
  
  <!-- Associated Names -->
  <xsl:template match="t:origin" mode="metadata">
    <tr>
      <th class="rowheader">Associated Names</th>
      <td><xsl:for-each select="t:persName[@type = 'asn']"><xsl:value-of select="normalize-space(.)"/><xsl:if test="position() != last()">; </xsl:if></xsl:for-each></td>
    </tr>
  </xsl:template>
  
  <!-- Images -->
  <xsl:template match="t:div[@type = 'figure']" mode="metadata">
    <xsl:for-each select=".//figure">
      <tr>
      <td colspan="2"><a href="{t:graphic/@url}"><xsl:choose>
        <xsl:when test="t:figDesc"><xsl:value-of select="t:figDesc"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="substring(t:graphic/@url, 1, 25)"/>...</xsl:otherwise>
      </xsl:choose>
      </a></td>
    </tr>
    </xsl:for-each>
    
  </xsl:template>
  
  <!-- Generate parallel reference string -->
  <xsl:template name="get-references">
    <xsl:param name="links"/>
    <xsl:if test="$collection = 'hgv'">HGV </xsl:if><xsl:value-of select="/t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='filename']"></xsl:value-of>
    <xsl:for-each select="$relations">
      <xsl:if test="contains(., 'hgv/') and doc-available(pi:get-filename(., 'xml'))">
        <xsl:if test="position() = 1"> = HGV </xsl:if><xsl:value-of select="normalize-space(doc(pi:get-filename(., 'xml'))//t:bibl[@type = 'publication' and @subtype='principal'])"/><xsl:if test="contains($relations[position() + 1], 'hgv/')">; </xsl:if>
      </xsl:if>
    </xsl:for-each>
    <xsl:for-each-group select="$relations[contains(., 'hgv/')]" group-by="replace(., '[a-z]', '')"><xsl:if test="contains(., 'hgv')">
      = <xsl:choose>
        <xsl:when test="$links = 'yes'"><a href="http://www.trismegistos.org/tm/detail.php?quick={replace(pi:get-id(.), '[a-z]', '')}">Trismegistos <xsl:value-of select="replace(pi:get-id(.), '[a-z]', '')"/></a></xsl:when>
        <xsl:otherwise>Trismegistos <xsl:value-of select="replace(pi:get-id(.), '[a-z]', '')"/></xsl:otherwise>
      </xsl:choose>
    </xsl:if></xsl:for-each-group>
    <xsl:for-each select="$relations[contains(., 'apis/')]"> = <xsl:value-of select="pi:get-id(.)"/></xsl:for-each>
    <xsl:for-each select="tokenize($isReplacedBy, '\s')"> = <xsl:value-of select="pi:get-id(.)"/></xsl:for-each>
    <xsl:for-each select="tokenize($replaces, '\s')"> = <xsl:value-of select="pi:get-id(.)"/></xsl:for-each>
  </xsl:template>
  
  <xsl:template match="rdf:Description">
    <xsl:value-of select="@rdf:about"/>
  </xsl:template>
</xsl:stylesheet>
