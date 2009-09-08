<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id: tpl-reasonlost.xsl 807 2008-05-01 12:37:41Z zau $ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <!-- Templates for opening and closing brackets for gap and supplied [@reason = 'lost'] -->
  
  
  <xsl:template name="lost-opener">
    <!-- Relationship: start at x going to y -->
    <xsl:choose>
      <!--1.1
        ````````__|__
        ```````|`````|
        ```````y`````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="preceding-sibling::*[1][@reason='lost']">
        <xsl:if test="preceding-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>


      <!--1.2
        ````````__|__
        ```````|`````|
        ```````y```__z__
        ``````````|`````|
        ``````````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::*)]
        [not(preceding-sibling::text()) or translate(normalize-space(preceding-sibling::text()), ' ', '') = '']
        /parent::*[preceding-sibling::*[1][@reason='lost']]">
        <xsl:if test="parent::*[preceding-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>
      

      <!--1.3
        ````````______|______
        ```````|`````````````|
        ```````y```````````__z__
        ``````````````````|`````|
        ````````````````__z__
        ```````````````|`````|
        ```````````````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      
      <xsl:when test="current()[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[preceding-sibling::*[1][@reason='lost']]">
        <xsl:if
          test="parent::*/parent::*[preceding-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>
      

      <!--2.1
        ````````__|__
        ```````|`````|
        `````__z__```x
        ````|`````|
        ``````````y
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /preceding-sibling::*[1]/*[@reason='lost'][not(following-sibling::*)]">
        <xsl:if
          test="preceding-sibling::*[1]/*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>

      <!--2.2
        ````````____|____
        ```````|`````````|
        `````__z__`````__z__
        ````|`````|```|`````|
        ``````````y```x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[preceding-sibling::*[1]]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /preceding-sibling::*[1]/*[@reason='lost'][not(following-sibling::*)]">
        <xsl:if
          test="parent::*/preceding-sibling::*[1]
          /*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!--2.3
        ````````______|______
        ```````|`````````````|
        `````__z__`````````__z__
        ````|`````|```````|`````|
        ``````````y`````__z__
        ```````````````|`````|
        ```````````````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[preceding-sibling::*[1]]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /preceding-sibling::*[1]
        /*[@reason='lost'][not(following-sibling::*)]">
        <xsl:if
          test="parent::*/parent::*/preceding-sibling::*[1]
          /*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>


      <!--3.1
        ````````____|____
        ```````|`````````|
        `````__z__```````x
        ````|`````|
        ````````__z__
        ```````|`````|
        `````````````y
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /preceding-sibling::*[1]
        /*[not(following-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /*[@reason='lost'][not(following-sibling::*)]">
        <xsl:if
          test="preceding-sibling::*[1]/*
          /*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!--3.2
        ````````_______|_______
        ```````|```````````````|
        `````__z__```````````__z__
        ````|`````|`````````|`````|
        ````````__z__```````x
        ```````|`````|
        `````````````y
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[preceding-sibling::*[1]]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /preceding-sibling::*[1]
        /*[not(following-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /*[@reason='lost'][not(following-sibling::*)]">
        <xsl:if
          test="parent::*/preceding-sibling::*[1]/*
          /*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!--3.3 
        ````````______|______
        ```````|`````````````|
        `````__z__`````````__z__
        ````|`````|```````|`````|
        ````````__z__```__z__
        ```````|`````|`|`````|
        `````````````y`x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[not(preceding-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[preceding-sibling::*[1]]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /preceding-sibling::*[1]
        /*[not(following-sibling::*)]
        [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /*[@reason='lost'][not(following-sibling::*)]">
        <xsl:if
          test="parent::*/parent::*/preceding-sibling::*[1]/*
          /*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>[</xsl:text>
        </xsl:if>
      </xsl:when>
            
      
      <xsl:otherwise>
        <xsl:text>[</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template name="lost-closer">
    <!-- 
      In the diagrams above corresponding to the same number
      Relationship: start at y going to x
      And so the 'y' in the comments should be replaced with 'x' 
    -->
    <xsl:choose>
      <!-- 1.1 -->
      <xsl:when test="following-sibling::*[1][@reason='lost']">
        <xsl:if test="following-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!-- 1.2 -->
      <xsl:when test="current()[not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /following-sibling::*[1]/*[@reason='lost'][not(preceding-sibling::*)]">
        <xsl:if
          test="following-sibling::*[1]/*[@reason='lost'][not(preceding-sibling::*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!-- 1.3 -->
      <xsl:when test="current()[not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /following-sibling::*[1]
        /*[not(preceding-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /*[@reason='lost'][not(preceding-sibling::*)]">
        <xsl:if
          test="following-sibling::*[1]/*
          /*[@reason='lost'][not(preceding-sibling::*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!-- 2.1 -->
      <xsl:when test="current()[not(following-sibling::*)]
        [not(following-sibling::text()) or translate(normalize-space(following-sibling::text()), ' ', '') = '']
        /parent::*[following-sibling::*[1][@reason='lost']]">
        <xsl:if test="parent::*[following-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>

      
      <!-- 2.2 -->
      <xsl:when test="current()[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[following-sibling::*[1]]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /following-sibling::*[1]/*[@reason='lost'][not(preceding-sibling::*)]">
        <xsl:if
          test="parent::*/preceding-sibling::*[1]
          /*[@reason='lost'][not(following-sibling::*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!-- 2.3 -->
      <xsl:when test="current()[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[following-sibling::*[1]]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /following-sibling::*[1]
        /*[not(preceding-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /*[@reason='lost'][not(preceding-sibling::*)]">
        <xsl:if
          test="parent::*/following-sibling::*[1]/*
          /*[@reason='lost'][not(preceding-sibling::*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!-- 3.1 -->
      <xsl:when test="current()[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[following-sibling::*[1][@reason='lost']]">
        <xsl:if
          test="parent::*/parent::*[following-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
         
      
      <!-- 3.2 -->
      <xsl:when test="current()[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[following-sibling::*[1]]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /following-sibling::*[1]
        /*[@reason='lost'][not(preceding-sibling::*)]">
        <xsl:if
          test="parent::*/parent::*/following-sibling::*[1]
          /*[@reason='lost'][not(preceding-sibling::*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <!-- 3.3 -->
      <xsl:when test="current()[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[not(following-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /parent::*[following-sibling::*[1]]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /following-sibling::*[1]
        /*[not(preceding-sibling::*)]
        [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
        /*[@reason='lost'][not(preceding-sibling::*)]">
        <xsl:if
          test="parent::*/parent::*/following-sibling::*[1]/*
          /*[@reason='lost'][not(preceding-sibling::*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
          <xsl:text>]</xsl:text>
        </xsl:if>
      </xsl:when>
      
      
      <xsl:otherwise>
          <xsl:text>]</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
