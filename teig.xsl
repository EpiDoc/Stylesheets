<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: teig.xsl 1447 2008-08-07 12:57:55Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0"
                version="1.0">
  <!-- Templates imported by [htm|txt]-teig.xsl -->

  <xsl:template name="lb-dash">
      <xsl:if test="following::t:*[1][local-name() = 'lb'][@type='inWord']">
         <xsl:text>- </xsl:text>
      </xsl:if>
  </xsl:template>

  <xsl:template name="w-space">
      <xsl:if test="ancestor::w">
         <xsl:text> </xsl:text>
      </xsl:if>
  </xsl:template>
  
  <xsl:template match="t:g">
      <xsl:value-of select="@type"/>
  </xsl:template>
  
  <!-- London specific template -->
  <xsl:template name="g-london">
      <xsl:choose>
         <xsl:when test="@type = 'chirho'">
            <xsl:text>⳩</xsl:text>
         </xsl:when>
         <xsl:when test="@type = 'taurho'">
            <xsl:text>⳨</xsl:text>
         </xsl:when>
      </xsl:choose>
    
  </xsl:template>

  <!-- ddb specific template -->
  <xsl:template name="g-ddbdp">
      <xsl:choose>
         <xsl:when test="@type='apostrophe'">
            <xsl:text>’</xsl:text>
         </xsl:when>
         <xsl:when test="@type='check' or @type='check-mark'">
            <xsl:text>／</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='chirho'">
            <xsl:text>☧</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='dipunct'">
            <xsl:text>∶</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='filled-circle'">
            <xsl:text>⦿</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='filler' and @rend='extension'">
            <xsl:text>―</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='latin interpunct' or @type='middot' or @type='mid punctus'">
            <xsl:text>·</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='monogram'">
            <span class="italic">
               <xsl:text>monogr.</xsl:text>
            </span>    
         </xsl:when>
         <xsl:when test="@type='upper-brace-opening'">
            <xsl:text>⎧</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='center-brace-opening'">
            <xsl:text>⎨</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='lower-brace-opening'">
            <xsl:text>⎩</xsl:text> 
         </xsl:when>
         <xsl:when test="@type='upper-brace-closing'">
            <xsl:text>⎫</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='center-brace-closing'">
            <xsl:text>⎬</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='lower-brace-closing'">
            <xsl:text>⎭</xsl:text> 
         </xsl:when>
         <xsl:when test="@type='parens-upper-opening'">
            <xsl:text>⎛</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='parens-middle-opening'">
            <xsl:text>⎜</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='parens-lower-opening'">
            <xsl:text>⎝</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='parens-upper-closing'">
            <xsl:text>⎞</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='parens-middle-closing'">
            <xsl:text>⎟</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='parens-lower-closing'">
            <xsl:text>⎠</xsl:text>       
         </xsl:when>
         <xsl:when test="@type='slanting-stroke'">
            <xsl:text>/</xsl:text>
         </xsl:when>
         <xsl:when test="@type='stauros'">
            <xsl:text>†</xsl:text>
         </xsl:when>
         <xsl:when test="@type='tachygraphic marks'">
            <span class="italic">
               <xsl:text>tachygr. marks</xsl:text>
            </span>    
         </xsl:when>
         <xsl:when test="@type='tripunct'">
            <xsl:text>⋮</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='double-vertical-bar'">
            <xsl:text>‖</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='long-vertical-bar'">
            <xsl:text>|</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='x'">
            <xsl:text>☓</xsl:text>        
         </xsl:when>
         <xsl:when test="@type='xs'">
            <xsl:text>☓☓☓☓☓</xsl:text>        
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