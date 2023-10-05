NWS.initNamespace('NWS.UI.Animation', function(){
	function activateVisible(e, selector, offset, callback)
	{
		var listSelector, visibleOffset, postActivateCallback;
		visibleOffset = 0;
		if(typeof(selector) !== "undefined") 
			listSelector = selector + ":not('.animated')";
		else if(e && typeof(e.data) !== "undefined" && typeof(e.data.animateSelector) !== "undefined")
			listSelector = e.data.animateSelector + ":not('.animated')"
		else 
			return;
		
		if(typeof(offset) !== "undefined") 
			visibleOffset = offset;
		else if(e && typeof(e.data) !== "undefined" && typeof(e.data.visibleOffset) !== "undefined")
			visibleOffset = e.data.visibleOffset;
		
		postActivateCallback = null;
		if(typeof(callback) === "function")
			postActivateCallback = callback;
		else if(e && typeof(e.data) !== "undefined" && typeof(e.data.callback) !== "undefined")
			postActivateCallback = e.data.callback;
		
				
		$(listSelector).each(function() {
				var $element = $(this);
				var $window = $(window);
				if(($window.scrollTop() + $window.height()) > ($element.offset().top + visibleOffset))
				{
					$element.addClass("animated fadeIn");
					if(postActivateCallback)
						postActivateCallback(this);
				}	
				});
	}
	
	return {
		AnimateBlocks: function(selector, visibleOffset, callback){
			activateVisible(null, selector, visibleOffset, callback);
			$(window).on('scroll', {'animateSelector':selector, 'visibleOffset':visibleOffset, 'callback':callback}, activateVisible);
		}		
	}
});
/*
$(function () {
	NWS.UI.Animation.AnimateBlocks("div.Freeform", 50, function(element){ alert(element.className);});
});
*/




