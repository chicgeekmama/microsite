<xsl:stylesheet version="2.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xhtml" omit-xml-declaration="yes" indent="no" /> 

    <xsl:param name="CurrentDocID" />
    <xsl:param name="ApplicationBasePath"></xsl:param>
    <xsl:param name="Separator" />

	<!-- Let's calculated the selected branch once and reuse this variable -->
	<xsl:variable name="SelectedBranch" select="/NavTree/Node/Node[descendant-or-self::*[@DocID=$CurrentDocID]]" />
	
	<!-- This nav only ever shows the second level items, of the current branch, with the current branch item as the root node (though not linked). -->
    <xsl:template match="/">
		<xsl:comment>BeginNoIndex</xsl:comment>
		<div class="grey">
        	<xsl:comment>content spacer</xsl:comment>
			<xsl:apply-templates select="$SelectedBranch" mode="root"/>
		</div>
		<xsl:comment>EndNoIndex</xsl:comment>
    </xsl:template>

	<!-- This matches the root level of our nav tree. -->
    <xsl:template match="Node" mode="root">
        <xsl:if test="Node[Zones/Zone='Left']">
        	<ul>
				<!-- Gather up all the nodes for our one-level nav -->
				<xsl:apply-templates select="Node[Zones/Zone='Left']" mode="Level1">
					<xsl:sort select="Priority" data-type="number"/>
				</xsl:apply-templates>
			</ul>
		</xsl:if>
    </xsl:template>
	
    <!-- This matches the selected node and its siblings.  -->
    <xsl:template match="Node" mode="Level1">
		<li>
            <xsl:choose>
                <xsl:when test="position()=1">
                    <xsl:attribute name="class">navFirst</xsl:attribute>
                </xsl:when>
                <xsl:when test="position()=last()">
                    <xsl:attribute name="class">navLast</xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates select="." mode="makeLink"/>
        
	<xsl:if test="Node[Zones/Zone='Left']">
	    <ul>
		<xsl:apply-templates select="Node[Zones/Zone='Left']" mode="Level2">
		   <xsl:sort select="Priority" data-type="number"/>
		</xsl:apply-templates>
	    </ul>
	</xsl:if>
	</li>
    </xsl:template>	

    <xsl:template match="Node" mode="Level2">
	<li>
            <xsl:apply-templates select="." mode="makeLink"/>
        </li>
    </xsl:template>

    <xsl:template match="Node[contains(LinkParameter, '://')]" mode="makeLink">
        <a>
		    <xsl:if test="DisplayTargetTypeID='102'">
			    <xsl:attribute name="target">_blank</xsl:attribute>
		    </xsl:if>            
            <xsl:attribute name="href"><xsl:value-of disable-output-escaping="yes" select="LinkParameter"/></xsl:attribute>                
            <xsl:apply-templates select="descendant-or-self::*[@DocID=$CurrentDocID]" mode="markCurrent"/>
            <xsl:value-of select="DisplayName" disable-output-escaping="yes"/>
        </a>    
    </xsl:template>

    <xsl:template match="Node" mode="makeLink">
        <a>
		    <xsl:if test="DisplayTargetTypeID='102'">
			    <xsl:attribute name="target">_blank</xsl:attribute>
		    </xsl:if>            
            <xsl:attribute name="href"><xsl:value-of disable-output-escaping="yes" select="concat($ApplicationBasePath, LinkParameter)"/></xsl:attribute>                
            <xsl:apply-templates select="descendant-or-self::*[@DocID=$CurrentDocID]" mode="markCurrent"/>
            <xsl:value-of select="DisplayName" disable-output-escaping="yes"/>
        </a>    
    </xsl:template>

    <xsl:template match="Node" mode="markCurrent">
        <xsl:attribute name="class">current</xsl:attribute>
    </xsl:template>

	<xsl:template match="Node" mode="heading">
		<h3><xsl:value-of select="DisplayName" disable-output-escaping="yes"/></h3>
	</xsl:template>
	
</xsl:stylesheet>