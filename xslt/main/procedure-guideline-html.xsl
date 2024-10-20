<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="xlink mml">

  <xsl:import href="jats-html.xsl"/>

  <xsl:output encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:if test="//sec[@sec-type='feature-procedure-guideline' and @disp-level='feature'][ancestor::back/parent::book-part/@book-part-type='chapter']">
      <div class="feature-procedure-guideline">
        <h2 class="section-title">Procedure</h2>
        <xsl:apply-templates select="//sec[@sec-type='feature-procedure-guideline' and @disp-level='feature'][ancestor::back/parent::book-part/@book-part-type='chapter']"/>
      </div>
    </xsl:if>
  </xsl:template>
    
</xsl:stylesheet>
