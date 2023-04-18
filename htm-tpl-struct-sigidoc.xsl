<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:i18n="http://apache.org/cocoon/i18n/2.1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0"
                xmlns:fn="http://www.w3.org/2005/xpath-functions">
  <!-- Contains named templates for IOSPE file structure (aka "metadata" aka "supporting data") -->

  <!-- Called from htm-tpl-structure.xsl -->
  
  <!-- LAST MODIFIED: 2023-03-08 -->

  <xsl:template name="sigidoc-body-structure">
    <xsl:call-template name="navigation"/>
    

      <h6 width="600" align="right" xml:space="preserve">SigiDoc ID: 
        <xsl:choose>
          <xsl:when test="//t:publicationStmt//t:idno[@type='SigiDocID']//text()">
            <xsl:apply-templates select="//t:publicationStmt//t:idno[@type='SigiDocID']"/>
          </xsl:when>
          <xsl:otherwise>―</xsl:otherwise>
        </xsl:choose>
      </h6>
    
    
    <div id="stone">
      <h3 class="iospe"><i18n:text i18n:key="artifact">Artifact</i18n:text></h3>
      <dl class="iospe">
        <dt width="150" align="left"><i18n:text i18n:key="type">Type</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:objectType//t:term//t:seg//text()">
              <xsl:apply-templates select="//t:objectType//t:term//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="general-layout">General layout</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:TEI//t:teiHeader//t:fileDesc//t:sourceDesc//t:msDesc//t:physDesc//t:objectDesc//t:layoutDesc//t:layout[@n='whole']//t:rs[@type='layout']//t:seg//text()">
              <xsl:apply-templates select="//t:TEI//t:teiHeader//t:fileDesc//t:sourceDesc//t:msDesc//t:physDesc//t:objectDesc//t:layoutDesc//t:layout[@n='whole']//t:rs[@type='layout']//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="matrix">Matrix</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
            <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']">
              <xsl:choose>
                <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc'] and //t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']">
                  SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']"/>* - PBW ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']"/>*
                </xsl:when>
                <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']">
                  SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']"/>*
                </xsl:when>
                <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']">
                  PBW ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']"/>*
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']">
              <xsl:choose>
                <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc'] and //t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']">
                  SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']"/> - PBW ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']"/>
                </xsl:when>
                <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']">
                  SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']"/>
                </xsl:when>
                <xsl:when test="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']">
                  PBW ID: <xsl:apply-templates select="//t:layout[@n='whole']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']"/>
                </xsl:when>
              </xsl:choose>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
      </dl>
    </div>
        <div id="stone">
          <h4 class="iospe"><i><i18n:text i18n:key="physical-description">Physical description</i18n:text></i></h4>
          <!-- ************* physical description *************** -->
          <dl class="iospe">
            <dt width="150" align="left"><i18n:text i18n:key="medium">Medium</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:objectType//t:interp[@type='workType']//text()">
              <xsl:apply-templates select="//t:objectType//t:interp[@type='workType']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="material">Material</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:material//t:seg//text()">
              <xsl:apply-templates select="//t:support//t:material//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="shape">Shape</i18n:text></dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//t:layout//t:rs[@type='shape']//t:seg//text()">
                  <xsl:apply-templates select="//t:layout//t:rs[@type='shape']//t:seg"/>
                </xsl:when>
                <xsl:otherwise>―</xsl:otherwise>
              </xsl:choose>
            </dd>
            <dt width="150" align="left"><i18n:text i18n:key="dimensions">Dimensions (mm)</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
            <xsl:when test="//t:support/t:dimensions/t:dim[@type='diameter']/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="diameter">Diam. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:dim[@type='diameter']"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')] and //t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="height">H. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:height"/>,
              <i18n:text i18n:key="width">W. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:width"/>,
              <i18n:text i18n:key="thickness">Th. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:depth"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="height">H. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:height"/>,
              <i18n:text i18n:key="width">W. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:width"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="height">H. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:height"/>,
              <i18n:text i18n:key="thickness">Th. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:depth"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')] and //t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="width">W. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:width"/>,
              <i18n:text i18n:key="thickness">Th. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:depth"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="height">H. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:height"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="width">W. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:width"/>
            </xsl:when>
            <xsl:when test="//t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="thickness">Th. </i18n:text>
              <xsl:apply-templates select="//t:support/t:dimensions/t:depth"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="weight">Weight (g)</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:measure[@type='weight'][@unit='g']//text()">
              <xsl:apply-templates select="//t:support//t:measure[@type='weight'][@unit='g']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="channel-orientation">Channel orientation (clock)</i18n:text></dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//t:support//t:measure[@type='channelOrient'][@unit='clock']//text()">
                  <xsl:apply-templates select="//t:support//t:measure[@type='channelOrient'][@unit='clock']"/>
                </xsl:when>
                <xsl:otherwise>―</xsl:otherwise>
              </xsl:choose>
            </dd>
            <dt width="150" align="left"><i18n:text i18n:key="axis">Axis (clock)</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:measure[@type='axis'][@unit='clock']//text()">
              <xsl:apply-templates select="//t:support//t:measure[@type='axis'][@unit='clock']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="overstrike-orientation">Overstrike orientation (clock)</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:support//t:measure[@type='overstrikeOrient'][@unit='clock']//text()">
              <xsl:apply-templates select="//t:support//t:measure[@type='overstrikeOrient'][@unit='clock']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="execution">Execution</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:layout//t:rs[@type='execution']//t:seg//text()">
              <xsl:apply-templates select="//t:layout//t:rs[@type='execution']//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
            <dt width="150" align="left"><i18n:text i18n:key="countermark">Countermark</i18n:text></dt>
            <dd>
              <xsl:choose>
                <xsl:when test="//t:support//t:measure[@type='countermark']//text()">
                  <xsl:apply-templates select="//t:support//t:measure[@type='countermark']"/>
                </xsl:when>
                <xsl:otherwise>―</xsl:otherwise>
              </xsl:choose>
            </dd>
            <dt width="150" align="left"><i18n:text i18n:key="condition">Condition</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
            <xsl:when test="//t:supportDesc//t:condition/t:p/text()">
              <xsl:apply-templates select="//t:supportDesc//t:condition//t:p//text()"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          </dl>
        </div>
        <div id="stone">
          <h4 class="iospe"><i><i18n:text i18n:key="dating">Dating</i18n:text></i></h4><!-- ***********Dating************ -->
        <dl class="iospe">
          <dt width="150" align="left"><i18n:text i18n:key="date">Date</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:origin//t:origDate[@type='analysis']//t:seg/text()">
              <xsl:apply-templates select="//t:origin//t:origDate[@type='analysis']//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="internal-date">Internal date</i18n:text></dt>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:origin//t:origDate[@type='internal']//t:seg/text()">
                <xsl:apply-templates select="//t:origin//t:origDate[@type='internal']//t:seg"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="dating-criteria">Dating criteria</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:origin//t:origDate//t:interp/text()">
              <xsl:apply-templates select="//t:origin//t:origDate//t:interp"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
          <!-- <xsl:choose>
            <xsl:when test="//t:origin/t:origDate/@evidence">
              <xsl:for-each select="tokenize(//t:origin/t:origDate/@evidence,' ')">
                <xsl:value-of select="translate(.,'-',' ')"/>
                <xsl:if test="position()!=last()">
                  <xsl:text>, </xsl:text>
                </xsl:if>
              </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <i><i18n:text i18n:key="not-specified"><xsl:text>Not specified</xsl:text></i18n:text></i>
            </xsl:otherwise>
            </xsl:choose> --><!-- NOT TO BE CHANGED INTO <xsl:apply-templates/> -->
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="alternative-dating">Alternative dating</i18n:text></dt>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:origin//t:date//t:choice">
                <xsl:apply-templates select="//t:origin//t:date//t:choice//t:corr"/> (<xsl:apply-templates select="//t:origin//t:date//t:choice//t:corr/@resp"/>), <i18n:text i18n:key="alternative-dating-basedon">based on</i18n:text>: <xsl:apply-templates select="//t:origin//t:date//t:interp[@type='datingCriteria']"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
        </dl>
        </div>
        <div id="stone">
          <h4 class="iospe"><i><i18n:text i18n:key="history">History</i18n:text></i></h4><!-- ***********History********* -->
        <dl class="iospe">
          <dt width="150" align="left"><i18n:text i18n:key="seal-category">Category</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:msContents//t:summary[@n='whole']//t:seg//text()">
              <xsl:apply-templates select="//t:msContents//t:summary[@n='whole']//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="issuer">Issuer</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:author//t:roleName//t:seg//text()">
              <xsl:apply-templates select="//t:author//t:roleName//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="issuer-milieu">Issuer's milieu</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:author//t:roleName//t:interp//text()">
              <xsl:apply-templates select="//t:author//t:roleName//t:interp"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="place-origin">Place of origin</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:origPlace//t:seg//t:placeName//text()">
              <xsl:apply-templates select="//t:origPlace//t:seg//t:placeName"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="find-place">Find place</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
            <xsl:when test="//t:history//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']//text() and //t:history//t:provenance[@type='found']//t:placeName[@type='modernFindspot']//text()">
              <xsl:apply-templates select="//t:history//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']"/> (<xsl:apply-templates select="//t:history//t:provenance[@type='found']//t:placeName[@type='modernFindspot']"/>)
            </xsl:when>
            <xsl:when test="//t:history//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']//text()">
              <xsl:apply-templates select="//t:history//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']"/>
            </xsl:when>
            <xsl:when test="//t:history//t:provenance[@type='found']//t:placeName[@type='modernFindspot']//text()">
              <xsl:apply-templates select="//t:history//t:provenance[@type='found']//t:placeName[@type='modernFindspot']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="find-date">Find date</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:provenance[@type='found']/@when">
                <xsl:apply-templates select="//t:provenance[@type='found']/@when"/>
              </xsl:when>
              <xsl:when test="//t:provenance[@type='found']/@notBefore and //t:provenance[@type='found']/@notAfter">
                <xsl:apply-templates select="//t:provenance[@type='found']/@notBefore"/> - <xsl:apply-templates select="//t:provenance[@type='found']/@notAfter"/>
              </xsl:when>
              <xsl:when test="//t:provenance[@type='found']/@notBefore">
                <i18n:text i18n:key="not-before">Not before</i18n:text> <xsl:apply-templates select="//t:provenance[@type='found']/@notBefore"/>
              </xsl:when>
              <xsl:when test="//t:provenance[@type='found']/@notAfter">
                <i18n:text i18n:key="not-after">Not after</i18n:text> <xsl:apply-templates select="//t:provenance[@type='found']/@notAfter"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="find-circumstances">Find circumstances</i18n:text></dt>
          <dd>
          <xsl:choose>
            <xsl:when test="//t:provenance[@type='found']//t:rs[@type='circumstances']//text()">
              <xsl:apply-templates select="//t:provenance[@type='found']//t:rs[@type='circumstances']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="modern-location">Modern location</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
                        <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier//t:settlement//t:seg//text() and //t:sourceDesc//t:msDesc//t:msIdentifier//t:country//t:seg//text()">
                          <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:settlement//t:seg"/>
                          (<xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:country//t:seg"/>) 
                        </xsl:when>
                        <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier//t:settlement//t:seg//text()">
                          <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:settlement//t:seg"/>
                          <xsl:text></xsl:text>
                        </xsl:when>
                        <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier//t:country//t:seg//text()">
                          <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:country//t:seg"/>
                          <xsl:text></xsl:text>
                        </xsl:when>
                        <xsl:otherwise>―</xsl:otherwise>
                    </xsl:choose>
        </dd>
          <dt width="150" align="left"><i18n:text i18n:key="institution-repository">Institution and repository</i18n:text></dt>
        <!-- <dd>
            <xsl:choose xml:space="preserve">
                        <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier">
                            <xsl:value-of select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:institution"/>: <xsl:value-of select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:repository"/>, <xsl:value-of select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:collection"/>, No. <xsl:value-of select="//t:sourceDesc//t:msDesc//t:msIdentifier//t:idno"/>  
                        </xsl:when>
                        <xsl:otherwise><i18n:text i18n:key="not-available">Not available</i18n:text></xsl:otherwise>
                    </xsl:choose>
          </dd> -->
          <dd>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier/t:institution//text() and //t:sourceDesc//t:msDesc//t:msIdentifier/t:repository//text()">
                <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:institution"/>,
                <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:repository"/>
              </xsl:when>
              <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier/t:institution//text()">
              <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:institution"/>
              <xsl:text></xsl:text>
            </xsl:when>
              <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier/t:repository/text()">
              <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:repository"/>
              <xsl:text></xsl:text>
            </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="collection-inventory">Collection and inventory</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier/t:collection//text() and //t:sourceDesc//t:msDesc//t:msIdentifier/t:idno//text()">
                <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:collection"/>
                <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:idno"/>
              </xsl:when>
              <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier/t:collection//text()">
              <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:collection"/>
              <xsl:text>no inv. no.</xsl:text>
            </xsl:when>
              <xsl:when test="//t:sourceDesc//t:msDesc//t:msIdentifier/t:idno//text()">
              <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:msIdentifier/t:idno"/>
              <xsl:text></xsl:text>
            </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:sourceDesc//t:msDesc//t:altIdentifier/t:repository/text() and //t:sourceDesc//t:msDesc//t:altIdentifier//t:idno//text()">
                 (<i>olim </i><xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:altIdentifier/t:repository"/>  
                <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:altIdentifier/t:idno"/>)
              </xsl:when>
              <xsl:when test="//t:sourceDesc//t:msDesc//t:altIdentifier/t:repository/text()">
               (<i>olim </i><xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:altIdentifier/t:repository"/>)
            </xsl:when>
              <xsl:when test="//t:sourceDesc//t:msDesc//t:altIdentifier/t:idno//text()">
              <xsl:apply-templates select="//t:sourceDesc//t:msDesc//t:altIdentifier/t:idno"/>
            </xsl:when>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="acquisition">Acquisition</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:acquisition//t:p//text()">
                <xsl:apply-templates select="//t:acquisition//t:p"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="previous-locations">Previous locations</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:provenance[@type='transferred']//t:p//text()">
                <xsl:apply-templates select="//t:provenance[@type='transferred']//t:p"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="modern-observations">Modern observations</i18n:text></dt>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:provenance[@type='observed']//t:p//text() and //t:provenance[@type='not-observed']//t:p//text()">
                <xsl:apply-templates select="//t:provenance[@type='observed']//t:p"/>
                <xsl:apply-templates select="//t:provenance[@type='not-observed']//t:p"/>
              </xsl:when>
              <xsl:when test="//t:provenance[@type='observed']//t:p//text()">
                <xsl:apply-templates select="//t:provenance[@type='observed']//t:p"/>
              </xsl:when>
              <xsl:when test="//t:provenance[@type='not-observed']//t:p//text()">
                <xsl:apply-templates select="//t:provenance[@type='not-observed']//t:p"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
        </dl>
        </div>
        
      <div id="text-field">
        <h3 class="iospe"><i18n:text i18n:key="field-obverse">Obverse</i18n:text></h3>
        <!-- *******inscribed field - obverse *********** -->
        <dl class="iospe"> 
          <dt width="150" align="left"><i18n:text i18n:key="languages">Language(s)</i18n:text></dt>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:msContents//t:textLang[@n='r']//t:seg//text()">
                <xsl:apply-templates select="//t:msContents//t:textLang[@n='r']//t:seg"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="layout-field">Layout of field</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
                        <xsl:when test="//t:layoutDesc//t:layout[@n='r']/t:p/text()">
                            <xsl:apply-templates select="//t:layoutDesc//t:layout[@n='r']/t:p/text()"/>
                        </xsl:when>
                        <xsl:otherwise>―</xsl:otherwise>
                    </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="field-dimensions">Field's dimensions (mm)</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
            <xsl:when test="//t:layout[@n='r']/t:dimensions/t:dim[@type='diameter']/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="diameter">Diam. </i18n:text>
              <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:dim[@type='diameter']"/>
            </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:layout[@n='r']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')] and //t:layout[@n='r']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:height"/>,
              <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:width"/>,
              <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:depth"/><!-- not necessary for field's dimensions, but still... -->
            </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:layout[@n='r']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:height"/>,
              <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:width"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:layout[@n='r']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:height"/>,
                <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:depth"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')] and //t:layout[@n='r']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:width"/>,
                <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:depth"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:height"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:width"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='r']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='r']/t:dimensions/t:depth"/>
              </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="matrix">Matrix</i18n:text></dt>
          <dd>
            <xsl:choose xml:space="preserve">
              <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']">
                <xsl:choose>
                  <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc'] and //t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']">
                    SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']//text()"/>* - PBW ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']//text()"/>*
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']">
                SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']//text()"/>*
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']">
                PBW ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']//text()"/>*
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']">
                <xsl:choose xml:space="preserve">
                  <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc'] and //t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']">
                    SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']//text()"/> - PBW ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']//text()"/>
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']">
                    SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']//text()"/>
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']">
                    PBW ID: <xsl:apply-templates select="//t:layout[@n='r']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']//text()"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="iconography">Iconography</i18n:text></dt>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:figure//t:figDesc[@n='r']//text()">
                <xsl:apply-templates select="//t:figure//t:figDesc[@n='r']"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="decoration">Decoration</i18n:text></dt>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:figure//t:figDesc[@n='decoR']//text()">
                <xsl:apply-templates select="//t:figure//t:figDesc[@n='decoR']"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <dt width="150" align="left"><i18n:text i18n:key="epigraphy">Epigraphy</i18n:text></dt>
          <dd id="epigraphy">
            <xsl:choose> <!--cambiare @n='whole' in 'r' e 'v'-->
              <xsl:when test="//t:handDesc//t:handNote[@n='r']//t:seg//text()">
                <xsl:apply-templates select="//t:handDesc//t:handNote[@n='r']//t:seg"/>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
          </dd>
          <!-- dating for assembled seals not included yet -->
        </dl>
      </div>

    <dl class="iospe"></dl><!-- don't touch this! -->
      
    <div id="text-field">
      <h3 class="iospe"><i18n:text i18n:key="field-reverse">Reverse</i18n:text></h3><!-- *******inscribed field - reverse *********** -->
      <dl class="iospe"> 
        <dt width="150" align="left"><i18n:text i18n:key="languages">Language(s)</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:msContents//t:textLang[@n='v']//t:seg//text()">
              <xsl:apply-templates select="//t:msContents//t:textLang[@n='v']//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="layout-field">Layout of field</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
                        <xsl:when test="//t:layoutDesc//t:layout[@n='v']/t:p/text()">
                            <xsl:apply-templates select="//t:layoutDesc//t:layout[@n='v']/t:p/text()"/>
                        </xsl:when>
                        <xsl:otherwise>―</xsl:otherwise>
                    </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="field-dimensions">Field's dimensions (mm)</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
            <xsl:when test="//t:layout[@n='v']/t:dimensions/t:dim[@type='diameter']/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="diameter">Diam. </i18n:text>
              <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:dim[@type='diameter']"/>
            </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:layout[@n='v']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')] and //t:layout[@n='v']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
              <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:height"/>,
              <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:width"/>,
              <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:depth"/><!-- not necessary for field's dimensions, but still... -->
            </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:layout[@n='v']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:height"/>,
              <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:width"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')] and //t:layout[@n='v']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:height"/>,
                <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:depth"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')] and //t:layout[@n='v']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:width"/>,
                <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:depth"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:height/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="height">H. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:height"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="width">W. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:width"/>
              </xsl:when>
              <xsl:when test="//t:layout[@n='v']/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">
                <i18n:text i18n:key="thickness">Th. </i18n:text>
                <xsl:apply-templates select="//t:layout[@n='v']/t:dimensions/t:depth"/>
              </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="matrix">Matrix</i18n:text></dt>
        <dd>
          <xsl:choose xml:space="preserve">
              <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']">
                <xsl:choose>
                  <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc'] and //t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']">
                    SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']//text()"/>* - PBW ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']//text()"/>*
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']">
                SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='SigiDoc']//text()"/>*
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']">
                PBW ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='surviving']//t:idno[@type='PBW']//text()"/>*
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']">
                <xsl:choose xml:space="preserve">
                  <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc'] and //t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']">
                    SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']//text()"/> - PBW ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']//text()"/>
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']">
                    SigiDoc ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='SigiDoc']//text()"/>
                  </xsl:when>
                  <xsl:when test="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']">
                    PBW ID: <xsl:apply-templates select="//t:layout[@n='v']//t:rs[@type='matrix'][@subtype='notSurviving']//t:idno[@type='PBW']//text()"/>
                  </xsl:when>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise>―</xsl:otherwise>
            </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="iconography">Iconography</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:figure//t:figDesc[@n='v']//text()">
              <xsl:apply-templates select="//t:figure//t:figDesc[@n='v']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="decoration">Decoration</i18n:text></dt>
        <dd>
          <xsl:choose>
            <xsl:when test="//t:figure//t:figDesc[@n='decoV']//text()">
              <xsl:apply-templates select="//t:figure//t:figDesc[@n='decoV']"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="epigraphy">Epigraphy</i18n:text></dt>
        <dd id="epigraphy">
          <xsl:choose>
            <xsl:when test="//t:handDesc//t:handNote[@n='v']//t:seg//text()">
              <xsl:apply-templates select="//t:handDesc//t:handNote[@n='v']//t:seg"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <!-- dating for assembled seals -->
      </dl>
    </div>
    <dl class="iospe"><!-- don't touch this! --></dl>
    <div id="text">
      <!--<h3 class="iospe"><i18n:text i18n:key="text">Text</i18n:text></h3>-->
      <div id="images"><!-- ************************* IMAGES ************************************ -->
        <h4 class="iospe"><i><i18n:text i18n:key="images">Images</i18n:text></i></h4>
        <dl class="box">
          <xsl:for-each select="//t:facsimile//t:surface[@type='obverse']//t:graphic">
            <dd>
              <xsl:apply-templates select="." />
            </dd>
          </xsl:for-each>
          <dt width="150">
            <xsl:value-of select="//t:facsimile//t:surface[@type='obverse']//t:graphic//t:desc"/>
          </dt>
        </dl>
        <dl class="box">
          <xsl:for-each select="//t:facsimile//t:surface[@type='reverse']//t:graphic">
            <dd>
              <xsl:apply-templates select="." />
            </dd>
          </xsl:for-each>
          <dt width="150">
            <xsl:value-of select="//t:facsimile//t:surface[@type='reverse']//t:graphic//t:desc"/>
          </dt>
        </dl>
        
        <!-- alternative (without captions) -->
        
        <!--<dl class="box">
          <dt width="150"/>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:facsimile//t:surface[@type='obverse']//t:graphic">
                <xsl:apply-templates select="//t:facsimile//t:surface[@type='obverse']//t:graphic"/>
              </xsl:when>
              <xsl:otherwise><i18n:text>No images available</i18n:text></xsl:otherwise>
            </xsl:choose>
          </dd>
        </dl>
        <dl class="box">
          <dt width="150"/>
          <dd>
            <xsl:choose>
              <xsl:when test="//t:facsimile//t:surface[@type='reverse']//t:graphic">
                <xsl:apply-templates select="//t:facsimile//t:surface[@type='reverse']//t:graphic"/>
              </xsl:when>
              <xsl:otherwise><i18n:text>No images available</i18n:text></xsl:otherwise>
            </xsl:choose>
          </dd>
        </dl>-->

<!-- deprecated solution, with table -->
        
        <!--<table border="1">
          <tr>
            <td align="center">
              <dl>
                <xsl:for-each select="//t:facsimile//t:surface[@type='obverse']//t:graphic">
                <dt width="150" align="left"></dt>
                  <dd>
                    <xsl:apply-templates select="." />
                  </dd>
                </xsl:for-each>
              </dl>
            </td>
            <td align="center">
              <dl>
                <xsl:for-each select="//t:facsimile//t:surface[@type='reverse']//t:graphic">
                  <dt width="150" align="left"></dt>
                  <dd>
                    <xsl:apply-templates select="." />
                  </dd>
                </xsl:for-each>
              </dl>
            </td>
          </tr>
          <tr>
            <th>
              <xsl:choose>
                <xsl:when test="//t:facsimile//t:surface[@type='obverse']//t:graphic//t:desc//text()">
                  <xsl:apply-templates select="//t:facsimile//t:surface[@type='obverse']//t:graphic//t:desc"/>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
              </xsl:choose>
            </th>
            <th>
              <xsl:choose>
                <xsl:when test="//t:facsimile//t:surface[@type='reverse']//t:graphic//t:desc//text()">
                  <xsl:apply-templates select="//t:facsimile//t:surface[@type='reverse']//t:graphic//t:desc"/>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
              </xsl:choose>
            </th>
          </tr>
        </table>-->
      </div>

      <h4 class="iospe"><i><i18n:text i18n:key="edition">Edition</i18n:text></i></h4>
      <div class="section-container tabs" data-section="tabs">
        <section>
          <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="interpretive">Interpretive</i18n:text></a></p>
          <div class="content" id="edition" data-section-content="data-section-content">
            <!-- Edited text output -->
            <xsl:variable name="edtxt">
              <xsl:apply-templates select="//t:div[@type='edition'][@subtype='editorial']">
                <xsl:with-param name="parm-edition-type" select="'interpretive'" tunnel="yes"/>
              </xsl:apply-templates>
            </xsl:variable>
            <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
            <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
          </div>
        </section>
        <section>
          <p class="title" data-section-title="data-section-title"><a href="#"><i18n:text i18n:key="diplomatic">Diplomatic</i18n:text></a></p>
          <div class="content" id="diplomatic" data-section-content="data-section-content">
            <!-- Edited text output -->
            <xsl:variable name="edtxt">
              <xsl:apply-templates select="//t:div[@type='edition'][@subtype='diplomatic']">
                <xsl:with-param name="parm-edition-type" select="'diplomatic'" tunnel="yes"/>
              </xsl:apply-templates>
            </xsl:variable>
            <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
            <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
          </div>
        </section>
      </div>
      <div id="apparatus" class="iospe">
        <h4 class="iospe"><i18n:text i18n:key="apparatus">Apparatus</i18n:text></h4>
        <!-- Apparatus text output -->
        <xsl:variable name="apptxt">
          <xsl:apply-templates select="//t:div[@type='apparatus']/t:listApp"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
      </div>
      
      <div id="translation">
        <h4 class="iospe"><i><i18n:text i18n:key="legend-translation">Legend and Translation</i18n:text></i></h4>
        <!-- Translation text output -->
        <xsl:variable name="transtxt">
          <xsl:apply-templates select="//t:div[@type='translation']//t:p"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
      </div>
      
      <div id="bibliography"> <!--is a div here necessary?????-->
        <h4 class="iospe"><i18n:text i18n:key="references">References</i18n:text></h4>
      <dl class="iospe">  
        <dt width="150" align="left"><i18n:text i18n:key="editions"><i>Edition(s)</i></i18n:text></dt>
        <dd id="biblioEditions">
          <xsl:choose>
            <xsl:when test="//t:body//t:div[@type='bibliography'][@subtype='edition']/t:p/node()">
              <xsl:apply-templates select="//t:body//t:div[@type='bibliography'][@subtype='edition']/t:p/node()"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
        <!--<dt width="150" align="left"><i18n:text i18n:key="commentary-edition">Commentary on edition(s)</i18n:text></dt>
        <dd id="biblioCommEditions">
          <xsl:choose>
            <xsl:when test="//t:body//t:div[@type='bibliography'][@subtype='discussionCurrent']/t:p/node()">
              <xsl:apply-templates select="//t:body//t:div[@type='bibliography'][@subtype='discussionCurrent']/t:p/node()"/>
            </xsl:when>
            <xsl:otherwise><i><i18n:text i18n:key="none">None</i18n:text></i></xsl:otherwise>
          </xsl:choose>
        </dd>-->
        <dt width="150" align="left"><i18n:text i18n:key="parallels"><i>Parallel(s)</i></i18n:text></dt>
        <dd id="biblioParallels">
          <xsl:choose>
            <xsl:when test="//t:body//t:div[@type='bibliography'][@subtype='parallels']/t:p/node()">
              <xsl:apply-templates select="//t:body//t:div[@type='bibliography'][@subtype='parallels']/t:p/node()"/>
            </xsl:when>
            <xsl:otherwise><i><i18n:text i18n:key="no-parallels-known">No parallels known</i18n:text></i></xsl:otherwise>
          </xsl:choose>
        </dd>
        <dt width="150" align="left"><i18n:text i18n:key="further-references"><i>Further references</i></i18n:text></dt>
        <dd id="biblioCommParallels">
          <xsl:choose> <!--da cambiare i subtype-->
            <xsl:when test="//t:body//t:div[@type='bibliography'][@subtype='discussion']/t:p/node()">
              <xsl:apply-templates select="//t:body//t:div[@type='bibliography'][@subtype='discussion']/t:p/node()"/>
            </xsl:when>
            <xsl:otherwise>―</xsl:otherwise>
          </xsl:choose>
        </dd>
      </dl>
      </div>
      
      <div id="commentary">
        <h4 class="iospe"><i><i18n:text i18n:key="commentary">Commentary</i18n:text></i></h4>
        <!-- Commentary text output -->
        <xsl:variable name="commtxt">
          <xsl:apply-templates select="//t:div[@type='commentary'][@subtype='text']//t:p"/>
        </xsl:variable>
        <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
        <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
      </div>
      
      <!-- ************** FOOTNOTES ***************** -->
      <div class="fnseparator"/>
      <div id="footnotes">
        <h4 class="iospe" id="notes"><i18n:text i18n:key="footnotes">Footnotes</i18n:text></h4>
        <xsl:choose>
          <xsl:when test="//t:div[@type='commentary'][@subtype='footnotes']//t:p">
            <xsl:apply-templates select="//t:div[@type='commentary'][@subtype='footnotes']//t:p"/>
          </xsl:when>
          <xsl:otherwise>―</xsl:otherwise>
        </xsl:choose>
      </div>
      
    </div>
  </xsl:template>

  <xsl:template name="sigidoc-structure">
    <xsl:variable name="title">
      <xsl:call-template name="iospe-title" />
    </xsl:variable>
    <html>
      <head>
        <title>
          <xsl:value-of select="$title"/>
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
        <!-- Found in htm-tpl-cssandscripts.xsl -->
        <xsl:call-template name="css-script"/>
      </head>
      <body>
        <h1>
          <xsl:value-of select="$title"/>
        </h1>
        <xsl:call-template name="iospe-body-structure" />
      </body>
    </html>
  </xsl:template>

  <xsl:template name="sigidoc-title">
    <xsl:choose>
      <xsl:when test="//t:titleStmt/t:title/text() and matches(//t:idno[@type='filename'], '^\d\.\d{1,4}$')">
        <xsl:number value="substring-before(//t:idno[@type='filename'],'.')" format="I"/>
        <xsl:text>&#xa0;</xsl:text>
        <xsl:number value="substring-after(//t:idno[@type='filename'],'.')" format="1"/>
        <xsl:text>.&#xa0;</xsl:text>
        <xsl:if test="string(normalize-space(//t:origPlace[1]))"><xsl:value-of select="normalize-space(//t:origPlace[1])"/>
        <xsl:text>.&#xa0;</xsl:text></xsl:if>
        <xsl:value-of select="//t:titleStmt/t:title[child::text()][1]"/>
        <xsl:if test="not(//t:titleStmt/t:title[child::text()][1][child::t:origDate])">
          <xsl:text>,&#xa0;</xsl:text>
          <xsl:value-of select="//t:origDate[1]"/>
        </xsl:if>
      </xsl:when>
      <xsl:when test="//t:titleStmt/t:title/text()">
        <xsl:value-of select="//t:titleStmt/t:title"/>
      </xsl:when>
      <xsl:when test="//t:sourceDesc//t:bibl/text()">
        <xsl:value-of select="//t:sourceDesc//t:bibl"/>
      </xsl:when>
      <xsl:when test="//t:idno[@type='filename']/text()">
        <xsl:value-of select="//t:idno[@type='filename']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>EpiDoc example output, SigiDoc style</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:placeName"><!-- don't add @mode!!! -->
    <xsl:choose>
      <xsl:when test="contains(@ref,'pleiades.stoa.org') or contains(@ref,'geonames.org') or contains(@ref,'slsgazetteer.org')">
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="@ref"/>
          </xsl:attribute>
          <xsl:attribute name="target">_blank</xsl:attribute>
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="t:ref"><!-- for external (not <placeName/>) and internal links -->
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@target"/>
      </xsl:attribute>
      <xsl:attribute name="target">_blank</xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <xsl:template match="t:idno[@type='PBW']"><!-- pointing to the boulloterion ID page on the PBW -->
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="@corresp"/>
      </xsl:attribute>
      <xsl:attribute name="target">_blank</xsl:attribute>
      <xsl:apply-templates/>
    </a>
  </xsl:template>
  
  <xsl:template match="t:ptr[@target]">
    <xsl:variable name="bibl-ref" select="@target"/>
    <xsl:variable name="bibl" select="document(concat('file:',system-property('user.dir'),'/webapps/ROOT/content/xml/authority/bibliography.xml'))//t:bibl[@xml:id=$bibl-ref][not(@sameAs)]"/>
    <a>
      <xsl:attribute name="href">
        <xsl:text>../concordance/bibliography/</xsl:text>
        <xsl:value-of select="$bibl-ref"/>
        <xsl:text>.html</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="target">_blank</xsl:attribute>
      <xsl:choose>
        <xsl:when test="$bibl//t:bibl[@type='abbrev']">
          <xsl:apply-templates select="$bibl//t:bibl[@type='abbrev'][1]"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="$bibl"/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>
  
  <!-- arrows pointing to previous/next seal: from "Cretan Inscriptions" project -->
  <xsl:template name="navigation">
    <xsl:if test="doc-available(concat('file:',system-property('user.dir'),'/all_seals.xml')) = fn:true()">
      <xsl:variable name="filename"><xsl:value-of select="//t:idno[@type='sequence']"/></xsl:variable>
      <xsl:variable name="list" select="document(concat('file:',system-property('user.dir'),'/all_seals.xml'))//t:list"/>
      <xsl:variable name="prev" select="$list/t:item[@sortKey=$filename]/preceding-sibling::t:item[1]/@n"/>
      <xsl:variable name="next" select="$list/t:item[@sortKey=$filename]/following-sibling::t:item[1]/@n"/>
      
      <div class="row">
        <div class="large-12 columns">
          <ul class="pagination left">
            <xsl:if test="$prev">
              <li class="arrow">
                <a>
                  <xsl:attribute name="href">
                    <xsl:text>./</xsl:text>
                    <xsl:value-of select="$prev"/>
                    <xsl:text>.html</xsl:text>
                  </xsl:attribute>
                  <i18n:text i18n:key="arrow-left"><xsl:text>&#x021D0; previous</xsl:text></i18n:text>
                </a>
              </li>
            </xsl:if>
            
            <xsl:if test="$next">
              <li class="arrow">
                <a>
                  <xsl:attribute name="href">
                    <xsl:text>./</xsl:text>
                    <xsl:value-of select="$next"/>
                    <xsl:text>.html</xsl:text>
                  </xsl:attribute>
                  <i18n:text i18n:key="arrow-right"><xsl:text>next &#x021D2;</xsl:text></i18n:text>
                </a>
              </li>
            </xsl:if>
          </ul>
        </div>
      </div>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
