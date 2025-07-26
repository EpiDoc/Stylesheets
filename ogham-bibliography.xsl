<xsl:stylesheet xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:html="http://www.w3.org/1999/html" xmlns:map="http://www.w3.org/2005/xpath-functions/map" xmlns:f="http://example.com/ns/functions" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema-instance" exclude-result-prefixes="t f" version="3.1">


        <xsl:template match="/">
           
            <!-- Start repeating -->
            <xsl:call-template name="repeatable"/>
        </xsl:template>
        
        <xsl:template name="repeatable">
            <xsl:param name="index" select="1"/>
            <xsl:param name="total" select="3"/>
            
            <!-- Do something -->
            <xsl:variable name="json-doc" select="json-to-xml(unparsed-text('https://api.zotero.org/groups/4625439/tags?limit=100'))"/>
            <xsl:if test="not($index = $total)">
               
                <xsl:for-each select="$json-doc/*/map/string[@key='tag']" xpath-default-namespace="http://www.w3.org/2005/xpath-functions">
                    <xsl:variable name="tag" select="./string()"/>
                    <xsl:if test="starts-with($tag, 'og:')">
                    <xsl:copy-of select="document(concat('https://api.zotero.org/groups/4625439/items?tag=', $tag, '&amp;format=bib'))/*/*"/>
                    <xsl:text> </xsl:text>(<xsl:value-of select="$tag"/>)
                    </xsl:if>
                </xsl:for-each>               

                <xsl:call-template name="repeatable">

                    <xsl:with-param name="index" select="$index + 1"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:template>
        
 

</xsl:stylesheet>