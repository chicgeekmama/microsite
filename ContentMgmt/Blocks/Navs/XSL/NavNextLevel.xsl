<xsl:stylesheet version="2.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xhtml" omit-xml-declaration="yes" indent="no" />

	<!-- 
		This is a "Next Level" nav, meaning the deeper you go, you always get the next level.
		It always starts at the first level, showing the current branch and it's top level 
		siblings. It isn't meant to be perfect... at some point, you'll be too deep to look good. 
		
		The assumption is you'll never be showing a left nav on the home page.
	-->

	<xsl:param name="CurrentDocID" />
	<xsl:param name="Separator" />
	<xsl:param name="Zone" />

	<xsl:variable name="CurrentLevel" select="/NavTree//Node[@DocID=$CurrentDocID]/@Level" />

	<xsl:template match="/">
		<xsl:comment>BeginNoIndex</xsl:comment>
		<xsl:apply-templates select="/NavTree/Node/Node[Zones/Zone=$Zone]" mode="roots"/>
		<xsl:comment>EndNoIndex</xsl:comment>
	</xsl:template>

	<!-- This matches the top level node.  Either the root of our nav tree or the parent of the selected node.-->
	<xsl:template match="Node" mode="roots">
		<xsl:variable name="CurrentNode" select="descendant-or-self::*[@DocID=$CurrentDocID]"/>
		<h4>
			<xsl:apply-templates select="." mode="makeLink">
				<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
			</xsl:apply-templates>
		</h4>
		<xsl:if test="$CurrentNode and Node[Zones/Zone=$Zone]">
			<ul>
				<xsl:apply-templates select="Node[Zones/Zone=$Zone]" mode="NextLevel">
					<xsl:sort select="Priority" data-type="number"/>
				</xsl:apply-templates>
			</ul>
		</xsl:if>
	</xsl:template>

	<!-- We're only showing additional levels for the -->
	<xsl:template match="Node" mode="NextLevel">
		<xsl:variable name="CurrentNode" select="descendant-or-self::*[@DocID=$CurrentDocID]"/>
		<li>
			<xsl:choose>
				<xsl:when test="$CurrentNode and position()=1">
					<xsl:attribute name="class">navFirst current</xsl:attribute>
				</xsl:when>
				<xsl:when test="$CurrentNode and position()=last()">
					<xsl:attribute name="class">navLast current</xsl:attribute>
				</xsl:when>
				<xsl:when test="position()=1">
					<xsl:attribute name="class">navFirst</xsl:attribute>
				</xsl:when>
				<xsl:when test="position()=last()">
					<xsl:attribute name="class">navLast</xsl:attribute>
				</xsl:when>
				<xsl:when test="$CurrentNode">
					<xsl:attribute name="class">current</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates select="." mode="makeLink">
				<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
			</xsl:apply-templates>
			<xsl:if test="$CurrentNode and Node[@Level &lt;= $CurrentLevel+1][Zones/Zone=$Zone]">
				<ul>
					<xsl:apply-templates select="Node[Zones/Zone=$Zone]" mode="NextLevel">
						<xsl:sort select="Priority" data-type="number"/>
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template match="Node[contains(LinkParameter, '://')]" mode="makeLink">
		<!-- if not passed in this should always return an empty nodeset -->
		<xsl:param name="CurrentNode" select="self::node()[@DocID=$CurrentDocID]"/>
		<a>
			<xsl:if test="DisplayTargetTypeID='102'">
				<xsl:attribute name="target">_blank</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of disable-output-escaping="yes" select="LinkParameter"/>
			</xsl:attribute>
			<xsl:apply-templates select="$CurrentNode" mode="markCurrent"/>
			<xsl:value-of select="DisplayName" disable-output-escaping="yes"/>
		</a>
	</xsl:template>

	<xsl:template match="Node" mode="makeLink">
		<!-- if not passed in this should always return an empty nodeset -->
		<xsl:param name="CurrentNode" select="self::node()[@DocID=$CurrentDocID]"/>
		<a>
			<xsl:if test="DisplayTargetTypeID='102'">
				<xsl:attribute name="target">_blank</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of disable-output-escaping="yes" select="LinkParameter"/>
			</xsl:attribute>
			<xsl:apply-templates select="$CurrentNode" mode="markCurrent"/>
			<xsl:value-of select="DisplayName" disable-output-escaping="yes"/>
		</a>
	</xsl:template>

	<xsl:template match="Node" mode="markCurrent">
		<xsl:attribute name="class">current</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>