<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t"
                version="2.0">
  <!-- Contains app and its children rdg, ptr, note and lem -->

  <xsl:template match="t:app">
      <xsl:param name="parm-apparatus-style" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
         <xsl:when test="@resp='previous'">
            <span class="previouslyread">
               <xsl:apply-templates/>
            </span>
         </xsl:when>
         <xsl:when test="@resp='autopsy'"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>

      <!-- Found in htm-tpl-apparatus - creates links to footnote in apparatus -->
      <xsl:if test="$parm-apparatus-style = 'ddbdp'">
         <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>


  <xsl:template match="t:rdg">
      <xsl:param name="parm-edition-type" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="$parm-edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@resp='previous'"/>
               <xsl:when test="@resp='autopsy'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="@resp='previous'">
            <xsl:apply-templates/>
         </xsl:when>
         <xsl:when test="@resp='autopsy'"/>
         <xsl:when test="parent::t:app"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template match="t:wit">
      <xsl:choose>
      <!-- Temporary -->
         <xsl:when test="parent::t:app"/>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

  <xsl:template match="t:lem">
      <xsl:param name="parm-leiden-style" tunnel="yes" required="no"></xsl:param>
      <xsl:param name="parm-hgv-gloss" tunnel="yes" required="no"></xsl:param>
      <xsl:choose>
          <xsl:when test="$parm-leiden-style=('ddbdp','sammelbuch') and ancestor::t:div[@type='translation']">
            <xsl:variable name="wit-val" select="@resp"/>
            <xsl:variable name="lang" select="ancestor::t:div[@type = 'translation']/@xml:lang"/>
            <span class="term">
              <xsl:apply-templates/>
              <span class="gloss" style="display:none">
              <b><xsl:choose>
                  <xsl:when test="$lang = 'en'">
                    <xsl:if test=".//t:term[@target]">
                      <xsl:text>Glossary/</xsl:text>
                    </xsl:if>
                    <xsl:text>Correction:</xsl:text>
                  </xsl:when>
                  <xsl:when test="$lang = 'de'">
                    <xsl:if test=".//t:term[@target]">
                      <xsl:text>Glossar/</xsl:text>
                    </xsl:if>
                    <xsl:text>Korrektur:</xsl:text>
                  </xsl:when>
                </xsl:choose></b>
                <xsl:for-each select=".//t:term[@target]">
                    <xsl:value-of select="document($parm-hgv-gloss)//t:item[@xml:id = current()/@target]/t:term"/>
                  <xsl:text>. </xsl:text>
                    <xsl:value-of select="document($parm-hgv-gloss)//t:item[@xml:id = current()/@target]/t:gloss[@xml:lang = $lang]"/>
                  <xsl:text>; </xsl:text>
                </xsl:for-each>
                <xsl:value-of select="$wit-val"/>
              </span>
            </span>
         </xsl:when>
          <xsl:when test="$parm-leiden-style=('ddbdp','sammelbuch') and ancestor::t:*[local-name()=('reg','corr','rdg')
            or self::t:del[@rend='corrected']]">
            <xsl:apply-templates/>
            <xsl:if test="@resp">
               <xsl:choose>
                   <xsl:when test="$parm-leiden-style='ddbdp'"><xsl:text> FNORD-SPLIT </xsl:text></xsl:when>
                  <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
               </xsl:choose>
               <xsl:if test="parent::t:app[@type='BL']">
                  <xsl:text>BL </xsl:text>
               </xsl:if>

               <xsl:value-of select="@resp"/>

               <xsl:if test="parent::t:app[@type='SoSOL']">
                  <xsl:text> (via PE)</xsl:text>
               </xsl:if>
               <xsl:choose>
                   <xsl:when test="$parm-leiden-style='ddbdp'"><xsl:text> FNORD-DELIM </xsl:text></xsl:when>
                  <xsl:otherwise><xsl:text> </xsl:text></xsl:otherwise>
               </xsl:choose>
            </xsl:if>
            <xsl:choose>
               <xsl:when test="parent::t:app[@type='editorial']">
                  <xsl:text> (</xsl:text><xsl:for-each select="following-sibling::t:rdg">
                     <!-- found in tpl-apparatus.xsl -->
                     <xsl:call-template name="app-ed-mult"/>
                  </xsl:for-each><xsl:text>)</xsl:text>
               </xsl:when>
               <xsl:when test="parent::t:app[@type='alternative']">
                  <xsl:text> (or </xsl:text>
                  <xsl:for-each select="following-sibling::t:rdg">
                     <xsl:apply-templates/>
                     <xsl:if test="position()!=last()">
                        <xsl:text> or </xsl:text>
                     </xsl:if>
                  </xsl:for-each>
                  <xsl:text>)</xsl:text>
               </xsl:when>
            </xsl:choose>
         </xsl:when>
         <xsl:when test="parent::t:app[@type='previouslyread']">
            <span class="previouslyread">
               <xsl:apply-templates/>
            </span>
         </xsl:when>
          <xsl:when test="$parm-leiden-style='iospe' and ../t:rdg">
            <xsl:apply-templates/>
            <xsl:for-each select="../t:rdg">
               <xsl:text> resp. </xsl:text>
               <xsl:apply-templates/>
            </xsl:for-each>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>