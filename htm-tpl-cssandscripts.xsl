<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" 
   xmlns="http://www.w3.org/1999/xhtml"
   exclude-result-prefixes="t"
   version="2.0">
   <!-- Called from start-edition.xsl -->

   <xsl:template name="css-script">

      <link rel="stylesheet" type="text/css" media="screen, projection">
         <xsl:attribute name="href">
            <xsl:value-of select="$css-loc"/>
         </xsl:attribute>
      </link>
   </xsl:template>
</xsl:stylesheet>
