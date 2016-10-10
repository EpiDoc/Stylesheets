<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0"
	xmlns:f="http://example.com/ns/functions" xmlns:html="http://www.w3.org/1999/html" exclude-result-prefixes="t f"
	version="2.0">
<!--

Pietro notes on 14/8/2015 work on this template, from mail to Gabriel.

- I have converted the TEI bibliography of IRT and IGCyr to ZoteroRDF 
(https://github.com/EAGLE-BPN/BiblioTEI2ZoteroRDF) in this passage I have tried to 
distinguish books, bookparts, articles and conference proceedings.

- I have uploaded these to the zotero eagle open group bibliography 
(https://www.zotero.org/groups/eagleepigraphicbibliography)

- I have created a parametrized template in my local epidoc xslts which looks at the json 
and TEI output of the Zotero api basing the call on the content of ptr/@target in each 
bibl. It needs both because the key to build the link is in the json but the TEI xml is 
much more accessible for the other data. I tried also to grab the html div exposed in the 
json, which would have been the easiest thing to do, but I can only get it escaped and 
thus is not usable.
** If set on 'zotero' it prints surname, name, title and year with a link to the zotero 
item in the eagle group bibliography. It assumes bibl only contains ptr and citedRange.
** If set on 'localTEI' it looks at a local bibliography (no zotero) and compares the 
@target to the xml:id to take the results and print something (in the sample a lot, but 
I'd expect more commonly Author-Year references(.
** I have also created sample values for irt and igcyr which are modification of the 
zotero option but deal with some of the project specific ways of encoding the 
bibliography. All examples only cater for book and article.



-->

<!--
		
		Pietro Notes on 10.10.2016
		
		this should be modified based on parameters to
		
		* decide wheather to use zotero or a local version of the bibliography in TEI
	
		* assuming that the user has entered a unique tag name as value of ptr/@target, decide group or user in zotero to look up based on parameter value entered at transformation time
	
		* output style based on Zotero Style Repository stored in a parameter value entered at transformation time
		
		
	
	-->

	<xsl:template match="t:bibl" priority="1">
		<xsl:param name="parm-bib" tunnel="yes" required="no"/>
		
		
		<xsl:choose>
			<!-- default general zotero behaviour prints author surname and name, title in italics, date and links to the zotero item page on the eagle group bibliography. assumes the inscription source has no free text in bibl, !!!!!!!only a <ptr @target='key'/> and a <citedRange>pp. 45-65</citedRange>!!!!!!!-->
			<xsl:when test="$parm-bib = 'zotero'">
				<xsl:choose>
					<xsl:when test=".[t:ptr]">
						<xsl:variable name="biblentry" select="substring-after(./t:ptr/@target, '#')"/>
						<xsl:variable name="zoteroapitei">
<!--							THIS IS BASED ON THE EAGLE KEY for the group library-->
							<xsl:value-of
								select="concat('https://api.zotero.org/users/1405276/items?tag=', $biblentry, '&amp;format=tei')"/>
							<!-- to go to the json with the escaped html included  use &amp;format=json&amp;include=bib,data and the code below: the result is anyway escaped... -->
							
						</xsl:variable>
						<xsl:variable name="zoteroapijson">
							<xsl:value-of
								select="concat('https://api.zotero.org/users/1405276/items?tag=', $biblentry, '&amp;format=json')"
							/>
						</xsl:variable>
						<xsl:variable name="zoteroitemurl">
							<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapijson)"/>
							<xsl:analyze-string select="$unparsedtext"
								regex="(\[\s+\{{\s+&quot;key&quot;:\s&quot;)(.+)&quot;">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(2)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>
							
						</xsl:variable>
						<xsl:choose>
							<xsl:when test="not(ancestor::t:div[@type='bibliography'])">
								<xsl:variable name="pointerurl">
									<xsl:choose>
										<xsl:when
											test="document($zoteroapitei)//t:idno[@type = 'DOI']">
											<xsl:value-of
												select="document($zoteroapitei)//t:idno[@type = 'DOI']"
											/>
										</xsl:when>

										<xsl:otherwise>
											<xsl:choose>
												<xsl:when
												test="document($zoteroapitei)//t:note[@type = 'url']">
												<xsl:value-of
												select="document($zoteroapitei)//t:note[@type = 'url']"
												/>
												</xsl:when>
												<xsl:otherwise>
												<xsl:value-of
												select="concat('https://www.zotero.org/pietroliuzzo/items/', $zoteroitemurl)"
												/>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<a href="{$pointerurl}">
									<xsl:value-of select="document($zoteroapitei)//t:author/t:surname"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:date"/>
									<xsl:if test="t:citedRange"><xsl:text>, </xsl:text>
									<xsl:value-of select="t:citedRange"/></xsl:if>
								</a>
							</xsl:when>
							<xsl:when test="document($zoteroapitei)//t:biblStruct[@type = 'book']">
								<a href="{concat('https://www.zotero.org/pietroliuzzo/items/',$zoteroitemurl)}">
									<xsl:value-of select="document($zoteroapitei)//t:author/t:surname"/>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:author/t:forename"/><xsl:text> </xsl:text>
									<i>
										<xsl:value-of select="document($zoteroapitei)//t:title[@level = 'm']"/>
									</i>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:date"/>
								</a>
							</xsl:when>

							<xsl:when test="document($zoteroapitei)//t:biblStruct[@type = 'journalArticle']">
								<a href="{concat('https://www.zotero.org/pietroliuzzo/items/',$zoteroitemurl)}">
									<xsl:value-of select="document($zoteroapitei)//t:author/t:surname"/>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:author/t:forename"/><xsl:text> </xsl:text>
									<i>
										<xsl:value-of select="document($zoteroapitei)//t:title[@level = 'a']"/>
									</i>
									<xsl:text>, in </xsl:text>
									<xsl:text>"</xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:title[@level = 'j']"/>
									<xsl:text>" </xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:biblScope[@type = 'issue']"/>
									<xsl:text> (</xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:date"/>
									<xsl:text>) </xsl:text>
									<xsl:value-of select="t:citedRange"/>. </a> 
								<xsl:if test="document($zoteroapitei)//t:note[@type = 'url']">
									<xsl:text>EDH bibliography url: </xsl:text>
									<xsl:value-of select="document($zoteroapitei)//t:note[@type = 'url']"/>
								</xsl:if>

							</xsl:when>
						</xsl:choose>
						<!--				
this is to be used to get to the html in the zotero json including data and bib. this is of no much use as the html is returned escaped and thus is not really usable as such

<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapi)"/>
				<xsl:analyze-string select="$unparsedtext" regex="(bib&quot;:\s&quot;)(.+)&quot;"> <!-\-(bib&quot;: &quot;)(.+)(&quot;, &quot;data)-\->
<xsl:matching-substring>
	<xsl:variable name="a" select="replace(regex-group(2), '\\n', '')"/>
<xsl:variable name="b" select="replace($a,'\\','')"/>
	<xsl:value-of select="$b" disable-output-escaping="yes"/>
</xsl:matching-substring>
				</xsl:analyze-string>
-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="citedRange"/>
			</xsl:when>
			<!-- this render for irt taking into account that the desidered reference is already in the file and that only in some cases it needs to be edited. also the content of the zotero records is specific. irt uses biblScope as citedRange.-->
			<xsl:when test="$parm-bib = 'irt'">
				<xsl:choose>
					<xsl:when test=".[t:ptr]">
						<xsl:variable name="biblentry" select="./t:ptr/@target"/>
						
						<xsl:variable name="zoteroapiteiirt">
							<xsl:choose>
								<!--this variable normalize the way in which some AE and CIL pointers are refered to in irt-->
								<xsl:when test="$biblentry = 'ae'">
									<xsl:variable name="normalizedAEbib1" select="replace(t:biblScope, ':', ' ')"/>
									<xsl:variable name="normalizedAEbib2"
										select="concat(substring-before($normalizedAEbib1, ' '), ' ', format-number(number(substring-after($normalizedAEbib1, ' ')), '0000'))"/>
									<xsl:value-of
										select="concat('https://api.zotero.org/users/2138134/items?tag=', 'AE ', $normalizedAEbib2, '&amp;format=tei')"
									/>
								</xsl:when>
								<xsl:when test="$biblentry = 'cil'">
									<xsl:variable name="normalizedCILbib1" select="replace(t:biblScope, ':', ' ')"/>
									<xsl:variable name="normalizedCILbib2"
										select="concat(substring-before($normalizedCILbib1, ' '), ' ', format-number(number(substring-after($normalizedCILbib1, ' ')), '0000'))"/>
									<xsl:value-of
										select="concat('https://api.zotero.org/users/2138134/items?tag=', 'CIL ', $normalizedCILbib2, '&amp;format=tei')"
									/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
										select="concat('https://api.zotero.org/users/2138134/items?tag=', $biblentry, '&amp;format=tei')"/>
									<!-- to go to the json with the escaped html included  use &amp;format=json&amp;include=bib,data and the code below: the result is anyway escaped... -->
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="zoteroapijsonirt">
							<xsl:choose>
								<xsl:when test="$biblentry = 'ae'">
									<xsl:variable name="normalizedAEbib1" select="replace(t:biblScope, ':', ' ')"/>
									<xsl:variable name="normalizedAEbib2"
										select="concat(substring-before($normalizedAEbib1, ' '), ' ', format-number(number(substring-after($normalizedAEbib1, ' ')), '0000'))"/>
									<xsl:value-of
										select="concat('https://api.zotero.org/users/2138134/items?tag=', 'AE ', $normalizedAEbib2, '&amp;format=json')"
									/>
								</xsl:when>
								<xsl:when test="$biblentry = 'cil'">
									<xsl:variable name="normalizedCILbib1" select="replace(t:biblScope, ':', ' ')"/>
									<xsl:variable name="normalizedCILbib2"
										select="concat(substring-before($normalizedCILbib1, ' '), ' ', format-number(number(substring-after($normalizedCILbib1, ' ')), '0000'))"/>
									<xsl:value-of
										select="concat('https://api.zotero.org/users/2138134/items?tag=', 'CIL ', $normalizedCILbib2, '&amp;format=json')"
									/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
										select="concat('https://api.zotero.org/users/2138134/items?tag=', $biblentry, '&amp;format=json')"/>
									<!-- to go to the json with the escaped html included  use &amp;format=json&amp;include=bib,data and the code below: the result is anyway escaped... -->
								</xsl:otherwise>
							</xsl:choose>

						</xsl:variable>
						<xsl:variable name="zoteroitemurlirt">
							<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapijsonirt)"/>
							<xsl:analyze-string select="$unparsedtext"
								regex="(\[\s+\{{\s+&quot;key&quot;:\s&quot;)(.+)&quot;">
								<xsl:matching-substring>
									<xsl:value-of select="regex-group(2)"/>
								</xsl:matching-substring>
							</xsl:analyze-string>

						</xsl:variable>
						<xsl:choose>
							<xsl:when test="document($zoteroapiteiirt)//t:biblStruct[@type = 'book']">
								<a href="{concat('https://www.zotero.org/eaglebpn/items/',$zoteroitemurlirt)}">
									<xsl:value-of select="t:author"/>
									<i>
										<xsl:value-of select="document($zoteroapiteiirt)//t:title[@level = 'm']"/>
									</i>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapiteiirt)//t:date"/>
								</a>
							</xsl:when>

							<xsl:when test="document($zoteroapiteiirt)//t:biblStruct[@type = 'journalArticle']">
								<a href="{concat('https://www.zotero.org/eaglebpn/items/',$zoteroitemurlirt)}">
									<xsl:value-of select="t:author"/>
									<i>
										<xsl:value-of select="document($zoteroapiteiirt)//t:title[@level = 'a']"/>
									</i>
									<xsl:text>, in</xsl:text>
									<xsl:text> "</xsl:text>
									<xsl:value-of select="document($zoteroapiteiirt)//t:title[@level = 'j']"/>
									<xsl:text>" </xsl:text>
									<xsl:value-of select="document($zoteroapiteiirt)//t:biblScope[@type = 'issue']"/>
									<xsl:text> (</xsl:text>
									<xsl:value-of select="document($zoteroapiteiirt)//t:date"/>
									<xsl:text>) </xsl:text>
									<xsl:value-of select="document($zoteroapiteiirt)//t:biblScope[@type = 'pp']"/></a>
								<xsl:if test="document($zoteroapiteiirt)//t:note[@type = 'url']">
									<xsl:text>EDH bibliography url: </xsl:text>
									<xsl:value-of select="document($zoteroapiteiirt)//t:note[@type = 'url']"/>
								</xsl:if>

							</xsl:when>
						</xsl:choose>
						<!--				
this is to be used to get to the html in the zotero json including data and bib. this is of no much use as the html is returned escaped and thus is not really usable as such

<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapi)"/>
				<xsl:analyze-string select="$unparsedtext" regex="(bib&quot;:\s&quot;)(.+)&quot;"> <!-\-(bib&quot;: &quot;)(.+)(&quot;, &quot;data)-\->
<xsl:matching-substring>
	<xsl:variable name="a" select="replace(regex-group(2), '\\n', '')"/>
<xsl:variable name="b" select="replace($a,'\\','')"/>
	<xsl:value-of select="$b" disable-output-escaping="yes"/>
</xsl:matching-substring>
				</xsl:analyze-string>
-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:value-of select="t:biblScope"/>
			</xsl:when>
			<!--this render for igcyr where the bibliography is fully reported in the zotero record imported and citedRange is used. the formatting needs to take into account text content of bibl-->
			<xsl:when test="$parm-bib = 'igcyr'">
				<xsl:variable name="biblentryigcyr" select="substring-after(./t:ptr/@target, '#')"/>
				<xsl:variable name="zoteroapiteiigcyr">
					
					<xsl:value-of
						select="concat('https://api.zotero.org/users/2138134/items?tag=', $biblentryigcyr, '&amp;format=tei')"/>
					<!-- to go to the json with the escaped html included  use &amp;format=json&amp;include=bib,data and the code below: the result is anyway escaped... -->
					
				</xsl:variable>
				<xsl:variable name="zoteroapijsonigcyr">
					<xsl:value-of
						select="concat('https://api.zotero.org/users/2138134/items?tag=', $biblentryigcyr, '&amp;format=json')"
					/>
				</xsl:variable>
				<xsl:variable name="zoteroitemurligcyr">
					<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapijsonigcyr)"/>
					<xsl:analyze-string select="$unparsedtext"
						regex="(\[\s+\{{\s+&quot;key&quot;:\s&quot;)(.+)&quot;">
						<xsl:matching-substring>
							<xsl:value-of select="regex-group(2)"/>
						</xsl:matching-substring>
					</xsl:analyze-string>
					
				</xsl:variable>
				<xsl:if test="text()[following-sibling::t:ptr]">
					<xsl:value-of select="text()[following-sibling::t:ptr]"/>
				</xsl:if>
				<xsl:choose>
					<xsl:when test=".[t:ptr]">
						<xsl:choose>
							<xsl:when test="document($zoteroapiteiigcyr)//t:biblStruct[@type = 'book']">
								<a href="{concat('https://www.zotero.org/eaglebpn/items/',$zoteroitemurligcyr)}">
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:author/t:surname"/>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:author/t:forename"/> <xsl:text> </xsl:text>
									<i>
										<xsl:value-of select="document($zoteroapiteiigcyr)//t:title[@level = 'm']"/>
									</i>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:date"/>
								</a>
							</xsl:when>

							<xsl:when test="document($zoteroapiteiigcyr)//t:biblStruct[@type = 'journalArticle']">
								<a href="{concat('https://www.zotero.org/eaglebpn/items/',$zoteroitemurligcyr)}">
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:author/t:surname"/>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:author/t:forename"/> <xsl:text> </xsl:text>
									<i>
										<xsl:value-of select="document($zoteroapiteiigcyr)//t:title[@level = 'a']"/>
									</i>
									<xsl:text>, in</xsl:text>
									<xsl:text>"</xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:title[@level = 'j']"/>
									<xsl:text>" </xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:biblScope[@type = 'issue']"/>
									<xsl:text> (</xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:date"/>
									<xsl:text>) </xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:biblScope[@type = 'pp']"/>. </a>
								<xsl:if test="document($zoteroapiteiigcyr)//t:note[@type = 'url']">
									<xsl:text>EDH bibliography url: </xsl:text>
									<xsl:value-of select="document($zoteroapiteiigcyr)//t:note[@type = 'url']"/>
								</xsl:if>

							</xsl:when>
						</xsl:choose>
						<!--				
this is to be used to get to the html in the zotero json including data and bib. this is of no much use as the html is returned escaped and thus is not really usable as such

<xsl:variable name="unparsedtext" select="unparsed-text($zoteroapi)"/>
				<xsl:analyze-string select="$unparsedtext" regex="(bib&quot;:\s&quot;)(.+)&quot;"> <!-\-(bib&quot;: &quot;)(.+)(&quot;, &quot;data)-\->
<xsl:matching-substring>
	<xsl:variable name="a" select="replace(regex-group(2), '\\n', '')"/>
<xsl:variable name="b" select="replace($a,'\\','')"/>
	<xsl:value-of select="$b" disable-output-escaping="yes"/>
</xsl:matching-substring>
				</xsl:analyze-string>
-->
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="text()[following-sibling::t:citedRange and preceding-sibling::t:ptr]">
					<xsl:value-of select="text()[following-sibling::t:citedRange and preceding-sibling::t:ptr]"/>
				</xsl:if>
				<xsl:value-of select="t:citedRange"/>
				
				<xsl:if test="text()[preceding-sibling::t:citedRange][1]">
					<xsl:value-of select="text()[preceding-sibling::t:citedRange][1]"/>
				</xsl:if>
			</xsl:when>

			<!--assumes a bibliography.xml file in the same folder as the stylesheet. path should be changed according to local directory-->
			<xsl:when test="$parm-bib = 'localTEI'">
				<xsl:variable name="extendedbib">
					<xsl:variable name="biblentry" select="./t:ptr/@target"/>
					
					<xsl:variable name="reference" select="document('bibliography.xml')//t:bibl/@xml:id"/>
					<xsl:variable name="textref"
						select="document('bibliography.xml')//t:bibl[@xml:id = $biblentry]"/>
					<xsl:for-each select="$biblentry">
						<xsl:choose>
							<xsl:when test="$reference = $biblentry">
								<xsl:choose>
									<xsl:when test="parent::t:ptr/parent::t:bibl/t:author">
										<xsl:value-of select="parent::t:ptr/parent::t:bibl/t:author[1]"/>
										<xsl:if test="parent::t:ptr/parent::t:bibl/t:author[2]">
											<xsl:text>-</xsl:text>
											<xsl:value-of select="parent::t:ptr/parent::t:bibl/t:author[2]"/>
										</xsl:if>
										<xsl:text>, </xsl:text>
									</xsl:when>
									<xsl:when test="parent::t:ptr/parent::t:bibl/t:editor">
										<xsl:value-of select="parent::t:ptr/parent::t:bibl/t:editor[1]"/>
										<xsl:if test="parent::t:ptr/parent::t:bibl/t:editor[2]">
											<xsl:text>-</xsl:text>
											<xsl:value-of select="parent::t:ptr/parent::t:bibl/t:editor[2]"/>
										</xsl:if>
									</xsl:when>
								</xsl:choose>
								<xsl:value-of select="$textref"/>
								<xsl:text>, </xsl:text>
								<xsl:value-of select="parent::t:ptr/parent::t:bibl/t:biblScope"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="parent::t:ptr/parent::t:bibl/t:date"/>

							</xsl:when>
							<xsl:otherwise>
								<!--if this appears the id do not really correspond to each other, ther might be a typo or a missing entry in the bibliography-->
								<xsl:text> !</xsl:text>
								<xsl:value-of select="$biblentry"/>
								<xsl:text>!</xsl:text>
							</xsl:otherwise>
						</xsl:choose>

					</xsl:for-each>

				</xsl:variable>
				<xsl:value-of select="$extendedbib"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- This applyes other templates and does not call the zotero api -->
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
