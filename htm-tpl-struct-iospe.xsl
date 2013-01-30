<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-iospe.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
   <!-- Contains named templates for IOSPE file structure (aka "metadata" aka "supporting data") -->

   <!-- Called from htm-tpl-structure.xsl -->

<xsl:template name="iospe-structure">
      <xsl:variable name="title">
         <xsl:choose>
            <xsl:when test="//t:titleStmt/t:title/text()">
               <xsl:choose>
                  <xsl:when test="//t:idno[@type='filename'][starts-with(.,'byz')]">
                     <xsl:value-of
                        select="substring-after(//t:idno[@type='filename'],'byz')"/>
                     <xsl:text>. </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="//t:idno[@type='filename']"/>
                  </xsl:otherwise>
               </xsl:choose>
               <xsl:value-of select="//t:titleStmt/t:title"/>
            </xsl:when>
            <xsl:when test="//t:sourceDesc//t:bibl/text()">
               <xsl:value-of select="//t:sourceDesc//t:bibl"/>
            </xsl:when>
            <xsl:when test="//t:idno[@type='filename']/text()">
               <xsl:value-of select="//t:idno[@type='filename']"/>
            </xsl:when>
            <xsl:otherwise>
               <xsl:text>EpiDoc example output, IOSPE style</xsl:text>
            </xsl:otherwise>
         </xsl:choose>
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
            <div id="stone">
               <h3>Stone</h3>
               <table border="0">
                     <tr>
                     <th width="150" align="left">Type of monument:</th>
                        <td>
                           <xsl:choose>
                              <xsl:when test="//t:support//t:objectType//text()">
                                 <xsl:value-of select="//t:support//t:objectType"/>
                              </xsl:when>
                              <xsl:otherwise>Not specified</xsl:otherwise>
                           </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Material:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:support//t:material//text()">
                              <xsl:value-of select="//t:support//t:material"/>
                           </xsl:when>
                           <xsl:otherwise>Not specified</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Description and condition</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:support//t:p//text()">
                              <xsl:value-of select="//t:support//t:p"/>
                           </xsl:when>
                           <xsl:otherwise>Not specified</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
               </table>
               <table border="0">
                  <tr>
                     <th width="150" align="left">Find place:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']//text()">
                              <xsl:value-of select="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']"/>
                           </xsl:when>
                           <xsl:otherwise>Unknown</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Find circumstances:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:provenance[@type='found']//t:rs[@type='circumstances']//text()">
                              <xsl:value-of select="//t:provenance[@type='found']//t:rs[@type='circumstances']"/>
                           </xsl:when>
                           <xsl:otherwise>Unknown</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Find context:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:provenance[@type='found']//t:rs[@type='context']//text()">
                              <xsl:value-of select="//t:provenance[@type='found']//t:rs[@type='context']"/>
                           </xsl:when>
                           <xsl:otherwise>Unknown</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Modern location:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:provenance[@type='observed']//text()">
                              <xsl:value-of select="//t:provenance[@type='observed']"/>
                           </xsl:when>
                           <xsl:otherwise>Unknown</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Dimensions:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:support/t:dimensions//text()[not(normalize-space(.)=' ')]">
                              <xsl:if test="//t:support/t:dimensions/t:height/text()[not(normalize-space(.)=' ')]">H. <xsl:value-of select="//t:support/t:dimensions/t:height"/>,</xsl:if>
                              <xsl:if test="//t:support/t:dimensions/t:width/text()[not(normalize-space(.)=' ')]">W. <xsl:value-of select="//t:support/t:dimensions/t:width"/>,</xsl:if>
                              <xsl:if test="//t:support/t:dimensions/t:depth/text()[not(normalize-space(.)=' ')]">Th. <xsl:value-of select="//t:support/t:dimensions/t:depth"/></xsl:if>
                              <xsl:if test="//t:support/t:dimensions/t:dim[@type='diameter']/text()[not(normalize-space(.)=' ')]">, Diam. <xsl:value-of select="//t:support/t:dimensions/t:dim[@type='diameter']"/></xsl:if>
                           </xsl:when>
                           <xsl:otherwise>Unknown</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Institution and inventory:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:msIdentifier//t:repository/text() and //t:msIdentifier//t:idno/text()">
                              <xsl:value-of select="//t:msIdentifier//t:repository"/>
                              <xsl:value-of select="//t:msIdentifier//t:idno"/>
                           </xsl:when>
                           <xsl:when test="//t:msIdentifier//t:repository/text()">
                              <xsl:value-of select="//t:msIdentifier//t:repository"/>
                              <xsl:text>no inv. no.</xsl:text>
                           </xsl:when>
                           <xsl:otherwise>Unknown</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
               </table>
            </div>
            <div id="text-field">
               <h3>Text field</h3>
               <table border="0">
                  <xsl:if test="//t:layout/@ana"><tr>
                     <th width="150" align="left">Faces code:</th>
                     <td><xsl:value-of select="//t:layout/@ana"/></td>
                  </tr></xsl:if>
                  <tr>
                     <th width="150" align="left">Placement of text:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:layout/text()">
                              <xsl:value-of select="//t:layout"/>
                           </xsl:when>
                           <xsl:otherwise>Not specified</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Style of lettering:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:handNote//text()[not(ancestor::t:height)]">
                              <xsl:value-of select="/t:handNote//text()[not(ancestor::t:height)]"/>
                           </xsl:when>
                           <xsl:otherwise>Not specified</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Letterheights:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:handNote//t:height/text()">
                              <xsl:value-of select="//t:handNote//t:height"/>
                           </xsl:when>
                           <xsl:otherwise>Not specified</xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
               </table>
            </div>
            <div id="text">
               <h3>Text</h3>
               <table border="0">
                  <tr>
                     <th align="left" width="150">Origin of text:</th>
                     <td><xsl:value-of select="//t:origin/t:origPlace"/></td>
                  </tr>
                  <tr>
                     <th align="left" width="150">Document type:</th>
                     <td><xsl:value-of select="//t:msContents/t:summary"/></td>
                  </tr>
                  <tr>
                     <th align="left" width="150">Date:</th>
                     <td><xsl:value-of select="//t:origin/t:origDate"/></td>
                  </tr>
                  <tr>
                     <th align="left" width="150">Dating criteria:</th>
                     <td>
                        <xsl:choose>
                           <xsl:when test="//t:origin/t:origDate/@evidence">
                              <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence],' ')">
                                 <xsl:value-of select="translate(.,'-',' ')"/>
                                 <xsl:if test="position()!=last()">
                                    <xsl:text>, </xsl:text>
                                 </xsl:if>
                              </xsl:for-each>
                           </xsl:when>
                           <xsl:otherwise>
                              <xsl:text>n/a</xsl:text>
                           </xsl:otherwise>
                        </xsl:choose>
                     </td>
                  </tr>
                  <tr>
                     <th align="left" width="150">Editions:</th>
                     <td><xsl:value-of select="//t:body//t:div[@type='bibliography']"/></td>
                  </tr>
               </table>
               <div id="edition">
                  <!-- Edited text output -->
                  <xsl:variable name="edtxt">
                     <xsl:apply-templates select="//t:div[@type='edition']"/>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$edtxt" mode="sqbrackets"/>
               </div>
               <div id="apparatus">
                  <h4>Apparatus</h4>
                  <!-- Apparatus text output -->
                  <xsl:variable name="apptxt">
                     <xsl:apply-templates select="//t:div[@type='apparatus']"/>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$apptxt" mode="sqbrackets"/>
               </div>
               <div id="translation">
                  <h4>Translation</h4>
                  <!-- Translation text output -->
                  <xsl:variable name="transtxt">
                     <xsl:apply-templates select="//t:div[@type='translation']"/>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$transtxt" mode="sqbrackets"/>
               </div>
               <div id="commentary">
                  <h4>Commentary</h4>
                  <!-- Commentary text output -->
                  <xsl:variable name="commtxt">
                     <xsl:apply-templates select="//t:div[@type='commentary']"/>
                  </xsl:variable>
                  <!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                  <xsl:apply-templates select="$commtxt" mode="sqbrackets"/>
               </div>
            </div>
         </body>
      </html>
   </xsl:template>

</xsl:stylesheet>
