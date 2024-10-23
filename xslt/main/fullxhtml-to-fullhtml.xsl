<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  xmlns:xi="https://www.w3.org/TR/xinclude/"
  xmlns:ali="http://www.niso.org/schemas/ali/1.0/"
  xmlns:a="http://www.w3.org/1999/xhtml" 
  exclude-result-prefixes="xlink mml xi ali">

  
  <xsl:template match="node()|@*">
    <xsl:copy exclude-result-prefixes="#all">
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  
  
  <xsl:template match="*">
    <xsl:element name="{local-name(.)}">
      <xsl:apply-templates select="node()|@*"/>
    </xsl:element>
  </xsl:template>

</xsl:stylesheet>
