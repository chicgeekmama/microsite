<xsl:stylesheet version="2.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xhtml" omit-xml-declaration="yes" indent="no" />

	<xsl:param name="CurrentDocID"></xsl:param>
	<xsl:param name="Separator" />
	<xsl:param name="Zone" />
	
	<xsl:variable name="StopLevel" select="4"/>

	<xsl:template match="/">
		<xsl:comment>BeginNoIndex</xsl:comment>
		<ul navName="TopMenu" navZone="{$Zone}" class="menu">
			<xsl:apply-templates select="/NavTree/Node/Node[Zones/Zone=$Zone]">
				<xsl:sort select="Priority" data-type="number"/>
			</xsl:apply-templates>
		</ul>
		<xsl:comment>EndNoIndex</xsl:comment>
	</xsl:template>

	<xsl:template match="Node">
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
			<!--Gather next level of navigation and work two levels down in the tree-->
			<xsl:if test="Node[Zones/Zone=$Zone]">
				<ul>
					<xsl:apply-templates select="Node[Zones/Zone=$Zone]" mode="NextLevel">
						<xsl:sort select="Priority" data-type="number"/>
						<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
					</xsl:apply-templates>
				</ul>
			</xsl:if>
			<xsl:if test="$Separator and position() != last()">
				<span>
					<xsl:value-of select="$Separator"/>
				</span>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template match="Node" mode="NextLevel">
		<xsl:param name="CurrentNode"/>
		<li>
			<xsl:apply-templates select="." mode="makeLink">
				<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
			</xsl:apply-templates>
			<xsl:if test="@Level &lt; $StopLevel and Node[Zones/Zone=$Zone]">
				<ul>
					<xsl:apply-templates select="Node[Zones/Zone=$Zone]" mode="NextLevel">
						<xsl:sort select="Priority" data-type="number"/>
						<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template match="Node[contains(LinkParameter, '://')]" mode="makeLink">
		<xsl:param name="CurrentNode"/>
		<a>
			<xsl:if test="DisplayTargetTypeID='102'">
				<xsl:attribute name="target">_blank</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of disable-output-escaping="yes" select="LinkParameter"/>
			</xsl:attribute>
			<xsl:apply-templates select="." mode="markCurrent">
				<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
			</xsl:apply-templates>
			<span>
				<xsl:value-of select="DisplayName" disable-output-escaping="yes"/>
			</span>
		</a>
	</xsl:template>

	<xsl:template match="Node" mode="makeLink">
		<xsl:param name="CurrentNode"/>
		<a>
			<xsl:if test="DisplayTargetTypeID='102'">
				<xsl:attribute name="target">_blank</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href">
				<xsl:value-of disable-output-escaping="yes" select="LinkParameter"/>
			</xsl:attribute>
			<xsl:apply-templates select="." mode="markCurrent">
				<xsl:with-param name="CurrentNode" select="$CurrentNode"/>
			</xsl:apply-templates>
			<span>
				<xsl:value-of select="DisplayName" disable-output-escaping="yes"/>
			</span>
		</a>
	</xsl:template>

	<xsl:template match="Node" mode="markCurrent">
		<xsl:param name="CurrentNode"/>
		<xsl:variable name="HasChild" select="@Level &lt; $StopLevel and Node[Zones/Zone=$Zone]"/>
		<xsl:choose>
			<xsl:when test="$HasChild and $CurrentNode">
				<xsl:attribute name="class">hasChild current</xsl:attribute>
			</xsl:when>
			<xsl:when test="$HasChild">
				<xsl:attribute name="class">hasChild</xsl:attribute>
			</xsl:when>
			<xsl:when test="$CurrentNode">
				<xsl:attribute name="class">current</xsl:attribute>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>