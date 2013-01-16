<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-tpl-struct-iospe.xsl 1434 2011-05-31 18:23:56Z gabrielbodard $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" version="2.0">
   <!-- Contains named templates for IOSPE file structure (aka "metadata" aka "supporting data") -->

   <!-- Called from htm-tpl-structure.xsl -->

   <xsl:template name="iospe-structure">
      <html>
         <head>
            <title>
               <xsl:variable name="title">
                  <xsl:choose>
                     <xsl:when test="//t:titleStmt/t:title/text()">
                        <xsl:if test="//t:idno[@type='filename']/text()">
                           <xsl:value-of
                              select="number(substring-after(//t:idno[@type='filename'],'Byz'))"/>
                           <xsl:text>. </xsl:text>
                        </xsl:if>
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
                  <xsl:if test="//t:support//t:objectType//text()"><tr>
                     <th width="150" align="left">Type of monument:</th>
                     <td>
                        <xsl:value-of select="//t:support//t:objectType"/>
                     </td>
                  </tr></xsl:if>
                  <tr>
                     <th width="150" align="left">Material:</th>
                     <td>
                        <xsl:value-of select="//t:support//t:material"/>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Description and condition</th>
                     <td>
                        <xsl:value-of select="//t:support//t:p"/>
                     </td>
                  </tr>
               </table>
               <table border="0">
                  <tr>
                     <th width="150" align="left">Find place:</th>
                     <td>
                        <xsl:value-of select="//t:provenance[@type='found']//t:placeName[@type='ancientFindspot']"/>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Find circumstances:</th>
                     <td>
                        <xsl:value-of select="//t:provenance[@type='found']//t:rs[@type='circumstances']"/>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Find context:</th>
                     <td>
                        <xsl:value-of select="//t:provenance[@type='found']//t:rs[@type='context']"/>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Modern location:</th>
                     <td>
                        <xsl:value-of select="//t:provenance[@type='observed']"/>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Dimensions:</th>
                     <td>
                        <xsl:if test="//t:support/t:dimensions/t:height/text()">H. <xsl:value-of select="//t:support/t:dimensions/t:height"/>,</xsl:if>
                        <xsl:if test="//t:support/t:dimensions/t:width/text()">W. <xsl:value-of select="//t:support/t:dimensions/t:width"/>,</xsl:if>
                        <xsl:if test="//t:support/t:dimensions/t:depth/text()">Th. <xsl:value-of select="//t:support/t:dimensions/t:depth"/></xsl:if>
                        <xsl:if test="//t:support/t:dimensions/t:dim[@type='diameter']/text()">, Diam. <xsl:value-of select="//t:support/t:dimensions/t:dim[@type='diameter']"/></xsl:if>
                     </td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Institution and inventory:</th>
                     <td>
                        <xsl:value-of select="//t:msIdentifier//t:repository"/>
                        <xsl:value-of select="//t:msIdentifier//t:idno"/>
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
                     <td><xsl:value-of select="//t:layout"/></td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Style of lettering:</th>
                     <td><xsl:value-of select="//t:handNote//text()[not(ancestor::t:height)]"/></td>
                  </tr>
                  <tr>
                     <th width="150" align="left">Letterheights:</th>
                     <td><xsl:value-of select="//t:handNote//t:height"/></td>
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
                        <xsl:for-each select="tokenize(//t:origin/t:origDate[@evidence],' ')">
                           <xsl:value-of select="translate(.,'-',' ')"/>
                        </xsl:for-each>
                     </td>
                  </tr>
                  <tr>
                     <th align="left" width="150">Editions:</th>
                     <td><xsl:value-of select="//t:body//div[@type='bibliography']"/></td>
                  </tr>
               </table>
               <div id="edition">
                  <xsl:apply-templates select="//div[@type='edition']"/>
               </div>
            </div>
         </body>
      </html>
   </xsl:template>

</xsl:stylesheet>
