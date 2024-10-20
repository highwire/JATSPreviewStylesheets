<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="xlink mml">

  <xsl:import href="jats-html.xsl"/>

  <xsl:output encoding="UTF-8"/>

  <xsl:template match="/">
    <xsl:if test="//fig">
      <div class="floats">
        <xsl:if test="//fig[label]">
	  <h2 class="section-title">Figures</h2>
	  <xsl:apply-templates select="//fig[label]"/>
	</xsl:if>
     </div>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
