------------------------------add this to document <head>------------------------------
these files must come before the Project_site.js file in order for overlay to work
<!-- Add fancyBox -->
<link rel="stylesheet" href="/CommonScripts/fancybox/jquery.fancybox.css?v=2.1.5" type="text/css" media="screen" />
<link rel="stylesheet" href="/CommonScripts/fancybox/jquery.fancybox-thumbs.css" type="text/css" media="screen" />
<script type="text/javascript" src="/CommonScripts/fancybox/jquery.fancybox.pack.js?v=2.1.5"></script>
<script type="text/javascript" src="/CommonScripts/fancybox/jquery.fancybox-thumbs.js"></script> 
<!--for youtube video support-->
<script type="text/javascript" src="/CommonScripts/fancybox/jquery.fancybox-media.js"></script>  

------------------------------add this to Project_site.js------------------------------

/*fancybox*/
if ($(".fancybox").length ) {
	$(".fancybox").fancybox();
}

/*fancybox with video*/
if ($(".fancybox").length ) {
	$(".fancybox").fancybox({
		helpers: {
			media: true
		}
	});
}

/*fancybox with thumbnails*/
if ($(".fancybox").length ) {
	$(".fancybox").fancybox({
		helpers:  {
			thumbs : {
				width: 80,
				height: 80
			}
		}
	});
}


/* FANCYBOX - PRODUCT DETAIL PHOTO BLOCK */
$(".fancybox").fancybox({
	helpers: {
		overlay: {
			locked: false
		},
		title : { 
			type : 'inside' 
		}
	},
	beforeShow : function(){
		this.title =  $(this.element).data("caption");
	}
});

/*options used for Montessori*/
/*fancybox*/
	$(".fancybox").fancybox({
		helpers:  {
			thumbs : {
				width: 80,
				height: 80,
				position: 'top'
			},
			title : { 
				type : 'inside' 
			},
			overlay : {
				showEarly : false
			}
		},
		topRatio  : "0",
		/* autoPlay : "true", */
		playSpeed : "5000",
		beforeShow : function(){
			this.title =  this.title + " </br> " + $(this.element).data("caption");
		}
	});
	

------------------------------add this to css------------------------------	
	/*FancyBox Gallery*/
	
	div.PhotoBlock div.filmstrip div.thumbnails {
		border: medium none;
		float: none;
		height: auto;
		margin-left: 0;
		overflow: auto;
		width: 100%;
	}
