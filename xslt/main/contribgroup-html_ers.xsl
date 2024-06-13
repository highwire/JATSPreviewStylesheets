<xsl:stylesheet version="3.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:mml="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="xlink mml">
  
  <xsl:import href="jats-html.xsl"/>
  
  <xsl:output encoding="UTF-8"/>
  
  <xsl:template match="/">
    <xsl:where-populated>
      <div>
        <xsl:choose>
          <xsl:when test="book">
            <xsl:apply-templates select="//contrib-group[parent::book-meta]" mode="contrib-group"/>
          </xsl:when>
          <xsl:when test="book-part">
            <xsl:apply-templates select="//contrib-group[parent::book-part-meta]" mode="contrib-group"/>
          </xsl:when>
          <xsl:when test="article">
            <xsl:apply-templates select="//contrib-group[parent::article-meta]" mode="contrib-group"/>
          </xsl:when>
          <xsl:when test="book-app">
            <xsl:apply-templates select="//contrib-group[parent::book-part-meta]" mode="contrib-group"/>
          </xsl:when>
        </xsl:choose>
      </div>
    </xsl:where-populated>
  </xsl:template>
  
  <xsl:template match="contrib-group[parent::book-meta or parent::book-part-meta or parent::article-meta][contrib[@contrib-type eq 'author']]" mode="contrib-group">
    <div class="contributors">
      <ul class="contributor-list" data-list-type="authors">
        <xsl:apply-templates select="contrib[@contrib-type eq 'author']" mode="#current"/>
      </ul>
      <xsl:if test="parent::book-part-meta/descendant::aff or parent::book-meta/descendant::aff">
        <ul class="affiliation-list" data-list-type="affiliation">
          <xsl:apply-templates select="parent::book-part-meta/descendant::aff|parent::book-meta/descendant::aff" mode="#current"/>
        </ul>
      </xsl:if>
      <xsl:if test="//book-part-meta/author-notes/corresp or //book-meta/author-notes/corresp">
        <ul class="corresp-list" data-list-type="correspondence">
          <xsl:element name="li">
            <xsl:attribute name="class">
              <xsl:value-of select="'corresp'"/>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:value-of select="//book-part-meta/author-notes/corresp/@id|//book-meta/author-notes/corresp/@id"/>
            </xsl:attribute>
            <xsl:if test="//corresp[parent::author-notes]/label">
              <span class="label">
                <xsl:value-of select="//book-part-meta/author-notes/corresp/label|//book-meta/author-notes/corresp/label"/>
              </span>
            </xsl:if>
            <xsl:apply-templates select="//book-part-meta/author-notes/corresp/node()|//book-meta/author-notes/corresp/node() except (//book-part-meta/author-notes/corresp/label|//book-meta/author-notes/corresp/label)"/>
          </xsl:element>
        </ul>
      </xsl:if>
      <xsl:if test="//book-part-meta/author-notes/fn | //book-meta/author-notes/fn">
        <ul class="authnote-list" data-list-type="authornote">
          <xsl:apply-templates select="//book-part-meta/author-notes/fn | //book-meta/author-notes/fn"/>
        </ul>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="//book-part-meta/author-notes | //book-meta/author-notes">
    <xsl:apply-templates select="fn"/>
  </xsl:template>
  
  <xsl:template match="fn[parent::author-notes]">
    <xsl:element name="li">
      <xsl:attribute name="class">
        <xsl:value-of select="'authornote'"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of
          select="@id"/>
      </xsl:attribute>
      <xsl:if test="label">
        <span class="label">
          <xsl:value-of
            select="label"/>
        </span>
      </xsl:if>
      <xsl:apply-templates
        select="node() except (label)"
        mode="#current"/>
    </xsl:element>
  </xsl:template>
  
  <xsl:template match="contrib-group[parent::book-meta or parent::book-part-meta or parent::article-meta][contrib[@contrib-type eq 'editor']]" mode="contrib-group">
    <div class="contrib-group-editors">
      <ul class="contributor-list" data-list-type="editors">
        <xsl:apply-templates select="contrib[@contrib-type eq 'editor']" mode="contrib-group"/>
      </ul>
      <xsl:if test="(parent::book-part-meta/descendant::aff) or (parent::book-meta/descendant::aff)">
        <ul class="affiliation-list" data-list-type="affiliation">
          <xsl:apply-templates select="parent::book-part-meta/descendant::aff|parent::book-meta/descendant::aff" mode="#current"/>
        </ul>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="contrib-group[parent::book-meta or parent::article-meta][contrib[@contrib-type eq 'guest-editor']]" mode="contrib-group">
    <div class="contrib-group-guest-editors">
      <span class="contributor-list-label">Guest Editor:</span>
      <ul class="contributor-list" data-list-type="guest-editors">
        <xsl:apply-templates select="contrib[@contrib-type eq 'guest-editor']" mode="contrib-group"/>
      </ul>
      <xsl:if test="(parent::book-part-meta/descendant::aff) or (parent::book-meta/descendant::aff)">
        <ul class="affiliation-list" data-list-type="affiliation">
          <xsl:apply-templates select="parent::book-part-meta/descendant::aff|parent::book-meta/descendant::aff" mode="#current"/>
        </ul>
      </xsl:if>
    </div>
  </xsl:template>
  
  <xsl:template match="contrib[matches(@contrib-type, '(author|editor)')]" mode="contrib-group">
    <li class="contributor">
      <xsl:choose>
        <xsl:when test="contrib-id[@contrib-id-type eq 'orcid']">
          <span class="name" contrib-id-type="{contrib-id/@contrib-id-type}" tabindex="0" data-container="body" data-toggle="popover" data-placement="right" data-trigger="focus" title="" data-html="true">
            <xsl:attribute name="data-content"><xsl:apply-templates select="contrib-id" mode="#current"/><xsl:apply-templates select="bio" mode="bio-and-orcid"/></xsl:attribute>
            <xsl:attribute name="data-original-title" select="if(@contrib-type eq 'guest-editor') then 'Guest Editor Bio' else if(@contrib-type eq 'editor') then 'Editor Bio' else 'Author Bio'"/>
            <xsl:apply-templates select="name, string-name, degrees" mode="#current"/>
          </span>
        </xsl:when>
        <xsl:when test="xref[@ref-type='author-notes']/@rid[contains(.,'orcid')] = parent::contrib-group/following-sibling::author-notes/fn/@id[contains(.,'orcid')]">
          <xsl:variable name="author-notes-rid" select="xref[@ref-type='author-notes']/@rid[contains(.,'orcid')]"/>
          <span class="name" contrib-id-type="orcid" tabindex="0" data-container="body" data-toggle="popover" data-placement="right" data-trigger="focus" title="" data-html="true">
            <xsl:attribute name="data-content">
              <xsl:choose>
                <xsl:when test="xref[@ref-type='author-notes']/@rid[contains(.,'orcid')] = parent::contrib-group/following-sibling::author-notes/fn[child::p/uri]/@id[contains(.,'orcid')]">
                  <xsl:value-of select="concat('&lt;div&gt;&lt;a href=&#34;',parent::contrib-group/following-sibling::author-notes/fn[@id=$author-notes-rid]/p/uri/normalize-space(text()),'&#34;')"/>
                </xsl:when>
                <xsl:when test="xref[@ref-type='author-notes']/@rid[contains(.,'orcid')] = parent::contrib-group/following-sibling::author-notes/fn/@id[contains(.,'orcid')]">
                  <xsl:value-of select="concat('&lt;div&gt;&lt;a href=&#34;',parent::contrib-group/following-sibling::author-notes/fn[@id=$author-notes-rid]/p/normalize-space(text()),'&#34;')"/>
                </xsl:when>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="class" select="'&#34;orcid&#34;'"/>
            <xsl:attribute name="target">
              <xsl:text>&#34;_blank&#34;&gt;</xsl:text>
              <xsl:apply-templates select="name, string-name, degrees" mode="#current"/>
              <xsl:text>&lt;/a&gt;&lt;/div&gt;</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="data-original-title" select="'Author Bio'"/>
            <xsl:apply-templates select="name, string-name, degrees" mode="#current"/>
          </span>
        </xsl:when>
        <xsl:when test="bio">
          <span tabindex="0" data-container="body" data-toggle="popover" data-placement="right" data-trigger="focus" title="" data-html="true">
            <xsl:attribute name="data-content"><xsl:apply-templates select="bio" mode="#current"/></xsl:attribute>
            <xsl:attribute name="data-original-title" select="if(@contrib-type eq 'guest-editor') then 'Guest Editor Bio' else if(@contrib-type eq 'editor') then 'Editor Bio' else 'Author Bio'"/>
            <!-- <xsl:apply-templates select="* except (bio, x, aff)" mode="#current"/> -->
            <xsl:apply-templates select="name, string-name, degrees" mode="#current"/>
          </span>
        </xsl:when>
        <xsl:when test="child::collab">
          <span class="{@contrib-type}" tabindex="0" data-container="body" data-toggle="popover" data-placement="right" data-trigger="focus" title="" data-html="true" data-content="">
            <xsl:attribute name="data-original-title" select="if(@contrib-type eq 'guest-editor') then 'Guest Editor Bio' else if(@contrib-type eq 'editor') then 'Editor Bio' else 'Author Bio'"/>
            <xsl:apply-templates select="collab/text(), name, string-name, degrees" mode="#current"/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <!-- <xsl:apply-templates select="* except (x, aff)" mode="#current"/> -->
          <span class="name" contrib-type="{@contrib-type}" tabindex="0" data-container="body" data-toggle="popover" data-placement="right" data-trigger="focus" title="" data-html="true" data-content="">
            <xsl:attribute name="data-original-title" select="if(@contrib-type eq 'guest-editor') then 'Guest Editor Bio' else if(@contrib-type eq 'editor') then 'Editor Bio' else 'Author Bio'"/>
            <xsl:apply-templates select="name, string-name, degrees" mode="#current"/>
          </span>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:for-each select="xref[@ref-type='aff']">
        <xsl:variable name="xref-rid" select="@rid"/>
        <xsl:choose>
          <xsl:when test="node()">
            <a href="#{@rid}" class="xref-aff" data-link="affiliate">
              <xsl:value-of select="."/>
            </a>
            <xsl:if test="following-sibling::xref[@ref-type='aff']">
              <span class="xref-sep">,</span>
            </xsl:if>
          </xsl:when>
        </xsl:choose>
      </xsl:for-each>
      <xsl:if test="xref[@ref-type='corresp']">
        <a href="#{xref[@ref-type='corresp']/@rid}" class="xref-up-link" data-link="corresp">
          <!--<xsl:value-of select="xref[@ref-type='corresp']"/>-->
          <xsl:choose>
            <xsl:when test="string-length(xref[@ref-type='corresp']/normalize-space(.))>0">
              <span><xsl:value-of select="xref[@ref-type='corresp']/normalize-space(.)"/></span>
            </xsl:when>
            <xsl:otherwise>
              <span>&#x21D1;</span>
            </xsl:otherwise>
          </xsl:choose>
        </a>
      </xsl:if>
      <xsl:if test="xref[@ref-type='fn']">
        <a href="#{xref[@ref-type='fn']/@rid}" class="authnote" data-link="authnote">
          <xsl:value-of select="xref[@ref-type='fn']"/>
        </a>
      </xsl:if>
    </li>
  </xsl:template>
  
  <!--<xsl:template match="aff" mode="contrib-group">
    <xsl:element name="li">
      <xsl:attribute name="class">
        <xsl:value-of select="'aff'"/>
      </xsl:attribute>
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:if test="label">
        <span class="label">
          <sup><xsl:value-of select="label"/></sup>
        </span>
      </xsl:if>
      <xsl:value-of select="node() except label"/>
    </xsl:element>
  </xsl:template>-->
  
  <xsl:template match="aff" mode="contrib-group">
    <xsl:choose>
      <xsl:when test="not(target)">
        <xsl:element name="li">
          <xsl:attribute name="class">
            <xsl:value-of select="'aff'"/>
          </xsl:attribute>
          <xsl:attribute name="id">
            <xsl:value-of select="@id"/>
          </xsl:attribute>
          <xsl:if test="label">
            <span class="label">
              <sup><xsl:value-of select="label"/></sup>
            </span>
          </xsl:if>
          <xsl:value-of select="node() except label"/>
        </xsl:element>
      </xsl:when>
      <xsl:when test="target">
        <xsl:for-each-group select="*" group-starting-with="target">
          <xsl:element name="li">
            <xsl:attribute name="class">
              <xsl:value-of select="'aff'"/>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:value-of select="current-group()/@id"/>
            </xsl:attribute>
            <xsl:if test="current-group()/self::label">
              <span class="label">
                <sup><xsl:value-of select="current-group()/self::label"/></sup>
              </span>
            </xsl:if>
            <xsl:value-of select="current-group() except current-group()/self::label"/>
          </xsl:element>
          <xsl:text>
        </xsl:text>
        </xsl:for-each-group>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
</xsl:stylesheet>
