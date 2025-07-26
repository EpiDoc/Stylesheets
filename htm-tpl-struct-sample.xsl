<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:i18n="http://apache.org/cocoon/i18n/2.1" exclude-result-prefixes="t" version="2.0">
  <!-- Contains named templates for sample file structure -->
  <!-- Called from htm-tpl-structure.xsl -->

  <xsl:template name="sample-title">
    
    <xsl:choose>
      <xsl:when test="//t:titleStmt/t:title//text() and //t:publicationStmt/t:idno[@type = 'filename']/text()">

        <xsl:apply-templates select="//t:titleStmt/t:title"/>
        <xsl:text> (</xsl:text>
        <xsl:value-of select="//t:publicationStmt/t:idno[@type = 'filename']"/>
        <xsl:text>)</xsl:text>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title//text()">
        <xsl:apply-templates select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:sourceDesc//t:bibl//text()">
        <xsl:apply-templates select="//t:sourceDesc//t:bibl"/>
      </xsl:when>
      <xsl:when test="//t:idno[@type = 'filename']/text()">
        <xsl:value-of select="//t:idno[@type = 'filename']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>EpiDoc example output, sample style</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="sample-structure">
    <xsl:variable name="title">
      <xsl:call-template name="sample-title"/>
    </xsl:variable>

    <xsl:variable name="previous">
      <xsl:variable name="idno" select="//t:publicationStmt/t:idno[@type='filename']"/>
      <xsl:variable name="prefix" select="replace($idno, '\d+$', '')"/>
      <xsl:variable name="number-part" select="substring-after($idno, $prefix)"/>
      <xsl:choose>
        <xsl:when test="$number-part = '001'">
          <xsl:value-of select="'disable'"/>
        </xsl:when>
        <xsl:otherwise>
          <!-- Decrement the number part -->
          <xsl:variable name="decremented-number">
            <xsl:value-of select="format-number(number($number-part) - 1, '000')"/>
          </xsl:variable>
          
          <!-- Construct the new string -->
          <xsl:value-of select="concat('detail.html?doc=', $prefix, $decremented-number)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="next">
      <xsl:variable name="idno" select="//t:publicationStmt/t:idno[@type='filename']"/>
      <xsl:variable name="prefix" select="replace($idno, '\d+$', '')"/>
      <xsl:variable name="number-part" select="substring-after($idno, $prefix)"/>
      
      <!-- Increment the number part -->
      <xsl:variable name="incremented-number">
        <xsl:value-of select="format-number(number($number-part) + 1, '000')"/>
      </xsl:variable>
      
      <!-- Construct the new string -->
      <xsl:value-of select="concat('detail.html?doc=', $prefix, $incremented-number)"/>
      
    </xsl:variable>

    <html>
      <head>
        <title>
          <xsl:value-of select="$title"/>
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <!-- Found in htm-tpl-cssandscripts.xsl -->

      </head>
      <body>
        <h1 class="object_title">
          <xsl:value-of select="$title"/>
        </h1>
<div class="navigation-row">
    <ul class="navigation-buttons">

            <li class="nav-item">
              <xsl:choose>
                <!-- Disable link by omitting href when previous is 'disable' -->
                <xsl:when test="$previous = 'disable'">
                  <a class="nav-link">
                                        Previous</a>
                </xsl:when>
                <xsl:otherwise>
                  <a class="nav-link" href="{$previous}">
                                        <i class="fas fa-arrow-left"/> Previous</a>
                </xsl:otherwise>
              </xsl:choose>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="{$next}">Next <i class="fas fa-arrow-right"/>
                            </a>
            </li>
          </ul>
        </div>
        <xsl:call-template name="sample-body-structure"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template name="sample-body-structure">
    <div id="metadata">

      <div class="row align-items-start">
        <div class="col">
<br/>
          
          <br/>
          <h3>PROVENANCE</h3>
          <p>
                        <b>Discovery: </b>
            <xsl:choose>
              <xsl:when test="//t:provenance[@type = 'found']//text()">
                <xsl:apply-templates select="//t:provenance[@type = 'found']"/>
              </xsl:when>
              <xsl:otherwise>Unknown</xsl:otherwise>
            </xsl:choose>
          </p>
          
          <p>
            <b>Findspot: </b>
            <xsl:choose>
              
              <xsl:when test="//t:origin/t:origPlace//text()">
                <xsl:for-each select="//t:origin/t:origPlace/t:placeName">
                  <xsl:apply-templates select="."/>
                  <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="//t:origin/t:origPlace/t:note"/>
                <xsl:text>)</xsl:text>
              </xsl:when>
              <xsl:when test="//t:origin/t:placeName//text()">
                <xsl:apply-templates select="//t:origin/t:placeName"/>
              </xsl:when>
              <xsl:otherwise>Unknown</xsl:otherwise>
            </xsl:choose>
          </p>
          <xsl:choose>
            <xsl:when test="//t:msIdentifier//t:repository//text()">
              <p>
                <b>Current repository: </b>
                <xsl:for-each select="//t:msIdentifier//t:repository">
                  <xsl:if test="preceding-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                    <xsl:for-each select="preceding-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                      <xsl:apply-templates select="."/>
                      <xsl:text> </xsl:text>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:if test="following-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                    <xsl:for-each select="following-sibling::t:*[not(self::t:idno)][not(self::t:altIdentifier)]">
                      <xsl:apply-templates select="."/>
                      <xsl:text> </xsl:text>
                    </xsl:for-each>
                  </xsl:if>
                  <xsl:apply-templates select="."/>
                  <xsl:if test="following-sibling::t:idno">
                    <xsl:text> (inv. no. </xsl:text>
                    <xsl:for-each select="following-sibling::t:idno">
                      <xsl:apply-templates select="."/>
                      <xsl:if test="position() != last()">
                        <xsl:text>, </xsl:text>
                      </xsl:if>
                    </xsl:for-each>
                    <xsl:text>)</xsl:text>
                  </xsl:if>
                  <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
                            </p>
            </xsl:when>
            <xsl:when test="//t:msIdentifier//t:msName//text()">
              <xsl:for-each select="//t:msIdentifier//t:msName">
                <xsl:apply-templates select="."/>
                <xsl:if test="position() != last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            
            <!--<xsl:otherwise>Unknown</xsl:otherwise>-->
          </xsl:choose>
          <xsl:if test="//t:provenance[@type = 'observed' or @type = 'not-observed' or @type = 'transferred']//text()">
            <p>
              <b>Last recorded location(s): </b>
              <xsl:for-each select="//t:provenance[@type = 'observed' or @type = 'not-observed' or @type = 'transferred']">
                <xsl:apply-templates select="."/>
                <xsl:if test="position() != last()">
                  <xsl:text> </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </p>
          </xsl:if>
          <br/>
          <br/>
          <h3>SUPPORT</h3>
          <xsl:if test="//t:support//t:p//text() or //t:support/t:rs[not(@type = 'decoration')]//text()">
            
             <p>
              <xsl:apply-templates select="//t:support/t:p" mode="sample-dimensions"/>
              <xsl:text> </xsl:text>
              <xsl:for-each select="//t:support/t:rs[not(@type = 'decoration')]">
                <xsl:apply-templates select="." mode="sample-dimensions"/>
                <xsl:if test="position() != last()">
                  <xsl:text>; </xsl:text>
                </xsl:if>
              </xsl:for-each>
             </p>
            
          </xsl:if>
          
          <xsl:if test="//t:support/t:objectType//text()">
            <p>
              <b>Object type: </b>
              <xsl:apply-templates select="//t:support/t:objectType"/>
            </p>
          </xsl:if>
          <xsl:if test="//t:support/t:material//text()">
            
            <p>
              <b>Material: </b>
              <xsl:apply-templates select="//t:support/t:material"/>
            </p>
          </xsl:if>


          <xsl:if test="//t:support/t:dimensions//text()">
            <p>
              <b>Dimensions: </b>
              <xsl:apply-templates select="//t:support/t:dimensions" mode="sample-dimensions"/>
            </p>
          </xsl:if>

          <xsl:if test="//t:support/t:desc[@type = 'decoration']">
            <p>
              <b>Decoration: </b>
              <xsl:apply-templates select="//t:support/t:desc[@type = 'decoration']"/>
            </p>
          </xsl:if>

          <xsl:if test="//t:supportDesc//t:condition//text()">
            <p>
              <b>Condition: </b>
              <xsl:value-of select="//t:supportDesc//t:condition"/>
            </p>
          </xsl:if>

          <xsl:if test="//t:layoutDesc/t:layout//text()">
            <br/>
            <br/>
<h3>INSCRIPTION</h3>
            <p>
              <b>Text field: </b>
                            <xsl:apply-templates select="//t:layoutDesc/t:layout" mode="sample-dimensions"/>
            </p>
          </xsl:if>
          <xsl:if test="//t:handDesc//text()">
            
            <p>
              <b>Letters: </b>
                            <xsl:apply-templates select="//t:handDesc"/>
            </p>
          </xsl:if>
          <xsl:if test="//t:origin/t:origDate//text()">
            
            
            <p>
              <b>Date: </b>
              <xsl:apply-templates select="//t:origin/t:origDate"/>
              <xsl:if test="//t:origin/t:origDate[@evidence]">
                <xsl:text> (</xsl:text>
                <xsl:for-each select="tokenize(//t:origin/t:origDate/@evidence, ' ')">
                  <xsl:value-of select="translate(translate(., '-', ' '), ',', '')"/>
                  <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                  </xsl:if>
                </xsl:for-each>
                <xsl:text>)</xsl:text>
              </xsl:if>
            </p>
            <!--<xsl:when test="//t:origin/t:date//text()">
                <xsl:apply-templates select="//t:origin/t:date"/>
                <xsl:if test="//t:origin/t:date[@evidence]">
                  <xsl:text> (</xsl:text>
                  <xsl:for-each select="tokenize(//t:origin/t:date/@evidence, ' ')">
                    <xsl:value-of select="translate(translate(., '-', ' '), ',', '')"/>
                    <xsl:if test="position() != last()">
                      <xsl:text>, </xsl:text>
                    </xsl:if>
                  </xsl:for-each>
                  <xsl:text>)</xsl:text>
                </xsl:if>
              </xsl:when>
              <xsl:otherwise>Unknown.</xsl:otherwise>-->
          </xsl:if>
          
          

          


          

          
<!--
          <p>
            <b>Text type: </b>
            <xsl:choose>
              <xsl:when test="//t:textClass//t:keywords//t:term[@type = 'textType']">
                <xsl:apply-templates select="//t:textClass//t:keywords//t:term[@type = 'textType']"/>
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="//t:teiHeader//t:rs[@type = 'textType']">
                <xsl:apply-templates select="//t:teiHeader//t:rs[@type = 'textType']"/>
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="//t:msContents//t:summary[@corresp]">
                <xsl:apply-templates select="//t:msContents//t:summary[@corresp]"/>
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="//t:textClass//t:keywords//t:term[not(@type = 'textType')]">
                <xsl:apply-templates select="//t:textClass//t:keywords//t:term[not(@type = 'textType')]"/>
                <xsl:text> </xsl:text>
              </xsl:when>
              <xsl:when test="//t:msDesc//t:msItem[@class]">
                <xsl:value-of select="//t:msDesc//t:msItem/@class"/>
              </xsl:when>
              <xsl:otherwise>Unknown</xsl:otherwise>
            </xsl:choose>
          </p>
          -->
          

          <xsl:if test="//t:msDesc/t:msContents/t:msItem/t:p//text() or //t:msContents//t:summary//text()">
            <p>
              <b>Summary: </b>
              <xsl:choose>
                <xsl:when test="//t:msDesc/t:msContents/t:msItem/t:p">
                  <xsl:value-of select="//t:msDesc/t:msContents/t:msItem/t:p"/>
                </xsl:when>
                <xsl:when test="//t:msContents//t:summary">
                  <xsl:apply-templates select="//t:msContents//t:summary"/>
                </xsl:when>
              </xsl:choose>
            </p>
          </xsl:if>

          <!--<xsl:if test="//t:textClass//t:keywords//text()">
        <p><b>Keywords: </b>
          <xsl:apply-templates select="//t:textClass//t:keywords"/>
        </p>
      </xsl:if>-->
          <!--
    <div id="file_metadata">
      <xsl:if test="//t:titleStmt//t:editor//text()">
        <p><b>Editor(s): </b>
          <xsl:for-each select="//t:editor">
            <xsl:apply-templates select="."/>
            <xsl:if test="@role">
              <xsl:text> (</xsl:text><xsl:value-of select="@role"/><xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="position()!=last()">
              <xsl:text>, </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
      
      
      <xsl:if test="//t:revisionDesc//t:change">
        <p><b>Changes history: </b>
          <xsl:for-each select="//t:change">
            <xsl:value-of select="@when"/><xsl:text> </xsl:text>
            <xsl:value-of select="@who"/><xsl:text> </xsl:text>
            <xsl:value-of select="."/>
            <xsl:if test="position()!=last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
      
      
      
      <xsl:if test="//t:publicationStmt[descendant::t:*[not(self::t:idno)]//text()]">
        <p><b>Publication details: </b>
          <xsl:for-each select="//t:publicationStmt/t:*[not(self::t:idno)] ">
            <xsl:apply-templates select="."/>
            <xsl:if test="position()!=last()">
              <xsl:text>; </xsl:text>
            </xsl:if>
          </xsl:for-each>
        </p>
      </xsl:if>
    </div>
    
    -->
          <br/>
          <br/>
          
          <h3>EDITION</h3>
          <div class="section-container tabs" data-section="tabs">

            <nav>
              <div class="nav nav-tabs" id="nav-tab" role="tablist">
                <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Interpretive</button>
                <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Diplomatic</button>
              </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
              <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                <xsl:variable name="edtxt">
                  <xsl:apply-templates select="//t:div[@type = 'edition']">
                    <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
                  </xsl:apply-templates>

                </xsl:variable>
                <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
              </div>

              <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                <!-- Edited text output -->
                <xsl:variable name="edtxt">
                  <xsl:apply-templates select="//t:div[@type = 'edition']">
                    <xsl:with-param name="parm-edition-type" select="'diplomatic'" tunnel="yes"/>
                    <xsl:with-param name="parm-verse-lines" select="'off'" tunnel="yes"/>
                  </xsl:apply-templates>
                </xsl:variable>
                <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
              </div>
            </div>
          </div>

          <xsl:if test="//t:div[@type = 'apparatus']//text()">
            <br/>
            <div id="apparatus">
              <!-- Apparatus text output -->
              <xsl:variable name="apptxt">
                <xsl:apply-templates select="//t:div[@type = 'apparatus']"/>
              </xsl:variable>
              
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
            </div>
          </xsl:if>


          <xsl:if test="//t:div[@type = 'translation']//text()">
            <div id="translation">
              <!-- Translation text output -->
              <xsl:variable name="transtxt">
                <xsl:for-each select="//t:div[@type = 'translation']">
                  <br/>
                  <br/>
                  <h3>TRANSLATION <xsl:if test="@xml:lang">
                                            <xsl:text> (</xsl:text>
                      <xsl:choose>
                        <xsl:when test="@xml:lang = 'en'">
                                                    <xsl:text>English</xsl:text>
                                                </xsl:when>
                        <xsl:when test="@xml:lang = 'fr'">
                                                    <xsl:text>French</xsl:text>
                                                </xsl:when>
                        <xsl:when test="@xml:lang = 'it'">
                                                    <xsl:text>Italian</xsl:text>
                                                </xsl:when>
                        <xsl:when test="@xml:lang = 'de'">
                                                    <xsl:text>German</xsl:text>
                                                </xsl:when>
                        <xsl:when test="@xml:lang = 'ru'">
                                                    <xsl:text>Russian</xsl:text>
                                                </xsl:when>
                        <xsl:when test="@xml:lang = 'ar'">
                                                    <xsl:text>Arabic</xsl:text>
                                                </xsl:when>
                        <xsl:when test="@xml:lang = 'es'">
                                                    <xsl:text>Spanish</xsl:text>
                                                </xsl:when>
                        <xsl:otherwise>
                                                    <xsl:value-of select="@xml:lang"/>
                                                </xsl:otherwise>
                      </xsl:choose>
                      <xsl:text>)</xsl:text>
                                        </xsl:if>
                                    </h3>
                  <xsl:if test="@resp">
                    <p>
                      <xsl:text>Translation by </xsl:text>
                      <xsl:value-of select="translate(@resp, '#', '')"/>
                    </p>
                  </xsl:if>
                  <xsl:if test="@source">
                    <p>
                      <xsl:text>Translation from </xsl:text>
                      <xsl:value-of select="translate(@source, '#', '')"/>
                    </p>
                  </xsl:if>
                  <xsl:apply-templates select="descendant::t:p | descendant::t:ab"/>
                </xsl:for-each>
              </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
            </div>
          </xsl:if>

          <xsl:if test="//t:div[@type = 'commentary']//text()">
            <div id="commentary">
              <!-- Commentary text output -->
              <xsl:variable name="commtxt">
                <xsl:for-each select="//t:div[@type = 'commentary']">
                  <br/>
                  <br/>
                  <h3>COMMENTARY <xsl:if test="@subtype">
                                            <xsl:text> (</xsl:text>
                                            <xsl:value-of select="@subtype"/>
                                            <xsl:text>)</xsl:text>
                                        </xsl:if>
                                    </h3>
                  <xsl:apply-templates select="descendant::t:p"/>
                </xsl:for-each>
              </xsl:variable>
              <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
              <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
            </div>
          </xsl:if>

          <xsl:if test="//t:div[@type = 'bibliography']//text() or //t:teiHeader//t:listBibl//text()">
            <div id="bibliography">
              <xsl:for-each select="//t:div[@type = 'bibliography']">
                <br/>
                <br/>
                <h3>REFERENCES <xsl:if test="@subtype">
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="@subtype"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </h3>
                <xsl:apply-templates select="descendant::t:p"/>
                <xsl:apply-templates select="descendant::t:listBibl"/>
              </xsl:for-each>

              <xsl:for-each select="//t:teiHeader//t:listBibl">
                <h3>Bibliography <xsl:if test="@type">
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of select="@type"/>
                                        <xsl:text>)</xsl:text>
                                    </xsl:if>
                                </h3>
                <p>
                  <xsl:apply-templates select="descendant::t:bibl"/>
                </p>
              </xsl:for-each>

              <xsl:if test="//t:creation//text()">
                <p>
                  <b>Text constituted from: </b>
                  <xsl:apply-templates select="//t:creation"/>
                </p>
              </xsl:if>
            </div>
          </xsl:if>
        </div>
        <div class="col-4">
          
          
          
          <div id="map"/>
          
          <xsl:variable name="geo-code-split" select="tokenize(//t:geo, ',')"/>
          <xsl:variable name="cert" select="//t:geo/@cert"/>
          <span style="display:none" id="lat">
            <xsl:apply-templates select="$geo-code-split[1]"/>
          </span>
          <span style="display:none" id="long">
            <xsl:apply-templates select="$geo-code-split[2]"/>
          </span>
        <span style="display:none" id="cert">
            <xsl:apply-templates select="$cert"/>
          </span>
          <script>let lat = Number(document.getElementById('lat').textContent);
   let long = Number(document.getElementById('long').textContent);
   let cert = document.getElementById('cert').textContent;
   console.log(cert);

   var map = L.map('map').setView([lat, long], 8);

   L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
   }).addTo(map);

   // Create a marker and set icon based on the cert value
   let markerIcon = L.AwesomeMarkers.icon({
       icon: 'info-sign',
       markerColor: 'blue' // Default color
   });

   if (cert === 'low') {
       markerIcon = L.AwesomeMarkers.icon({
           icon: 'info-sign',
           markerColor: 'orange' // Orange color for low cert
       });
   }

   // Add marker with custom icon
   L.marker([lat, long], { icon: markerIcon }).addTo(map);
        </script>
          <br/>
          
         
          
          <xsl:if test="//t:facsimile">
            <div id="images">
              <xsl:choose>
                <xsl:when test="//t:facsimile/t:graphic">
                  <xsl:if test="count(//t:facsimile/t:graphic) = 1">
                    <xsl:variable name="image_url">
                      <xsl:value-of select="//t:facsimile/t:graphic/@url"/>
                    </xsl:variable>
                    <img src="{concat('../data/images/', $image_url)}" title="{t:desc}" class="d-block w-100"/>
                  </xsl:if>
                  <xsl:if test="count(//t:facsimile/t:graphic) &gt; 1">
                    <div id="carouselExampleCaptions" class="carousel slide">
                      
                      <div class="carousel-inner">
                        <xsl:for-each select="//t:facsimile/t:graphic">
                          <!-- Assign the 'active' class only to the first image (Luca)-->
                          <xsl:variable name="active">
                            <xsl:if test="position() = 1">
                              <xsl:text>active</xsl:text>
                            </xsl:if>
                          </xsl:variable>
                          <div class="carousel-item {$active}">
                            
                            
                            <img src="{concat('../data/images/', @url)}" title="{t:desc}" class="d-block w-100"/>
                            <div class="carousel-caption d-none d-md-block">
                              
                              <p>
                                <xsl:if test="t:desc">
                                  <xsl:apply-templates select="t:desc"/>
                                </xsl:if>
                              </p>
                            </div>
                          </div>
                          
                          
                          
                        </xsl:for-each>
                        
                      </div>
                      <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"/>
                        <span class="visually-hidden">Previous</span>
                      </button>
                      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"/>
                        <span class="visually-hidden">Next</span>
                      </button>
                    </div>
                  </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                  <xsl:for-each select="//t:facsimile[not(//t:graphic)]">
                    <p>No images available.</p>
                  </xsl:for-each>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </xsl:if>
          
          <h3>3D MODEL</h3>
          
          
          
          <!--POINT PICKING-->
          
          
          <div id="3dhop" class="tdhop">
                        <div id="tdhlg"/>
            
            <div id="toolbar">
             
              
              <br/>
              
              <div class="icon-container">
                <div class="d-flex align-items-center gap-3">
                  
                  <button id="i_solidColorButton" class="btn btn-secondary" data-state="off" data-on="Plain Color" data-off="Texture" onclick="toggleSolidColorButton(this, 'Model1');">
                    Texture
                  </button>
                  
                  <button id="toggle-light-controller" class="btn btn-primary">
                    Toggle Light Controller
                  </button>
                </div>
                <canvas id="lightcontroller_canvas"/>
                <img id="home" class="icon" title="Home" src="../resources/3dhop/skins/dark/home.png" alt="Home button"/>
                <img id="screenshot" class="icon" title="Save Screenshot" src="../resources/3dhop/skins/dark/screenshot.png" alt="Screenshot button"/>
                <img id="zoomin" class="icon" title="Zoom In" src="../resources/3dhop/skins/dark/zoomin.png" alt="Zoom in button"/>
                <img id="zoomout" class="icon" title="Zoom Out" src="../resources/3dhop/skins/dark/zoomout.png" alt="Zoom out button"/>
                <img id="measure_on" class="icon hidden" title="Disable Measure Tool" src="../resources/3dhop/skins/dark/measure_on.png" alt="Measure Tool On"/>
                <img id="measure" class="icon visible" title="Enable Measure Tool" src="../resources/3dhop/skins/dark/measure.png" alt="Measure Tool Off"/>
                <img id="lighting_off" class="icon hidden" title="Enable Lighting" src="../resources/3dhop/skins/dark/lighting.png" alt="Lighting Off"/>
                <img id="lighting" class="icon visible" title="Disable Lighting" src="../resources/3dhop/skins/dark/lighting_off.png" alt="Lighting On"/>
                <img id="perspective" class="icon hidden" title="Perspective Camera" src="../resources/3dhop/skins/dark/perspective.png" alt="Perspective Camera"/>
                <img id="orthographic" class="icon faded visible" title="Orthographic Camera" src="../resources/3dhop/skins/dark/orthographic.png" alt="Orthographic Camera"/>
                <img id="pick_on" class="icon hidden" title="Disable PickPoint Mode" src="../resources/3dhop/skins/dark/pick_on.png" alt="PickPoint Mode On"/>
                <img id="pick" class="icon" title="Enable PickPoint Mode" src="../resources/3dhop/skins/dark/pick.png" alt="PickPoint Mode Off"/>
                <img id="angle_on" class="icon hidden" title="Disable Angle Tool" src="../resources/3dhop/skins/dark/angle_on.png" alt="Angle Tool On"/>
                <img id="angle" class="icon visible" title="Enable Angle Tool" src="../resources/3dhop/skins/dark/angle.png" alt="Angle Tool Off"/>
                <img id="full" class="icon visible" title="Full Screen" src="../resources/3dhop/skins/dark/full.png" alt="Full Screen"/>
                <img id="full_on" class="icon hidden" title="Exit Full Screen" src="../resources/3dhop/skins/dark/full_on.png" alt="Exit Full Screen"/>
              </div>
              
              
            </div>


            <canvas id="draw-canvas"/>
              
  <!-- Output Boxes -->
  <div id="measure-box" class="output-box hidden">
    Measured length<hr/>
    <span id="measure-output" class="output-text" onmousedown="event.stopPropagation()">0.0</span>
  </div>
  
  <div id="pickpoint-box" class="output-box hidden">
    XYZ picked point<hr/>
    <span id="pickpoint-output" class="output-text" onmousedown="event.stopPropagation()">[ 0 , 0 , 0 ]</span>
  </div>
  
  <div id="angle-box" class="output-box hidden">
    Angle<hr/>
    <span id="angle-output" class="output-text" onmousedown="event.stopPropagation()">0.0°</span>
  </div>

          </div>
          <link type="text/css" rel="stylesheet" href="../resources/3dhop/stylesheet/3dhop.css"/>
          
          <!-- SPIDERGL -->
          <script type="text/javascript" src="../resources/3dhop/js/spidergl.js"/>
          
          <!-- PRESENTER -->
          <script type="text/javascript" src="../resources/3dhop/js/presenter.js"/>
          
          <!-- 3D MODELS LOADING AND RENDERING -->
          <script type="text/javascript" src="../resources/3dhop/js/nexus.js"/>
          <script type="text/javascript" src="../resources/3dhop/js/ply.js"/>
          
          <!-- TRACKBALLS -->
          <script type="text/javascript" src="../resources/3dhop/js/trackball_sphere.js"/>
          <script type="text/javascript" src="../resources/3dhop/js/trackball_turntable.js"/>
          <script type="text/javascript" src="../resources/3dhop/js/trackball_turntable_pan.js"/>
          <script type="text/javascript" src="../resources/3dhop/js/trackball_pantilt.js"/>
          
          <!-- UTILITY -->
          <script src="../resources/3dhop/js/init.js"/>
          <script src="../resources/3dhop/ogham_3d.js"/>
          <br/>
          <br/>
        </div>
        <!-- column -->
        
      </div>
      <!-- row -->
    </div>
    <!--  metadata -->

  </xsl:template>

  <!-- dimensions -->
  <xsl:template match="t:dimensions" mode="sample-dimensions">
    <xsl:if test="@type">
      <xsl:value-of select="@type"/>
      <xsl:text>: </xsl:text>
    </xsl:if>
    <xsl:if test="//text()">

      <xsl:if test="t:height/text()">
        <xsl:text>H </xsl:text>
        <xsl:value-of select="t:height"/>
        <xsl:if test="t:height[@unit]">
          <xsl:text> </xsl:text>
          <xsl:value-of select="t:height/@unit"/>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:width/text()">
        <xsl:text> × W </xsl:text>
        <xsl:value-of select="t:width"/>
        <xsl:if test="t:width[@unit]">
          <xsl:text> </xsl:text>
          <xsl:value-of select="t:width/@unit"/>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:depth/text()">
        <xsl:text> × D </xsl:text>
        <xsl:value-of select="t:depth"/>
        <xsl:if test="t:depth[@unit]">
          <xsl:text> </xsl:text>
          <xsl:value-of select="t:depth/@unit"/>
        </xsl:if>
      </xsl:if>
      <xsl:if test="t:dim[@type = 'diameter']/text()">
        <xsl:text> × diam. </xsl:text>
        <xsl:value-of select="t:dim[@type = 'diameter']"/>
        <xsl:if test="t:dim[@type = 'diameter'][@unit]">
          <xsl:text> </xsl:text>
          <xsl:value-of select="t:dim[@type = 'diameter']/@unit"/>
        </xsl:if>
      </xsl:if>
      <xsl:if test="@unit">
        <xsl:text> </xsl:text>
        <xsl:value-of select="@unit"/>
      </xsl:if>
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>

  <!-- uncomment the following template to activate external links in @ref -->
  <!--<xsl:template priority="10" match="t:*[starts-with(@ref, 'http')]">
      <a href="{@ref}" target="_blank"><xsl:apply-templates/></a>
    </xsl:template>-->

</xsl:stylesheet>