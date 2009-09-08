<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <!-- Called from start-edition.xsl -->
  
  <xsl:template name="css-script">
    
    <link rel="stylesheet" type="text/css" media="screen, projection"
      href="http://papyri.info/global.css"/>
    
    <xsl:if test="$leiden-style = 'ddbdp' and //div[@type = 'translation']">
      <script type="text/javascript" src="http://papyri.info/js/overlib_mini.js">&#160;</script>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
