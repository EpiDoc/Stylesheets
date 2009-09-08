<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teig.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Templates imported by [htm|txt]-teig.xsl -->

  <xsl:template name="lb-dash">
    <xsl:if test="following::*[1][local-name() = 'lb'][@type='worddiv']">
      <xsl:text>- </xsl:text>
    </xsl:if>
  </xsl:template>

  <xsl:template name="w-space">
    <xsl:if test="ancestor::w">
      <xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="g">
    <xsl:value-of select="@type"/>
  </xsl:template>
  
  <!-- London specific template -->
  <xsl:template name="g-london">
    <xsl:choose>
      <xsl:when test="@type = 'chirho'">
        <xsl:text>&#x2ce9;</xsl:text>
      </xsl:when>
      <xsl:when test="@type = 'taurho'">
        <xsl:text>&#x2ce8;</xsl:text>
      </xsl:when>
    </xsl:choose>
    
  </xsl:template>

  <!-- ddb specific template -->
  <xsl:template name="g-ddbdp">
    <xsl:choose>
      <xsl:when test="@type='apostrophe'">
        <xsl:text>&#x2019;</xsl:text>
      </xsl:when>
      <xsl:when test="@type='check' or @type='check-mark'">
        <xsl:text>&#xFF0F;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='chirho'">
        <xsl:text>&#x2627;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='dipunct'">
        <xsl:text>&#x2236;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='filled-circle'">
        <xsl:text>&#x29BF;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='filler' and @rend='extension'">
        <xsl:text>&#x2015;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='latin interpunct' or @type='middot' or @type='mid punctus'">
        <xsl:text>&#x00B7;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='monogram'">
        <span class="italic"><xsl:text>monogr.</xsl:text></span>    
      </xsl:when>
      <xsl:when test="@type='upper-brace-opening'">
        <xsl:text>&#x23A7;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='center-brace-opening'">
        <xsl:text>&#x23A8;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='lower-brace-opening'">
        <xsl:text>&#x23A9;</xsl:text> 
      </xsl:when>
      <xsl:when test="@type='upper-brace-closing'">
        <xsl:text>&#x23AB;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='center-brace-closing'">
        <xsl:text>&#x23AC;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='lower-brace-closing'">
        <xsl:text>&#x23AD;</xsl:text> 
      </xsl:when>
      <xsl:when test="@type='parens-upper-opening'">
        <xsl:text>&#x239B;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='parens-middle-opening'">
        <xsl:text>&#x239C;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='parens-lower-opening'">
        <xsl:text>&#x239D;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='parens-upper-closing'">
        <xsl:text>&#x239E;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='parens-middle-closing'">
        <xsl:text>&#x239F;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='parens-lower-closing'">
        <xsl:text>&#x23A0;</xsl:text>       
      </xsl:when>
      <xsl:when test="@type='slanting-stroke'">
        <xsl:text>/</xsl:text>
      </xsl:when>
      <xsl:when test="@type='stauros'">
        <xsl:text>&#x2020;</xsl:text>
      </xsl:when>
      <xsl:when test="@type='tachygraphic marks'">
        <span class="italic"><xsl:text>tachygr. marks</xsl:text></span>    
      </xsl:when>
      <xsl:when test="@type='tripunct'">
        <xsl:text>&#x22ee;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='double-vertical-bar'">
        <xsl:text>&#x2016;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='long-vertical-bar'">
        <xsl:text>&#x007C;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='x'">
        <xsl:text>&#x2613;</xsl:text>        
      </xsl:when>
      <xsl:when test="@type='xs'">
        <xsl:text>&#x2613;&#x2613;&#x2613;&#x2613;&#x2613;</xsl:text>        
      </xsl:when>
      <!-- Interim error reporting -->
      <xsl:otherwise>
        <text> ((</text>
        <xsl:value-of select="@type"/>
        <text>)) </text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
