<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0" version="1.0">
   <!-- Called from start-edition.xsl -->

   <xsl:template name="css-script">

      <link rel="stylesheet" type="text/css" media="screen, projection">
         <xsl:attribute name="href">
            <xsl:choose>
               <xsl:when test="$leiden-style = 'ddbdp'">
                  <xsl:text>http://papyri.info/global.css</xsl:text>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:text>../xsl/global.css</xsl:text>
               </xsl:otherwise>
            </xsl:choose>
         </xsl:attribute>
      </link>

      <xsl:if test="$leiden-style = 'ddbdp' and //t:div[@type = 'translation']">
         <script type="text/javascript" src="http://papyri.info/js/overlib_mini.js">
             </script>
      </xsl:if>
   </xsl:template>
</xsl:stylesheet>
