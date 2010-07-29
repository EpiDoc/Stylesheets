<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema" 
  xmlns:dc="http://purl.org/dc/terms/" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" 
  xmlns:pi="http://papyri.info/ns"
  exclude-result-prefixes="xs"
  xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" version="2.0">
  
  <xsl:function name="pi:get-docs">
    <xsl:param name="urls"/>
    <xsl:param name="format"/>
    <xsl:for-each select="$urls">
      <xsl:if test="doc-available(pi:get-filename(., $format))">
        <xsl:copy-of select="doc(pi:get-filename(., $format))"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:function>
  
  <!-- Given an identifier URL, get the filename -->
  <xsl:function name="pi:get-filename" as="xs:string">
    <xsl:param name="url"/>
    <xsl:param name="format"/>
    <xsl:variable name="base"><xsl:choose>
      <xsl:when test="$format = 'xml'"><xsl:value-of select="$path"/></xsl:when>
      <xsl:when test="$format = 'html'"><xsl:value-of select="$outbase"/></xsl:when>
    </xsl:choose>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="contains($url, 'ddbdp')">
        <xsl:choose>
          <xsl:when test="$url = 'http://papyri.info/ddbdp'"><xsl:sequence select="concat($base, '/DDB_EpiDoc_XML/index.html')"/></xsl:when>
          <xsl:when test="ends-with($url, '/source')">
            <xsl:variable name="id" select="tokenize(substring-before(substring-after($url, 'http://papyri.info/ddbdp/'), '/'), ';')"/>
            <xsl:choose>
              <!-- like http://papyri.info/ddbdp/c.etiq.mom;;165/source -->
              <xsl:when test="$id[2] = ''"><xsl:sequence select="concat($base, '/DDB_EpiDoc_XML/', $id[1], '/', $id[1], '.', replace(replace($id[3], '%2C', '-'), '%2F', '_'), '.', $format)"/></xsl:when>
              <!-- like http://papyri.info/ddbdp/bgu;1;1/source -->
              <xsl:otherwise><xsl:sequence select="concat($base, '/DDB_EpiDoc_XML/', $id[1], '/', $id[1], '.', $id[2], '/', $id[1], '.', $id[2], '.', replace(replace($id[3], '%2C', '-'), '%2F', '_'), '.', $format)"/></xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:choose>
              <!-- like http://papyri.info/ddbdp/bgu;1 -->
              <xsl:when test="contains($url, ';')">
                <xsl:variable name="id" select="tokenize(substring-after($url, 'http://papyri.info/ddbdp/'), ';')"/>
                <xsl:sequence select="concat($base, '/DDB_EpiDoc_XML/', $id[1], '/', $id[1], '.', $id[2], '/index.html')"/>
              </xsl:when>
              <!-- like http://papyri.info/ddbdp/bgu -->
              <xsl:otherwise><xsl:sequence select="concat($base, '/DDB_EpiDoc_XML/', substring-after($url, 'http://papyri.info/ddbdp/'), '/index.html')"/></xsl:otherwise>
            </xsl:choose>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="contains($url, 'hgv/')">
        <xsl:variable name="dir">
          <xsl:choose>
            <xsl:when test="ends-with($url, '/source')"><xsl:value-of select="ceiling(number(replace(substring-before(substring-after($url, 'http://papyri.info/hgv/'), '/'), '[a-z]', '')) div 1000)"></xsl:value-of></xsl:when>
            <xsl:otherwise><xsl:value-of select="substring-after($url, 'http://papyri.info/hgv/')"/></xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <xsl:sequence select="concat($base, '/HGV_meta_EpiDoc/HGV', $dir, '/', replace(substring-after($url, 'http://papyri.info/hgv/'), '/source', ''), '.', $format)"/>
      </xsl:when>
      <xsl:when test="contains($url, 'hgvtrans')">
        <xsl:sequence select="concat($base, '/HGV_trans_EpiDoc/', substring-before(substring-after($url, 'http://papyri.info/hgvtrans/'), '/'), '.', $format)"/>
      </xsl:when>
      <xsl:when test="contains($url, 'apis')">
        <xsl:variable name="id" select="tokenize(replace(substring-after($url, 'http://papyri.info/apis/'), '/source', ''), '\.')"/>
        <xsl:choose>
          <xsl:when test="contains($url, '.')">
            <xsl:choose>
              <xsl:when test="count($id) = 2"><xsl:sequence select="concat($base, '/APIS/', $id[1], '/', $format, '/', $id[1], '.', $id[2], '.', $format)"/></xsl:when>
              <xsl:otherwise><xsl:sequence select="concat($base, '/APIS/', $id[1], '/', $format, '/', $id[1], '.', $id[2], '.', $id[3], '.', $format)"/></xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise><xsl:sequence select="concat($base, '/APIS/', substring-after($url, 'http://papyri.info/apis/'), 'index.html')"/></xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise><xsl:sequence select="string('null')"/></xsl:otherwise>
    </xsl:choose>
  </xsl:function>
  
  <!-- Given an identifier URL, get the bare id -->
  <xsl:function name="pi:get-id" as="xs:string">
    <xsl:param name="url"/>
    <xsl:sequence select="replace(replace(replace(replace(replace(replace($url, 'http://papyri\.info/[^/]+/', ''), '/source$', ''), ';;', '.'), ';', '.'), '%2C', ','), '%2F', '/')"/>
  </xsl:function>
</xsl:stylesheet>
