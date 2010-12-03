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
            <a>
               <xsl:call-template name="mouseover">
                  <xsl:with-param name="wit-val" select="$wit-val"/>
                  <xsl:with-param name="gloss">
                     <xsl:if test=".//t:term[@target]">
                        <xsl:text>on</xsl:text>
                     </xsl:if>
                  </xsl:with-param>
               </xsl:call-template>
               <xsl:apply-templates/>
            </a>
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


  <xsl:template name="mouseover">
      <xsl:param name="wit-val"/>
      <xsl:param name="gloss"/>
      <xsl:variable name="lang" select="ancestor::t:div[@type = 'translation']/@xml:lang"/>
    
      <xsl:attribute name="class">
         <xsl:text>hgv-corr</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="href">
         <xsl:text>javascript:void(0);</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="onmouseover">
         <xsl:text>return overlib('</xsl:text>
         <xsl:if test="$gloss = 'on'">
            <xsl:for-each select=".//t:term[@target]">
               <xsl:value-of select="document($hgv-gloss)//t:item[@xml:id = current()/@target]/t:term"/>
               <xsl:text>. </xsl:text>
               <xsl:value-of select="document($hgv-gloss)//t:item[@xml:id = current()/@target]/t:gloss[@xml:lang = $lang]"/>
               <xsl:text>; </xsl:text>
            </xsl:for-each>
         </xsl:if>
         <xsl:value-of select="$wit-val"/>
         <xsl:text>',STICKY,CAPTION,'</xsl:text>
         <xsl:choose>
            <xsl:when test="$lang = 'en'">
               <xsl:if test="$gloss = 'on'">
                  <xsl:text>Glossary/</xsl:text>
               </xsl:if>
               <xsl:text>Correction:</xsl:text>
            </xsl:when>
            <xsl:when test="$lang = 'de'">
               <xsl:if test="$gloss = 'on'">
                  <xsl:text>Glossar/</xsl:text>
               </xsl:if>
               <xsl:text>Korrektur:</xsl:text>
            </xsl:when>
         </xsl:choose>
         <xsl:text>',MOUSEOFF,NOCLOSE);</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="onmouseout">
         <xsl:text>return nd();</xsl:text>
      </xsl:attribute>
  </xsl:template>

</xsl:stylesheet>