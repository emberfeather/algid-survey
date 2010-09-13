/**
 * Survey JavaScript
 * 
 * Used to unobtrusively enhance the survey experience for the user.
 */
;(function($) {
	$.survey = {
			hooks: {
				updatePosition: doNothing,
				updatePercent: doNothing
			}
		};
	
	$(function() {
		$.survey.hooks.updatePosition(12, 14);
		$.survey.hooks.updatePercent((10/14) * 100);
	});
	
	var doNothing = function() {};
})(jQuery);
