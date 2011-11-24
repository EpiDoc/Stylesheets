<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:html="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xd:doc xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 2, 2011</xd:p>
            <xd:p><xd:b>Author:</xd:b> gbodard</xd:p>
            <xd:p><xd:b>Author:</xd:b> flawrence</xd:p>
            <xd:p><xd:b>Author:</xd:b> rviglianti</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:output method="xml" media-type="text/html" encoding="UTF-8" />
        
    <xsl:template name="sqbrackets">
        <xsl:param name="html-elm"/>
        <xsl:for-each select="$html-elm">
            <xsl:element name="{name()}" namespace="http://www.w3.org/1999/xhtml">
                <xsl:copy-of select="@*"/>
                <xsl:for-each select="node()">
                    <xsl:choose>
                        <xsl:when test="self::text()">
                            <xsl:variable name="me" select="."/>
                            <xsl:variable name="startspace" select="if (matches(substring(.,1,1),'[\n\r\s\t]')) then ' ' else ''"/>
                            <xsl:variable name="endspace" select="if (matches(substring(.,string-length(.)),'[\n\r\s\t]')) then ' ' else ''"/>
                            <xsl:variable name="current" select="replace(normalize-space(.), '([^\]])\](\s*)\[([^\[])', '$1$2$3')" />
                            <xsl:variable name="strlength" select="string-length($current)"/>
                            <xsl:variable name="firstletter" select="substring($current, 1, 1)"/>
                            <xsl:variable name="lastletter" select="substring($current, $strlength)"/>
                            
                            <!--<xsl:text>[start]</xsl:text><xsl:value-of select="$startspace"/><xsl:text>[/start]</xsl:text>-->
                            <xsl:value-of select="$startspace"/>
                            
                            <!-- <xsl:value-of select="$firstletter"/>
                            <xsl:value-of select="$lastletter"/> -->
                                <xsl:choose>
                                    <xsl:when test="$firstletter = '[' or $lastletter = ']'">
                                        
                                        <xsl:variable name="previous" select="preceding::text()[1]" />
                                        <xsl:variable name="after" select="following::text()[1]" />
                                        
                                        <!-- get the first text node before the next br (if this node matches current text node then there is a br between this text node and the next text node so don't strip brackets) -->
                                        <xsl:variable name="beforenextbr" select="following::html:br[1]/preceding::text()[1]"/>
                                        
                                        <!-- get the first next node following the preceding br (if this node matches current text node then there is a br between this text node and the previous text node so don't strip brackets)-->
                                        <xsl:variable name="afterprevbr" select="preceding::html:br[1]/following::text()[1]"/>
                                                                               
                                        <!--  previous = "<xsl:value-of select="$previous" />"
                                       next = "<xsl:value-of select="$after" />"-->
                                        
                                        <xsl:variable name="afirstletter" select="substring(normalize-space($after), 1, 1)"/>
                                        <xsl:variable name="plastletter" select="substring(normalize-space($previous), string-length(normalize-space($previous)))"/>
                                    
                                        <!--texty-before="<xsl:value-of select="."/>"-->
                                        
                                        <!-- previous last letter = "<xsl:value-of select="$plastletter" />"
                                        next first letter = "<xsl:value-of select="$afirstletter" />" -->

                                        <xsl:choose>
                                            <!-- <xsl:when test="$afterprevbr = . or $beforenextbr = .">
                                                ~~<xsl:value-of select="$current"/>~~
                                            </xsl:when>-->
                                            <xsl:when test="$plastletter = ']' and $afirstletter = '[' and $afterprevbr != . and $beforenextbr != .">
                                                
                                                <!--<xsl:value-of select="$current"/>--><xsl:value-of select="substring($current, 2, string-length($current)-2)"/>                                                
                                            </xsl:when>
                                            <xsl:when test="$plastletter = ']' and $afterprevbr != .">
                                                <!--<xsl:value-of select="$current"/>--><xsl:value-of select="substring($current, 2)"/>
                                            </xsl:when>
                                            <xsl:when test="$afirstletter = '[' and $beforenextbr != .">
                                                <!--<xsl:value-of select="$current"/>--><xsl:value-of select="substring($current, 1, string-length($current)-1)"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$current"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                                                        
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <!--textx-before="<xsl:value-of select="." />-->
                                        <xsl:value-of select="$current"/><!--<xsl:value-of select="replace(., '([^\]])\](\s*)\[([^\[])', '$1$2$3')"/>-->
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:value-of select="$endspace"/>
                            <!--<xsl:text>[end]</xsl:text><xsl:value-of select="$endspace"/><xsl:text>[/end]</xsl:text>-->
                            
                        </xsl:when>
                        <xsl:when test="self::*">
                            <xsl:call-template name="sqbrackets">
                                <xsl:with-param name="html-elm" select="."/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:copy-of select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:element>
        </xsl:for-each>
        
    </xsl:template>
    
</xsl:stylesheet>
