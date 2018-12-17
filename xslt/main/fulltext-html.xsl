<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xi="https://www.w3.org/TR/xinclude/"
  exclude-result-prefixes="xlink mml xi">

  <xsl:import href="jats-html.xsl"/>

  <xsl:output encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="book">
        <div class="book">
	  <xsl:apply-templates select="//front-matter"/>
	  <xsl:apply-templates select="//book-back"/>
	</div>
      </xsl:when>
      <xsl:when test="book-part[@book-part-type eq 'part']">
        <div class="part">
	  <xsl:apply-templates select="//body[not(child::*[self::xi:include])][parent::book-part[@book-part-type eq 'part']]"/>
	  <!-- <xsl:apply-templates select="//book-part[@book-part-type eq 'chapter']"/> -->
	</div>
      </xsl:when>
      <xsl:when test="book-part[@book-part-type eq 'section']">
        <div class="section">
          <xsl:apply-templates select="//body[not(child::*[self::xi:include])][parent::book-part[@book-part-type eq 'section']]"/>
        </div>
      </xsl:when>
      <!-- <xsl:when test="book-part[@book-part-type eq 'chapter']"> -->
      <xsl:when test="book-part[matches(@book-part-type, '^[Cc]hapter$')]">
        <div class="chapter">
          <xsl:apply-templates select="//body"/>
          <xsl:apply-templates select="//back"/>
	</div>
      </xsl:when>
      <xsl:when test="book-part[matches(@book-part-type,'^case[\s-]study$')]">
        <div class="case-study">
	  <xsl:apply-templates select="//body"/>
          <xsl:apply-templates select="//back"/>
	</div>
      </xsl:when>
      <xsl:when test="book-part[@book-part-type eq 'introduction']">
        <div class="introduction">
          <xsl:apply-templates select="//body"/>
          <xsl:apply-templates select="//back"/>
        </div>
      </xsl:when>
      <xsl:when test="book-part[@book-part-type eq 'conclusion']">
        <div class="conclusion">
          <xsl:apply-templates select="//body"/>
          <xsl:apply-templates select="//back"/>
        </div>
      </xsl:when>
      <xsl:when test="book-part[@book-part-type eq 'reference']">
        <div class="reference-topic">
          <xsl:apply-templates select="//body"/>
          <xsl:apply-templates select="//back"/>
        </div>
      </xsl:when>
      <xsl:when test="article">
        <div class="article">
	  <xsl:apply-templates select="//body"/>
          <xsl:apply-templates select="//back"/>
	</div>
      </xsl:when>
      <xsl:when test="ack | dedication | preface | appendix | foreword | book-app | glossary | ref-list | foreword"> 
        <xsl:apply-templates/>
      </xsl:when>
      <xsl:otherwise/>
    </xsl:choose>
  </xsl:template>

  <!-- <xsl:template match="book-part[@book-part-type eq 'chapter']">
    <div class="chapter">
      <xsl:apply-templates select="body"/>
      <xsl:apply-templates select="back"/>
    </div>
  </xsl:template> -->

  <xsl:template match="front-matter">
    <div class="front-matter">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="book-back">
    <div class="book-back">
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <xsl:template match="body">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="back">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
