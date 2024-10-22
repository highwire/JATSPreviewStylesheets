<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="xlink mml">
  <!--WILYSCOL-81: change Date: 22-10-2024  Heading changes 'figures' to  'Illustrations' -->
  <xsl:import href="jats-html_FigCaption.xsl"/>

  <xsl:output encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:if test="//fig">
      <div class="floats">
        <xsl:if test="//fig[label]">
          <h2 class="section-title">Illustrations</h2>
          <xsl:apply-templates select="//fig[label]"/>
        </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
