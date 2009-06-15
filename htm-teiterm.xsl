<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: htm-teiterm.xsl 1567 2008-08-21 16:38:31Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:tei="http://www.tei-c.org/ns/1.0" version="1.0">
  
  <xsl:template match="term">
    <xsl:choose>
      <!-- Adds caption for hgv translations -->
      <xsl:when test="$leiden-style = 'ddbdp' and ancestor::div[@type = 'translation'] and @target">
        <xsl:variable name="lang" select="ancestor::div[@type = 'translation']/@lang" />
        <xsl:variable name="term" select="@target" />
        
        <xsl:choose>
          <xsl:when test="ancestor::lem">
            <xsl:apply-templates />
          </xsl:when>
          <xsl:otherwise>
            <a class="hgv-term" href="javascript:void(0);" onmouseout="return nd();">
              <xsl:attribute name="onmouseover">
                <xsl:text>return overlib('</xsl:text>
                <xsl:value-of select="document($hgv-gloss)//tei:item[@xml:id = $term]/tei:term"/>
                <xsl:text>. </xsl:text>
                <xsl:value-of select="document($hgv-gloss)//tei:item[@xml:id = $term]/tei:gloss[@xml:lang = $lang]"/>
                <xsl:text>',STICKY,CAPTION,'</xsl:text>
                <xsl:choose>
                  <xsl:when test="$lang = 'en'">
                    <xsl:text>Glossary:</xsl:text>
                  </xsl:when>
                  <xsl:when test="$lang = 'de'">
                    <xsl:text>Glossar:</xsl:text>
                  </xsl:when>
                </xsl:choose>            
                <xsl:text>',MOUSEOFF,NOCLOSE);</xsl:text>
              </xsl:attribute>
              
              <xsl:apply-templates />
            </a>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      
      
      <xsl:otherwise>
        <xsl:apply-templates />
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
</xsl:stylesheet>
