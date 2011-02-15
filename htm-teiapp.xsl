<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teiapp.xsl 1567 2008-08-21 16:38:31Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="t" 
                version="1.0">
  <!-- Contains app and its children rdg, ptr, note and lem -->

  <xsl:template match="t:app">
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
    <xsl:if test="$apparatus-style = 'ddbdp'">
         <xsl:call-template name="app-link">
            <xsl:with-param name="location" select="'text'"/>
         </xsl:call-template>
      </xsl:if>
  </xsl:template>


  <xsl:template match="t:rdg">
      <xsl:choose>
         <xsl:when test="$edition-type = 'diplomatic'">
            <xsl:choose>
               <xsl:when test="@resp='previous'"/> 
               <xsl:when test="@resp='autopsy'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="@resp='previous'">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:when test="@resp='autopsy'"/>
               <xsl:when test="parent::t:app"/>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
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
      <xsl:choose>
         <xsl:when test="($leiden-style = 'ddbdp' or $leiden-style = 'sammelbuch') and ancestor::t:div[@type = 'translation']">
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
                  <xsl:value-of select="document($hgv-gloss)//t:item[@xml:id = current()/@target]/t:term"/>
                  <xsl:text>. </xsl:text>
                  <xsl:value-of select="document($hgv-gloss)//t:item[@xml:id = current()/@target]/t:gloss[@xml:lang = $lang]"/>
                  <xsl:text>; </xsl:text>
                </xsl:for-each>
                <xsl:value-of select="$wit-val"/>
              </span>                 
            </span>
         </xsl:when>
         <xsl:otherwise>
            <xsl:choose>
               <xsl:when test="parent::t:app[@type='previouslyread']">
                  <span class="previouslyread">
                     <xsl:apply-templates/>
                  </span>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates/>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>