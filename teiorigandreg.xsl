<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t" version="2.0">
   <!-- Contains templates for choice/orig and choice/reg and surplus -->

   <xsl:template match="t:choice/t:orig">
      <xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <!-- old ddb-style (pre-October release)
            <xsl:choose>
               <xsl:when test="not(../t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)])">
                  <xsl:apply-templates/>
               </xsl:when>
               <xsl:otherwise/>
            </xsl:choose>-->
         <!-- commented out until later DDbDP switch-over -->
             <xsl:apply-templates/>
            <xsl:call-template name="cert-low"/>
            <!-- if context is inside the app-part of an app-like element... -->
            <xsl:if test="ancestor::t:*[local-name()=('orig','reg','sic','corr','lem','rdg') 
               or self::t:del[@rend='corrected'] 
               or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')]">
               <xsl:text> (i.e. </xsl:text>
               <xsl:apply-templates select="../t:reg/node()"/>
               <xsl:text>)</xsl:text>
            </xsl:if>
         </xsl:when>
         <xsl:otherwise>
            <xsl:apply-templates/>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template match="t:choice/t:reg"/>
      <!--<xsl:choose>
         <xsl:when test="$leiden-style = 'ddbdp'">
            <xsl:choose>
               <xsl:when test="@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang"/>
               <xsl:when test="preceding-sibling::t:reg[not(@xml:lang != ancestor::t:*[@xml:lang][1]/@xml:lang)]"/>
               <!-\- if element is within the app part of a parent app -\->
                  <xsl:when test="parent::t:orig or ancestor::t:*[local-name()=('orig','reg','sic','corr','add','del','lem','rdg') 
                     or self::t:del[@rend='corrected'] 
                     or self::t:add[@place='inline']][1][local-name()=('reg','corr','del','rdg')]">
                     <xsl:text> (i.e. </xsl:text>
                     <xsl:apply-templates/><xsl:call-template name="cert-low"/>
                     <xsl:text>)</xsl:text>
                  </xsl:when>
               
               <xsl:otherwise/>
                  <!-\- to be removed when later DDbDP switch-over -\->
                  <!-\-<xsl:apply-templates/>
                  -\->
            </xsl:choose>
         </xsl:when>
         <xsl:otherwise/>
      </xsl:choose>
   </xsl:template>-->

</xsl:stylesheet>
