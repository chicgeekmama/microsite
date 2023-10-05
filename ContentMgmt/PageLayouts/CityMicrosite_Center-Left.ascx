<%@ Register TagPrefix="cms" Namespace="NorthwoodsSoftwareDevelopment.Cms.Display" Assembly="UISupport" %>
<%@ Control language="c#" AutoEventWireup="false" Inherits="NorthwoodsSoftwareDevelopment.Cms.Display.LayoutController" %>

<a href="#Nav" class="skipNav">Skip to Sub Navigation</a>
<header id="headerArea">
  <div id="utilityArea" class="layoutContainer">
    <div class="siteBounds">
      <nav class="TranslateLink">
        <ul>
          <li>
            <div id="google_translate_element" class="">
              <div class="skiptranslate goog-te-gadget" dir="ltr" style="">
                <div id=":0.targetLanguage" class="goog-te-gadget-simple" style="white-space: nowrap;"> <img src="https://www.google.com/images/cleardot.gif" class="goog-te-gadget-icon" alt="" style="background-image: url('https://translate.googleapis.com/translate_static/img/te_ctrl3.gif'); background-position: -65px 0px;"> <span style="vertical-align: middle;"> <a aria-haspopup="true" href="javascript:void(0)"><em class="fa fa-language fa-1">&nbsp;</em>Translate</a> </span> </div>
              </div>
            </div>
          </li>
        </ul>
      </nav>
      <div class="utilityWrapper">
        <nav class="utility">
          <cms:DisplayNavigation id="utilityNav" Zone="Utility" Xslt="NavUtility.xsl" MaximumTreeLevels="8" runat="server" />
        </nav>
        <div class="searchArea">
          <div class="searchBar"> 
            <script language="C#" runat="server">
						    /*
							    The search bar control will direct control to the URL specified in the
							    site-specific data for the document's site.  This value can be overridden
							    by providing the attribute ResultsPage.
						    */
					    </script>
            <cms:SearchBar id="searchBarTop" XslTransform="SearchBar/SearchBar.xsl" HintText="Search" runat="server" />
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="siteBounds">
    <div id="logoArea"> 
      <script language="C#" runat="server">
				/*
					The logo control pulls the logo, destination URL and alt text value from
					the Site-specific data for the document's site.  These values can be 
					overriden using the attributes LogoPath, LogoLink and AltText.  Overriding
					the values will result in the same logo information, regardless of document
					site.
				*/
			</script>
      <cms:Logo id="logoControl" runat="server" />
    </div>
    <input type="checkbox" id="navOpener" />
    <div id="navArea">
      <div class="searchArea">
        <div class="searchBar">
          <cms:SearchBar id="mobileSearchBar" XslTransform="SearchBar/SearchBar.xsl" HintText="Search" runat="server" />
        </div>
      </div>
      <label for="navOpener" tabindex="0" onkeydown="DefaultButton(event, this)">
      <div id="navButton"><span>Menu</span><br />
        <span class="fa" /> </div>
      </label>
      <div class="navInner">
        <nav class="top">
          <cms:DisplayNavigation id="topNav" Zone="Top" Xslt="city_Micro-navtopmenu.xsl" MaximumTreeLevels="8" runat="server" />
        </nav>
        <nav class="utility">
          <cms:DisplayNavigation id="mobileUtility" Zone="Utility" Xslt="NavUtility.xsl" MaximumTreeLevels="8" runat="server" />
        </nav>
      </div>
    </div>
  </div>
</header>
<section id="contentArea" class="layoutContainer">
  <div id="topZone">
    <cms:CenterContent id="topContent" Zone="Top" ParseStripes="false" runat="server" />
  </div>
  <div id="pageTools">
    <div class="siteBounds">
      <nav class="breadcrumb">
        <cms:BreadCrumb id="breadCrumb" zone="Breadcrumb" Xslt="NavBreadCrumbBCZone.xsl" runat="server"/>
      </nav>
      <nav class="tools">
        <cms:DisplayNavigation id="pageToolsNav" Xslt="PageTools.xsl" MaximumTreeLevels="8" runat="server" />
      </nav>
    </div>
  </div>
  <div class="siteBounds rightZoneWrapper">
    <div id="leftZone" class="sideZone">
      <cms:CenterContent id="leftContent" Zone="Left" ParseStripes="false" runat="server" />
    </div>
    <div id="centerZone"> <a name="MainContent" id="MainContent" class="skipNav">Main Content</a>
      <cms:CenterContent id="centerContent" Zone="Center" ParseStripes="false" runat="server" />
      <cms:CommentsAndRatings id="ratings" Xslt="Default.xsl" Display="CommentForm,StandardComments,FeaturedComments" runat="server" />
    </div>
  </div>
</section>
<footer id="footerArea" class="layoutContainer">
  <div class="bottomContent">
    <div class="siteBounds">
      <div class="customFooter">
        <cms:StaticContent id="customFooter" SiteParam="CustomFooter" runat="server" />
      </div>
      <nav class="bottom">
        <cms:DisplayNavigation id="bottomNav" Zone="Bottom" Xslt="NavBottom.xsl" MaximumTreeLevels="8" runat="server" />
      </nav>
    </div>
  </div>
  <div id="copyRightContainer">
    <div class="siteBounds">
      <div class="UtilityLinks">
        <ul>
          <li><a href="https://milwaukee.gov/Information-and-Services/webpolicies" linktype="2" target="_self">Web Policies</a></li>
          <li><a href="https://milwaukee.gov/Web-Accessibility" linktype="2" target="_self">Web Accessibility</a></li>
          <li><a href="mailto:UCCWebHelp@milwaukee.gov?subject=City%20of%20Milwaukee%20Website%20Inquiry" linktype="5" target="_self">Web Contact Us</a></li>
        </ul>
      </div>
      <div class="footerLogo">
        <p style="text-align: center"><img alt="City of Milwaukee" src="https://milwaukee.gov/FileLibrary/city-logo-m3footer.png"></p>
      </div>
      <div class="poweredBy">
        <p>&copy; 2023 City of Milwaukee<br />
          Powered by Northwoods Titan CMS </p>
      </div>
    </div>
  </div>
</footer>
<a href="#" id="scrollTop"><span class="fa fa-angle-up"></span><span class="screenReaderOnly">top</span></a>